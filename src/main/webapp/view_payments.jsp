<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.mega_city_cab_service.model.BookingDetails" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Payments - Mega City Cab Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --dark-bg: #121212;
            --card-bg: #1e1e1e;
            --accent: #ff9800;
            --text-primary: #e0e0e0;
            --text-secondary: #aaaaaa;
            --border-color: #333333;
        }

        body {
            background-color: var(--dark-bg);
            color: var(--text-primary);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .page-title {
            color: var(--accent);
            font-weight: 600;
            margin-bottom: 30px;
            border-bottom: 2px solid var(--accent);
            padding-bottom: 10px;
        }

        .booking-card {
            background-color: var(--card-bg);
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease;
            overflow: hidden;
        }

        .booking-card:hover {
            transform: translateY(-5px);
        }

        .card-header {
            background-color: rgba(255, 152, 0, 0.2);
            border-bottom: 1px solid var(--border-color);
            padding: 15px 20px;
            font-weight: 500;
        }

        .card-body {
            padding: 20px;
        }

        .booking-info {
            margin-bottom: 15px;
        }

        .booking-label {
            color: var(--text-secondary);
            font-size: 0.9rem;
            margin-bottom: 5px;
        }

        .booking-value {
            font-size: 1.1rem;
            font-weight: 500;
        }

        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .status-confirmed {
            background-color: rgba(76, 175, 80, 0.2);
            color: #4CAF50;
        }

        .status-pending {
            background-color: rgba(255, 193, 7, 0.2);
            color: #FFC107;
        }

        .status-cancelled {
            background-color: rgba(244, 67, 54, 0.2);
            color: #F44336;
        }

        .status-completed {
            background-color: rgba(33, 150, 243, 0.2);
            color: #2196F3;
        }

        .payment-details {
            background-color: rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            padding: 15px;
            margin-top: 15px;
        }

        .payment-title {
            font-size: 1rem;
            color: var(--accent);
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }

        .payment-title i {
            margin-right: 8px;
        }

        .payment-info {
            display: flex;
            flex-wrap: wrap;
        }

        .payment-item {
            flex: 1 0 50%;
            min-width: 200px;
            margin-bottom: 10px;
        }

        .payment-label {
            color: var(--text-secondary);
            font-size: 0.85rem;
        }

        .payment-value {
            font-weight: 500;
        }

        .empty-state {
            background-color: var(--card-bg);
            border-radius: 10px;
            padding: 40px 20px;
            text-align: center;
        }

        .empty-state i {
            font-size: 4rem;
            color: var(--text-secondary);
            margin-bottom: 20px;
        }

        .empty-state-text {
            font-size: 1.2rem;
            color: var(--text-secondary);
        }

        @media (max-width: 768px) {
            .booking-card {
                margin-bottom: 15px;
            }

            .payment-item {
                flex: 1 0 100%;
            }
        }
    </style>
</head>
<body>
<div class="container mt-5 mb-5">
    <h2 class="text-center page-title">
        <i class="fas fa-taxi me-2"></i>Your Bookings and Payments
    </h2>

    <% List<BookingDetails> bookings = (List<BookingDetails>) request.getAttribute("bookings"); %>
    <% if (bookings != null && !bookings.isEmpty()) { %>
    <div class="row">
        <% for (BookingDetails booking : bookings) { %>
        <div class="col-12">
            <div class="booking-card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <div>
                        <i class="fas fa-bookmark me-2"></i>Booking #<%= booking.getBookingID() %>
                    </div>
                    <%
                        String statusClass = "status-pending";
                        if (booking.getStatus().equalsIgnoreCase("confirmed")) {
                            statusClass = "status-confirmed";
                        } else if (booking.getStatus().equalsIgnoreCase("cancelled")) {
                            statusClass = "status-cancelled";
                        } else if (booking.getStatus().equalsIgnoreCase("completed")) {
                            statusClass = "status-completed";
                        }
                    %>
                    <span class="status-badge <%= statusClass %>">
                                <%= booking.getStatus() %>
                            </span>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="booking-info">
                                <div class="booking-label">
                                    <i class="fas fa-map-marker-alt me-2"></i>Pickup Point
                                </div>
                                <div class="booking-value">
                                    <%= booking.getPickupPointName() %>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="booking-info">
                                <div class="booking-label">
                                    <i class="fas fa-location-arrow me-2"></i>Destination
                                </div>
                                <div class="booking-value">
                                    <%= booking.getDestinationName() %>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="booking-info">
                                <div class="booking-label">
                                    <i class="far fa-calendar-alt me-2"></i>Pickup Date
                                </div>
                                <div class="booking-value">
                                    <%= booking.getPickupDate() %>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="payment-details">
                        <div class="payment-title">
                            <i class="fas fa-credit-card"></i>Payment Information
                        </div>
                        <div class="payment-info">
                            <div class="payment-item">
                                <div class="payment-label">Payment ID</div>
                                <div class="payment-value"><%= booking.getPaymentId() %></div>
                            </div>
                            <div class="payment-item">
                                <div class="payment-label">Method</div>
                                <div class="payment-value">
                                    <%
                                        String paymentIcon = "fa-money-bill";
                                        if (booking.getPaymentMethod().toLowerCase().contains("card")) {
                                            paymentIcon = "fa-credit-card";
                                        } else if (booking.getPaymentMethod().toLowerCase().contains("paypal")) {
                                            paymentIcon = "fa-paypal";
                                        } else if (booking.getPaymentMethod().toLowerCase().contains("wallet")) {
                                            paymentIcon = "fa-wallet";
                                        }
                                    %>
                                    <i class="fas <%= paymentIcon %> me-1"></i>
                                    <%= booking.getPaymentMethod() %>
                                </div>
                            </div>
                            <div class="payment-item">
                                <div class="payment-label">Amount</div>
                                <div class="payment-value"><%= booking.getPaymentAmount() %></div>
                            </div>
                            <div class="payment-item">
                                <div class="payment-label">Date</div>
                                <div class="payment-value"><%= booking.getPaymentDate() %></div>
                            </div>
                            <div class="payment-item">
                                <div class="payment-label">Status</div>
                                <%
                                    String paymentStatusClass = "text-warning";
                                    if (booking.getPaymentStatus().equalsIgnoreCase("paid") ||
                                            booking.getPaymentStatus().equalsIgnoreCase("completed")) {
                                        paymentStatusClass = "text-success";
                                    } else if (booking.getPaymentStatus().equalsIgnoreCase("failed")) {
                                        paymentStatusClass = "text-danger";
                                    }
                                %>
                                <div class="payment-value <%= paymentStatusClass %>">
                                    <%= booking.getPaymentStatus() %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <div class="empty-state">
        <i class="fas fa-search"></i>
        <div class="empty-state-text">No bookings found. Your booking history will appear here.</div>
    </div>
    <% } %>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>