<%--
  Created by IntelliJ IDEA.
  User: kavee
  Date: 3/15/2025
  Time: 10:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.mega_city_cab_service.model.Driver" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin - Manage Drivers</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<div class="container mt-5">
  <h2 class="mb-4 text-center">Driver Management</h2>

  <!-- Success/Error Messages -->
  <%
    String message = request.getParameter("message");
    String error = request.getParameter("error");

    if (message != null && !message.isEmpty()) {
  %>
  <div class="alert alert-success text-center">
    <%= message %>
  </div>
  <% } %>

  <% if (error != null && !error.isEmpty()) { %>
  <div class="alert alert-danger text-center">
    <%= error %>
  </div>
  <% } %>

  <!-- Add Driver Button -->
  <button class="btn btn-primary mb-3" data-bs-toggle="collapse" data-bs-target="#addDriverForm">
    <i class="fas fa-user-plus me-2"></i>Add New Driver
  </button>

  <!-- Add Driver Form -->
  <div id="addDriverForm" class="collapse mt-3">
    <div class="card card-body">
      <h4>Add New Driver</h4>
      <form action="addDriver" method="post">
        <div class="row">
          <div class="col-md-6">
            <div class="mb-3">
              <label for="name" class="form-label">Name <span class="text-danger">*</span></label>
              <input type="text" id="name" name="name" class="form-control" required>
            </div>
          </div>
          <div class="col-md-6">
            <div class="mb-3">
              <label for="phone" class="form-label">Phone <span class="text-danger">*</span></label>
              <input type="text" id="phone" name="phone" class="form-control" required>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="mb-3">
              <label for="email" class="form-label">Email</label>
              <input type="email" id="email" name="email" class="form-control">
            </div>
          </div>
          <div class="col-md-6">
            <div class="mb-3">
              <label for="licenseNumber" class="form-label">License Number <span class="text-danger">*</span></label>
              <input type="text" id="licenseNumber" name="licenseNumber" class="form-control" required>
            </div>
          </div>
        </div>
        <div class="mb-3">
          <label for="isAvailable" class="form-label">Availability <span class="text-danger">*</span></label>
          <select id="isAvailable" name="isAvailable" class="form-select" required>
            <option value="true">Available</option>
            <option value="false">Not Available</option>
          </select>
        </div>
        <button type="submit" class="btn btn-success">
          <i class="fas fa-check me-2"></i>Save Driver
        </button>
      </form>
    </div>
  </div>

  <!-- Edit Driver Form -->
  <%
    Driver editDriver = (Driver) request.getAttribute("editDriver");
    if (editDriver != null) {
  %>
  <div class="mt-3">
    <h4>Edit Driver</h4>
    <form action="addDriver" method="post">
      <input type="hidden" name="driverId" value="<%= editDriver.getDriverId() %>">
      <div class="row">
        <div class="col-md-6">
          <div class="mb-3">
            <label for="editName" class="form-label">Name <span class="text-danger">*</span></label>
            <input type="text" id="editName" name="name" class="form-control" value="<%= editDriver.getName() %>" required>
          </div>
        </div>
        <div class="col-md-6">
          <div class="mb-3">
            <label for="editPhone" class="form-label">Phone <span class="text-danger">*</span></label>
            <input type="text" id="editPhone" name="phone" class="form-control" value="<%= editDriver.getPhone() %>" required>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <div class="mb-3">
            <label for="editEmail" class="form-label">Email</label>
            <input type="email" id="editEmail" name="email" class="form-control" value="<%= editDriver.getEmail() != null ? editDriver.getEmail() : "" %>">
          </div>
        </div>
        <div class="col-md-6">
          <div class="mb-3">
            <label for="editLicenseNumber" class="form-label">License Number <span class="text-danger">*</span></label>
            <input type="text" id="editLicenseNumber" name="licenseNumber" class="form-control" value="<%= editDriver.getLicenseNumber() %>" required>
          </div>
        </div>
      </div>
      <div class="mb-3">
        <label for="editIsAvailable" class="form-label">Availability <span class="text-danger">*</span></label>
        <select id="editIsAvailable" name="isAvailable" class="form-select" required>
          <option value="true" <%= editDriver.isAvailable() ? "selected" : "" %>>Available</option>
          <option value="false" <%= !editDriver.isAvailable() ? "selected" : "" %>>Not Available</option>
        </select>
      </div>
      <button type="submit" class="btn btn-warning">
        <i class="fas fa-save me-2"></i>Update Driver
      </button>
    </form>
  </div>
  <% } %>

  <!-- Driver List Table -->
  <h4 class="mt-5 mb-3">Driver List</h4>
  <table class="table table-bordered table-hover">
    <thead class="table-dark">
    <tr>
      <th>ID</th>
      <th>Name</th>
      <th>Phone</th>
      <th>Email</th>
      <th>License Number</th>
      <th>Availability</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
      List<Driver> drivers = (List<Driver>) request.getAttribute("drivers");
      if (drivers != null && !drivers.isEmpty()) {
        for (Driver driver : drivers) {
    %>
    <tr>
      <td><%= driver.getDriverId() %></td>
      <td><%= driver.getName() %></td>
      <td><%= driver.getPhone() %></td>
      <td><%= driver.getEmail() != null ? driver.getEmail() : "N/A" %></td>
      <td><%= driver.getLicenseNumber() %></td>
      <td>
                <span class="badge <%= driver.isAvailable() ? "bg-success" : "bg-danger" %>">
                    <%= driver.isAvailable() ? "Available" : "Unavailable" %>
                </span>
      </td>
      <td>
        <a href="editDriver?driverId=<%= driver.getDriverId() %>" class="btn btn-sm btn-warning me-2">
          <i class="fas fa-edit"></i> Edit
        </a>
        <a href="deleteDriver?driverId=<%= driver.getDriverId() %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this driver?')">
          <i class="fas fa-trash-alt"></i> Delete
        </a>
      </td>
    </tr>
    <%
      }
    } else {
    %>
    <tr>
      <td colspan="7" class="text-center">No drivers available.</td>
    </tr>
    <% } %>
    </tbody>
  </table>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>