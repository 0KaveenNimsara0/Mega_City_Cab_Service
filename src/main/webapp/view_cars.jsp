<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.mega_city_cab_service.model.Car" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.mega_city_cab_service.service.VehicleTypeService" %>
<%@ page import="com.example.mega_city_cab_service.model.VehicleType" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Cars - Mega City Cab Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .car-table {
            margin-top: 30px;
        }
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        .action-buttons a {
            text-decoration: none;
            color: white;
        }
        .btn-edit {
            background-color: #28a745;
            border: none;
        }
        .btn-delete {
            background-color: #dc3545;
            border: none;
        }
        .btn-availability {
            background-color: #ffc107;
            border: none;
        }
    </style>
</head>
<body>

<!-- Display Success/Error Messages -->
<%
    String message = request.getParameter("message");
    String error = request.getParameter("error");
    if (message != null && !message.isEmpty()) {
%>
<div class="alert alert-success text-center"><%= message %></div>
<%
} else if (error != null && !error.isEmpty()) {
%>
<div class="alert alert-danger text-center"><%= error %></div>
<%
    }
%>
<div class="container mt-5">
    <h2 class="text-center mb-4"><i class="fas fa-car me-2"></i>Manage Cars</h2>

    <!-- Add Car Button -->
    <div class="text-end mb-3">
        <a href="AddCarServlet" class="btn btn-primary"><i class="fas fa-plus me-2"></i>Add New Car</a>
    </div>

    <!-- Table to Display Cars -->
    <table class="table table-bordered car-table">
        <thead class="table-dark">
        <tr>
            <th>Car ID</th>
            <th>Model</th>
            <th>Capacity</th>
            <th>Availability</th>
            <th>Registration Number</th>
            <th>Driver ID</th>
            <th>Type ID</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% List<Car> cars = (List<Car>) request.getAttribute("cars"); %>
        <% if (cars != null && !cars.isEmpty()) { %>
        <% for (Car car : cars) { %>
        <tr>
            <td><%= car.getCarId() %></td>
            <td><%= car.getModel() %></td>
            <td><%= car.getCapacity() %></td>
            <td>
                <% if (car.isAvailable()) { %>
                <span class="badge bg-success">Available</span>
                <% } else { %>
                <span class="badge bg-danger">Unavailable</span>
                <% } %>
            </td>
            <td><%= car.getRegistrationNumber() %></td>
            <td><%= car.getDriverId() %></td>
            <td><%= car.getTypeId() %></td>
            <td>
                <div class="action-buttons">
                    <!-- Edit Button -->
                    <a href="EditCarServlet?carId=<%= car.getCarId() %>" class="btn btn-sm btn-edit">
                        <i class="fas fa-edit"></i> Edit
                    </a>
                    <!-- Change Availability Button -->
                    <form action="ChangeAvailabilityServlet" method="post" style="display: inline;">
                        <input type="hidden" name="carId" value="<%= car.getCarId() %>">
                        <input type="hidden" name="isAvailable" value="<%= !car.isAvailable() %>">
                        <button type="submit" class="btn btn-sm btn-availability">
                            <i class="fas fa-sync-alt"></i>
                            <%= car.isAvailable() ? "Make Unavailable" : "Make Available" %>
                        </button>
                    </form>
                    <!-- Delete Button -->
                    <form action="DeleteCarServlet" method="post" style="display: inline;">
                        <input type="hidden" name="carId" value="<%= car.getCarId() %>">
                        <button type="submit" class="btn btn-sm btn-delete" onclick="return confirm('Are you sure you want to delete this car?')">
                            <i class="fas fa-trash"></i> Delete
                        </button>
                    </form>
                </div>
            </td>
        </tr>
        <% } %>
        <% } else { %>
        <tr>
            <td colspan="8" class="text-center">No cars found.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>