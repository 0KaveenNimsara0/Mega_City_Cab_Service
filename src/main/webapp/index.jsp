<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Mega City Cab Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .welcome-container {
            text-align: center;
            margin-top: 100px;
        }
        .btn-custom {
            margin: 10px;
            padding: 10px 20px;
            font-size: 18px;
        }
        .btn-register {
            background-color: #28a745;
            color: white;
        }
        .btn-login {
            background-color: #007bff;
            color: white;
        }
    </style>
</head>
<body>
<div class="container welcome-container">
    <h1 class="display-4">Welcome to Mega City Cab System</h1>
    <p class="lead">Your reliable partner for hassle-free transportation.</p>

    <div class="mt-5">
        <a href="admin_login.jsp" class="btn btn-custom btn-register">Admin Login</a>
        <a href="register.jsp" class="btn btn-custom btn-register">Register</a>
        <a href="Login.jsp" class="btn btn-custom btn-login">Login</a>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>