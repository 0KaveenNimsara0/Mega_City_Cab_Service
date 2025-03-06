<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.UUID" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thank You - Mega City Cab Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #333333;
            --accent-color: #1a73e8;
            --success-color: #28a745;
            --light-gray: #f8f9fa;
            --dark-gray: #495057;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f5f5;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .page-header {
            background-color: var(--primary-color);
            color: var(--secondary-color);
            padding: 15px 0;
            border-radius: 0 0 15px 15px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .cab-logo {
            max-height: 60px;
        }

        .success-card {
            background-color: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            border: none;
            margin-bottom: 40px;
            position: relative;
        }

        .success-icon-container {
            text-align: center;
            margin: 30px auto 20px;
        }

        .success-icon {
            height: 80px;
            width: 80px;
            background-color: #d4edda;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto;
            color: var(--success-color);
            font-size: 40px;
            animation: scale-up 0.5s ease-in-out;
        }

        @keyframes scale-up {
            0% { transform: scale(0); opacity: 0; }
            80% { transform: scale(1.1); }
            100% { transform: scale(1); opacity: 1; }
        }

        .thank-you-message {
            text-align: center;
            padding: 0 20px 20px;
        }

        .thank-you-message h2 {
            color: var(--secondary-color);
            font-weight: 600;
        }

        .booking-summary {
            padding: 20px 30px;
            background-color: var(--light-gray);
            border-top: 1px solid #eee;
        }

        .booking-summary h4 {
            color: var(--secondary-color);
            margin-bottom: 20px;
            font-weight: 600;
            text-align: center;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            align-items: center;
        }

        .summary-item .label {
            color: var(--dark-gray);
            font-weight: 500;
            display: flex;
            align-items: center;
        }

        .summary-item .value {
            font-weight: 400;
            text-align: right;
        }

        .booking-id {
            background-color: #e9f5fe;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .booking-id .label {
            color: var(--accent-color);
            font-weight: 600;
        }

        .booking-id .value {
            font-family: monospace;
            font-weight: 600;
            font-size: 1.1rem;
            color: var(--accent-color);
            letter-spacing: 1px;
        }

        .total-amount {
            background-color: #fffbeb;
            padding: 15px;
            border-radius: 10px;
            margin-top: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 1.2rem;
        }

        .total-amount .label {
            font-weight: 600;
            color: var(--secondary-color);
        }

        .total-amount .value {
            font-weight: 700;
            color: var(--secondary-color);
        }

        .icon {
            margin-right: 10px;
            color: var(--accent-color);
        }

        .divider {
            height: 1px;
            background-color: #eee;
            margin: 15px 0;
        }

        .actions {
            display: flex;
            justify-content: center;
            gap: 15px;
            padding: 30px 0;
        }

        .btn-dashboard {
            background-color: var(--primary-color);
            color: var(--secondary-color);
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s;
            display: flex;
            align-items: center;
        }

        .btn-dashboard:hover {
            background-color: #e6b800;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .btn-dashboard i {
            margin-right: 8px;
        }

        .btn-print {
            background-color: white;
            color: var(--secondary-color);
            border: 1px solid #ddd;
            padding: 12px 25px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s;
            display: flex;
            align-items: center;
        }

        .btn-print:hover {
            background-color: #f8f9fa;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .btn-print i {
            margin-right: 8px;
        }

        .rating-section {
            padding: 20px;
            text-align: center;
            background-color: white;
        }

        .rating-section h5 {
            margin-bottom: 15px;
            color: var(--secondary-color);
        }

        .stars {
            display: flex;
            justify-content: center;
            gap: 5px;
            margin-bottom: 15px;
        }

        .star {
            color: #ddd;
            font-size: 30px;
            cursor: pointer;
            transition: color 0.2s;
        }

        .star:hover, .star.active {
            color: #ffc107;
        }

        .footer {
            text-align: center;
            padding: 20px;
            color: var(--dark-gray);
            font-size: 0.9rem;
            margin-top: auto;
        }

        .social-links {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 10px;
        }

        .social-link {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background-color: #eee;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--secondary-color);
            transition: all 0.3s;
        }

        .social-link:hover {
            background-color: var(--primary-color);
            transform: translateY(-3px);
        }

        .confetti {
            position: absolute;
            width: 10px;
            height: 10px;
            background-color: #FFD700;
            opacity: 0;
            top: 0;
            animation: confetti-fall 3s ease-in-out forwards;
        }

        @keyframes confetti-fall {
            0% {
                transform: translateY(-10px) rotate(0deg);
                opacity: 1;
            }
            100% {
                transform: translateY(400px) rotate(360deg);
                opacity: 0;
            }
        }

        /* Responsive adjustments */
        @media (max-width: 767.98px) {
            .booking-id, .total-amount {
                flex-direction: column;
                align-items: flex-start;
            }

            .booking-id .value, .total-amount .value {
                margin-top: 5px;
            }

            .actions {
                flex-direction: column;
            }

            .btn-dashboard, .btn-print {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<header class="page-header">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center">
                <img src="/api/placeholder/120/60" alt="Mega City Cab" class="cab-logo">
            </div>
            <h1 class="m-0 fs-3">Booking Confirmation</h1>
        </div>
    </div>
</header>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-10 col-lg-8">
            <div class="success-card">
                <!-- Animated confetti elements -->
                <div id="confetti-container"></div>

                <!-- Success icon -->
                <div class="success-icon-container">
                    <div class="success-icon">
                        <i class="fas fa-check"></i>
                    </div>
                </div>

                <!-- Thank you message -->
                <div class="thank-you-message">
                    <h2>Booking Confirmed!</h2>
                    <p>Thank you for choosing Mega City Cab Service. Your ride has been successfully booked.</p>
                </div>

                <!-- Booking summary -->
                <div class="booking-summary">
                    <div class="booking-id">
                        <div class="label">
                            <i class="fas fa-ticket-alt icon"></i>Booking ID
                        </div>
                        <div class="value">
                            <%= request.getAttribute("bookingId") != null ? request.getAttribute("bookingId") : "N/A" %>
                            <i class="far fa-copy ms-2" style="cursor: pointer;" onclick="copyBookingId()"></i>
                        </div>
                    </div>

                    <h4>Trip Details</h4>

                    <div class="summary-item">
                        <div class="label">
                            <i class="fas fa-map-marker-alt icon"></i>Pickup Point
                        </div>
                        <div class="value">
                            <%= request.getAttribute("pickupPoint") != null ? request.getAttribute("pickupPoint") : "N/A" %>
                        </div>
                    </div>

                    <div class="summary-item">
                        <div class="label">
                            <i class="fas fa-map-marker icon"></i>Destination
                        </div>
                        <div class="value">
                            <%= request.getAttribute("destination") != null ? request.getAttribute("destination") : "N/A" %>
                        </div>
                    </div>

                    <div class="summary-item">
                        <div class="label">
                            <i class="fas fa-car icon"></i>Vehicle Type
                        </div>
                        <div class="value">
                            <%= request.getAttribute("carType") != null ? request.getAttribute("carType") : "N/A" %>
                        </div>
                    </div>

                    <div class="summary-item">
                        <div class="label">
                            <i class="far fa-calendar-alt icon"></i>Pickup Date
                        </div>
                        <div class="value">
                            <%= request.getAttribute("pickupDate") != null ? request.getAttribute("pickupDate") : "N/A" %>
                        </div>
                    </div>

                    <div class="divider"></div>

                    <div class="total-amount">
                        <div class="label">
                            <i class="fas fa-money-bill-wave icon"></i>Total Amount
                        </div>
                        <div class="value">
                            LKR <%= request.getAttribute("totalAmount") != null ? request.getAttribute("totalAmount") : "N/A" %>
                        </div>
                    </div>
                </div>

                <!-- Rating section -->
                <div class="rating-section">
                    <h5>How would you rate our service?</h5>
                    <div class="stars">
                        <span class="star" onclick="rate(1)"><i class="fas fa-star"></i></span>
                        <span class="star" onclick="rate(2)"><i class="fas fa-star"></i></span>
                        <span class="star" onclick="rate(3)"><i class="fas fa-star"></i></span>
                        <span class="star" onclick="rate(4)"><i class="fas fa-star"></i></span>
                        <span class="star" onclick="rate(5)"><i class="fas fa-star"></i></span>
                    </div>
                    <p id="rating-message" class="text-muted">Click to rate our service</p>
                </div>

                <!-- Action buttons -->
                <div class="actions">
                    <a href="Customer_Dashboard.jsp" class="btn btn-dashboard">
                        <i class="fas fa-home"></i>Return to Dashboard
                    </a>
                    <button class="btn btn-print" onclick="printBooking()">
                        <i class="fas fa-print"></i>Print Receipt
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="footer">
    <div class="container">
        <p>You will receive a confirmation email shortly with all your booking details.</p>
        <p>Have questions? Contact our support team at <strong>support@megacitycab.com</strong></p>

        <div class="social-links">
            <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
            <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
            <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
            <a href="#" class="social-link"><i class="fab fa-whatsapp"></i></a>
        </div>
    </div>
</footer>

<!-- JavaScript -->
<script>
    // Create confetti animation
    function createConfetti() {
        const container = document.getElementById('confetti-container');
        const colors = ['#ffcc00', '#ff6b6b', '#4ecdc4', '#1a535c', '#ff9f1c'];

        for (let i = 0; i < 50; i++) {
            const confetti = document.createElement('div');
            confetti.className = 'confetti';
            confetti.style.left = Math.random() * 100 + '%';
            confetti.style.backgroundColor = colors[Math.floor(Math.random() * colors.length)];
            confetti.style.width = Math.random() * 10 + 5 + 'px';
            confetti.style.height = confetti.style.width;
            confetti.style.animationDelay = Math.random() * 3 + 's';
            container.appendChild(confetti);
        }
    }

    // Copy booking ID to clipboard
    function copyBookingId() {
        const bookingId = '<%= request.getAttribute("bookingId") != null ? request.getAttribute("bookingId") : "N/A" %>';
        if (bookingId !== 'N/A') {
            navigator.clipboard.writeText(bookingId)
                .then(() => {
                    showNotification('Booking ID copied to clipboard!');
                })
                .catch(err => {
                    console.error('Could not copy text: ', err);
                });
        }
    }

    // Show notification
    function showNotification(message) {
        // Create notification element
        const notification = document.createElement('div');
        notification.style.position = 'fixed';
        notification.style.bottom = '20px';
        notification.style.left = '50%';
        notification.style.transform = 'translateX(-50%)';
        notification.style.backgroundColor = '#333';
        notification.style.color = 'white';
        notification.style.padding = '10px 20px';
        notification.style.borderRadius = '5px';
        notification.style.zIndex = '1000';
        notification.style.opacity = '0';
        notification.style.transition = 'opacity 0.3s ease-in-out';
        notification.textContent = message;

        // Add to document
        document.body.appendChild(notification);

        // Show notification
        setTimeout(() => { notification.style.opacity = '1'; }, 10);

        // Hide and remove after 3 seconds
        setTimeout(() => {
            notification.style.opacity = '0';
            setTimeout(() => {
                document.body.removeChild(notification);
            }, 300);
        }, 3000);
    }

    // Print booking receipt
    function printBooking() {
        window.print();
    }

    // Star rating functionality
    function rate(rating) {
        const stars = document.querySelectorAll('.star');
        const messages = [
            'Poor - We\'ll do better next time',
            'Fair - Thanks for your feedback',
            'Good - We appreciate your business',
            'Very Good - Glad you enjoyed the ride',
            'Excellent - Thank you for your support!'
        ];

        // Reset all stars
        stars.forEach(star => star.classList.remove('active'));

        // Highlight stars up to the selected rating
        for (let i = 0; i < rating; i++) {
            stars[i].classList.add('active');
        }

        // Update rating message
        document.getElementById('rating-message').textContent = messages[rating - 1];

        // Send rating to server (simulated)
        setTimeout(() => {
            showNotification('Thank you for your feedback!');
        }, 500);
    }

    // Run on page load
    document.addEventListener('DOMContentLoaded', function() {
        createConfetti();
    });
</script>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>