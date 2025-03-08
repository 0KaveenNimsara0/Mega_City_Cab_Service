<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.mega_city_cab_service.model.VehicleType" %>
<%@ page import="com.example.mega_city_cab_service.model.Driver" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Car - Mega City Cab Service</title>
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
        .section-header {
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
            margin-bottom: 20px;
            color: #333;
        }
    </style>
</head>
<body class="bg-light">

<%
    // Ensure vehicleTypes and drivers are not null by providing default empty lists
    List<VehicleType> vehicleTypes = (List<VehicleType>) request.getAttribute("vehicleTypes");
    if (vehicleTypes == null) {
        vehicleTypes = new ArrayList<>();
    }

    List<Driver> drivers = (List<Driver>) request.getAttribute("drivers");
    if (drivers == null) {
        drivers = new ArrayList<>();
    }

    String error = request.getParameter("error");
%>

<div class="container py-5">
    <% if (error != null && !error.isEmpty()) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="fas fa-exclamation-circle me-2"></i><%= error %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% } %>

    <a href="javascript:history.back()" class="back-link">
        <i class="fas fa-arrow-left me-1"></i> Back to Dashboard
    </a>

    <div class="card">
        <div class="card-header bg-white py-3">
            <h2 class="text-center mb-0"><i class="fas fa-car me-2"></i>Add a New Car</h2>
        </div>
        <div class="card-body p-4">
            <form action="AddCarServlet" method="POST" class="mt-2">
                <h5 class="section-header"><i class="fas fa-info-circle me-2"></i>Car Information</h5>
                <div class="row">
                    <!-- Model -->
                    <div class="col-md-6 mb-3">
                        <label for="model" class="form-label">Car Model</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-car-side"></i></span>
                            <input type="text" class="form-control" id="model" name="model" placeholder="e.g., Toyota Camry" required>
                        </div>
                    </div>

                    <!-- Registration Number -->
                    <div class="col-md-6 mb-3">
                        <label for="registrationNumber" class="form-label">Registration Number</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                            <input type="text" class="form-control" id="registrationNumber" name="registrationNumber" placeholder="e.g., ABC-1234" required>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <!-- Vehicle Type -->
                    <div class="col-md-6 mb-3">
                        <label for="typeId" class="form-label">Vehicle Type</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-tags"></i></span>
                            <select class="form-select" id="typeId" name="typeId" required>
                                <option value="">Select Vehicle Type</option>
                                <% if (!vehicleTypes.isEmpty()) {
                                    for (VehicleType vehicleType : vehicleTypes) { %>
                                <option value="<%= vehicleType.getTypeId() %>"><%= vehicleType.getTypeName() %></option>
                                <% }
                                } else { %>
                                <option value="" disabled>No vehicle types available</option>
                                <% } %>
                            </select>
                        </div>
                        <% if (vehicleTypes.isEmpty()) { %>
                        <div class="form-text text-danger">
                            <i class="fas fa-exclamation-triangle me-1"></i>
                            Vehicle types not loaded. Please ensure they are configured in the system.
                        </div>
                        <% } %>
                    </div>

                    <!-- Capacity -->
                    <div class="col-md-6 mb-3">
                        <label for="capacity" class="form-label">Passenger Capacity</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-users"></i></span>
                            <input type="number" class="form-control" id="capacity" name="capacity" min="1" max="20" placeholder="e.g., 4" required>
                        </div>
                    </div>
                </div>

                <!-- Availability -->
                <div class="mb-4">
                    <label class="form-label">Availability Status</label>
                    <div class="d-flex">
                        <div class="form-check me-4">
                            <input class="form-check-input" type="radio" name="isAvailable" id="availableYes" value="true" checked>
                            <label class="form-check-label" for="availableYes">
                                <i class="fas fa-check-circle text-success me-1"></i> Available
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="isAvailable" id="availableNo" value="false">
                            <label class="form-check-label" for="availableNo">
                                <i class="fas fa-times-circle text-danger me-1"></i> Not Available
                            </label>
                        </div>
                    </div>
                </div>

                <h5 class="section-header"><i class="fas fa-user me-2"></i>Driver Assignment</h5>
                <!-- Driver Section -->
                <div class="mb-4">
                    <label for="driverId" class="form-label">Assign Driver</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-id-badge"></i></span>
                        <select class="form-select" id="driverId" name="driverId">
                            <option value="-1">No Driver (Available for Assignment)</option>
                            <% if (!drivers.isEmpty()) {
                                for (Driver driver : drivers) { %>
                            <option value="<%= driver.getDriverId() %>"><%= driver.getName() %> (License: <%= driver.getLicenseNumber() %>)</option>
                            <% }
                            } else { %>
                            <option value="" disabled>No drivers available in the system</option>
                            <% } %>
                        </select>
                    </div>
                    <% if (drivers.isEmpty()) { %>
                    <div class="form-text text-danger">
                        <i class="fas fa-exclamation-triangle me-1"></i>
                        Drivers not loaded. Please ensure drivers are added to the system.
                    </div>
                    <% } %>
                </div>

                <!-- Submit Button -->
                <div class="d-grid gap-2 mt-4">
                    <button type="submit" class="btn btn-primary py-2">
                        <i class="fas fa-plus-circle me-2"></i>Add Car to Fleet
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>