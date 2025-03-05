<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.mega_city_cab_service.model.Location" %>
<%@ page import="com.example.mega_city_cab_service.model.VehicleType" %>
<%@ page import="com.example.mega_city_cab_service.dao.VehicleTypeDAO" %>
<%@ page import="com.example.mega_city_cab_service.service.LocationService" %>
<%@ page import="com.example.mega_city_cab_service.service.VehicleTypeService" %>

<%
    // Fetch locations from the database using LocationDAO
    List<Location> locations = null;
    try {
        LocationService allLocations = new LocationService();
        locations = allLocations.getAllLocations(); // Assuming getAllLocations() returns a list of Location objects
    } catch (Exception e) {
        e.printStackTrace();
    }

    // Fetch vehicle types from the database using VehicleTypeDAO
    List<VehicleType> vehicleTypes = null;
    try {
        VehicleTypeService allvehicleType = new VehicleTypeService();
        vehicleTypes = allvehicleType.getAllVehicleTypes(); // Assuming getAllVehicleTypes() returns a list of VehicleType objects
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab Service - Book Your Ride</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f4f7f6;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .booking-container {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            padding: 30px;
            margin-top: 50px;
            max-width: 600px;
        }
        .booking-title {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
            font-weight: 600;
        }
        .form-label {
            color: #34495e;
            font-weight: 500;
        }
        .form-control, .form-select {
            border-radius: 8px;
            border-color: #bdc3c7;
            transition: all 0.3s ease;
        }
        .form-control:focus, .form-select:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 0.2rem rgba(52,152,219,0.25);
        }
        .btn-primary {
            background-color: #3498db;
            border-color: #3498db;
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #2980b9;
            border-color: #2980b9;
        }
        .cab-icon {
            max-width: 100px;
            margin-bottom: 20px;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="booking-container">
                <img src="/api/placeholder/100/100" alt="Cab Icon" class="cab-icon">
                <h2 class="booking-title">Book Your Mega City Cab</h2>

                <form id="bookingForm" action="confirmBooking" method="post">
                    <div class="mb-3">
                        <label for="pickupPoint" class="form-label">Pickup Point</label>
                        <select id="pickupPoint" name="pickupPoint" class="form-select" required>
                            <option value="">Select Pickup Point</option>
                            <% if (locations != null && !locations.isEmpty()) { %>
                            <% for (Location location : locations) { %>
                            <option value="<%= location.getLocationId() %>"><%= location.getLocationName() %></option>
                            <% } %>
                            <% } else { %>
                            <option value="">No locations available</option>
                            <% } %>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="destination" class="form-label">Destination</label>
                        <select id="destination" name="destination" class="form-select" required>
                            <option value="">Select Destination</option>
                            <% if (locations != null && !locations.isEmpty()) { %>
                            <% for (Location location : locations) { %>
                            <option value="<%= location.getLocationId() %>"><%= location.getLocationName() %></option>
                            <% } %>
                            <% } else { %>
                            <option value="">No destinations available</option>
                            <% } %>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="carType" class="form-label">Vehicle Type</label>
                        <select id="carType" name="carType" class="form-select" required>
                            <option value="">Select Vehicle Type</option>
                            <% if (vehicleTypes != null && !vehicleTypes.isEmpty()) { %>
                            <% for (VehicleType vehicleType : vehicleTypes) { %>
                            <option value="<%= vehicleType.getTypeId() %>"><%= vehicleType.getTypeName() %></option>
                            <% } %>
                            <% } else { %>
                            <option value="">No car types available</option>
                            <% } %>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="pickupDate" class="form-label">Pickup Date and Time</label>
                        <input type="datetime-local" id="pickupDate" name="pickupDate" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label for="couponCode" class="form-label">Coupon Code (Optional)</label>
                        <input type="text" id="couponCode" name="couponCode" class="form-control" value="${param.couponCode}">
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">Book Your Cab</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS (optional, but recommended for full functionality) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>