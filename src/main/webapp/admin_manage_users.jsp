<%--
  Created by IntelliJ IDEA.
  User: kavee
  Date: 3/10/2025
  Time: 1:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.mega_city_cab_service.model.User" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Manage Users | Mega City Cab Service</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .card-header {
            background-color: #343a40;
            color: white;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            padding: 15px 20px;
        }
        .status-active {
            background-color: #d4edda;
            color: #155724;
        }
        .status-warning {
            background-color: #fff3cd;
            color: #856404;
        }
        .status-banned {
            background-color: #f8d7da;
            color: #721c24;
        }
        .action-btn {
            min-width: 100px;
        }
        .table-responsive {
            overflow-x: auto;
        }
        .badge {
            font-size: 90%;
            padding: 6px 10px;
        }
    </style>
</head>
<body>
<div class="container py-4">
    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h2 class="mb-0"><i class="fas fa-users me-2"></i>Manage Users</h2>
            <div>
                <button class="btn btn-outline-light btn-sm"><i class="fas fa-file-export me-1"></i> Export</button>
                <button class="btn btn-outline-light btn-sm ms-2"><i class="fas fa-filter me-1"></i> Filter</button>
            </div>
        </div>
        <div class="card-body">
            <% String message = request.getParameter("message");
                String error = request.getParameter("error"); %>
            <% if (message != null && !message.isEmpty()) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i><%= message %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% } %>
            <% if (error != null && !error.isEmpty()) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i><%= error %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% } %>

            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-light">
                    <tr>
                        <th><i class="fas fa-id-card me-1"></i> Customer ID</th>
                        <th><i class="fas fa-user me-1"></i> Username</th>
                        <th><i class="fas fa-envelope me-1"></i> Email</th>
                        <th><i class="fas fa-phone me-1"></i> Phone</th>
                        <th><i class="fas fa-map-marker-alt me-1"></i> Address</th>
                        <th><i class="fas fa-id-badge me-1"></i> NIC</th>
                        <th><i class="fas fa-info-circle me-1"></i> Status</th>
                        <th><i class="fas fa-cogs me-1"></i> Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        List<User> users = (List<User>) request.getAttribute("users");
                        if (users != null && !users.isEmpty()) {
                            for (User user : users) {
                                String statusClass = "";
                                String statusIcon = "";

                                if ("Active".equals(user.getStatus())) {
                                    statusClass = "status-active";
                                    statusIcon = "fa-check-circle";
                                } else if ("Warning".equals(user.getStatus())) {
                                    statusClass = "status-warning";
                                    statusIcon = "fa-exclamation-circle";
                                } else if ("Banned".equals(user.getStatus())) {
                                    statusClass = "status-banned";
                                    statusIcon = "fa-ban";
                                }
                    %>
                    <tr>
                        <td><%= user.getCustomerId() %></td>
                        <td><strong><%= user.getUsername() %></strong></td>
                        <td><a href="mailto:<%= user.getEmail() %>"><%= user.getEmail() %></a></td>
                        <td><a href="tel:<%= user.getPhone() %>"><%= user.getPhone() %></a></td>
                        <td><%= user.getAddress() != null ? user.getAddress() : "<span class='text-muted'>N/A</span>" %></td>
                        <td><%= user.getNic() != null ? user.getNic() : "<span class='text-muted'>N/A</span>" %></td>
                        <td><span class="badge rounded-pill <%= statusClass %>"><i class="fas <%= statusIcon %> me-1"></i> <%= user.getStatus() %></span></td>
                        <td>
                            <form action="AdminUserManagementServlet" method="post">
                                <input type="hidden" name="action" value="updateStatus">
                                <input type="hidden" name="userId" value="<%= user.getCustomerId() %>">
                                <div class="input-group input-group-sm">
                                    <select name="status" class="form-select">
                                        <option value="Active" <%= "Active".equals(user.getStatus()) ? "selected" : "" %>>Active</option>
                                        <option value="Warning" <%= "Warning".equals(user.getStatus()) ? "selected" : "" %>>Warning</option>
                                        <option value="Banned" <%= "Banned".equals(user.getStatus()) ? "selected" : "" %>>Banned</option>
                                    </select>
                                    <button type="submit" class="btn btn-primary action-btn">Update</button>
                                </div>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="8" class="text-center py-4">
                            <div class="text-muted">
                                <i class="fas fa-search fa-3x mb-3"></i>
                                <p>No users found in the system.</p>
                                <p>New users will appear here once they register.</p>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

            <div class="d-flex justify-content-between align-items-center mt-3">
                <div>
                    <span class="text-muted">Showing <%= users != null ? users.size() : 0 %> users</span>
                </div>
                <nav aria-label="Page navigation">
                    <ul class="pagination pagination-sm justify-content-end mb-0">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1">Previous</a>
                        </li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#">Next</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>