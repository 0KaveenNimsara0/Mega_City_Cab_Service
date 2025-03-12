<%--
  Created by IntelliJ IDEA.
  User: kavee
  Date: 2/21/2025
  Time: 7:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Login</title>
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

        .login-container {
            width: 100%;
            max-width: 420px;
            padding: 35px;
            background: var(--card-bg);
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
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

        .form-label {
            color: var(--text-secondary);
            font-size: 0.9rem;
            font-weight: 500;
            margin-bottom: 8px;
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

        .input-group-text {
            background-color: var(--input-bg);
            border: 1px solid var(--input-border);
            border-right: none;
            color: var(--text-secondary);
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
        }

        .btn-primary:hover {
            background-color: #5a52e0;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(108, 99, 255, 0.45);
        }

        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            font-size: 0.9rem;
        }

        .form-check-input {
            background-color: var(--input-bg);
            border-color: var(--input-border);
        }

        .form-check-input:checked {
            background-color: var(--primary);
            border-color: var(--primary);
        }

        .form-check-label {
            color: var(--text-secondary);
            cursor: pointer;
        }

        .forgot-link, .signup-link {
            color: var(--primary);
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .forgot-link:hover, .signup-link:hover {
            color: #5a52e0;
            text-decoration: underline;
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

        .social-login {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 25px;
        }

        .social-btn {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--input-bg);
            color: var(--text-primary);
            font-size: 1.2rem;
            transition: all 0.3s ease;
            border: none;
        }

        .social-btn:hover {
            transform: translateY(-3px);
            background-color: var(--input-border);
        }

        .signup-text {
            text-align: center;
            margin-top: 20px;
            color: var(--text-secondary);
            font-size: 0.9rem;
        }

        .error-message {
            background-color: rgba(220, 53, 69, 0.15);
            color: #ff6b6b;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 0.9rem;
            text-align: center;
            border-left: 3px solid #ff6b6b;
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
    </style>
</head>
<body>
<div class="login-container">
    <div class="logo-container">
        <div class="logo">
            <i class="fas fa-user-shield"></i>
        </div>
        <h2>Welcome Back</h2>
    </div>

    <%-- Display error message if present --%>
    <% String error = request.getParameter("error");
        if ("true".equals(error)) { %>
    <div class="error-message">
        <i class="fas fa-exclamation-circle me-2"></i>
        Invalid username/email or password. Please try again.
    </div>
    <% } else if ("banned".equals(error)) { %>
    <div class="alert alert-danger text-center">Your account is banned. Please contact support.</div>
    <% } %>


    <form action="login" method="post">
        <div class="input-wrapper">
            <i class="fas fa-user input-icon"></i>
            <input type="text" id="usernameOrEmail" name="usernameOrEmail"
                   class="form-control input-with-icon"
                   placeholder="Username or Email" required>
        </div>

        <div class="input-wrapper">
            <i class="fas fa-lock input-icon"></i>
            <input type="password" id="password" name="password"
                   class="form-control input-with-icon"
                   placeholder="Password" required>
            <button type="button" class="password-toggle" onclick="togglePassword()">
                <i id="toggleIcon" class="fas fa-eye-slash"></i>
            </button>
        </div>

        <div class="remember-forgot">
            <div class="form-check">
                <input class="form-check-input" type="checkbox" value="" id="rememberMe">
                <label class="form-check-label" for="rememberMe">
                    Remember me
                </label>
            </div>
            <a href="#" class="forgot-link">Forgot password?</a>
        </div>

        <button type="submit" class="btn btn-primary w-100">
            <i class="fas fa-sign-in-alt me-2"></i>Log In
        </button>
    </form>

    <div class="divider">
        <span>OR</span>
    </div>

    <div class="social-login">
        <button class="social-btn" title="Login with Google">
            <i class="fab fa-google"></i>
        </button>
        <button class="social-btn" title="Login with Facebook">
            <i class="fab fa-facebook-f"></i>
        </button>
        <button class="social-btn" title="Login with Apple">
            <i class="fab fa-apple"></i>
        </button>
    </div>

    <p class="signup-text">
        Don't have an account? <a href="Register.jsp" class="signup-link">Sign up</a>
    </p>
</div>

<script>
    function togglePassword() {
        const passwordInput = document.getElementById('password');
        const toggleIcon = document.getElementById('toggleIcon');

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
</script>
</body>
</html>