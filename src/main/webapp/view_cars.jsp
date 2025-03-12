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
    <title>Manage Cars | Mega City Cab Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #1a73e8;
            --secondary-color: #f8f9fa;
            --success-color: #28a745;
            --warning-color: #ffc107;
            --danger-color: #dc3545;
            --dark-color: #343a40;
            --light-color: #f8f9fa;
        }

        body {
            background-color: #f5f7fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .page-header {
            background: linear-gradient(135deg, var(--primary-color), #0d47a1);
            color: white;
            padding: 20px 0;
            border-radius: 0 0 10px 10px;
            margin-bottom: 25px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .card {
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            border: none;
            margin-bottom: 20px;
        }

        .car-table th {
            background-color: var(--primary-color);
            color: white;
            font-weight: 500;
            padding: 12px 15px;
        }

        .car-table td {
            vertical-align: middle;
            padding: 12px 15px;
        }

        .car-table tbody tr:hover {
            background-color: rgba(26, 115, 232, 0.05);
        }

        .table-striped>tbody>tr:nth-of-type(odd)>* {
            background-color: rgba(0, 0, 0, 0.02);
        }

        .btn-edit {
            background-color: var(--success-color);
            border: none;
        }

        .btn-delete {
            background-color: var(--danger-color);
            border: none;
        }

        .btn-availability {
            background-color: var(--warning-color);
            color: #212529;
            border: none;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .action-buttons button, .action-buttons a {
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 6px;
            transition: all 0.2s;
        }

        .action-buttons i {
            margin-right: 5px;
        }

        .filter-controls {
            background-color: white;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .badge {
            font-size: 0.85rem;
            padding: 6px 10px;
            border-radius: 20px;
        }

        .alert {
            border-radius: 8px;
            font-weight: 500;
        }

        .car-id {
            font-weight: bold;
            color: var(--primary-color);
        }

        .empty-state {
            padding: 40px 20px;
            text-align: center;
        }

        .empty-state i {
            font-size: 48px;
            color: #cfd8dc;
            margin-bottom: 20px;
        }

        .btn-add-car {
            background-color: var(--primary-color);
            color: white;
            border-radius: 6px;
            padding: 8px 16px;
            transition: all 0.2s;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .btn-add-car:hover {
            background-color: #0d47a1;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .stats-card {
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            transition: all 0.3s;
        }

        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .stats-card i {
            font-size: 2rem;
            margin-bottom: 10px;
        }

        .stats-card .stats-value {
            font-size: 1.8rem;
            font-weight: bold;
        }

        .stats-card .stats-label {
            color: #6c757d;
            font-size: 0.9rem;
        }

        .capacity-badge {
            background-color: #e3f2fd;
            color: #0d47a1;
        }

        .type-badge {
            background-color: #e8f5e9;
            color: #2e7d32;
        }

        .table-responsive {
            border-radius: 10px;
            overflow: hidden;
        }
    </style>
</head>
<body>

<div class="page-header">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <h2 class="mb-0"><i class="fas fa-car me-2"></i>Manage Cars</h2>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="#" class="text-white">Dashboard</a></li>
                    <li class="breadcrumb-item active text-white" aria-current="page">Cars</li>
                </ol>
            </nav>
        </div>
    </div>
</div>

<div class="container">
    <!-- Display Success/Error Messages -->
    <%
        String message = request.getParameter("message");
        String error = request.getParameter("error");
        if (message != null && !message.isEmpty()) {
    %>
    <div class="alert alert-success alert-dismissible fade show">
        <i class="fas fa-check-circle me-2"></i><%= message %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <%
    } else if (error != null && !error.isEmpty()) {
    %>
    <div class="alert alert-danger alert-dismissible fade show">
        <i class="fas fa-exclamation-circle me-2"></i><%= error %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <%
        }
    %>

    <%
        List<Car> cars = (List<Car>) request.getAttribute("cars");
        int totalCars = cars != null ? cars.size() : 0;
        int availableCars = 0;
        int unavailableCars = 0;

        if (cars != null) {
            for (Car car : cars) {
                if (car.isAvailable()) {
                    availableCars++;
                } else {
                    unavailableCars++;
                }
            }
        }
    %>

    <!-- Stats Cards -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="stats-card bg-white text-center">
                <i class="fas fa-car text-primary"></i>
                <div class="stats-value"><%= totalCars %></div>
                <div class="stats-label">Total Cars</div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stats-card bg-white text-center">
                <i class="fas fa-check-circle text-success"></i>
                <div class="stats-value"><%= availableCars %></div>
                <div class="stats-label">Available Cars</div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stats-card bg-white text-center">
                <i class="fas fa-times-circle text-danger"></i>
                <div class="stats-value"><%= unavailableCars %></div>
                <div class="stats-label">Unavailable Cars</div>
            </div>
        </div>
    </div>

    <!-- Filter Controls -->
    <div class="filter-controls mb-4">
        <div class="row g-3">
            <div class="col-md-3">
                <label for="availabilityFilter" class="form-label">Availability</label>
                <select id="availabilityFilter" class="form-select">
                    <option value="">All Cars</option>
                    <option value="available">Available Only</option>
                    <option value="unavailable">Unavailable Only</option>
                </select>
            </div>
            <div class="col-md-3">
                <label for="typeFilter" class="form-label">Vehicle Type</label>
                <select id="typeFilter" class="form-select">
                    <option value="">All Types</option>
                    <option value="1">Economy</option>
                    <option value="2">Standard</option>
                    <option value="3">Premium</option>
                    <option value="4">SUV</option>
                </select>
            </div>
            <div class="col-md-3">
                <label for="searchFilter" class="form-label">Search</label>
                <input type="text" id="searchFilter" class="form-control" placeholder="Model, Registration...">
            </div>
            <div class="col-md-3 d-flex align-items-end">
                <button class="btn btn-primary w-100">
                    <i class="fas fa-filter me-2"></i>Apply Filters
                </button>
            </div>
        </div>
    </div>

    <!-- Card Container -->
    <div class="card">
        <div class="card-body">
            <!-- Add Car Button -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h5 class="card-title mb-0"><i class="fas fa-list me-2"></i>Vehicle List</h5>
                <a href="AddCarServlet" class="btn btn-add-car">
                    <i class="fas fa-plus me-2"></i>Add New Car
                </a>
            </div>

            <!-- Table to Display Cars -->
            <div class="table-responsive">
                <table class="table table-striped car-table mb-0">
                    <thead>
                    <tr>
                        <th><i class="fas fa-hashtag me-1"></i>Car ID</th>
                        <th><i class="fas fa-car-side me-1"></i>Model</th>
                        <th><i class="fas fa-users me-1"></i>Capacity</th>
                        <th><i class="fas fa-check-circle me-1"></i>Status</th>
                        <th><i class="fas fa-id-card me-1"></i>Registration</th>
                        <th><i class="fas fa-user me-1"></i>Driver</th>
                        <th><i class="fas fa-tag me-1"></i>Type</th>
                        <th><i class="fas fa-cogs me-1"></i>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if (cars != null && !cars.isEmpty()) { %>
                    <% for (Car car : cars) { %>
                    <tr>
                        <td class="car-id">#<%= car.getCarId() %></td>
                        <td><strong><%= car.getModel() %></strong></td>
                        <td>
                            <span class="badge capacity-badge">
                                <i class="fas fa-user me-1"></i><%= car.getCapacity() %> Seats
                            </span>
                        </td>
                        <td>
                            <% if (car.isAvailable()) { %>
                            <span class="badge bg-success">
                                <i class="fas fa-check-circle me-1"></i>Available
                            </span>
                            <% } else { %>
                            <span class="badge bg-danger">
                                <i class="fas fa-times-circle me-1"></i>Unavailable
                            </span>
                            <% } %>
                        </td>
                        <td><%= car.getRegistrationNumber() %></td>
                        <td>
                            <% if (car.getDriverId() > 0) { %>
                            <span class="badge bg-info text-dark">ID: <%= car.getDriverId() %></span>
                            <% } else { %>
                            <span class="text-muted">Not Assigned</span>
                            <% } %>
                        </td>
                        <td>
                            <span class="badge type-badge">
                                <i class="fas fa-tag me-1"></i>Type <%= car.getTypeId() %>
                            </span>
                        </td>
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
                                        <%= car.isAvailable() ? "Set Unavailable" : "Set Available" %>
                                    </button>
                                </form>
                                <!-- Delete Button -->
                                <form action="DeleteCarServlet" method="post" style="display: inline;">
                                    <input type="hidden" name="carId" value="<%= car.getCarId() %>">
                                    <button type="submit" class="btn btn-sm btn-delete"
                                            onclick="return confirm('Are you sure you want to delete this car? This action cannot be undone.')">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                    <% } else { %>
                    <tr>
                        <td colspan="8">
                            <div class="empty-state">
                                <i class="fas fa-car"></i>
                                <h4>No Cars Available</h4>
                                <p class="text-muted">Your fleet is empty. Start by adding your first vehicle.</p>
                                <a href="AddCarServlet" class="btn btn-primary mt-3">
                                    <i class="fas fa-plus me-2"></i>Add New Car
                                </a>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="d-flex justify-content-between align-items-center mt-4 mb-5">
        <div>
            <span class="text-muted">Showing <%= totalCars %> vehicles</span>
        </div>
        <% if (totalCars > 0) { %>
        <nav aria-label="Page navigation">
            <ul class="pagination mb-0">
                <li class="page-item disabled">
                    <a class="page-link" href="#" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                    <a class="page-link" href="#" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
        <% } %>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // JavaScript for enhanced functionality
    document.addEventListener('DOMContentLoaded', function() {
        const availabilityFilter = document.getElementById('availabilityFilter');
        const typeFilter = document.getElementById('typeFilter');
        const searchFilter = document.getElementById('searchFilter');

        // Simple event listeners for demonstration purposes
        availabilityFilter.addEventListener('change', function() {
            console.log("Availability filter changed to:", this.value);
            // Implementation would go here
        });

        // Auto-dismiss alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    });
</script>
</body>
</html>