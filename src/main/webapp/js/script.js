document.addEventListener('DOMContentLoaded', function() {
    // Initialize Bootstrap carousel
    const initImageCarousel = function() {
        const carouselElement = document.getElementById('carouselExampleIndicators');
        if (!carouselElement) return;

        const carousel = new bootstrap.Carousel(carouselElement, {
            interval: 5000,
            ride: 'carousel',
            wrap: true
        });

        const carouselContainer = document.querySelector('.carousel-container');
        if (carouselContainer) {
            carouselContainer.addEventListener('mouseenter', () => carousel.pause());
            carouselContainer.addEventListener('mouseleave', () => carousel.cycle());
        }
    };
});
// FAQ toggle functionality
document.querySelectorAll('.faq-question').forEach(question => {
    question.addEventListener('click', () => {
        const answer = question.nextElementSibling;
        const isActive = question.classList.contains('active');

        // Close all answers first
        document.querySelectorAll('.faq-answer').forEach(ans => {
            ans.style.display = 'none';
        });
        document.querySelectorAll('.faq-question').forEach(q => {
            q.classList.remove('active');
        });

        // Open clicked answer if it wasn't active
        if (!isActive) {
            answer.style.display = 'block';
            question.classList.add('active');
        }
    });
});

// Form submission handling
document.getElementById('contactForm').addEventListener('submit', function(e) {
    e.preventDefault();
    alert('Thank you for your message! We will get back to you shortly.');
    this.reset();
});

// Toggle password visibility - improved version
const togglePassword = document.querySelector('#togglePassword');
const password = document.querySelector('#password');
const passwordIcon = togglePassword.querySelector('i');

togglePassword.addEventListener('click', function() {
    const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
    password.setAttribute('type', type);

    // Toggle eye icon
    passwordIcon.classList.toggle('bx-hide');
    passwordIcon.classList.toggle('bx-show');

    // Focus back on password field
    password.focus();
});

// Form submission handling
document.getElementById('signinForm').addEventListener('submit', function(e) {
    e.preventDefault();
    // Add to submit handler:
    if (!email.includes('@') || !email.includes('.')) {
        alert('Please enter a valid email address');
        return;
    }

    // Get form values
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const rememberMe = document.getElementById('remember').checked;

    // Here you would typically send this data to your server for authentication
    console.log('Signing in with:', { email, password, rememberMe });

    // Simulate successful login
    alert('Sign in successful! Redirecting to your dashboard...');
    window.location.href = 'front.html';
});

// Social login handlers
document.querySelectorAll('.social-btn').forEach(btn => {
    btn.addEventListener('click', function(e) {
        e.preventDefault();
        const provider = this.querySelector('i').className.split('-')[1];
        alert(`Redirecting to ${provider} authentication...`);
    });
});

// Toggle password visibility
const togglePassword = document.querySelector('#togglePassword');
const password = document.querySelector('#password');

togglePassword.addEventListener('click', function() {
    const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
    password.setAttribute('type', type);
    this.classList.toggle('bx-hide');
    this.classList.toggle('bx-show');
});

// Form validation
document.getElementById('signupForm').addEventListener('submit', function(e) {
    e.preventDefault();

    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;

    if (password !== confirmPassword) {
        alert('Passwords do not match!');
        return;
    }

    if (!document.getElementById('terms').checked) {
        alert('You must agree to the terms and conditions');
        return;
    }

    // Form is valid - proceed with signup
    alert('Account created successfully! Redirecting...');
    window.location.href = 'front.html'; // Redirect after signup
});



