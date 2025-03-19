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
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body class="bg-light">
<div class="container py-4">
    <h2 class="text-center mb-4">
        <i class="bi bi-taxi-front me-2"></i>Your Bookings and Payments
    </h2>

    <% List<BookingDetails> bookings = (List<BookingDetails>) request.getAttribute("bookings"); %>
    <% if (bookings != null && !bookings.isEmpty()) { %>
    <div class="row">
        <% for (BookingDetails booking : bookings) { %>
        <div class="col-12 mb-3">
            <div class="card shadow-sm">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <div>
                        <i class="bi bi-bookmark me-2"></i>Booking #<%= booking.getBookingID() %>
                    </div>
                    <%
                        String badgeClass = "bg-warning";
                        if (booking.getStatus().equalsIgnoreCase("confirmed")) {
                            badgeClass = "bg-success";
                        } else if (booking.getStatus().equalsIgnoreCase("cancelled")) {
                            badgeClass = "bg-danger";
                        } else if (booking.getStatus().equalsIgnoreCase("completed")) {
                            badgeClass = "bg-primary";
                        }
                    %>
                    <span class="badge <%= badgeClass %>">
                        <%= booking.getStatus() %>
                    </span>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <div>
                                <div class="text-muted small">
                                    <i class="bi bi-geo-alt me-2"></i>Pickup Point
                                </div>
                                <div class="fw-bold">
                                    <%= booking.getPickupPointName() %>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div>
                                <div class="text-muted small">
                                    <i class="bi bi-geo me-2"></i>Destination
                                </div>
                                <div class="fw-bold">
                                    <%= booking.getDestinationName() %>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <div>
                                <div class="text-muted small">
                                    <i class="bi bi-calendar me-2"></i>Pickup Date
                                </div>
                                <div class="fw-bold">
                                    <%= booking.getPickupDate() %>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="bg-light p-3 rounded">
                        <div class="mb-2 fw-bold">
                            <i class="bi bi-credit-card me-2"></i>Payment Information
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-lg-3 mb-2">
                                <div class="text-muted small">Payment ID</div>
                                <div><%= booking.getPaymentId() %></div>
                            </div>
                            <div class="col-md-6 col-lg-3 mb-2">
                                <div class="text-muted small">Method</div>
                                <div>
                                    <%
                                        String paymentIcon = "bi-cash";
                                        if (booking.getPaymentMethod().toLowerCase().contains("card")) {
                                            paymentIcon = "bi-credit-card";
                                        } else if (booking.getPaymentMethod().toLowerCase().contains("paypal")) {
                                            paymentIcon = "bi-paypal";
                                        } else if (booking.getPaymentMethod().toLowerCase().contains("wallet")) {
                                            paymentIcon = "bi-wallet";
                                        }
                                    %>
                                    <i class="bi <%= paymentIcon %> me-1"></i>
                                    <%= booking.getPaymentMethod() %>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-3 mb-2">
                                <div class="text-muted small">Amount</div>
                                <div class="fw-bold"><%= booking.getPaymentAmount() %></div>
                            </div>
                            <div class="col-md-6 col-lg-3 mb-2">
                                <div class="text-muted small">Date</div>
                                <div><%= booking.getPaymentDate() %></div>
                            </div>
                            <div class="col-md-6 col-lg-3">
                                <div class="text-muted small">Status</div>
                                <%
                                    String paymentStatusClass = "text-warning";
                                    if (booking.getPaymentStatus().equalsIgnoreCase("paid") ||
                                            booking.getPaymentStatus().equalsIgnoreCase("completed")) {
                                        paymentStatusClass = "text-success";
                                    } else if (booking.getPaymentStatus().equalsIgnoreCase("failed")) {
                                        paymentStatusClass = "text-danger";
                                    }
                                %>
                                <div class="<%= paymentStatusClass %>">
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
    <div class="card shadow-sm">
        <div class="card-body text-center py-5">
            <i class="bi bi-search fs-1 text-muted mb-3 d-block"></i>
            <h5 class="text-muted">No bookings found. Your booking history will appear here.</h5>
        </div>
    </div>
    <% } %>

    <div class="mt-3">
        <a href="Customer_Dashboard.jsp" class="btn btn-outline-primary">
            <i class="bi bi-arrow-left"></i> Back to Dashboard
        </a>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>