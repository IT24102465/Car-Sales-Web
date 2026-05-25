// Populate year dropdown
const yearSelect = document.getElementById('year');
if(yearSelect) { // Only run if the element exists (logged-in user)
    const currentYear = new Date().getFullYear();
    for (let year = currentYear; year >= 1990; year--) {
        const option = document.createElement('option');
        option.value = year;
        option.textContent = year;
        yearSelect.appendChild(option);
    }
}

// Image upload functionality
const uploadArea = document.getElementById('uploadArea');
const fileInput = document.getElementById('carImages');
const previewContainer = document.getElementById('previewContainer');

if(uploadArea && fileInput && previewContainer) {
    uploadArea.addEventListener('click', () => fileInput.click());

    uploadArea.addEventListener('dragover', (e) => {
        e.preventDefault();
        uploadArea.style.borderColor = '#FF0000';
        uploadArea.style.backgroundColor = 'rgba(255, 0, 0, 0.05)';
    });

    uploadArea.addEventListener('dragleave', () => {
        uploadArea.style.borderColor = '#ddd';
        uploadArea.style.backgroundColor = 'transparent';
    });

    uploadArea.addEventListener('drop', (e) => {
        e.preventDefault();
        uploadArea.style.borderColor = '#ddd';
        uploadArea.style.backgroundColor = 'transparent';

        if (e.dataTransfer.files.length) {
            fileInput.files = e.dataTransfer.files;
            handleFiles(fileInput.files);
        }
    });

    fileInput.addEventListener('change', () => {
        if (fileInput.files.length) {
            handleFiles(fileInput.files);
        }
    });

    function handleFiles(files) {
        previewContainer.innerHTML = '';

        if (files.length > 10) {
            alert('You can upload a maximum of 10 images');
            return;
        }

        Array.from(files).forEach(file => {
            if (!file.type.match('image.*')) {
                return;
            }

            const reader = new FileReader();
            reader.onload = (e) => {
                const preview = document.createElement('div');
                preview.style.display = 'inline-block';
                preview.style.margin = '5px';
                preview.style.position = 'relative';

                const img = document.createElement('img');
                img.src = e.target.result;
                img.style.height = '80px';
                img.style.borderRadius = '5px';

                const removeBtn = document.createElement('button');
                removeBtn.innerHTML = '&times;';
                removeBtn.style.position = 'absolute';
                removeBtn.style.top = '-5px';
                removeBtn.style.right = '-5px';
                removeBtn.style.background = '#FF0000';
                removeBtn.style.color = 'white';
                removeBtn.style.border = 'none';
                removeBtn.style.borderRadius = '50%';
                removeBtn.style.width = '20px';
                removeBtn.style.height = '20px';
                removeBtn.style.cursor = 'pointer';

                removeBtn.addEventListener('click', () => {
                    preview.remove();
                    // Need to update the file input as well
                    const newFiles = Array.from(fileInput.files).filter(f => f !== file);
                    const dataTransfer = new DataTransfer();
                    newFiles.forEach(f => dataTransfer.items.add(f));
                    fileInput.files = dataTransfer.files;
                });

                preview.appendChild(img);
                preview.appendChild(removeBtn);
                previewContainer.appendChild(preview);
            };
            reader.readAsDataURL(file);
        });
    }
}

// Form submission
const carSellForm = document.getElementById('carSellForm');
if(carSellForm) {
    carSellForm.addEventListener('submit', function(e) {
        e.preventDefault();

        // Basic validation
        if(this.carImages.files.length === 0) {
            alert('Please upload at least one image of your car');
            return;
        }

        // If validation passes, submit the form
        this.submit();
    });
}