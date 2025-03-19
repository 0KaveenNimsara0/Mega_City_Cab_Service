<%@ page import="com.example.mega_city_cab_service.model.Booking" %>
<%@ page import="com.example.mega_city_cab_service.model.Location" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Booking booking = (Booking) request.getAttribute("booking");
    if (booking == null) {
        booking = new Booking(); // Prevent null pointer exceptions
    }

    Location location = (Location) request.getAttribute("location");
    if (location == null) {
        location = new Location(); // Prevent null pointer exceptions
    }
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Your Booking - Mega City Cab Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for basic icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
            padding: 20px 0;
        }

        .header {
            background-color: #0275d8;
            color: white;
            padding: 15px 0;
            margin-bottom: 20px;
        }

        .confirmation-container {
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            padding: 20px;
            margin-top: 20px;
        }

        .booking-title {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .details-card {
            background-color: #f8f9fa;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 15px;
            border-left: 3px solid #0275d8;
        }

        .card-title {
            color: #0275d8;
            margin-bottom: 10px;
            font-weight: bold;
        }

        .detail-row {
            display: flex;
            margin-bottom: 8px;
            padding-bottom: 8px;
            border-bottom: 1px solid #eee;
        }

        .detail-row:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .detail-label {
            flex: 0 0 40%;
            font-weight: bold;
        }

        .detail-value {
            flex: 0 0 60%;
        }

        .discount-value {
            color: #28a745;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .btn-confirm {
            background-color: #0275d8;
            color: white;
            border: none;
            flex: 1;
        }

        .btn-cancel {
            background-color: white;
            color: #dc3545;
            border: 1px solid #dc3545;
            flex: 1;
        }

        .total-amount {
            font-size: 24px;
            font-weight: bold;
            color: #0275d8;
            text-align: center;
            margin: 10px 0;
        }

        .note-text {
            background-color: #fff3cd;
            border-left: 3px solid #ffc107;
            padding: 10px;
            margin: 15px 0;
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
            <i class="fas fa-taxi me-2"></i>
            <h1 class="m-0">Mega City Cab Service</h1>
        </div>
    </div>
</header>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="confirmation-container">
                <h2 class="booking-title">Confirm Your Booking</h2>

                <div class="alert alert-info" role="alert">
                    <i class="fas fa-info-circle me-2"></i>
                    Please review your booking details before confirming
                </div>

                <form action="BookingServlet" method="post">
                    <!-- Trip Details -->
                    <div class="details-card">
                        <h4 class="card-title">Trip Details</h4>
                        <div class="detail-row">
                            <div class="detail-label">Pickup Point:</div>
                            <div class="detail-value"><%= request.getAttribute("pickupPoint") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Destination:</div>
                            <div class="detail-value"><%= request.getAttribute("destination") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Distance:</div>
                            <div class="detail-value"><%= request.getAttribute("distance") %> km</div>
                        </div>
                    </div>

                    <!-- Vehicle & Schedule -->
                    <div class="details-card">
                        <h4 class="card-title">Vehicle & Schedule</h4>
                        <div class="detail-row">
                            <div class="detail-label">Vehicle Type:</div>
                            <div class="detail-value"><%= request.getAttribute("carType") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Pickup Date:</div>
                            <div class="detail-value"><%= request.getAttribute("pickupDate") %></div>
                        </div>
                    </div>

                    <!-- Pricing Details -->
                    <div class="details-card">
                        <h4 class="card-title">Pricing Details</h4>
                        <div class="detail-row">
                            <div class="detail-label">Per-KM Rate:</div>
                            <div class="detail-value">LKR <%= request.getAttribute("perKmRate") %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Tax:</div>
                            <div class="detail-value">LKR <%= request.getAttribute("tax") %></div>
                        </div>

                        <%
                            String couponCode = (String)request.getAttribute("couponCode");
                            boolean hasCoupon = couponCode != null && !couponCode.isEmpty();
                        %>
                        <div class="detail-row">
                            <div class="detail-label">Coupon Code:</div>
                            <div class="detail-value"><%= hasCoupon ? couponCode : "Not Applied" %></div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Discount:</div>
                            <div class="detail-value discount-value"><%= request.getAttribute("discount") %>%</div>
                        </div>
                        <div class="detail-row">
                            <div class="detail-label">Total Amount:</div>
                            <div class="detail-value">LKR <%= request.getAttribute("totalAmount") %></div>
                        </div>
                    </div>

                    <div class="details-card">
                        <h5 class="text-center mb-3">Booking Summary</h5>
                        <p class="text-center mb-2">Your estimated fare:</p>
                        <div class="total-amount">LKR <%= request.getAttribute("totalAmount") %></div>
                        <p class="text-center text-muted small">Including all taxes and discounts</p>
                    </div>

                    <div class="note-text">
                        <i class="fas fa-lightbulb me-2"></i>
                        <strong>Note:</strong> Your driver will contact you shortly before the pickup time. Please be ready at the pickup location.
                    </div>

                    <!-- Hidden Fields -->
                    <input type="hidden" name="pickupPoint" value="<%= request.getAttribute("pickupPointId") %>">
                    <input type="hidden" name="destination" value="<%= request.getAttribute("destinationId") %>">
                    <input type="hidden" name="carType" value="<%= request.getAttribute("carTypeId") %>">
                    <input type="hidden" name="pickupDate" value="<%= request.getAttribute("pickupDate") %>">
                    <input type="hidden" name="couponCode" value="<%= couponCode %>">
                    <input type="hidden" name="distance" value="<%= request.getAttribute("distance") %>">
                    <input type="hidden" name="tax" value="<%= request.getAttribute("tax") %>">
                    <input type="hidden" name="perKmRate" value="<%= request.getAttribute("perKmRate") %>">
                    <input type="hidden" name="discount" value="<%= request.getAttribute("discount") %>">
                    <input type="hidden" name="totalAmount" value="<%= request.getAttribute("totalAmount") %>">

                    <!-- Action Buttons -->
                    <div class="action-buttons">
                        <button type="submit" class="btn btn-confirm">
                            <i class="fas fa-check-circle me-2"></i>Confirm Booking
                        </button>
                        <a href="Customer_Dashboard.jsp" class="btn btn-cancel">
                            <i class="fas fa-times-circle me-2"></i>Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>