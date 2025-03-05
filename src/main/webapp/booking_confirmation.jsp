<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Confirm Booking</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            min-height: 100vh;
        }
        .container {
            margin-top: 50px;
            padding: 30px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }
        table td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        table td:first-child {
            font-weight: bold;
            color: #555;
        }
        .payment-methods {
            display: flex;
            justify-content: space-around;
            margin-top: 30px;
        }
        .payment-card {
            width: 30%;
            padding: 20px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 10px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .payment-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }
        .payment-card i {
            font-size: 40px;
            margin-bottom: 15px;
            color: #0d6efd;
        }
        .payment-card p {
            font-size: 16px;
            color: #333;
        }
        .total-amount {
            margin-top: 30px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            color: #28a745;
        }
        .btn-confirm {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-cancel {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="container">
    <h2><i class="fas fa-check-circle"></i> Confirm Your Booking</h2>

    <!-- Booking Details Table -->
    <table>
        <tr>
            <td>Pickup Point:</td>
            <td>${pickupPoint}</td>
        </tr>
        <tr>
            <td>Destination:</td>
            <td>${destination}</td>
        </tr>
        <tr>
            <td>Vehicle Type:</td>
            <td>${carType}</td>
        </tr>
        <tr>
            <td>Pickup Date:</td>
            <td>${pickupDate}</td>
        </tr>
        <tr>
            <td>Coupon Code:</td>
            <td>${couponCode}</td>
        </tr>
        <tr>
            <td>Distance:</td>
            <td>${distance} km</td>
        </tr>
        <tr>
            <td>Tax:</td>
            <td>LKR ${tax}</td>
        </tr>
        <tr>
            <td>Per-Kilometer Rate:</td>
            <td>LKR ${perKmRate}</td>
        </tr>
        <tr>
            <td>Discount:</td>
            <td>${discount}%</td>
        </tr>
        <tr>
            <td>Total Amount:</td>
            <td>LKR ${totalAmount}</td>
        </tr>
    </table>

    <!-- Payment Methods -->
    <div class="payment-methods">
        <div class="payment-card" onclick="selectPayment('cash')">
            <i class="fas fa-money-bill-wave"></i>
            <p>Cash Payment</p>
        </div>
        <div class="payment-card" onclick="selectPayment('creditCard')">
            <i class="fas fa-credit-card"></i>
            <p>Credit Card</p>
        </div>
        <div class="payment-card" onclick="selectPayment('online')">
            <i class="fas fa-globe"></i>
            <p>Online Payment</p>
        </div>
    </div>

    <!-- Total Amount -->
    <div class="total-amount">
        <i class="fas fa-dollar-sign"></i> Total Amount: LKR ${totalAmount}
    </div>

    <!-- Hidden Fields -->
    <form id="paymentForm" action="processPayment" method="post">
        <input type="hidden" name="pickupPoint" value="${pickupPoint}">
        <input type="hidden" name="destination" value="${destination}">
        <input type="hidden" name="carType" value="${carType}">
        <input type="hidden" name="pickupDate" value="${pickupDate}">
        <input type="hidden" name="couponCode" value="${couponCode}">
        <input type="hidden" name="distance" value="${distance}">
        <input type="hidden" name="tax" value="${tax}">
        <input type="hidden" name="perKmRate" value="${perKmRate}">
        <input type="hidden" name="discount" value="${discount}">
        <input type="hidden" name="totalAmount" value="${totalAmount}">
        <input type="hidden" id="paymentMethod" name="paymentMethod" value="">
    </form>

    <!-- Buttons -->
    <button class="btn-confirm" onclick="confirmPayment()">Confirm Payment</button>
    <button class="btn-cancel" onclick="cancelBooking()">Cancel Booking</button>
</div>

<!-- JavaScript -->
<script>
    let selectedPaymentMethod = "";

    function selectPayment(method) {
        selectedPaymentMethod = method;
        alert(`You selected ${method.charAt(0).toUpperCase() + method.slice(1)} as your payment method.`);
    }

    function confirmPayment() {
        if (!selectedPaymentMethod) {
            alert("Please select a payment method.");
            return;
        }

        // Set the selected payment method in the hidden field
        document.getElementById("paymentMethod").value = selectedPaymentMethod;

        // Submit the form
        document.getElementById("paymentForm").submit();
    }

    function cancelBooking() {
        if (confirm("Are you sure you want to cancel this booking?")) {
            window.location.href = "Customer_Dashboard.jsp";
        }
    }
</script>
</body>
</html>