<%--
  Created by IntelliJ IDEA.
  User: kavee
  Date: 2/22/2025
  Time: 2:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Customer</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px;
        }

        .register-container {
            width: 100%;
            max-width: 450px;
            padding: 25px;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }

        .form-control {
            margin-bottom: 15px;
            padding: 10px 15px 10px 40px;
        }

        .input-wrapper {
            position: relative;
            margin-bottom: 15px;
        }

        .input-icon {
            position: absolute;
            top: 50%;
            left: 15px;
            transform: translateY(-50%);
            color: #6c757d;
        }

        .password-toggle {
            position: absolute;
            top: 50%;
            right: 15px;
            transform: translateY(-50%);
            color: #6c757d;
            cursor: pointer;
            background: none;
            border: none;
            padding: 0;
        }

        .btn-primary {
            background-color: #0d6efd;
            width: 100%;
            padding: 10px;
            border: none;
            margin-top: 10px;
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 20px 0;
            color: #6c757d;
        }

        .divider::before, .divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid #dee2e6;
        }

        .divider span {
            padding: 0 10px;
            font-size: 0.9rem;
        }

        .login-text {
            text-align: center;
            margin-top: 20px;
            color: #6c757d;
        }

        .login-link {
            color: #0d6efd;
            text-decoration: none;
        }

        .login-link:hover {
            text-decoration: underline;
        }

        .text-danger {
            color: #dc3545;
            font-size: 0.85rem;
            margin-top: -10px;
            margin-bottom: 15px;
        }

        .password-strength {
            height: 4px;
            border-radius: 2px;
            margin-top: 5px;
            background-color: #e9ecef;
            margin-bottom: 10px;
        }

        .password-strength-meter {
            height: 100%;
            border-radius: 2px;
            width: 0;
            transition: width 0.3s ease, background-color 0.3s ease;
        }

        .password-feedback {
            font-size: 0.8rem;
            margin-bottom: 15px;
            color: #6c757d;
        }

        .password-bar-weak {
            width: 30%;
            background-color: #dc3545;
        }

        .password-bar-medium {
            width: 60%;
            background-color: #ffc107;
        }

        .password-bar-strong {
            width: 100%;
            background-color: #198754;
        }
    </style>
</head>
<body>
<div class="register-container">
    <h2>Create Account</h2>

    <form action="register" method="post" id="registerForm">
        <div class="input-wrapper">
            <i class="fas fa-user input-icon"></i>
            <input type="text" id="Name" name="Name" class="form-control" placeholder="Full Name" required>
        </div>

        <div class="input-wrapper">
            <i class="fas fa-phone input-icon"></i>
            <input type="tel" id="phone" name="phone" class="form-control" placeholder="Phone Number" required>
        </div>

        <div class="input-wrapper">
            <i class="fas fa-envelope input-icon"></i>
            <input type="email" id="email" name="email" class="form-control" placeholder="Email Address" required>
        </div>

        <div class="input-wrapper">
            <i class="fas fa-at input-icon"></i>
            <input type="text" id="username" name="username" class="form-control" placeholder="Username" required>
        </div>

        <div class="input-wrapper">
            <i class="fas fa-lock input-icon"></i>
            <input type="password" id="password" name="password" class="form-control" placeholder="Password" required>
            <button type="button" class="password-toggle" onclick="togglePassword('password', 'toggleIcon1')">
                <i id="toggleIcon1" class="fas fa-eye-slash"></i>
            </button>
        </div>

        <div class="password-strength">
            <div id="passwordStrengthMeter" class="password-strength-meter"></div>
        </div>
        <div id="passwordFeedback" class="password-feedback">Password strength will appear here</div>

        <div class="input-wrapper">
            <i class="fas fa-lock input-icon"></i>
            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Confirm Password" required>
            <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword', 'toggleIcon2')">
                <i id="toggleIcon2" class="fas fa-eye-slash"></i>
            </button>
        </div>

        <div id="passwordError" class="text-danger"></div>

        <button type="submit" class="btn btn-primary">
            <i class="fas fa-user-plus me-2"></i>Create Account
        </button>
    </form>

    <div class="divider">
        <span>OR</span>
    </div>

    <div class="login-text">
        Already have an account? <a href="Login.jsp" class="login-link">Login</a>
    </div>
</div>

<script>
    // Function to toggle password visibility
    function togglePassword(inputId, iconId) {
        const passwordInput = document.getElementById(inputId);
        const toggleIcon = document.getElementById(iconId);

        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            toggleIcon.classList.remove('fa-eye-slash');
            toggleIcon.classList.add('fa-eye');
        } else {
            passwordInput.type = 'password';
            toggleIcon.classList.remove('fa-eye');
            toggleIcon.classList.add('fa-eye-slash');
        }
    }

    // Password strength checker
    const passwordInput = document.getElementById('password');
    const strengthMeter = document.getElementById('passwordStrengthMeter');
    const feedback = document.getElementById('passwordFeedback');

    passwordInput.addEventListener('input', function() {
        const val = passwordInput.value;
        let strength = 0;

        // Check password length
        if (val.length >= 8) {
            strength += 1;
        }

        // Check for mixed case
        if (val.match(/[a-z]/) && val.match(/[A-Z]/)) {
            strength += 1;
        }

        // Check for numbers
        if (val.match(/[0-9]/)) {
            strength += 1;
        }

        // Check for special characters
        if (val.match(/[^a-zA-Z0-9]/)) {
            strength += 1;
        }

        // Update the strength meter
        strengthMeter.className = 'password-strength-meter';

        // Update the feedback message and color
        if (val.length === 0) {
            strengthMeter.style.width = '0';
            feedback.textContent = 'Password strength will appear here';
        } else if (strength < 2) {
            strengthMeter.classList.add('password-bar-weak');
            feedback.textContent = 'Weak password - add numbers, symbols, and mixed case';
            feedback.style.color = '#dc3545';
        } else if (strength === 2) {
            strengthMeter.classList.add('password-bar-medium');
            feedback.textContent = 'Medium password - try adding more variety';
            feedback.style.color = '#ffc107';
        } else {
            strengthMeter.classList.add('password-bar-strong');
            feedback.textContent = 'Strong password - good job!';
            feedback.style.color = '#198754';
        }
    });

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