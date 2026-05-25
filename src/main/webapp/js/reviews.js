document.addEventListener('DOMContentLoaded', function() {
    const track = document.querySelector('.review-track');
    const cards = document.querySelectorAll('.review-card');
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');
    const dotsContainer = document.getElementById('sliderDots');

    let cardWidth = cards[0].offsetWidth + 20; // width + margin
    let visibleCards = window.matchMedia('(max-width: 768px)').matches ? 1 : 4;
    let currentPosition = 0;
    let totalSlides = Math.ceil(cards.length / visibleCards);

    // Touch control variables
    let touchStartX = 0;
    let touchEndX = 0;
    let isDragging = false;
    let dragOffset = 0;
    let currentTranslate = 0;
    let animationID = 0;

    // Create dots
    function createDots() {
        dotsContainer.innerHTML = '';
        for (let i = 0; i < totalSlides; i++) {
            const dot = document.createElement('div');
            dot.classList.add('dot');
            if (i === 0) dot.classList.add('active');
            dot.dataset.slide = i;
            dot.addEventListener('click', goToSlide);
            dotsContainer.appendChild(dot);
        }
    }

    // Update buttons state
    function updateButtons() {
        prevBtn.disabled = currentPosition === 0;
        nextBtn.disabled = currentPosition <= -((cards.length - visibleCards) * cardWidth);
    }

    // Update dots state
    function updateDots() {
        const dots = document.querySelectorAll('.slider-dots .dot');
        const activeDot = Math.abs(Math.round(currentPosition / (cardWidth * visibleCards)));
        dots.forEach((dot, index) => {
            dot.classList.toggle('active', index === activeDot);
        });
    }

    // Move to specific slide
    function goToSlide(e) {
        const slideIndex = parseInt(this.dataset.slide);
        currentPosition = -slideIndex * visibleCards * cardWidth;
        animateSlider();
        updateButtons();
        updateDots();
    }

    // Animate slider movement
    function animateSlider() {
        track.style.transition = 'transform 0.5s ease-in-out';
        track.style.transform = `translateX(${currentPosition}px)`;
    }

    // Next slide
    function nextSlide() {
        if (currentPosition > -((cards.length - visibleCards) * cardWidth)) {
            currentPosition -= cardWidth * visibleCards;
            animateSlider();
            updateButtons();
            updateDots();
        }
    }

    // Previous slide
    function prevSlide() {
        if (currentPosition < 0) {
            currentPosition += cardWidth * visibleCards;
            animateSlider();
            updateButtons();
            updateDots();
        }
    }

    // Get current position from transform
    function getPositionX() {
        return currentPosition;
    }

    // Handle touch start
    function touchStart(e) {
        touchStartX = e.touches[0].clientX;
        isDragging = true;
        currentTranslate = getPositionX();
        track.style.transition = 'none';
        cancelAnimationFrame(animationID);
    }

    // Handle touch move
    function touchMove(e) {
        if (!isDragging) return;
        touchEndX = e.touches[0].clientX;
        dragOffset = touchEndX - touchStartX;
        const newPosition = currentTranslate + dragOffset;

        // Apply boundaries
        const maxPosition = 0;
        const minPosition = -((cards.length - 1) * cardWidth);

        if (newPosition > maxPosition + 50) {
            // Elastic effect when over-pulling to the right
            track.style.transform = `translateX(${maxPosition + dragOffset * 0.2}px)`;
        } else if (newPosition < minPosition - 50) {
            // Elastic effect when over-pulling to the left
            track.style.transform = `translateX(${minPosition + dragOffset * 0.2}px)`;
        } else {
            track.style.transform = `translateX(${newPosition}px)`;
        }
    }

    // Handle touch end
    function touchEnd() {
        if (!isDragging) return;
        isDragging = false;

        const threshold = cardWidth * 0.2; // 20% of card width
        const swipeDistance = touchEndX - touchStartX;

        if (swipeDistance < -threshold) {
            // Swiped left - next slide
            currentPosition = Math.floor((currentTranslate + dragOffset) / cardWidth) * cardWidth;
            if (currentPosition < -((cards.length - 1) * cardWidth)) {
                currentPosition = -((cards.length - 1) * cardWidth);
            }
        } else if (swipeDistance > threshold) {
            // Swiped right - previous slide
            currentPosition = Math.ceil((currentTranslate + dragOffset) / cardWidth) * cardWidth;
            if (currentPosition > 0) currentPosition = 0;
        } else {
            // Return to current position
            currentPosition = Math.round(currentTranslate / cardWidth) * cardWidth;
        }

        animateSlider();
        updateButtons();
        updateDots();
    }

    // Initialize slider
    function initSlider() {
        createDots();
        updateButtons();

        // Event listeners
        nextBtn.addEventListener('click', nextSlide);
        prevBtn.addEventListener('click', prevSlide);

        // Touch event listeners
        track.addEventListener('touchstart', touchStart, { passive: true });
        track.addEventListener('touchmove', touchMove, { passive: true });
        track.addEventListener('touchend', touchEnd, { passive: true });

        // Handle window resize
        window.addEventListener('resize', function() {
            cardWidth = cards[0].offsetWidth + 20;
            visibleCards = window.matchMedia('(max-width: 768px)').matches ? 1 : 4;
            totalSlides = Math.ceil(cards.length / visibleCards);
            animateSlider();
            createDots();
            updateDots();
        });
    }

    // Start the slider
    initSlider();
});
