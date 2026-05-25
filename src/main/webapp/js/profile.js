document.addEventListener('DOMContentLoaded', function() {
    // Get the current user's full name from JSP (add this at the top)
    const fullName = '<%= currentUser.getFullName() %>';
    const defaultAvatar = `https://ui-avatars.com/api/?name=${encodeURIComponent(fullName)}&background=random&size=120`;

    // ===== [1. REPLACE THE ENTIRE AVATAR UPLOAD HANDLER] =====
    const avatarUpload = document.getElementById('avatarUpload');
    const avatarForm = document.getElementById('avatarForm');
    const removeBtn = document.querySelector('.btn-remove-avatar');
    const profileImage = document.getElementById('profileImage'); // Navbar profile image

    if (avatarUpload && avatarForm) {
        avatarUpload.addEventListener('change', function(e) {
            if (this.files && this.files[0]) {
                // Show preview immediately
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('avatarPreview').src = e.target.result;
                    if (profileImage) profileImage.src = e.target.result;
                    if (removeBtn) removeBtn.disabled = false;
                };
                reader.readAsDataURL(this.files[0]);

                // Upload to server
                const formData = new FormData(avatarForm);

                console.log('Starting file upload...'); // Debug
                fetch('upload-avatar', {
                    method: 'POST',
                    body: formData
                })
                    .then(response => {
                        console.log('Received response:', response); // Debug
                        if (!response.ok) {
                            throw new Error(`Server returned ${response.status}`);
                        }
                        return response.json();
                    })
                    .then(data => {
                        console.log('Upload result:', data); // Debug
                        if (data.success) {
                            showToast('success', 'Profile photo updated successfully!');
                            // Update both images with the final URL from server
                            const finalUrl = data.avatarUrl + '?t=' + new Date().getTime(); // Cache buster
                            document.getElementById('avatarPreview').src = finalUrl;
                            if (profileImage) profileImage.src = finalUrl;
                        } else {
                            throw new Error(data.error || 'Upload failed');
                        }
                    })
                    .catch(error => {
                        console.error('Upload error:', error); // Debug
                        showToast('error', error.message);
                        // Revert to default avatar on error
                        document.getElementById('avatarPreview').src = defaultAvatar;
                        if (profileImage) profileImage.src = defaultAvatar;
                    });
            }
        });
    }

    // ===== [2. UPDATE THE REMOVE BUTTON HANDLER] =====
    // Replace the existing remove button handler with this:
    if (removeBtn) {
        removeBtn.addEventListener('click', function(e) {
            e.preventDefault();

            if (this.disabled) return;

            if (!confirm('Are you sure you want to remove your profile photo?')) {
                return;
            }

            const spinner = '<span class="spinner-border spinner-border-sm" role="status"></span>';
            const originalText = this.innerHTML;
            this.disabled = true;
            this.innerHTML = spinner + ' Removing...';

            fetch('remove-avatar', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
                .then(response => {
                    if (!response.ok) throw new Error('Removal failed');
                    return response.json();
                })
                .then(data => {
                    if (data.success) {
                        showToast('success', 'Photo removed successfully');
                        // Reset to default avatar
                        document.getElementById('avatarPreview').src = defaultAvatar;
                        if (profileImage) profileImage.src = defaultAvatar;
                        // Enable upload button
                        avatarUpload.value = '';
                    } else {
                        throw new Error(data.error || 'Removal failed');
                    }
                })
                .catch(error => {
                    showToast('error', error.message);
                })
                .finally(() => {
                    this.disabled = false;
                    this.innerHTML = originalText;
                });
        });
    }

    // ===== [3. KEEP YOUR EXISTING TOAST FUNCTION] =====
    function showToast(type, message) {
        const toast = document.createElement('div');
        toast.className = `toast align-items-center text-white bg-${type} border-0 position-fixed bottom-0 end-0 m-3`;
        toast.setAttribute('role', 'alert');
        toast.setAttribute('aria-live', 'assertive');
        toast.setAttribute('aria-atomic', 'true');

        toast.innerHTML = `
            <div class="d-flex">
                <div class="toast-body">
                    ${message}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        `;

        document.body.appendChild(toast);
        new bootstrap.Toast(toast).show();

        setTimeout(() => {
            toast.remove();
        }, 5000);
    }

    // ===== [4. DEBUGGING HELPERS - ADD THESE AT THE END] =====
    console.log('Profile JS loaded successfully');
    console.log('Default avatar URL:', defaultAvatar);
    if (avatarUpload) console.log('Avatar upload element found');
    if (profileImage) console.log('Navbar profile image found:', profileImage);
});
// Add this to your existing profile.js
document.getElementById('deleteAccountForm')?.addEventListener('submit', function(e) {
    e.preventDefault();

    const submitBtn = this.querySelector('button[type="submit"]');
    const spinner = document.getElementById('deleteSpinner');

    // Show loading state
    submitBtn.disabled = true;
    spinner.classList.remove('d-none');

    fetch(this.action, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams(new FormData(this))
    })
        .then(response => {
            if (response.redirected) {
                window.location.href = response.url;
            } else {
                return response.text();
            }
        })
        .then(text => {
            // Handle any non-redirect responses
            if (text) {
                showToast('error', text);
            }
        })
        .catch(error => {
            showToast('error', 'Error: ' + error.message);
        })
        .finally(() => {
            submitBtn.disabled = false;
            spinner.classList.add('d-none');
        });
});