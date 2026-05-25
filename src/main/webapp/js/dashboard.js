document.addEventListener('DOMContentLoaded', function() {
    const profileButton = document.getElementById('profileButton');
    const profileDropdown = document.getElementById('profileDropdown');
    const logoutButton = document.getElementById('logoutButton');

    if (profileButton && profileDropdown) {
        // Toggle dropdown on profile button click
        profileButton.addEventListener('click', function(e) {
            e.stopPropagation(); // Prevent event from bubbling up
            profileDropdown.classList.toggle('show');
        });

        // Close dropdown when clicking outside
        document.addEventListener('click', function(e) {
            if (!profileDropdown.contains(e.target)) {
                profileDropdown.classList.remove('show');
            }
        });
    }

    if (logoutButton) {
        logoutButton.addEventListener('click', function(e) {
            e.preventDefault();
            if (confirm("Are you sure you want to logout?")) {
                // Show logout message immediately
                alert("Logging out...");

                // Create a hidden form and submit it
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'logout';
                document.body.appendChild(form);
                form.submit();
            }
        });
    }
});