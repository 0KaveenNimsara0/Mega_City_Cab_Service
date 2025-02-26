<%--
  Created by IntelliJ IDEA.
  User: kavee
  Date: 2/21/2025
  Time: 7:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Customer Login</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .login-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2 class="text-center">Welcome Back</h2>
    <%-- Display error message if present --%>
    <%
        String error = request.getParameter("error");
        if ("true".equals(error)) {
    %>
    <div class="error-message">Invalid username/email or password. Please try again.</div>
    <%
        }
    %>
    <form action="login" method="post">
        <div class="mb-3">
            <input type="text" id="usernameOrEmail" name="usernameOrEmail" class="form-control"
                   placeholder="Enter your username or Email" required>
        </div>
        <div class="mb-3">
            <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Login</button>
    </form>
</div>
</body>
</html>