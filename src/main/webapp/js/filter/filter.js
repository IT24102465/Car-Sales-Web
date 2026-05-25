(function () {
    const modelsByMake = {
        Toyota: ['Highlander', 'Camry'],
        Honda: ['Camry', 'H200', 'Grace'],
        BMW: ['Camry', 'Highlander'],
        Mercedes: ['Camry', 'Highlander'],
        Ford: ['Camry'],
        Hyundai: ['H300'],
        Audi: ['Highlander'],
        Nissan: []
    };

    const allModels = ['Camry', 'Highlander', 'H200', 'H300', 'Grace'];

    const makeSelect = document.getElementById('filter-make');
    const modelSelect = document.getElementById('filter-model');
    if (!makeSelect || !modelSelect) return;

    function populateModels(make, selectedModel) {
        const models = make && modelsByMake[make] ? modelsByMake[make] : allModels;
        modelSelect.innerHTML = '<option value="">Any Model</option>';
        models.forEach(model => {
            const opt = document.createElement('option');
            opt.value = model;
            opt.textContent = model;
            if (selectedModel && selectedModel === model) {
                opt.selected = true;
            }
            modelSelect.appendChild(opt);
        });
        modelSelect.disabled = false;
    }

    const initialMake = makeSelect.value;
    const initialModel = modelSelect.dataset.selected || '';
    populateModels(initialMake, initialModel);

    makeSelect.addEventListener('change', function () {
        populateModels(this.value, '');
    });
})();
