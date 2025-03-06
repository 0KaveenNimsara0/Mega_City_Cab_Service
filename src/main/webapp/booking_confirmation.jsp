<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Your Booking - Mega City Cab Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db;
            --primary-dark: #2980b9;
            --secondary-color: #f39c12;
            --success-color: #2ecc71;
            --danger-color: #e74c3c;
            --text-color: #2c3e50;
            --light-bg: #f5f7fa;
            --border-radius: 10px;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: var(--text-color);
            min-height: 100vh;
            padding: 20px 0 40px;
        }

        .header {
            background-color: var(--primary-color);
            color: white;
            padding: 15px 0;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .confirmation-container {
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            padding: 30px;
            margin-top: 20px;
            position: relative;
            overflow: hidden;
        }

        .confirmation-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--primary-color), var(--success-color));
        }

        .booking-title {
            color: var(--text-color);
            text-align: center;
            margin-bottom: 30px;
            font-weight: 700;
            position: relative;
            padding-bottom: 15px;
        }

        .booking-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background-color: var(--primary-color);
        }

        .confirmation-header {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
        }

        .confirmation-icon {
            width: 80px;
            height: 80px;
            background-color: #e8f4fc;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: var(--primary-color);
            font-size: 40px;
        }

        .details-card {
            background-color: var(--light-bg);
            border-radius: var(--border-radius);
            padding: 20px;
            margin-bottom: 25px;
            border-left: 4px solid var(--primary-color);
        }

        .card-title {
            color: var(--primary-color);
            margin-bottom: 15px;
            font-weight: 600;
            display: flex;
            align-items: center;
        }

        .card-title i {
            margin-right: 10px;
        }

        .detail-row {
            display: flex;
            margin-bottom: 10px;
            align-items: center;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            padding-bottom: 10px;
        }

        .detail-row:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .detail-label {
            flex: 0 0 40%;
            font-weight: 500;
            color: #7f8c8d;
        }

        .detail-value {
            flex: 0 0 60%;
            font-weight: 500;
        }

        .price-row {
            font-size: 18px;
            font-weight: 700;
            color: var(--primary-dark);
        }

        .discount-value {
            color: var(--success-color);
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .btn-confirm {
            background: linear-gradient(to right, var(--primary-color), var(--primary-dark));
            color: white;
            border: none;
            border-radius: var(--border-radius);
            padding: 12px 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            flex: 1;
        }

        .btn-confirm:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            background: linear-gradient(to right, var(--primary-dark), var(--primary-color));
        }

        .btn-cancel {
            background-color: white;
            color: var(--danger-color);
            border: 2px solid var(--danger-color);
            border-radius: var(--border-radius);
            padding: 12px 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            flex: 1;
        }

        .btn-cancel:hover {
            background-color: var(--danger-color);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .summary-box {
            background-color: #f8f9fa;
            border-radius: var(--border-radius);
            padding: 20px;
            margin-top: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .total-amount {
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-dark);
            text-align: center;
            margin: 10px 0;
        }

        .note-text {
            background-color: #fff8e1;
            border-left: 4px solid var(--secondary-color);
            padding: 15px;
            border-radius: 0 var(--border-radius) var(--border-radius) 0;
            margin: 20px 0;
            font-size: 14px;
        }

        @media (max-width: 768px) {
            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<header class="header">
    <div class="container">
        <div class="d-flex justify-content-center align-items-center">
            <i class="fas fa-taxi me-2" style="font-size: 24px;"></i>
            <h1 class="m-0">Mega City Cab Service</h1>
        </div>
    </div>
</header>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-7">
            <div class="confirmation-container">
                <div class="confirmation-header">
                    <div class="confirmation-icon">
                        <i class="fas fa-clipboard-check"></i>
                    </div>
                    <h2 class="booking-title mb-0">Confirm Your Booking</h2>
                </div>

                <div class="alert alert-info" role="alert">
                    <i class="fas fa-info-circle me-2"></i>
                    Please review your booking details before confirming
                </div>

                <form action="BookingServlet" method="post">
                    <!-- Trip Details -->
                    <div class="details-card">
                        <h4 class="card-title"><i class="fas fa-route"></i>Trip Details</h4>
                        <div class="detail-row">
                            <div class="detail-label">
                                <i class="fas fa-map-marker-alt me-2 text-primary"></i>Pickup Point:
                            </div>
                            <div class="detail-value">${pickupPoint}</div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">
                                <i class="fas fa-location-arrow me-2 text-success"></i>Destination:
                            </div>
                            <div class="detail-value">${destination}</div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">
                                <i class="fas fa-road me-2 text-secondary"></i>Distance:
                            </div>
                            <div class="detail-value">${distance} km</div>
                        </div>
                    </div>

                    <!-- Vehicle & Schedule -->
                    <div class="details-card">
                        <h4 class="card-title"><i class="fas fa-car"></i>Vehicle & Schedule</h4>
                        <div class="detail-row">
                            <div class="detail-label">
                                <i class="fas fa-taxi me-2 text-warning"></i>Vehicle Type:
                            </div>
                            <div class="detail-value">${carType}</div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">
                                <i class="fas fa-calendar-alt me-2 text-info"></i>Pickup Date:
                            </div>
                            <div class="detail-value">${pickupDate}</div>
                        </div>
                    </div>

                    <!-- Pricing Details -->
                    <div class="details-card">
                        <h4 class="card-title"><i class="fas fa-file-invoice-dollar"></i>Pricing Details</h4>
                        <div class="detail-row">
                            <div class="detail-label">
                                <i class="fas fa-dollar-sign me-2 text-secondary"></i>Per-KM Rate:
                            </div>
                            <div class="detail-value">LKR ${perKmRate}</div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">
                                <i class="fas fa-percentage me-2 text-info"></i>Tax:
                            </div>
                            <div class="detail-value">LKR ${tax}</div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">
                                <i class="fas fa-tag me-2 text-success"></i>Coupon Code:
                            </div>
                            <div class="detail-value">${couponCode != null && !couponCode.isEmpty() ? couponCode : 'Not Applied'}</div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">
                                <i class="fas fa-piggy-bank me-2 text-success"></i>Discount:
                            </div>
                            <div class="detail-value discount-value">${discount}%</div>

                        </div>
                        <div class="detail-row price-row">
                            <div class="detail-label">
                                <i class="fas fa-money-bill-wave me-2"></i>Total Amount:
                            </div>
                            <div class="detail-value">LKR ${totalAmount}</div>
                        </div>
                    </div>

                    <div class="summary-box">
                        <h5 class="text-center mb-3">Booking Summary</h5>
                        <p class="text-center mb-2">Your estimated fare:</p>
                        <div class="total-amount">LKR ${totalAmount}</div>
                        <p class="text-center text-muted small">Including all taxes and discounts</p>
                    </div>

                    <div class="note-text">
                        <i class="fas fa-lightbulb me-2 text-warning"></i>
                        <strong>Note:</strong> Your driver will contact you shortly before the pickup time. Please be ready at the pickup location.
                    </div>

                    <!-- Hidden Fields -->
                    <input type="hidden" name="pickupPoint" value="${pickupPointId}">
                    <input type="hidden" name="destination" value="${destinationId}">
                    <input type="hidden" name="carType" value="${carTypeId}">
                    <input type="hidden" name="pickupDate" value="${pickupDate}">
                    <input type="hidden" name="couponCode" value="${couponCode}">
                    <input type="hidden" name="distance" value="${distance}">
                    <input type="hidden" name="tax" value="${tax}">
                    <input type="hidden" name="perKmRate" value="${perKmRate}">
                    <input type="hidden" name="discount" value="${discount}">
                    <input type="hidden" name="totalAmount" value="${totalAmount}">

                    <!-- Action Buttons -->
                    <div class="action-buttons">
                        <button type="submit" class="btn btn-confirm">
                            <i class="fas fa-check-circle me-2"></i>Confirm Booking
                        </button>
                        <button type="button" class="btn btn-cancel" onclick="cancelBooking()">
                            <i class="fas fa-times-circle me-2"></i>Cancel
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function cancelBooking() {
        if (confirm("Are you sure you want to cancel this booking? All your information will be lost.")) {
            window.location.href = "Customer_Dashboard.jsp"; // Redirect to the customer dashboard
        }
    }
</script>
</body>
</html>