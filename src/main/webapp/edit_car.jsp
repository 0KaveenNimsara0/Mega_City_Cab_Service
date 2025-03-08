<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.mega_city_cab_service.model.Car" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Car - Mega City Cab Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center">Edit Car Details</h2>
    <% Car car = (Car) request.getAttribute("car"); %>
    <form action="EditCarServlet" method="post" class="mt-4">
        <input type="hidden" name="carId" value="<%= car.getCarId() %>">

        <div class="mb-3">
            <label for="model" class="form-label">Model</label>
            <input type="text" class="form-control" id="model" name="model" value="<%= car.getModel() %>" required>
        </div>

        <div class="mb-3">
            <label for="capacity" class="form-label">Capacity</label>
            <input type="number" class="form-control" id="capacity" name="capacity" value="<%= car.getCapacity() %>" required>
        </div>

        <div class="mb-3">
            <label for="isAvailable" class="form-label">Is Available?</label>
            <select class="form-select" id="isAvailable" name="isAvailable" required>
                <option value="true" <%= car.isAvailable() ? "selected" : "" %>>Yes</option>
                <option value="false" <%= !car.isAvailable() ? "selected" : "" %>>No</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="registrationNumber" class="form-label">Registration Number</label>
            <input type="text" class="form-control" id="registrationNumber" name="registrationNumber" value="<%= car.getRegistrationNumber() %>" required>
        </div>

        <div class="mb-3">
            <label for="driverId" class="form-label">Driver ID</label>
            <input type="number" class="form-control" id="driverId" name="driverId" value="<%= car.getDriverId() %>" required>
        </div>

        <div class="mb-3">
            <label for="typeId" class="form-label">Type ID</label>
            <input type="number" class="form-control" id="typeId" name="typeId" value="<%= car.getTypeId() %>" required>
        </div>

        <button type="submit" class="btn btn-primary w-100">Update Car</button>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>