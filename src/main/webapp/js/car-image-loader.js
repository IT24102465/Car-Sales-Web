/**
 * Car photos from the web — each listing gets a different image when make/model match.
 */
(function (global) {
    const carUrlCache = new Map();
    const imagePools = new Map();
    const usedPoolIndex = new Map();
    let loadQueue = Promise.resolve();

    const POOL_SIZE = 18;
    const IMAGIN_ANGLES = ['01', '05', '09', '13', '17', '21', '23', '28', '31', '34', '37', '40'];

    function readSearchTerms(img) {
        return {
            make: (img.dataset.searchMake || img.dataset.make || '').trim(),
            model: (img.dataset.searchModel || img.dataset.model || '').trim(),
            year: (img.dataset.year || '').trim(),
            carId: (img.dataset.carId || '').trim()
        };
    }

    function poolKey(terms) {
        return [terms.year, terms.make, terms.model].join('|');
    }

    function placeholderSvg(text) {
        const label = (text || 'Car').substring(0, 32);
        const svg = '<svg xmlns="http://www.w3.org/2000/svg" width="400" height="300">'
            + '<rect width="100%" height="100%" fill="#e9ecef"/>'
            + '<text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle" fill="#6c757d" font-family="sans-serif" font-size="13">'
            + label + '</text></svg>';
        return 'data:image/svg+xml,' + encodeURIComponent(svg);
    }

    function hashString(str) {
        let h = 0;
        for (let i = 0; i < str.length; i++) {
            h = ((h << 5) - h) + str.charCodeAt(i);
            h |= 0;
        }
        return Math.abs(h);
    }

    function titleMatchesCar(title, make, model) {
        const t = (title || '').toLowerCase();
        return t.indexOf(make.toLowerCase()) !== -1
            && (t.indexOf(model.toLowerCase()) !== -1 || model.length <= 3);
    }

    function uniqueUrls(urls) {
        const seen = new Set();
        const out = [];
        for (let i = 0; i < urls.length; i++) {
            if (urls[i] && !seen.has(urls[i])) {
                seen.add(urls[i]);
                out.push(urls[i]);
            }
        }
        return out;
    }

    async function fetchWikipediaImages(make, model, year) {
        const titles = [
            (make + ' ' + model + (year ? ' ' + year : '')).replace(/ /g, '_'),
            (make + ' ' + model).replace(/ /g, '_'),
            (make + ' ' + model + '_(automobile)').replace(/ /g, '_')
        ];
        const promises = titles.map(async function (title) {
            try {
                const res = await fetch(
                    'https://en.wikipedia.org/api/rest_v1/page/summary/' + encodeURIComponent(title)
                );
                if (!res.ok) {
                    return null;
                }
                const data = await res.json();
                if (data.type === 'disambiguation') {
                    return null;
                }
                return (data.originalimage && data.originalimage.source)
                    || (data.thumbnail && data.thumbnail.source) || null;
            } catch (e) {
                return null;
            }
        });
        const results = await Promise.all(promises);
        return results.filter(Boolean);
    }

    function buildImaginUrl(make, model, year, angle, config) {
        if (!config.imaginCustomer) {
            return null;
        }
        const params = new URLSearchParams({
            customer: config.imaginCustomer,
            make: make,
            modelFamily: model,
            modelYear: year || '2020',
            angle: angle || '23',
            zoomType: 'fullscreen'
        });
        return 'https://cdn.imagin.studio/getImage?' + params.toString();
    }

    function buildImaginPool(make, model, year, config) {
        const urls = [];
        for (let i = 0; i < IMAGIN_ANGLES.length; i++) {
            const u = buildImaginUrl(make, model, year, IMAGIN_ANGLES[i], config);
            if (u) {
                urls.push(u);
            }
        }
        return urls;
    }

    async function fetchGoogleImages(query, config, num) {
        if (!config.googleKey || !config.googleCx) {
            return [];
        }
        const url = 'https://www.googleapis.com/customsearch/v1'
            + '?key=' + encodeURIComponent(config.googleKey)
            + '&cx=' + encodeURIComponent(config.googleCx)
            + '&searchType=image'
            + '&num=' + num
            + '&q=' + encodeURIComponent('"' + query + '" automobile exterior');
        try {
            const res = await fetch(url);
            if (!res.ok) {
                return [];
            }
            const data = await res.json();
            if (!data.items) {
                return [];
            }
            return data.items.map(function (item) { return item.link; }).filter(Boolean);
        } catch (e) {
            return [];
        }
    }

    async function fetchWikimediaImages(make, model, year, limit, extraKeyword) {
        const extra = extraKeyword ? (' ' + extraKeyword) : '';
        const queries = [
            make + ' ' + model + ' ' + (year || '') + extra + ' car exterior',
            'intitle:"' + make + ' ' + model + '"' + extra + ' automobile',
            make + ' ' + model + ' vehicle' + extra,
            make + ' ' + model + ' ' + (year || '') + extra + ' sedan',
            make + ' ' + model + extra + ' SUV'
        ];
        const promises = queries.map(async function (query) {
            const api = 'https://commons.wikimedia.org/w/api.php'
                + '?action=query'
                + '&generator=search'
                + '&gsrsearch=' + encodeURIComponent(query)
                + '&gsrlimit=' + Math.min(limit, 20)
                + '&gsrnamespace=6'
                + '&prop=imageinfo'
                + '&iiprop=url'
                + '&format=json'
                + '&origin=*';
            try {
                const res = await fetch(api);
                if (!res.ok) {
                    return [];
                }
                const data = await res.json();
                const pages = data.query && data.query.pages;
                if (!pages) {
                    return [];
                }
                const found = [];
                Object.values(pages).forEach(function (page) {
                    const pageTitle = page.title || '';
                    if (!titleMatchesCar(pageTitle, make, model)) {
                        return;
                    }
                    const info = page.imageinfo && page.imageinfo[0];
                    if (info && info.url) {
                        found.push(info.url);
                    }
                });
                return found;
            } catch (e) {
                return [];
            }
        });
        const results = await Promise.all(promises);
        const urls = [];
        for (let i = 0; i < results.length; i++) {
            const found = results[i];
            for (let j = 0; j < found.length; j++) {
                if (urls.indexOf(found[j]) === -1) {
                    urls.push(found[j]);
                }
            }
        }
        return urls.slice(0, limit);
    }

    async function buildImagePool(terms) {
        const config = global.CAR_IMAGE_CONFIG || {};
        const make = terms.make;
        const model = terms.model;
        const year = terms.year;
        let pool = [];

        if (config.imaginCustomer && make && model) {
            pool = pool.concat(buildImaginPool(make, model, year, config));
        }

        if (make && model) {
            const results = await Promise.all([
                fetchWikipediaImages(make, model, year),
                fetchWikimediaImages(make, model, year, POOL_SIZE, ''),
                fetchGoogleImages([year, make, model].filter(Boolean).join(' '), config, 10)
            ]);
            pool = pool.concat(results[0]).concat(results[1]).concat(results[2]);

            if (pool.length < POOL_SIZE) {
                const colorTerms = ['white', 'black', 'silver', 'red', 'blue', 'grey', 'front', 'side'];
                const colorPromises = colorTerms.map(function (color) {
                    return fetchWikimediaImages(make, model, year, 4, color);
                });
                const colorResults = await Promise.all(colorPromises);
                colorResults.forEach(function (more) {
                    pool = pool.concat(more);
                });
            }
        }

        return uniqueUrls(pool).slice(0, POOL_SIZE);
    }

    async function getImagePool(terms) {
        const key = poolKey(terms);
        if (!imagePools.has(key)) {
            imagePools.set(key, buildImagePool(terms));
        }
        return imagePools.get(key);
    }

    function pickPoolIndex(carId, poolLength, key) {
        if (poolLength <= 1) {
            return 0;
        }
        if (!usedPoolIndex.has(key)) {
            usedPoolIndex.set(key, new Set());
        }
        const used = usedPoolIndex.get(key);
        let idx = hashString(carId || String(Math.random())) % poolLength;
        let tries = 0;
        while (used.has(idx) && tries < poolLength) {
            idx = (idx + 1) % poolLength;
            tries++;
        }
        used.add(idx);
        return idx;
    }

    const CACHE_PREFIX = 'car_img_cache_';
    const CACHE_TTL = 7 * 24 * 60 * 60 * 1000; // 7 days in ms

    function getCachedImage(carId) {
        try {
            const cached = localStorage.getItem(CACHE_PREFIX + carId);
            if (cached) {
                const parsed = JSON.parse(cached);
                if (Date.now() - parsed.timestamp < CACHE_TTL) {
                    return parsed.url;
                }
                localStorage.removeItem(CACHE_PREFIX + carId);
            }
        } catch (e) {}
        return null;
    }

    function setCachedImage(carId, url) {
        try {
            localStorage.setItem(CACHE_PREFIX + carId, JSON.stringify({
                url: url,
                timestamp: Date.now()
            }));
        } catch (e) {}
    }

    async function resolveWebImage(terms) {
        const carId = terms.carId || poolKey(terms);
        if (carUrlCache.has(carId)) {
            return carUrlCache.get(carId);
        }

        const cachedUrl = getCachedImage(carId);
        if (cachedUrl !== null) {
            carUrlCache.set(carId, cachedUrl);
            return cachedUrl;
        }

        const pool = await getImagePool(terms);
        let imageUrl = null;

        if (pool.length > 0) {
            const key = poolKey(terms);
            const idx = pickPoolIndex(carId, pool.length, key);
            imageUrl = pool[idx];
        }

        carUrlCache.set(carId, imageUrl);
        setCachedImage(carId, imageUrl);
        return imageUrl;
    }

    function loadImageWithPlaceholder(img, url, fallbackLabel) {
        const tempImg = new Image();
        tempImg.onload = function () {
            img.src = url;
            img.dataset.webPhotoUrl = url;
        };
        tempImg.onerror = function () {
            img.src = placeholderSvg(fallbackLabel);
        };
        tempImg.src = url;
    }

    async function loadCarPhoto(img) {
        if (!img || img.dataset.webPhotoLoaded === '1') {
            return;
        }

        const terms = readSearchTerms(img);
        const label = [terms.year, terms.make, terms.model].filter(Boolean).join(' ') || 'Car';
        img.alt = label;

        // Force set src to loading placeholder if it isn't one
        if (!img.getAttribute('src') || img.getAttribute('src').indexOf('data:image') !== 0) {
            img.src = placeholderSvg('Loading…');
        }
        img.dataset.webPhotoLoaded = '1';

        const fixed = (img.dataset.fixedImage || img.getAttribute('data-fixed-image') || '').trim();
        if (fixed) {
            loadImageWithPlaceholder(img, fixed, label);
            return;
        }

        try {
            const imageUrl = await resolveWebImage(terms);
            if (imageUrl) {
                loadImageWithPlaceholder(img, imageUrl, label);
            } else {
                img.src = placeholderSvg(label);
            }
        } catch (e) {
            img.src = placeholderSvg(label);
        }
    }

    function initCarPhotos(root) {
        const scope = root || document;
        scope.querySelectorAll('img.car-web-photo[data-make][data-model]').forEach(function (img) {
            loadCarPhoto(img);
        });
    }

    global.loadCarPhoto = loadCarPhoto;
    global.initCarPhotos = initCarPhotos;
    global.buildCarImageSearchQuery = function (make, model, year) {
        return [year, make, model, 'car exterior'].filter(Boolean).join(' ');
    };

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', function () {
            initCarPhotos();
        });
    } else {
        initCarPhotos();
    }
})(window);
