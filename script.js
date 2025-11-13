// Download button functionality - Fixed to not show error when download works
document.addEventListener('DOMContentLoaded', function() {
    const downloadBtn = document.getElementById('downloadBtn');
    
    if (downloadBtn) {
        downloadBtn.addEventListener('click', function(e) {
            // Don't prevent default - let the download happen naturally
            // Just add visual feedback
            
            // Add loading state
            this.classList.add('loading');
            const originalContent = this.querySelector('.btn-content').innerHTML;
            this.querySelector('.btn-content').innerHTML = `
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="spinning">
                    <path d="M12 2V6M12 18V22M6 12H2M22 12H18M19.07 19.07L16.24 16.24M19.07 4.93L16.24 7.76M4.93 19.07L7.76 16.24M4.93 4.93L7.76 7.76" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                </svg>
                <span>Downloading...</span>
            `;
            
            // Reset button after a delay (download should have started)
            setTimeout(() => {
                this.classList.remove('loading');
                this.querySelector('.btn-content').innerHTML = originalContent;
            }, 2000);
        });
    }
    
    // Add ripple effect to download button
    if (downloadBtn) {
        downloadBtn.addEventListener('click', function(e) {
            const ripple = this.querySelector('.btn-ripple');
            if (ripple) {
                ripple.classList.remove('active');
                setTimeout(() => {
                    ripple.classList.add('active');
                }, 10);
            }
        });
    }
    
    // Smooth scroll for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
    
    // Enhanced scroll animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -100px 0px'
    };
    
    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-in');
            }
        });
    }, observerOptions);
    
    // Observe all sections and cards
    document.querySelectorAll('.info-section, .requirements-section, .instructions-section, .feature-card, .requirement-item').forEach(element => {
        element.classList.add('fade-in');
        observer.observe(element);
    });
    
    // Parallax effect for logo
    const logo = document.getElementById('appLogo');
    if (logo) {
        window.addEventListener('scroll', () => {
            const scrolled = window.pageYOffset;
            const rate = scrolled * 0.3;
            logo.style.transform = `translateY(${rate}px)`;
        });
    }
    
    // Add stagger animation to feature cards
    const featureCards = document.querySelectorAll('.feature-card');
    featureCards.forEach((card, index) => {
        card.style.animationDelay = `${index * 0.1}s`;
    });
    
    // Animate stats numbers
    const animateStats = () => {
        const statNumbers = document.querySelectorAll('.stat-number');
        
        const animateValue = (element, start, end, duration) => {
            let startTimestamp = null;
            const target = parseInt(element.getAttribute('data-target'));
            const step = (timestamp) => {
                if (!startTimestamp) startTimestamp = timestamp;
                const progress = Math.min((timestamp - startTimestamp) / duration, 1);
                const current = Math.floor(progress * (target - start) + start);
                
                // Format number with commas
                if (target >= 1000) {
                    element.textContent = current.toLocaleString();
                } else {
                    element.textContent = current;
                }
                
                if (progress < 1) {
                    window.requestAnimationFrame(step);
                } else {
                    element.textContent = target >= 1000 ? target.toLocaleString() : target;
                }
            };
            window.requestAnimationFrame(step);
        };
        
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const target = parseInt(entry.target.getAttribute('data-target'));
                    animateValue(entry.target, 0, target, 2000);
                    observer.unobserve(entry.target);
                }
            });
        }, { threshold: 0.5 });
        
        statNumbers.forEach(stat => {
            observer.observe(stat);
        });
    };
    
    // Initialize stats animation
    animateStats();
});

// Add CSS for spinning animation
const style = document.createElement('style');
style.textContent = `
    @keyframes spin {
        from { transform: rotate(0deg); }
        to { transform: rotate(360deg); }
    }
    .spinning {
        animation: spin 1s linear infinite;
    }
`;
document.head.appendChild(style);
