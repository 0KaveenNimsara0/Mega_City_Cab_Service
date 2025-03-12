<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #f7c427;
            --dark-bg: #121212;
            --card-bg: #1e1e1e;
            --text-primary: #ffffff;
            --text-secondary: #b3b3b3;
        }
        body.light-theme {
            /* Light Theme Variables */
            --primary: #f7c427;
            --dark-bg: #f5f5f5;
            --card-bg: #ffffff;
            --text-primary: #333333;
            --text-secondary: #666666;
        }

        body.dark-theme {
            /* Explicitly set dark theme variables (same as root) */
            --primary: #f7c427;
            --dark-bg: #121212;
            --card-bg: #1e1e1e;
            --text-primary: #ffffff;
            --text-secondary: #b3b3b3;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--dark-bg);
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            scroll-behavior: smooth;
        }

        .navbar {
            background-color: rgba(18, 18, 18, 0.9);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            padding: 15px 0;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 24px;
            color: var(--primary);
        }

        .logo-icon {
            margin-right: 10px;
            font-size: 28px;
            color: var(--primary);
        }

        .nav-link {
            color: var(--text-primary);
            font-weight: 500;
            margin: 0 10px;
            transition: color 0.3s;
        }

        .nav-link:hover {
            color: var(--primary);
        }

        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url("assets/images/cab1.webp") center/cover no-repeat;
            padding: 150px 0;
            text-align: center;
            margin-bottom: 50px;
        }

        .hero-title {
            font-size: 48px;
            font-weight: 700;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }

        .hero-subtitle {
            font-size: 22px;
            margin-bottom: 30px;
            color: var(--text-secondary);
        }

        .feature-card {
            background-color: var(--card-bg);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            transition: transform 0.3s, box-shadow 0.3s;
            height: 100%;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
        }

        .feature-icon {
            font-size: 40px;
            margin-bottom: 20px;
            color: var(--primary);
        }

        .feature-title {
            font-size: 22px;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .feature-text {
            color: var(--text-secondary);
            font-size: 16px;
        }

        .cta-section {
            background-color: var(--card-bg);
            padding: 60px 0;
            text-align: center;
            /*margin: 50px 0;*/
            border-radius: 15px;
        }

        .btn-custom {
            padding: 12px 30px;
            font-weight: 600;
            border-radius: 50px;
            transition: all 0.3s;
            margin: 10px;
            border: none;
        }

        .btn-register {
            background-color: var(--primary);
            color: #000;
        }

        .btn-register:hover {
            background-color: #e3b324;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(247, 196, 39, 0.3);
        }

        .btn-login {
            background-color: transparent;
            color: var(--text-primary);
            border: 2px solid var(--primary);
        }

        .btn-login:hover {
            background-color: var(--primary);
            color: #000;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(247, 196, 39, 0.3);
        }

        .btn-admin {
            background-color: #343a40;
            color: var(--text-primary);
        }

        .btn-admin:hover {
            background-color: #23272b;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(52, 58, 64, 0.3);
        }

        .footer {
            background-color: rgba(18, 18, 18, 0.95);
            padding: 50px 0 20px;
            margin-top: auto;
        }

        .footer-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--primary);
        }

        .footer-link {
            display: block;
            color: var(--text-secondary);
            margin-bottom: 10px;
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-link:hover {
            color: var(--primary);
        }

        .social-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--card-bg);
            color: var(--primary);
            margin-right: 10px;
            transition: all 0.3s;
        }

        .social-icon:hover {
            background-color: var(--primary);
            color: #000;
            transform: translateY(-3px);
        }

        .copyright {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            margin-top: 30px;
            color: var(--text-secondary);
        }

        .section-title {
            position: relative;
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 50px;
            text-align: center;
            padding-bottom: 20px;
        }

        .section-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 70px;
            height: 3px;
            background-color: var(--primary);
        }

        .about-section {
            padding: 80px 0;
        }

        .about-img {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .about-content {
            padding: 20px;
        }

        .counter-box {
            background-color: var(--card-bg);
            padding: 30px 20px;
            border-radius: 15px;
            text-align: center;
            margin-top: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .counter-number {
            font-size: 40px;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 10px;
        }

        .counter-text {
            font-size: 18px;
            color: var(--text-secondary);
        }

        .services-section {
            padding: 80px 0;
            background-color: rgba(30, 30, 30, 0.3);
        }

        .service-card {
            background-color: var(--card-bg);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            transition: transform 0.3s, box-shadow 0.3s;
            height: 100%;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .service-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
        }

        .service-icon {
            width: 80px;
            height: 80px;
            line-height: 80px;
            text-align: center;
            background-color: rgba(247, 196, 39, 0.2);
            border-radius: 50%;
            margin: 0 auto 25px;
            color: var(--primary);
            font-size: 32px;
            transition: all 0.3s;
        }

        .service-card:hover .service-icon {
            background-color: var(--primary);
            color: #000;
        }

        .contact-section {
            padding: 80px 0;
        }

        .contact-info-box {
            background-color: var(--card-bg);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            display: flex;
            align-items: center;
        }

        .contact-icon {
            width: 60px;
            height: 60px;
            background-color: rgba(247, 196, 39, 0.2);
            color: var(--primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-right: 20px;
            flex-shrink: 0;
        }

        .contact-form {
            background-color: var(--card-bg);
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .form-control {
            background-color: rgba(255, 255, 255, 0.1);
            border: none;
            border-radius: 8px;
            padding: 15px;
            color: var(--text-primary);
            margin-bottom: 20px;
        }

        .form-control:focus {
            background-color: rgba(255, 255, 255, 0.15);
            color: var(--text-primary);
            box-shadow: none;
            border: 1px solid var(--primary);
        }

        .form-control::placeholder {
            color: var(--text-secondary);
        }

        .map-container {
            border-radius: 15px;
            overflow: hidden;
            height: 400px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .section-padding {
            padding-top: 100px;
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#"><i class="fas fa-taxi logo-icon"></i>Mega City Cab</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="#home"><i class="fas fa-home"></i> Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#about"><i class="fas fa-info-circle"></i> About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#services"><i class="fas fa-car"></i> Services</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#contact"><i class="fas fa-phone"></i> Contact</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="Login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a>
                </li>
                <!-- Theme Toggle -->
                <li class="nav-item ms-3 d-flex align-items-center">
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="theme-toggle" onclick="toggleTheme()">
                        <label class="form-check-label" for="theme-toggle">
                            <i class="fas fa-sun me-1" style="color: var(--primary);"></i>
                            <i class="fas fa-moon" style="color: var(--primary);"></i>
                        </label>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section id="home" class="hero-section">
    <div class="container">
        <h1 class="hero-title">Welcome to Mega City Cab Service</h1>
        <p class="hero-subtitle">Your premium transportation partner in the heart of the city</p>
        <div>
            <a href="Register.jsp" class="btn btn-custom btn-register">
                <i class="fas fa-user-plus"></i> Register Now
            </a>
            <a href="Login.jsp" class="btn btn-custom btn-login">
                <i class="fas fa-sign-in-alt"></i> Login
            </a>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="container">
    <div class="row">
        <div class="col-md-4">
            <div class="feature-card">
                <i class="fas fa-route feature-icon"></i>
                <h3 class="feature-title">Smart Routing</h3>
                <p class="feature-text">Our AI-powered system finds the fastest routes even during peak hours, saving you time and money.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="feature-card">
                <i class="fas fa-shield-alt feature-icon"></i>
                <h3 class="feature-title">Safe Rides</h3>
                <p class="feature-text">All our drivers are thoroughly vetted, and vehicles undergo regular maintenance for your safety.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="feature-card">
                <i class="fas fa-money-bill-wave feature-icon"></i>
                <h3 class="feature-title">Transparent Pricing</h3>
                <p class="feature-text">No hidden charges or surge pricing. Pay only what you see before booking your ride.</p>
            </div>
        </div>
    </div>
</section>

<!-- About Section -->
<section id="about" class="about-section section-padding">
    <div class="container">
        <h2 class="section-title">About Us</h2>
        <div class="row align-items-center">
            <div class="col-lg-6">
                <div class="about-img">
                    <img src="assets/images/Cab2.png" alt="About Mega City Cab" class="img-fluid">
                </div>
            </div>
            <div class="col-lg-6">
                <div class="about-content">
                    <h3 class="mb-4">The Most Trusted Cab Service in Mega City</h3>
                    <p class="mb-4">Founded in 2010, Mega City Cab Service has been the leading transportation provider in the metropolitan area. We started with just 5 cars and have now expanded to a fleet of over 500 vehicles serving thousands of customers daily.</p>
                    <p class="mb-4">Our mission is to provide safe, reliable, and affordable transportation options for everyone. We leverage the latest technology to ensure that our services are efficient, environmentally friendly, and tailored to meet the diverse needs of our customers.</p>
                    <p>What sets us apart is our commitment to excellence, our professional drivers, and our dedication to customer satisfaction. Whether you're commuting to work, heading to the airport, or exploring the city, we've got you covered.</p>
                </div>
            </div>
        </div>

        <div class="row mt-5">
            <div class="col-md-3 col-6">
                <div class="counter-box">
                    <div class="counter-number">500+</div>
                    <div class="counter-text">Vehicles</div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="counter-box">
                    <div class="counter-number">1200+</div>
                    <div class="counter-text">Drivers</div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="counter-box">
                    <div class="counter-number">50K+</div>
                    <div class="counter-text">Monthly Rides</div>
                </div>
            </div>
            <div class="col-md-3 col-6">
                <div class="counter-box">
                    <div class="counter-number">98%</div>
                    <div class="counter-text">Customer Satisfaction</div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Services Section -->
<section id="services" class="services-section section-padding">
    <div class="container">
        <h2 class="section-title">Our Services</h2>
        <div class="row">
            <div class="col-lg-4 col-md-6">
                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-city"></i>
                    </div>
                    <h3 class="mb-3">City Travel</h3>
                    <p>Get around the city effortlessly with our reliable cab services. Available 24/7, our vehicles ensure you reach your destination on time, every time.</p>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-plane-departure"></i>
                    </div>
                    <h3 class="mb-3">Airport Transfer</h3>
                    <p>Never miss a flight with our punctual airport transfer services. Our drivers track your flight schedules to ensure timely pickups and drop-offs.</p>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-building"></i>
                    </div>
                    <h3 class="mb-3">Corporate Services</h3>
                    <p>Specialized services for businesses including employee transportation, client pickups, and corporate events with customized billing options.</p>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-road"></i>
                    </div>
                    <h3 class="mb-3">Intercity Travel</h3>
                    <p>Travel between cities comfortably with our intercity cab services. Long-distance journeys made easy with professional drivers and comfortable vehicles.</p>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <h3 class="mb-3">Scheduled Pickups</h3>
                    <p>Plan ahead with our scheduled pickup service. Book your ride in advance for important meetings, appointments, or regular commutes.</p>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="service-card">
                    <div class="service-icon">
                        <i class="fas fa-gift"></i>
                    </div>
                    <h3 class="mb-3">Premium Service</h3>
                    <p>Travel in luxury with our premium fleet of high-end vehicles. Perfect for special occasions, business meetings, or when you simply want to travel in style.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Contact Section -->
<section id="contact" class="contact-section section-padding">
    <div class="container">
        <h2 class="section-title">Contact Us</h2>
        <div class="row">
            <div class="col-lg-4">
                <div class="contact-info-box">
                    <div class="contact-icon">
                        <i class="fas fa-map-marker-alt"></i>
                    </div>
                    <div>
                        <h4>Our Location</h4>
                        <p class="mb-0">123 Main Street, Downtown,<br>Mega City, MC 12345</p>
                    </div>
                </div>
                <div class="contact-info-box">
                    <div class="contact-icon">
                        <i class="fas fa-phone-alt"></i>
                    </div>
                    <div>
                        <h4>Call Us</h4>
                        <p class="mb-0">+1 (555) 123-4567<br>+1 (555) 987-6543</p>
                    </div>
                </div>
                <div class="contact-info-box">
                    <div class="contact-icon">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <div>
                        <h4>Email Us</h4>
                        <p class="mb-0">info@megacitycab.com<br>support@megacitycab.com</p>
                    </div>
                </div>
                <div class="contact-info-box">
                    <div class="contact-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div>
                        <h4>Working Hours</h4>
                        <p class="mb-0">24/7 Service<br>Office: Mon-Sat: 9AM to 6PM</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-8">
                <div class="contact-form">
                    <form>
                        <div class="row">
                            <div class="col-md-6">
                                <input type="text" class="form-control" placeholder="Your Name">
                            </div>
                            <div class="col-md-6">
                                <input type="email" class="form-control" placeholder="Your Email">
                            </div>
                        </div>
                        <input type="text" class="form-control" placeholder="Subject">
                        <textarea class="form-control" rows="5" placeholder="Your Message"></textarea>
                        <button type="submit" class="btn btn-custom btn-register">
                            <i class="fas fa-paper-plane"></i> Send Message
                        </button>
                    </form>
                </div>
                <div class="map-container mt-4">
                    <img src="assets/images/map.png" alt="Map" class="img-fluid">
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="container cta-section">
    <h2 class="mb-4">Ready for a Better Cab Experience?</h2>
    <p class="mb-5">Join thousands of satisfied customers who rely on Mega City Cab Service for their daily commute.</p>
    <div>
        <a href="admin_login.jsp" class="btn btn-custom btn-admin">
            <i class="fas fa-user-shield"></i> Admin Login
        </a>
        <a href="Register.jsp" class="btn btn-custom btn-register">
            <i class="fas fa-user-plus"></i> Register
        </a>
        <a href="Login.jsp" class="btn btn-custom btn-login">
            <i class="fas fa-sign-in-alt"></i> Login
        </a>
    </div>
</section>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <h5 class="footer-title"><i class="fas fa-taxi logo-icon"></i> Mega City Cab</h5>
                <p>Providing premium transportation services since 2010. Our mission is to make transportation safe, reliable, and affordable for everyone.</p>
                <div class="mt-4">
                    <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            <div class="col-md-2">
                <h5 class="footer-title">Quick Links</h5>
                <a href="#home" class="footer-link">Home</a>
                <a href="#about" class="footer-link">About Us</a>
                <a href="#services" class="footer-link">Services</a>
                <a href="#contact" class="footer-link">Contact</a>
            </div>
            <div class="col-md-3">
                <h5 class="footer-title">Our Services</h5>
                <a href="#" class="footer-link">City Travel</a>
                <a href="#" class="footer-link">Airport Transfer</a>
                <a href="#" class="footer-link">Corporate Services</a>
                <a href="#" class="footer-link">Intercity Travel</a>
            </div>
            <div class="col-md-3">
                <h5 class="footer-title">Contact Us</h5>
                <p><i class="fas fa-map-marker-alt me-2"></i> 123 Main Street, Mega City</p>
                <p><i class="fas fa-phone me-2"></i> +1 (555) 123-4567</p>
                <p><i class="fas fa-envelope me-2"></i> info@megacitycab.com</p>
            </div>
        </div>
        <div class="copyright">
            <p>&copy; 2025 Mega City Cab Service. All rights reserved.</p>
        </div>
    </div>
</footer>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<script>
    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();

            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });

    // Theme toggle functionality
    document.addEventListener('DOMContentLoaded', function() {
        // Check for saved theme preference or use default dark theme
        const currentTheme = localStorage.getItem('theme') || 'dark';
        document.body.classList.add(currentTheme + '-theme');

        // Update toggle button state based on current theme
        const themeToggle = document.getElementById('theme-toggle');
        if (themeToggle) {
            themeToggle.checked = currentTheme === 'light';
        }
    });

    function toggleTheme() {
        const themeToggle = document.getElementById('theme-toggle');
        const isDark = !themeToggle.checked;
        const newTheme = isDark ? 'dark' : 'light';
        // const savedTheme = localStorage.getItem('theme') || 'dark';

        // Remove old theme class and add new one
        document.body.classList.remove('dark-theme', 'light-theme');
        document.body.classList.add(newTheme + '-theme');
        // document.documentElement.classList.add(savedTheme + '-theme');

        // Save preference to localStorage
        localStorage.setItem('theme', newTheme);
    }
</script>
</body>
</html>