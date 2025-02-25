<%--
  Created by IntelliJ IDEA.
  User: kavee
  Date: 2/22/2025
  Time: 2:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register Customer</title>
    <!-- Include Bootstrap  -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .register-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .btn-login {
            background-color: #007bff;
            color: white;
            border: none;
        }
        .btn-login:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="register-container">
    <h2 class="text-center">Welcome Back </h2>
    <form action="register" method="post" id="registerForm">
        <div class="mb-3">
            <input type="text" id="Name" name="Name" class="form-control" placeholder="Enter your Name" required>
        </div>
        <div class="mb-3">
            <input type="tel" id="phone" name="phone" class="form-control" placeholder="Enter your Phone Number" required>
        </div>
        <div class="mb-3">
            <input type="email" id="email" name="email" class="form-control" placeholder="Enter your Email" required>
        </div>
        <div class="mb-3">
            <input type="text" id="username" name="username" class="form-control" placeholder="Enter your Username" required>
        </div>
        <div class="mb-3">
            <input type="password" id="password" name="password" class="form-control" placeholder="Enter your Password" required>
        </div>
        <div class="mb-3">
            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Confirm your Password" required>
        </div>
        <div id="passwordError" class="text-danger mb-3"></div>
        <button type="submit" class="btn btn-login">Register</button>
    </form>
</div>
<!-- Include Bootstrap JS  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Add event listener to the form to validate confirm password
    document.getElementById('registerForm').addEventListener('submit', function (event) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const passwordError = document.getElementById('passwordError');

        // Clear previous error message
        passwordError.textContent = '';

        // Check if passwords match
        if (password !== confirmPassword) {
            passwordError.textContent = 'Passwords do not match!';
            event.preventDefault(); // Prevent form submission
        }
    });
</script>
</body>
</html>
