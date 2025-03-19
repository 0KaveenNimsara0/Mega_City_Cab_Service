<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation - Mega City Cab Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }

        .header {
            background-color: #3498db;
            color: #333;
            padding: 15px 0;
            margin-bottom: 20px;
        }

        .confirmation-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .success-icon {
            width: 60px;
            height: 60px;
            background-color: #d4edda;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 20px auto;
            color: #28a745;
            font-size: 30px;
        }

        .booking-details {
            padding: 20px;
            background-color: #f8f9fa;
        }

        .booking-id {
            background-color: #e9f5fe;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
        }

        .detail-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .total-amount {
            background-color: #fffbeb;
            padding: 10px;
            border-radius: 5px;
            margin-top: 15px;
            font-weight: bold;
        }

        .action-buttons {
            padding: 20px;
            text-align: center;
        }

        .footer {
            text-align: center;
            padding: 15px;
            color: #666;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
<!-- Header -->
<header class="header">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <h4 class="m-0">Mega City Cab Service</h4>
            <h5 class="m-0">Booking Confirmation</h5>
        </div>
    </div>
</header>

<!-- Main Content -->
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="confirmation-card">
                <!-- Success Icon -->
                <div class="text-center pt-4">
                    <div class="success-icon">
                        <i class="fas fa-check"></i>
                    </div>
                    <h3>Booking Confirmed!</h3>
                    <p>Your ride has been successfully booked.</p>
                </div>

                <!-- Booking Details -->
                <div class="booking-details">
                    <div class="booking-id">
                        <div class="detail-item">
                            <span><i class="fas fa-ticket-alt me-2"></i>Booking ID</span>
                            <span>
                                    <%= request.getAttribute("bookingId") != null ? request.getAttribute("bookingId") : "N/A" %>
                                    <i class="far fa-copy ms-2" style="cursor: pointer;" onclick="copyBookingId()"></i>
                                </span>
                        </div>
                    </div>

                    <h5 class="text-center mb-3">Trip Details</h5>

                    <div class="detail-item">
                        <span><i class="fas fa-map-marker-alt me-2"></i>Pickup Point</span>
                        <span><%= request.getAttribute("pickupPoint") != null ? request.getAttribute("pickupPoint") : "N/A" %></span>
                    </div>

                    <div class="detail-item">
                        <span><i class="fas fa-map-marker me-2"></i>Destination</span>
                        <span><%= request.getAttribute("destination") != null ? request.getAttribute("destination") : "N/A" %></span>
                    </div>

                    <div class="detail-item">
                        <span><i class="fas fa-car me-2"></i>Vehicle Type</span>
                        <span><%= request.getAttribute("carType") != null ? request.getAttribute("carType") : "N/A" %></span>
                    </div>

                    <div class="detail-item">
                        <span><i class="far fa-calendar-alt me-2"></i>Pickup Date</span>
                        <span><%= request.getAttribute("pickupDate") != null ? request.getAttribute("pickupDate") : "N/A" %></span>
                    </div>

                    <hr>

                    <div class="total-amount detail-item">
                        <span><i class="fas fa-money-bill-wave me-2"></i>Total Amount</span>
                        <span>LKR <%= request.getAttribute("totalAmount") != null ? request.getAttribute("totalAmount") : "N/A" %></span>
                    </div>
                </div>

                <!-- Simple Rating -->
                <div class="text-center py-3">
                    <h6>Rate our service:</h6>
                    <div class="mb-2">
                        <span class="star" onclick="rate(1)"><i class="far fa-star"></i></span>
                        <span class="star" onclick="rate(2)"><i class="far fa-star"></i></span>
                        <span class="star" onclick="rate(3)"><i class="far fa-star"></i></span>
                        <span class="star" onclick="rate(4)"><i class="far fa-star"></i></span>
                        <span class="star" onclick="rate(5)"><i class="far fa-star"></i></span>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="action-buttons">
                    <a href="Customer_Dashboard.jsp" class="btn btn-primary me-2">
                        <i class="fas fa-home me-1"></i>Return to Dashboard
                    </a>
                    <button class="btn btn-outline-secondary" onclick="printBooking()">
                        <i class="fas fa-print me-1"></i>Print Receipt
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <p>Contact our support team at <strong>support@megacitycab.com</strong></p>
    </div>
</footer>

<!-- JavaScript -->
<script>
    // Copy booking ID to clipboard
    function copyBookingId() {
        const bookingId = '<%= request.getAttribute("bookingId") != null ? request.getAttribute("bookingId") : "N/A" %>';
        if (bookingId !== 'N/A') {
            navigator.clipboard.writeText(bookingId)
                .then(() => {
                    alert('Booking ID copied to clipboard!');
                })
                .catch(err => {
                    console.error('Could not copy text: ', err);
                });
        }
    }

    // Print booking receipt
    function printBooking() {
        window.print();
    }

    // Star rating functionality
    function rate(rating) {
        const stars = document.querySelectorAll('.star i');

        // Reset all stars
        stars.forEach(star => star.className = 'far fa-star');

        // Fill stars up to selected rating
        for (let i = 0; i < rating; i++) {
            stars[i].className = 'fas fa-star';
        }

        // Simple alert for feedback
        setTimeout(() => {
            alert('Thank you for your feedback!');
        }, 300);
    }
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>