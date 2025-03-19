<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.UUID" %>

<%
    // Retrieve booking details from request attributes
    String pickupPoint = (String) request.getAttribute("pickupPoint");
    String destination = (String) request.getAttribute("destination");
    String carType = (String) request.getAttribute("carType");
    String pickupDate = (String) request.getAttribute("pickupDate");
    String couponCode = (String) request.getAttribute("couponCode");
    Double distance = (Double) request.getAttribute("distance");
    Double tax = (Double) request.getAttribute("tax");
    Double perKmRate = (Double) request.getAttribute("perKmRate");
    Double discount = (Double) request.getAttribute("discount");
    Double totalAmount = (Double) request.getAttribute("totalAmount");

    // Retrieve customer name and email from session
    String customerName = (String) session.getAttribute("name"); // Assuming customer name is stored in session
    String customerEmail = (String) session.getAttribute("email"); // Corrected variable name
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - Mega City Cab Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
            padding: 20px 0;
        }

        .page-header {
            background-color: #0275d8;
            color: white;
            padding: 15px 0;
            margin-bottom: 20px;
        }

        .main-card {
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .card-header {
            background-color: #343a40;
            color: white;
            font-weight: bold;
            padding: 15px;
            border-bottom: 2px solid #0275d8;
        }

        .card-body {
            padding: 20px;
        }

        .table td {
            padding: 8px;
            vertical-align: middle;
        }

        .booking-icon {
            color: #0275d8;
            margin-right: 10px;
        }

        .payment-methods {
            display: flex;
            justify-content: space-around;
            margin: 20px 0;
        }

        .payment-card {
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-align: center;
            cursor: pointer;
            width: 30%;
            background-color: white;
        }

        .payment-card.selected {
            border-color: #0275d8;
            background-color: #f0f8ff;
        }

        .payment-icon {
            font-size: 2rem;
            margin-bottom: 10px;
        }

        .cash-icon {
            color: #28a745;
        }

        .card-icon {
            color: #0275d8;
        }

        .paypal-icon {
            color: #0070ba;
        }

        .payment-label {
            font-weight: bold;
            margin-top: 5px;
        }

        .btn-action {
            padding: 10px 15px;
            font-weight: bold;
            border-radius: 5px;
            margin-top: 10px;
        }

        .btn-confirm {
            background-color: #0275d8;
            color: white;
            border: none;
        }

        .btn-cancel {
            background-color: white;
            color: #dc3545;
            border: 1px solid #dc3545;
        }

        .trip-info-section {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            padding: 10px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }

        .total-amount-row {
            background-color: #fff3cd;
            font-weight: bold;
        }

        .footer-text {
            text-align: center;
            margin-top: 15px;
            font-size: 0.9rem;
            color: #6c757d;
        }
    </style>
</head>
<body>
<header class="page-header">
    <div class="container">
        <div class="d-flex justify-content-center align-items-center">
            <h1 class="m-0">Mega City Cab Service - Payment</h1>
        </div>
    </div>
</header>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card main-card">
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h3 class="m-0">Booking Summary</h3>
                        <span class="badge bg-warning p-2">Pending Payment</span>
                    </div>
                </div>

                <div class="card-body">
                    <!-- Trip Route Information -->
                    <div class="trip-info-section">
                        <div class="text-center">
                            <i class="fas fa-map-marker-alt fa-2x text-danger"></i>
                            <div class="mt-2"><strong>Pick-up</strong></div>
                            <div><%= pickupPoint != null ? pickupPoint : "N/A" %></div>
                        </div>

                        <div class="flex-grow-1 text-center">
                            <i class="fas fa-route fa-2x text-primary"></i>
                            <div class="mt-2"><%= distance != null ? distance + " km" : "N/A" %></div>
                        </div>

                        <div class="text-center">
                            <i class="fas fa-map-marker-alt fa-2x text-success"></i>
                            <div class="mt-2"><strong>Destination</strong></div>
                            <div><%= destination != null ? destination : "N/A" %></div>
                        </div>
                    </div>

                    <table class="table">
                        <tr>
                            <td><i class="fas fa-user booking-icon"></i><strong>Customer Name:</strong></td>
                            <td><%= customerName != null ? customerName : "Guest" %></td>
                        </tr>
                        <tr>
                            <td><i class="fas fa-envelope booking-icon"></i><strong>Customer Email:</strong></td>
                            <td><%= customerEmail != null ? customerEmail : "Guest" %></td>
                        </tr>
                        <tr>
                            <td><i class="fas fa-car booking-icon"></i><strong>Vehicle Type:</strong></td>
                            <td><%= carType != null ? carType : "N/A" %></td>
                        </tr>
                        <tr>
                            <td><i class="fas fa-calendar-alt booking-icon"></i><strong>Pickup Date:</strong></td>
                            <td><%= pickupDate != null ? pickupDate : "N/A" %></td>
                        </tr>
                        <tr>
                            <td><i class="fas fa-tag booking-icon"></i><strong>Coupon Code:</strong></td>
                            <td><%= couponCode != null ? couponCode : "N/A" %></td>
                        </tr>
                        <tr>
                            <td><i class="fas fa-coins booking-icon"></i><strong>Per-Kilometer Rate:</strong></td>
                            <td>LKR <%= perKmRate != null ? perKmRate : "N/A" %></td>
                        </tr>
                        <tr>
                            <td><i class="fas fa-percentage booking-icon"></i><strong>Discount:</strong></td>
                            <td><%= discount != null ? discount + "%" : "N/A" %></td>
                        </tr>
                        <tr>
                            <td><i class="fas fa-hand-holding-usd booking-icon"></i><strong>Tax:</strong></td>
                            <td>LKR <%= tax != null ? tax : "N/A" %></td>
                        </tr>
                        <tr class="total-amount-row">
                            <td><i class="fas fa-money-bill-wave booking-icon"></i><strong>Total Amount:</strong></td>
                            <td><strong>LKR <%= totalAmount != null ? totalAmount : "N/A" %></strong></td>
                        </tr>
                    </table>
                </div>

                <div class="card-footer bg-white p-4">
                    <h4 class="text-center mb-3">Select Payment Method</h4>

                    <form id="paymentForm" action="processPayment" method="post">
                        <input type="hidden" name="bookingId" value="<%= request.getAttribute("bookingId") %>">
                        <input type="hidden" name="totalAmount" value="<%= totalAmount != null ? totalAmount : 0 %>">
                        <input type="hidden" id="paymentMethod" name="paymentMethod" value="">

                        <!-- Payment Method Selection -->
                        <div class="payment-methods">
                            <div class="payment-card" id="cash-option" onclick="selectPayment('cash')">
                                <i class="fas fa-money-bill-wave payment-icon cash-icon"></i>
                                <p class="payment-label">Cash</p>
                                <small>Pay directly to driver</small>
                            </div>

                            <div class="payment-card" id="card-option" onclick="selectPayment('creditCard')">
                                <i class="fas fa-credit-card payment-icon card-icon"></i>
                                <p class="payment-label">Credit/Debit Card</p>
                                <small>Secure online payment</small>
                            </div>

                            <div class="payment-card" id="paypal-option" onclick="selectPayment('paypal')">
                                <i class="fab fa-paypal payment-icon paypal-icon"></i>
                                <p class="payment-label">PayPal</p>
                                <small>Fast & secure</small>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="d-grid gap-2">
                            <button type="button" class="btn btn-action btn-confirm" onclick="confirmPayment()">
                                <i class="fas fa-check-circle me-2"></i>Confirm Payment
                            </button>
                            <button type="button" class="btn btn-action btn-cancel" onclick="cancelBooking()">
                                <i class="fas fa-times-circle me-2"></i>Cancel Booking
                            </button>
                        </div>
                    </form>

                    <p class="footer-text mt-4">
                        <i class="fas fa-shield-alt me-1"></i> Your payment information is secure and encrypted.
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript -->
<script>
    let selectedPaymentMethod = "";

    function selectPayment(method) {
        // Remove 'selected' class from all payment cards
        document.querySelectorAll('.payment-card').forEach(card => {
            card.classList.remove('selected');
        });

        // Add 'selected' class to the clicked payment card
        document.getElementById(method + '-option').classList.add('selected');

        selectedPaymentMethod = method;

        // Simple alert instead of custom notification
        alert(method.charAt(0).toUpperCase() + method.slice(1) + " selected as your payment method");
    }

    function confirmPayment() {
        if (!selectedPaymentMethod) {
            alert("Please select a payment method");
            return;
        }

        // Set the selected payment method in the hidden field
        document.getElementById("paymentMethod").value = selectedPaymentMethod;

        // Submit the form
        document.getElementById("paymentForm").submit();
    }

    function cancelBooking() {
        if (confirm("Are you sure you want to cancel this booking? This action cannot be undone.")) {
            // Set the hidden field for cancellation
            document.getElementById("paymentMethod").value = "cancelled";

            // Submit the form with a special action for cancellation
            const form = document.getElementById("paymentForm");
            form.action = "cancelBooking"; // Redirect to a new endpoint for cancellation
            form.submit();
        }
    }
</script>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>