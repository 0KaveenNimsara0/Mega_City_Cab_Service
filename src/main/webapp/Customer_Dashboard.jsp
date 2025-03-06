<%--
  Created by IntelliJ IDEA.
  User: kavee
  Date: 2/25/2025
  Time: 5:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check if the user is logged in
    HttpSession sessionObj = request.getSession(false); // Do not create a new session
    if (sessionObj == null || sessionObj.getAttribute("username") == null) {
        // Redirect to login page if the user is not logged in
        response.sendRedirect("Login.jsp");
        return; // Stop further execution of the JSP
    }

    // Retrieve session attributes
    String username = (String) sessionObj.getAttribute("username");
    String name = (String) sessionObj.getAttribute("name");
%>
<html>
<head>
    <title>Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Sidebar Styling */
        .sidebar {
            height: 100vh;
            width: 250px;
            position: fixed;
            top: 0;
            left: 0;
            background-color: #2c3e50;
            color: white;
            padding-top: 20px;
        }
        .sidebar a {
            padding: 10px 15px;
            text-decoration: none;
            font-size: 18px;
            color: white;
            display: block;
            transition: 0.3s;
        }
        .sidebar a:hover {
            background-color: #34495e;
        }
        .main-content {
            margin-left: 250px; /* Same as sidebar width */
            padding: 20px;
        }
        .welcome-message {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .dashboard-card {
            margin-bottom: 20px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
<!-- Sidebar -->
<div class="sidebar">
    <h4 class="text-center mb-4">Mega City Cab</h4>
    <a href="#booking"><i class="fas fa-taxi me-2"></i> Booking</a>
    <a href="#view-bookings"><i class="fas fa-list-alt me-2"></i> View Bookings</a>
    <a href="#payments"><i class="fas fa-money-bill-wave me-2"></i> Payments</a>
    <a href="#help"><i class="fas fa-question-circle me-2"></i> Help</a>
    <a href="#update-profile"><i class="fas fa-user-edit me-2"></i> Update Profile</a>
    <a href="logout"><i class="fas fa-sign-out-alt me-2"></i> Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="welcome-message">
        Welcome, <%= name %>! <span class="badge bg-primary"><%= username %></span>
    </div>

    <!-- Booking Section -->
    <div id="booking" class="dashboard-card bg-light">
        <h5><i class="fas fa-taxi me-2"></i> Booking</h5>
        <p>Book your cab ride here.</p>
        <a href="booking.jsp" class="btn btn-primary">Book Now</a>
    </div>

    <!-- View Bookings Section -->
    <div id="view-bookings" class="dashboard-card bg-light">
        <h5><i class="fas fa-list-alt me-2"></i> View Bookings</h5>
        <p>View all your past and upcoming bookings.</p>
        <a href="viewBookings.jsp" class="btn btn-info">View Bookings</a>
    </div>

    <!-- Payments Section -->
    <div id="payments" class="dashboard-card bg-light">
        <h5><i class="fas fa-money-bill-wave me-2"></i> Payments</h5>
        <p>Manage your payments and invoices.</p>
        <a href="payments.jsp" class="btn btn-success">Manage Payments</a>
    </div>

    <!-- Help Section -->
    <div id="help" class="dashboard-card bg-light">
        <h5><i class="fas fa-question-circle me-2"></i> Help</h5>
        <p>Get help and support for any issues.</p>
        <a href="help.jsp" class="btn btn-warning">Contact Support</a>
    </div>

    <!-- Update Profile Section -->
    <div id="update-profile" class="dashboard-card bg-light">
        <h5><i class="fas fa-user-edit me-2"></i> Update Profile</h5>
        <p>Update your profile information.</p>
        <a href="updateProfile.jsp" class="btn btn-secondary">Update Profile</a>
    </div>
</div>

<!-- Bootstrap JS and Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>