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
    <title>Admin - Manage Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center">Manage Users</h2>

    <% String message = request.getParameter("message");
        String error = request.getParameter("error"); %>
    <% if (message != null && !message.isEmpty()) { %>
    <div class="alert alert-success"><%= message %></div>
    <% } %>
    <% if (error != null && !error.isEmpty()) { %>
    <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <table class="table table-bordered mt-4">
        <thead>
        <tr>
            <th>Customer ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Address</th>
            <th>NIC</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<User> users = (List<User>) request.getAttribute("users");
            if (users != null && !users.isEmpty()) {
                for (User user : users) {
        %>
        <tr>
            <td><%= user.getCustomerId() %></td>
            <td><%= user.getUsername() %></td>
            <td><%= user.getEmail() %></td>
            <td><%= user.getPhone() %></td>
            <td><%= user.getAddress() != null ? user.getAddress() : "N/A" %></td>
            <td><%= user.getNic() != null ? user.getNic() : "N/A" %></td>
            <td><%= user.getStatus() %></td>
            <td>
                <form action="AdminUserManagementServlet" method="post" style="display: inline;">
                    <input type="hidden" name="action" value="updateStatus">
                    <input type="hidden" name="userId" value="<%= user.getCustomerId() %>">
                    <select name="status" class="form-select form-select-sm">
                        <option value="Active" <%= "Active".equals(user.getStatus()) ? "selected" : "" %>>Active</option>
                        <option value="Warning" <%= "Warning".equals(user.getStatus()) ? "selected" : "" %>>Warning</option>
                        <option value="Banned" <%= "Banned".equals(user.getStatus()) ? "selected" : "" %>>Banned</option>
                    </select>
                    <button type="submit" class="btn btn-sm btn-primary mt-2">Update Status</button>
                </form>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="8" class="text-center">No users found.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
