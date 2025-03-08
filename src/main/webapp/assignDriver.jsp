<%--
  Created by IntelliJ IDEA.
  User: kavee
  Date: 3/8/2025
  Time: 8:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.mega_city_cab_service.model.Driver" %>
<%@ page import="com.example.mega_city_cab_service.model.Car" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assign Driver - Mega City Cab Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .form-label {
            font-weight: 500;
        }
        .btn-primary {
            background-color: #4361ee;
            border-color: #4361ee;
        }
        .btn-primary:hover {
            background-color: #3a56d4;
            border-color: #3a56d4;
        }
        .form-control, .form-select {
            border-radius: 8px;
            padding: 10px 15px;
        }
        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: #4361ee;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        .car-details {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
        }
        .car-details h5 {
            color: #495057;
            border-bottom: 1px solid #dee2e6;
            padding-bottom: 10px;
            margin-bottom: 15px;
        }
        .detail-row {
            display: flex;
            margin-bottom: 8px;
        }
        .detail-label {
            font-weight: 500;
            width: 140px;
            color: #6c757d;
        }
        .detail-value {
            flex-grow: 1;
        }
    </style>
</head>
<body class="bg-light">

<%
    // Ensure drivers list is not null
    List<Driver> drivers = (List<Driver>) request.getAttribute("drivers");
    if (drivers == null) {
        drivers = new ArrayList<>();
    }

    // Get car object
    Car car = (Car) request.getAttribute("car");

    String error = (String) request.getAttribute("error");
%>

<div class="container py-5">
    <% if (error != null && !error.isEmpty()) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="fas fa-exclamation-circle me-2"></i><%= error %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% } %>

    <a href="ViewCarsServlet" class="back-link">
        <i class="fas fa-arrow-left me-1"></i> Back to Cars
    </a>

    <div class="card">
        <div class="card-header bg-white py-3">
            <h2 class="text-center mb-0"><i class="fas fa-user-plus me-2"></i>Assign Driver to Car</h2>
        </div>
        <div class="card-body p-4">
            <% if (car != null) { %>
            <div class="car-details">
                <h5><i class="fas fa-car me-2"></i>Car Details</h5>
                <div class="detail-row">
                    <span class="detail-label">Car ID:</span>
                    <span class="detail-value">#<%= car.getCarId() %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Model:</span>
                    <span class="detail-value"><%= car.getModel() %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Registration:</span>
                    <span class="detail-value"><%= car.getRegistrationNumber() %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Capacity:</span>
                    <span class="detail-value"><%= car.getCapacity() %> passengers</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Status:</span>
                    <span class="detail-value">
                            <% if (car.isAvailable()) { %>
                                <span class="badge bg-success">Available</span>
                            <% } else { %>
                                <span class="badge bg-danger">Not Available</span>
                            <% } %>
                        </span>
                </div>
            </div>



                <!-- Display Success or Error Messages -->

                <!-- Add Driver Form -->
                <form action="AddDriverServlet" method="post">

                    <input type="hidden" name="carId" value="<%= car.getCarId() %>">
                    <!-- Name -->
                    <div class="form-group">
                        <label for="name" class="form-label">Name <span class="text-danger">*</span></label>
                        <input type="text" id="name" name="name" class="form-control" required placeholder="Enter driver's name">
                    </div>

                    <!-- Phone -->
                    <div class="form-group">
                        <label for="phone" class="form-label">Phone <span class="text-danger">*</span></label>
                        <input type="text" id="phone" name="phone" class="form-control" required placeholder="Enter driver's phone number">
                    </div>

                    <!-- Email -->
                    <div class="form-group">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" id="email" name="email" class="form-control" placeholder="Enter driver's email (optional)">
                    </div>

                    <!-- License Number -->
                    <div class="form-group">
                        <label for="licenseNumber" class="form-label">License Number <span class="text-danger">*</span></label>
                        <input type="text" id="licenseNumber" name="licenseNumber" class="form-control" required placeholder="Enter driver's license number">
                    </div>

                    <!-- Availability -->
                    <div class="form-group">
                        <label for="isAvailable" class="form-label">Availability <span class="text-danger">*</span></label>
                        <select id="isAvailable" name="isAvailable" class="form-select" required>
                            <option value="">Select Availability</option>
                            <option value="true">Available</option>
                            <option value="false">Not Available</option>
                        </select>
                    </div>

                    <!-- Submit Button -->
                    <button type="submit" class="btn btn-submit">Add Driver</button>
                </form>





            <div class="text-center mt-3">
                <a href="ViewCarsServlet" class="text-decoration-none text-secondary">
                    <i class="fas fa-times me-1"></i> Skip driver assignment for now
                </a>
            </div>
            <% } else { %>
            <div class="alert alert-warning">
                <i class="fas fa-exclamation-triangle me-2"></i>
                Car information not available. Please go back and try again.
            </div>
            <div class="text-center mt-3">
                <a href="ViewCarsServlet" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-1"></i> Back to Cars
                </a>
            </div>
            <% } %>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
