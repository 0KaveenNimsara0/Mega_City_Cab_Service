<%--
  Created by IntelliJ IDEA.
  User: kavee
  Date: 3/11/2025
  Time: 8:56 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.mega_city_cab_service.model.Coupon, com.example.mega_city_cab_service.service.CouponService, java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Coupon Management</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 20px;
        }
        .card {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            border-radius: 10px;
            border: none;
            margin-bottom: 30px;
        }
        .card-header {
            background-color: #343a40;
            color: white;
            border-radius: 10px 10px 0 0 !important;
            font-weight: 600;
            padding: 15px 20px;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
        }
        .btn-primary:hover {
            background-color: #0069d9;
        }
        .btn-danger {
            background-color: #dc3545;
            border: none;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .btn-success {
            background-color: #28a745;
            border: none;
        }
        .btn-success:hover {
            background-color: #218838;
        }
        .table th {
            background-color: #343a40;
            color: white;
        }
        .coupon-form input, .coupon-form select {
            margin-bottom: 15px;
        }
        .status-message {
            animation: fadeOut 5s forwards;
            margin-bottom: 20px;
        }
        @keyframes fadeOut {
            0% { opacity: 1; }
            75% { opacity: 1; }
            100% { opacity: 0; }
        }
        .coupon-badge {
            font-size: 0.85rem;
            padding: 5px 10px;
            border-radius: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Status message handling -->
    <%
        String status = request.getParameter("status");
        if(status != null) {
            String alertClass = "alert-success";
            String message = "";

            if(status.equals("added")) {
                message = "Coupon added successfully!";
            } else if(status.equals("updated")) {
                message = "Coupon updated successfully!";
            } else if(status.equals("deleted")) {
                message = "Coupon deleted successfully!";
            } else if(status.equals("error")) {
                alertClass = "alert-danger";
                message = "An error occurred. Please try again.";
            }

            if(!message.isEmpty()) {
    %>
    <div class="alert <%= alertClass %> status-message">
        <%= message %>
    </div>
    <%
            }
        }
    %>

    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-md-12">
            <h2><i class="fas fa-tags me-2"></i> Coupon Management</h2>
            <hr>
        </div>
    </div>

    <!-- Add Coupon Form -->
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <i class="fas fa-plus-circle me-2"></i> Add New Coupon
                </div>
                <div class="card-body">
                    <form action="AdminCouponAddServlet" method="post" class="coupon-form">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="couponCode"><i class="fas fa-barcode me-2"></i>Coupon Code</label>
                                    <input type="text" id="couponCode" name="couponCode" class="form-control" required>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label for="discountPercentage"><i class="fas fa-percent me-2"></i>Discount %</label>
                                    <input type="number" id="discountPercentage" step="0.01" min="0" max="100" name="discountPercentage" class="form-control" required>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="validUntil"><i class="far fa-calendar-alt me-2"></i>Valid Until</label>
                                    <input type="date" id="validUntil" name="validUntil" class="form-control" required>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="description"><i class="fas fa-info-circle me-2"></i>Description</label>
                                    <input type="text" id="description" name="description" class="form-control" required>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-success mt-3">
                            <i class="fas fa-plus-circle me-2"></i>Add Coupon
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Coupons Table -->
    <div class="row mt-4">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <i class="fas fa-list me-2"></i> Available Coupons
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover table-striped">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Code</th>
                                <th>Discount %</th>
                                <th>Valid Until</th>
                                <th>Description</th>
                                <th width="30%">Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                CouponService service = new CouponService();
                                List<Coupon> coupons = service.getAllCoupons();
                                for (Coupon coupon: coupons) {
                                    java.util.Date today = new java.util.Date();
                                    boolean isValid = coupon.getValidUntil().after(today);
                                    String validClass = isValid ? "bg-success" : "bg-danger";
                            %>
                            <tr>
                                <td><%= coupon.getCouponId() %></td>
                                <td>
                                    <strong><%= coupon.getCouponCode() %></strong>
                                    <span class="coupon-badge <%= validClass %> text-white ms-2">
                                                <%= isValid ? "Active" : "Expired" %>
                                            </span>
                                </td>
                                <td><%= coupon.getDiscountPercentage() %>%</td>
                                <td><%= coupon.getValidUntil() %></td>
                                <td><%= coupon.getDescription() %></td>
                                <td>
                                    <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#editModal<%= coupon.getCouponId() %>">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <a href="AdminCouponDeleteServlet?couponId=<%= coupon.getCouponId() %>" class="btn btn-danger btn-sm ms-2" onclick="return confirm('Are you sure you want to delete this coupon?')">
                                        <i class="fas fa-trash-alt"></i> Delete
                                    </a>

                                    <!-- Edit Modal -->
                                    <div class="modal fade" id="editModal<%= coupon.getCouponId() %>" tabindex="-1" aria-labelledby="editModalLabel<%= coupon.getCouponId() %>" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header bg-primary text-white">
                                                    <h5 class="modal-title" id="editModalLabel<%= coupon.getCouponId() %>">
                                                        <i class="fas fa-edit me-2"></i>Edit Coupon
                                                    </h5>
                                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="AdminCouponUpdateServlet" method="post">
                                                        <input type="hidden" name="couponId" value="<%= coupon.getCouponId() %>">

                                                        <div class="mb-3">
                                                            <label for="editCouponCode<%= coupon.getCouponId() %>" class="form-label">
                                                                <i class="fas fa-barcode me-2"></i>Coupon Code
                                                            </label>
                                                            <input type="text" class="form-control" id="editCouponCode<%= coupon.getCouponId() %>"
                                                                   name="couponCode" value="<%= coupon.getCouponCode() %>" required>
                                                        </div>

                                                        <div class="mb-3">
                                                            <label for="editDiscountPercentage<%= coupon.getCouponId() %>" class="form-label">
                                                                <i class="fas fa-percent me-2"></i>Discount Percentage
                                                            </label>
                                                            <input type="number" step="0.01" min="0" max="100" class="form-control"
                                                                   id="editDiscountPercentage<%= coupon.getCouponId() %>"
                                                                   name="discountPercentage" value="<%= coupon.getDiscountPercentage() %>" required>
                                                        </div>

                                                        <div class="mb-3">
                                                            <label for="editValidUntil<%= coupon.getCouponId() %>" class="form-label">
                                                                <i class="far fa-calendar-alt me-2"></i>Valid Until
                                                            </label>
                                                            <input type="date" class="form-control" id="editValidUntil<%= coupon.getCouponId() %>"
                                                                   name="validUntil" value="<%= coupon.getValidUntil() %>" required>
                                                        </div>

                                                        <div class="mb-3">
                                                            <label for="editDescription<%= coupon.getCouponId() %>" class="form-label">
                                                                <i class="fas fa-info-circle me-2"></i>Description
                                                            </label>
                                                            <input type="text" class="form-control" id="editDescription<%= coupon.getCouponId() %>"
                                                                   name="description" value="<%= coupon.getDescription() %>" required>
                                                        </div>

                                                        <div class="text-end">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                            <button type="submit" class="btn btn-primary ms-2">Save Changes</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <% } %>
                            </tbody>
                        </table>
                        <% if (coupons.isEmpty()) { %>
                        <div class="text-center p-5">
                            <i class="fas fa-ticket-alt fa-3x text-muted mb-3"></i>
                            <p class="lead text-muted">No coupons available. Add your first coupon above!</p>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>