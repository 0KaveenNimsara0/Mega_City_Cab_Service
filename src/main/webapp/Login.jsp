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
    <style>
        body {
            background-color: #f8f9fa;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-container {
            max-width: 400px;
            width: 100%;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            background-color: #fff;
        }

        .logo-circle {
            width: 70px;
            height: 70px;
            background-color: #0d6efd;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            color: white;
            font-size: 2rem;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="login-container">
                <div class="text-center mb-4">
                    <div class="logo-circle">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <h2>Welcome Back</h2>
                </div>

                <%-- Display error message if present --%>
                <% String error = request.getParameter("error");
                    if ("true".equals(error)) { %>
                <div class="alert alert-danger text-center mb-3">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    Invalid username/email or password.
                </div>
                <% } else if ("banned".equals(error)) { %>
                <div class="alert alert-danger text-center mb-3">
                    Your account is banned. Please contact support.
                </div>
                <% } %>

                <form action="login" method="post">
                    <div class="mb-3">
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-user"></i>
                            </span>
                            <input type="text" id="usernameOrEmail" name="usernameOrEmail"
                                   class="form-control" placeholder="Username or Email" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-lock"></i>
                            </span>
                            <input type="password" id="password" name="password"
                                   class="form-control" placeholder="Password" required>
                            <button type="button" class="btn btn-outline-secondary" onclick="togglePassword()">
                                <i id="toggleIcon" class="fas fa-eye-slash"></i>
                            </button>
                        </div>
                    </div>

                    <div class="d-flex justify-content-between mb-3">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="rememberMe">
                            <label class="form-check-label" for="rememberMe">
                                Remember me
                            </label>
                        </div>
                        <a href="#">Forgot password?</a>
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-sign-in-alt me-2"></i>Log In
                        </button>
                    </div>
                </form>

                <div class="text-center my-3">
                    <span class="text-muted">OR</span>
                </div>

                <div class="d-flex justify-content-center gap-3 mb-3">
                    <button class="btn btn-outline-secondary rounded-circle" style="width: 45px; height: 45px;" title="Login with Google">
                        <i class="fab fa-google"></i>
                    </button>
                    <button class="btn btn-outline-secondary rounded-circle" style="width: 45px; height: 45px;" title="Login with Facebook">
                        <i class="fab fa-facebook-f"></i>
                    </button>
                    <button class="btn btn-outline-secondary rounded-circle" style="width: 45px; height: 45px;" title="Login with Apple">
                        <i class="fab fa-apple"></i>
                    </button>
                </div>

                <div class="text-center mt-3">
                    <p class="mb-0">Don't have an account? <a href="Register.jsp">Sign up</a></p>
                </div>
            </div>
        </div>
    </div>
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