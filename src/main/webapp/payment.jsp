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
        :root {
            --primary-color: #3498db;
            --secondary-color: #333333;
            --accent-color: #1a73e8;
            --light-gray: #f8f9fa;
            --dark-gray: #495057;
        }

        body {
            background-color: #f5f5f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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

        .main-card {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            border: none;
            margin-bottom: 30px;
        }

        .card-header {
            background-color: var(--secondary-color);
            color: white;
            font-weight: bold;
            padding: 15px;
            border-bottom: 3px solid var(--primary-color);
        }

        .card-body {
            padding: 25px;
        }

        .table {
            margin-bottom: 0;
        }

        .table td {
            padding: 12px;
            vertical-align: middle;
        }

        .booking-icon {
            color: var(--accent-color);
            margin-right: 10px;
        }

        .payment-methods {
            display: flex;
            justify-content: space-around;
            margin: 30px 0;
        }

        .payment-card {
            padding: 25px 15px;
            border: 2px solid #ddd;
            border-radius: 12px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 30%;
            background-color: white;
        }

        .payment-card.selected {
            border-color: var(--primary-color);
            background-color: #fffbeb;
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .payment-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .payment-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }

        .cash-icon {
            color: #28a745;
        }

        .card-icon {
            color: #007bff;
        }

        .paypal-icon {
            color: #0070ba;
        }

        .payment-label {
            font-weight: bold;
            margin-top: 10px;
        }

        .btn-action {
            padding: 12px 20px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 8px;
            transition: all 0.3s ease;
            margin-top: 15px;
        }

        .btn-confirm {
            background-color: var(--primary-color);
            color: var(--secondary-color);
            border: none;
        }

        .btn-confirm:hover {
            background-color: #e6b800;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .btn-cancel {
            background-color: white;
            color: #dc3545;
            border: 1px solid #dc3545;
        }

        .btn-cancel:hover {
            background-color: #dc3545;
            color: white;
        }

        .trip-info-section {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding: 15px;
            background-color: var(--light-gray);
            border-radius: 10px;
        }

        .route-icon {
            font-size: 1.5rem;
            margin: 0 10px;
            color: var(--dark-gray);
        }

        .total-amount-row {
            background-color: #fffbeb;
            font-size: 1.2rem;
        }

        .footer-text {
            text-align: center;
            margin-top: 20px;
            font-size: 0.9rem;
            color: var(--dark-gray);
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
            <h1 class="m-0">Payment Confirmation</h1>
        </div>
    </div>
</header>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-9">
            <div class="card main-card">
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h3 class="m-0"><i class="fas fa-receipt booking-icon"></i>Booking Summary</h3>
                        <span class="badge bg-primary p-2">Pending Payment</span>
                    </div>
                </div>

                <div class="card-body">
                    <!-- Trip Route Visualization -->
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

                    <table class="table table-hover">
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

        // Show a more elegant notification instead of alert
        const methodName = method.charAt(0).toUpperCase() + method.slice(1);
        showNotification(`${methodName} selected as your payment method`);
    }

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

    function confirmPayment() {
        if (!selectedPaymentMethod) {
            showNotification("Please select a payment method");
            return;
        }

        // Set the selected payment method in the hidden field
        document.getElementById("paymentMethod").value = selectedPaymentMethod;

        // Show loading state on button
        const confirmBtn = document.querySelector('.btn-confirm');
        const originalContent = confirmBtn.innerHTML;
        confirmBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Processing...';
        confirmBtn.disabled = true;

        // Simulate processing delay (remove this in production)
        setTimeout(() => {
            // Submit the form
            document.getElementById("paymentForm").submit();
        }, 1000);
    }

    function cancelBooking() {
        // Create modal for cancellation confirmation
        const modalHTML = `
            <div class="modal fade" id="cancelModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header bg-danger text-white">
                            <h5 class="modal-title">Cancel Booking</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>Are you sure you want to cancel this booking?</p>
                            <p class="text-muted small">This action cannot be undone.</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                <i class="fas fa-arrow-left me-2"></i>Go Back
                            </button>
                            <button type="button" class="btn btn-danger" onclick="confirmCancel()">
                                <i class="fas fa-times-circle me-2"></i>Yes, Cancel Booking
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        `;

        // Add modal to document
        const modalContainer = document.createElement('div');
        modalContainer.innerHTML = modalHTML;
        document.body.appendChild(modalContainer);

        // Show modal
        const cancelModal = new bootstrap.Modal(document.getElementById('cancelModal'));
        cancelModal.show();
    }

    function confirmCancel() {
        // Set the hidden field for cancellation
        document.getElementById("paymentMethod").value = "cancelled";

        // Submit the form with a special action for cancellation
        const form = document.getElementById("paymentForm");
        form.action = "cancelBooking"; // Redirect to a new endpoint for cancellation
        form.submit();
    }
</script>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>