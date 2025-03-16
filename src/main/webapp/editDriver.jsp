<%--
  Created by IntelliJ IDEA.
  User: kavee
  Date: 3/16/2025
  Time: 10:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.mega_city_cab_service.model.Driver" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Driver | Mega City Cab Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
            background-color: #fff;
        }
        .page-header {
            background-color: #f8f9fa;
            padding: 20px 0;
            margin-bottom: 30px;
            border-bottom: 1px solid #dee2e6;
        }
        .btn-primary {
            background-color: #0d6efd;
        }
        .btn-cancel {
            background-color: #6c757d;
        }
    </style>
</head>
<body class="bg-light">
<%
    Driver driver = (Driver) request.getAttribute("editDriver");
%>

<div class="page-header text-center">
    <div class="container">
        <h2><i class="bi bi-person-badge"></i> Edit Driver Profile</h2>
    </div>
</div>

<div class="container mb-5">
    <div class="form-container">
        <form action="editDriver" method="post" class="needs-validation" novalidate>
            <input type="hidden" name="driverId" value="<%= driver.getDriverId() %>">

            <div class="mb-3">
                <label for="name" class="form-label"><i class="bi bi-person"></i> Driver Name:</label>
                <input type="text" class="form-control" id="name" name="name" value="<%= driver.getName() %>" required>
                <div class="invalid-feedback">Please enter the driver's name.</div>
            </div>

            <div class="mb-3">
                <label for="phone" class="form-label"><i class="bi bi-telephone"></i> Phone Number:</label>
                <input type="text" class="form-control" id="phone" name="phone" value="<%= driver.getPhone() %>" required>
                <div class="invalid-feedback">Please enter a valid phone number.</div>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label"><i class="bi bi-envelope"></i> Email Address:</label>
                <input type="email" class="form-control" id="email" name="email" value="<%= driver.getEmail() %>">
                <div class="invalid-feedback">Please enter a valid email address.</div>
            </div>

            <div class="mb-3">
                <label for="licenseNumber" class="form-label"><i class="bi bi-card-text"></i> License Number:</label>
                <input type="text" class="form-control" id="licenseNumber" name="licenseNumber" value="<%= driver.getLicenseNumber() %>" required>
                <div class="invalid-feedback">Please enter the license number.</div>
            </div>

            <div class="mb-4">
                <label for="isAvailable" class="form-label"><i class="bi bi-toggle-on"></i> Availability Status:</label>
                <select class="form-select" id="isAvailable" name="isAvailable" required>
                    <option value="true" <%= driver.isAvailable() ? "selected" : "" %>>Available</option>
                    <option value="false" <%= !driver.isAvailable() ? "selected" : "" %>>Not Available</option>
                </select>
            </div>

            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                <a href="drivers" class="btn btn-cancel text-white me-md-2"><i class="bi bi-x-circle"></i> Cancel</a>
                <button type="submit" class="btn btn-primary"><i class="bi bi-save"></i> Update Driver</button>
            </div>
        </form>
    </div>
</div>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Form validation script
    (function () {
        'use strict'

        // Fetch all forms that need validation
        var forms = document.querySelectorAll('.needs-validation')

        // Loop over them and prevent submission
        Array.prototype.slice.call(forms)
            .forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }

                    form.classList.add('was-validated')
                }, false)
            })
    })()
</script>
</body>
</html>