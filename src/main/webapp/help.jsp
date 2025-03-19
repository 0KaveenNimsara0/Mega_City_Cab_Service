<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help Center - Mega City Cab Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            line-height: 1.6;
        }

        .help-container {
            max-width: 900px;
            margin: 30px auto;
            padding: 25px;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        .main-title {
            color: #0d6efd;
            font-weight: 700;
            margin-bottom: 25px;
            text-align: center;
            font-size: 2.2rem;
        }

        .section-title {
            color: #212529;
            font-weight: 600;
            margin: 30px 0 20px;
            border-bottom: 2px solid #0d6efd;
            padding-bottom: 8px;
            font-size: 1.4rem;
            display: flex;
            align-items: center;
        }

        .section-title i {
            margin-right: 10px;
            color: #0d6efd;
        }

        .welcome-text {
            background-color: #f0f8ff;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #0d6efd;
        }

        .faq-item {
            margin-bottom: 15px;
            background-color: #ffffff;
            border-radius: 8px;
            padding: 15px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
            border-left: 3px solid #0d6efd;
        }

        .faq-question {
            font-weight: 600;
            color: #0d6efd;
            margin-bottom: 10px;
            font-size: 1.1rem;
            display: flex;
            align-items: center;
        }

        .faq-question i {
            margin-right: 10px;
        }

        .faq-answer {
            color: #495057;
            padding-left: 25px;
        }

        .faq-highlight {
            color: #0d6efd;
            font-weight: 500;
        }

        .contact-info {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-top: 25px;
        }

        .contact-card {
            display: flex;
            align-items: center;
            margin: 15px 0;
            padding: 10px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
        }

        .contact-card i {
            color: #0d6efd;
            margin-right: 15px;
            width: 20px;
            text-align: center;
        }

        .quick-links {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin: 20px 0;
        }

        .quick-link {
            background-color: #e9ecef;
            padding: 8px 15px;
            border-radius: 20px;
            color: #212529;
            text-decoration: none;
            border: 1px solid #dee2e6;
            display: flex;
            align-items: center;
            font-size: 0.9rem;
        }

        .quick-link:hover {
            background-color: #0d6efd;
            color: #ffffff;
        }

        .quick-link i {
            margin-right: 8px;
        }

        .step-number {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 22px;
            height: 22px;
            background-color: #0d6efd;
            color: #ffffff;
            border-radius: 50%;
            margin-right: 8px;
            font-size: 0.75rem;
            font-weight: bold;
        }

        .payment-methods {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            margin: 15px 0;
        }

        .payment-method {
            background-color: #f8f9fa;
            padding: 10px;
            border-radius: 8px;
            margin: 5px;
            text-align: center;
            width: 110px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.05);
        }

        .payment-method i {
            font-size: 1.8rem;
            margin-bottom: 8px;
            color: #0d6efd;
        }

        .tip-card {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            border-left: 3px solid #0d6efd;
            display: flex;
            align-items: flex-start;
        }

        .tip-card i {
            color: #0d6efd;
            margin-right: 10px;
            font-size: 1.2rem;
            margin-top: 3px;
        }

        .button-section {
            display: flex;
            justify-content: center;
            margin-top: 25px;
            gap: 15px;
        }

        .help-button {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            display: flex;
            align-items: center;
            font-weight: 500;
        }

        .help-button.primary {
            background-color: #0d6efd;
        }

        .help-button i {
            margin-right: 8px;
        }

        .coupon-box {
            background-color: #f8f9fa;
            border: 1px dashed #0d6efd;
            border-radius: 5px;
            padding: 5px 10px;
            display: inline-block;
            margin: 5px 10px;
            font-family: monospace;
            letter-spacing: 1px;
        }

        footer {
            text-align: center;
            margin-top: 30px;
            color: #6c757d;
            font-size: 0.9rem;
        }

        @media (max-width: 768px) {
            .help-container {
                margin: 15px;
                padding: 15px;
            }

            .payment-methods {
                justify-content: space-between;
            }

            .payment-method {
                width: 45%;
                margin-bottom: 10px;
            }

            .button-section {
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>
<div class="help-container">
    <h1 class="main-title"><i class="fas fa-headset me-2"></i>Help & Support</h1>

    <!-- Quick Links Section -->
    <div class="quick-links">
        <a href="#faqs" class="quick-link"><i class="fas fa-question-circle"></i>FAQs</a>
        <a href="#bookings" class="quick-link"><i class="fas fa-taxi"></i>Bookings</a>
        <a href="#payments" class="quick-link"><i class="fas fa-credit-card"></i>Payments</a>
        <a href="#troubleshooting" class="quick-link"><i class="fas fa-tools"></i>Troubleshooting</a>
        <a href="#contact" class="quick-link"><i class="fas fa-envelope"></i>Contact Us</a>
    </div>

    <!-- Section: Introduction -->
    <div class="welcome-text">
        <p>
            <strong>Welcome to the Mega City Cab Service Help Center!</strong> We're here to make your journey smooth and hassle-free. Browse through our comprehensive guides or reach out to our friendly support team for assistance with bookings, payments, or any other queries.
        </p>
    </div>

    <!-- Section: FAQs -->
    <div id="faqs" class="section-title"><i class="fas fa-question-circle"></i>Frequently Asked Questions</div>
    <div class="faq-container">
        <div class="faq-item">
            <div class="faq-question"><i class="fas fa-chevron-right"></i>How do I book a cab?</div>
            <div class="faq-answer">
                Booking a cab with Mega City Cab Service is quick and easy:
                <ol>
                    <li><span class="step-number">1</span><span class="faq-highlight">Sign in</span> to your account or create a new one if you're a first-time user.</li>
                    <li><span class="step-number">2</span>Enter your <span class="faq-highlight">pickup location</span> and <span class="faq-highlight">destination</span> using our interactive map or search feature.</li>
                    <li><span class="step-number">3</span>Select your preferred <span class="faq-highlight">vehicle type</span> (Economy, Comfort, Premium, or XL) based on your needs.</li>
                    <li><span class="step-number">4</span>Choose your <span class="faq-highlight">pickup date and time</span> - book in advance or select "ASAP" for immediate pickups.</li>
                    <li><span class="step-number">5</span><span class="faq-highlight">Review</span> your booking details, add any special instructions for the driver if needed.</li>
                    <li><span class="step-number">6</span><span class="faq-highlight">Confirm and pay</span> using your preferred payment method to secure your ride.</li>
                </ol>
                You'll receive an instant confirmation via SMS and email with your booking details.
            </div>
        </div>

        <div id="payments" class="faq-item">
            <div class="faq-question"><i class="fas fa-chevron-right"></i>What payment methods are accepted?</div>
            <div class="faq-answer">
                We offer multiple secure payment options for your convenience:

                <div class="payment-methods">
                    <div class="payment-method">
                        <i class="fas fa-money-bill-wave"></i>
                        <div>Cash</div>
                    </div>
                    <div class="payment-method">
                        <i class="fas fa-credit-card"></i>
                        <div>Credit Card</div>
                    </div>
                    <div class="payment-method">
                        <i class="fab fa-paypal"></i>
                        <div>PayPal</div>
                    </div>
                    <div class="payment-method">
                        <i class="fas fa-mobile-alt"></i>
                        <div>Mobile Wallet</div>
                    </div>
                </div>

                <p>All online payments are processed through our secure payment gateway with 256-bit encryption for maximum security. For corporate clients, we also offer monthly invoicing options.</p>
            </div>
        </div>

        <div id="bookings" class="faq-item">
            <div class="faq-question"><i class="fas fa-chevron-right"></i>Can I cancel my booking?</div>
            <div class="faq-answer">
                Yes, we understand plans can change. Here's our cancellation policy:
                <ol>
                    <li><span class="step-number">1</span>Go to the <span class="faq-highlight">"My Bookings"</span> section in your account dashboard.</li>
                    <li><span class="step-number">2</span>Find the reservation you wish to cancel and click the <span class="faq-highlight">"Cancel Booking"</span> button.</li>
                    <li><span class="step-number">3</span>Select a reason for cancellation (optional but helpful) and confirm.</li>
                </ol>

                <p><strong>Cancellation Fees:</strong></p>
                <ul>
                    <li>More than 2 hours before pickup: <span class="faq-highlight">No charge</span></li>
                    <li>30 minutes to 2 hours before pickup: <span class="faq-highlight">25% of fare</span></li>
                    <li>Less than 30 minutes before pickup: <span class="faq-highlight">50% of fare</span></li>
                    <li>After driver is dispatched: <span class="faq-highlight">Full fare may apply</span></li>
                </ul>

                <p>For premium bookings and airport transfers, different cancellation policies may apply. Check your booking confirmation for details.</p>
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question"><i class="fas fa-chevron-right"></i>How do I apply a coupon code?</div>
            <div class="faq-answer">
                Save on your rides by applying our promotional coupon codes:
                <ol>
                    <li><span class="step-number">1</span>During the booking process, proceed to the <span class="faq-highlight">payment page</span>.</li>
                    <li><span class="step-number">2</span>Look for the <span class="faq-highlight">"Have a coupon?"</span> section and click to expand it.</li>
                    <li><span class="step-number">3</span>Enter your coupon code in the field and click <span class="faq-highlight">"Apply"</span>.</li>
                    <li><span class="step-number">4</span>If valid, you'll see the discount applied to your total fare instantly.</li>
                </ol>

                <p><strong>Popular coupon codes:</strong></p>
                <span class="coupon-box">WELCOME10</span> - 10% off your first ride (up to $15)
                <span class="coupon-box">SUMMER15</span> - 15% off during summer weekends
                <span class="coupon-box">AIRPORT25</span> - $25 off airport transfers
                <span class="coupon-box">REFER20</span> - 20% off when you refer a friend

                <p>Note: Coupon codes cannot be combined and are subject to terms and conditions. Most coupons expire after 30 days from issuance.</p>
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question"><i class="fas fa-chevron-right"></i>What if my driver is late?</div>
            <div class="faq-answer">
                We strive for punctuality, but sometimes delays happen due to traffic or other circumstances:
                <ul>
                    <li>If your driver is running late, you'll receive a notification through the app with the updated ETA.</li>
                    <li>You can track your driver's location in real-time through the app map.</li>
                    <li>If the delay exceeds 15 minutes from the scheduled pickup time, you'll receive a <span class="faq-highlight">10% discount</span> on your current ride automatically.</li>
                    <li>For delays exceeding 30 minutes, you have the option to cancel without any cancellation fee or receive a <span class="faq-highlight">25% discount</span>.</li>
                </ul>

                <p>If you need immediate assistance regarding a delayed pickup, contact our 24/7 support line at +123 456 7890.</p>
            </div>
        </div>
    </div>

    <!-- Section: Troubleshooting -->
    <div id="troubleshooting" class="section-title"><i class="fas fa-tools"></i>Troubleshooting Tips</div>
    <div class="tip-card">
        <i class="fas fa-wifi"></i>
        <div>
            <strong>Connection Issues</strong>
            <p>Ensure you have a stable internet connection. Switch between Wi-Fi and mobile data to see which works better. Our app requires only minimal data usage for optimal performance.</p>
        </div>
    </div>
    <div class="tip-card">
        <i class="fas fa-broom"></i>
        <div>
            <strong>App Performance</strong>
            <p>If the app feels sluggish, try clearing the cache: Go to Settings > Apps > Mega City Cab > Storage > Clear Cache. This won't delete your account or booking history.</p>
        </div>
    </div>
    <div class="tip-card">
        <i class="fas fa-map-marker-alt"></i>
        <div>
            <strong>Location Accuracy</strong>
            <p>For more accurate pickup, ensure your device's location services are set to "High Accuracy" mode. If in a building, try moving closer to a window or stepping outside.</p>
        </div>
    </div>
    <div class="tip-card">
        <i class="fas fa-sync-alt"></i>
        <div>
            <strong>App Updates</strong>
            <p>Make sure you're using the latest version of our app. We regularly release updates with bug fixes and performance improvements. Check your app store for any pending updates.</p>
        </div>
    </div>

    <!-- Section: Contact Information -->
    <div id="contact" class="section-title"><i class="fas fa-envelope"></i>Contact Us</div>
    <div class="contact-info">
        <p>Our friendly support team is available 24/7 to assist you with any queries or concerns:</p>

        <div class="contact-card">
            <i class="fas fa-envelope"></i>
            <div>
                <strong>Email Support</strong><br>
                <a href="mailto:support@megacitycab.com" style="color: #0d6efd;">support@megacitycab.com</a>
                <div style="font-size: 0.8rem; color: #6c757d;">Response time: Within 2 hours</div>
            </div>
        </div>

        <div class="contact-card">
            <i class="fas fa-phone-alt"></i>
            <div>
                <strong>24/7 Helpline</strong><br>
                <a href="tel:+1234567890" style="color: #0d6efd;">+123 456 7890</a>
                <div style="font-size: 0.8rem; color: #6c757d;">Available: 24 hours, 7 days a week</div>
            </div>
        </div>

        <div class="contact-card">
            <i class="fas fa-comments"></i>
            <div>
                <strong>Live Chat</strong><br>
                <span style="color: #0d6efd;">Available on our website and app</span>
                <div style="font-size: 0.8rem; color: #6c757d;">Average wait time: Less than 1 minute</div>
            </div>
        </div>

        <div class="contact-card">
            <i class="fas fa-building"></i>
            <div>
                <strong>Head Office</strong><br>
                <span style="color: #6c757d;">123 Cab Service Lane, Mega City, Country</span>
                <div style="font-size: 0.8rem; color: #6c757d;">Office hours: Mon-Fri, 9 AM - 6 PM</div>
            </div>
        </div>
    </div>

    <div class="button-section">
        <button class="help-button primary"><i class="fas fa-headset"></i>Live Chat</button>
        <button class="help-button"><i class="fas fa-book"></i>View Full Guide</button>
        <button class="help-button"><i class="fas fa-question-circle"></i>Submit a Ticket</button>
    </div>

    <footer>
        <p>© 2025 Mega City Cab Service. All rights reserved.</p>
        <p>Version 2.5.3 | Last Updated: March 8, 2025</p>
    </footer>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>