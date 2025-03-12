<%--
  Created by IntelliJ IDEA.
  User: kavee
  Date: 2/22/2025
  Time: 2:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Customer</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6c63ff;
            --dark-bg: #121212;
            --card-bg: #1e1e1e;
            --text-primary: #ffffff;
            --text-secondary: #b3b3b3;
            --input-bg: #2d2d2d;
            --input-border: #3d3d3d;
            --error: #ff6b6b;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--dark-bg);
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            padding: 20px;
        }

        .register-container {
            width: 100%;
            max-width: 500px;
            padding: 35px;
            background: var(--card-bg);
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
            border: none;
        }

        .logo-container {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo {
            background: var(--primary);
            color: white;
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            margin-bottom: 15px;
        }

        h2 {
            font-weight: 600;
            text-align: center;
            margin-bottom: 30px;
            color: var(--text-primary);
        }

        .form-control {
            background-color: var(--input-bg);
            border: 1px solid var(--input-border);
            color: var(--text-primary);
            border-radius: 8px;
            padding: 12px 20px;
            height: auto;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            background-color: var(--input-bg);
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(108, 99, 255, 0.2);
            color: var(--text-primary);
        }

        .form-control::placeholder {
            color: var(--text-secondary);
            opacity: 0.7;
        }

        .btn-primary {
            background-color: var(--primary);
            border: none;
            border-radius: 8px;
            padding: 12px 20px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(108, 99, 255, 0.35);
            width: 100%;
            margin-top: 10px;
        }

        .btn-primary:hover {
            background-color: #5a52e0;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(108, 99, 255, 0.45);
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 25px 0;
            color: var(--text-secondary);
        }

        .divider::before, .divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid var(--input-border);
        }

        .divider span {
            padding: 0 15px;
            font-size: 0.9rem;
        }

        .login-text {
            text-align: center;
            margin-top: 25px;
            color: var(--text-secondary);
            font-size: 0.9rem;
        }

        .login-link {
            color: var(--primary);
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .login-link:hover {
            color: #5a52e0;
            text-decoration: underline;
        }

        .text-danger {
            color: var(--error) !important;
            font-size: 0.85rem;
            margin-top: -10px;
            margin-bottom: 15px;
        }

        .input-wrapper {
            position: relative;
            margin-bottom: 20px;
        }

        .input-icon {
            position: absolute;
            top: 50%;
            left: 15px;
            transform: translateY(-50%);
            color: var(--text-secondary);
        }

        .input-with-icon {
            padding-left: 45px;
        }

        .password-toggle {
            position: absolute;
            top: 50%;
            right: 15px;
            transform: translateY(-50%);
            color: var(--text-secondary);
            cursor: pointer;
            background: none;
            border: none;
            padding: 0;
        }

        .password-strength {
            height: 5px;
            border-radius: 3px;
            margin-top: 8px;
            background-color: var(--input-border);
            position: relative;
            overflow: hidden;
        }

        .password-strength-meter {
            height: 100%;
            border-radius: 3px;
            width: 0;
            transition: width 0.3s ease, background-color 0.3s ease;
        }

        .password-feedback {
            font-size: 0.8rem;
            margin-top: 5px;
            color: var(--text-secondary);
        }

        .password-bar-weak {
            width: 30%;
            background-color: #ff4d4d;
        }

        .password-bar-medium {
            width: 60%;
            background-color: #ffa500;
        }

        .password-bar-strong {
            width: 100%;
            background-color: #2ecc71;
        }

        .progress-step-container {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }

        .progress-step {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: var(--input-border);
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.9rem;
            position: relative;
            z-index: 2;
        }

        .progress-step.active {
            background-color: var(--primary);
            color: white;
        }

        .progress-line {
            flex: 1;
            height: 3px;
            background-color: var(--input-border);
            margin: 0 5px;
            position: relative;
            top: 15px;
            z-index: 1;
        }
    </style>
</head>
<body>
<div class="register-container">
    <div class="logo-container">
        <div class="logo">
            <i class="fas fa-user-plus"></i>
        </div>
        <h2>Create Account</h2>
    </div>

    <form action="register" method="post" id="registerForm">
        <div class="input-wrapper">
            <i class="fas fa-user input-icon"></i>
            <input type="text" id="Name" name="Name" class="form-control input-with-icon" placeholder="Full Name" required>
        </div>

        <div class="input-wrapper">
            <i class="fas fa-phone input-icon"></i>
            <input type="tel" id="phone" name="phone" class="form-control input-with-icon" placeholder="Phone Number" required>
        </div>

        <div class="input-wrapper">
            <i class="fas fa-envelope input-icon"></i>
            <input type="email" id="email" name="email" class="form-control input-with-icon" placeholder="Email Address" required>
        </div>

        <div class="input-wrapper">
            <i class="fas fa-at input-icon"></i>
            <input type="text" id="username" name="username" class="form-control input-with-icon" placeholder="Username" required>
        </div>

        <div class="input-wrapper">
            <i class="fas fa-lock input-icon"></i>
            <input type="password" id="password" name="password" class="form-control input-with-icon" placeholder="Password" required>
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
            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control input-with-icon" placeholder="Confirm Password" required>
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

<!-- Include Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
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
        let message = '';

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
            feedback.style.color = '#ff4d4d';
        } else if (strength === 2) {
            strengthMeter.classList.add('password-bar-medium');
            feedback.textContent = 'Medium password - try adding more variety';
            feedback.style.color = '#ffa500';
        } else {
            strengthMeter.classList.add('password-bar-strong');
            feedback.textContent = 'Strong password - good job!';
            feedback.style.color = '#2ecc71';
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