<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile - Mega City Cab Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        :root {
            --dark-bg: #212529;
            --darker-bg: #181c1f;
            --primary-color: #5c67ec;
            --primary-hover: #4954d6;
            --text-primary: #e9ecef;
            --text-secondary: #adb5bd;
            --success-color: #43a047;
            --error-color: #e53935;
        }

        body {
            background-color: var(--dark-bg);
            color: var(--text-primary);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .card {
            background-color: var(--darker-bg);
            border-radius: 15px;
            border: 1px solid #2d3339;
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.3);
        }

        .card-header {
            border-bottom: 1px solid #2d3339;
            padding: 1.5rem;
        }

        .form-control, .form-select {
            background-color: #2d3339;
            border: 1px solid #424a53;
            color: var(--text-primary);
            border-radius: 8px;
            padding: 12px 16px;
        }

        .form-control:focus, .form-select:focus {
            background-color: #2d3339;
            border-color: var(--primary-color);
            color: var(--text-primary);
            box-shadow: 0 0 0 0.25rem rgba(92, 103, 236, 0.25);
        }

        .form-control::placeholder {
            color: var(--text-secondary);
        }

        .form-label {
            color: var(--text-secondary);
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            border-radius: 8px;
            padding: 12px 24px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary:hover, .btn-primary:focus {
            background-color: var(--primary-hover);
            border-color: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(92, 103, 236, 0.4);
        }

        .input-group-text {
            background-color: #2d3339;
            border: 1px solid #424a53;
            color: var(--text-secondary);
        }

        .form-text {
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        .password-strength {
            height: 5px;
            transition: all 0.3s ease;
            border-radius: 3px;
            margin-top: 5px;
        }

        .is-invalid {
            border-color: var(--error-color) !important;
        }

        .invalid-feedback {
            color: var(--error-color);
        }

        .is-valid {
            border-color: var(--success-color) !important;
        }

        .valid-feedback {
            color: var(--success-color);
        }

        .input-with-icon {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            z-index: 10;
        }

        .textarea-icon {
            position: absolute;
            left: 15px;
            top: 22px;
            color: var(--text-secondary);
            z-index: 10;
        }

        .input-with-icon .form-control {
            padding-left: 45px;
        }

        .password-toggle {
            cursor: pointer;
            position: absolute;
            top: 50%;
            right: 16px;
            transform: translateY(-50%);
            color: var(--text-secondary);
            z-index: 10;
        }

        .progress-label {
            font-size: 0.75rem;
            font-weight: 600;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card">
                <div class="card-header text-center">
                    <h2 class="mb-0"><i class="bi bi-person-circle me-2"></i>Update Your Profile</h2>
                    <p class="text-secondary mb-0">Mega City Cab Service</p>
                </div>
                <div class="card-body p-4">
                    <form id="profileForm" action="updateProfile" method="post" class="needs-validation" novalidate>
                        <!-- Full Name -->
                        <div class="mb-4">
                            <label for="name" class="form-label">Full Name</label>
                            <div class="input-with-icon">
                                <span class="input-icon">
                                    <i class="bi bi-person"></i>
                                </span>
                                <input type="text" class="form-control" id="name" name="name"
                                       value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>"
                                       pattern="^[a-zA-Z\s]{2,50}$"
                                       required>
                                <div class="invalid-feedback">
                                    Please enter a valid name (2-50 characters, letters only)
                                </div>
                            </div>
                        </div>

                        <!-- Email -->
                        <div class="mb-4">
                            <label for="email" class="form-label">Email</label>
                            <div class="input-with-icon">
                                <span class="input-icon">
                                    <i class="bi bi-envelope"></i>
                                </span>
                                <input type="email" class="form-control" id="email" name="email"
                                       value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                                       required>
                                <div class="invalid-feedback">
                                    Please enter a valid email address
                                </div>
                            </div>
                        </div>

                        <!-- Phone Number -->
                        <div class="mb-4">
                            <label for="phone" class="form-label">Phone Number</label>
                            <div class="input-with-icon">
                                <span class="input-icon">
                                    <i class="bi bi-telephone"></i>
                                </span>
                                <input type="tel" class="form-control" id="phone" name="phone"
                                       value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>"
                                       pattern="^[0-9]{10,15}$"
                                       required>
                                <div class="invalid-feedback">
                                    Please enter a valid phone number (10-15 digits)
                                </div>
                            </div>
                        </div>

                        <!-- Address -->
                        <div class="mb-4">
                            <label for="address" class="form-label">Address</label>
                            <div class="input-with-icon">
                                <span class="textarea-icon">
                                    <i class="bi bi-geo-alt"></i>
                                </span>
                                <textarea class="form-control" id="address" name="address" rows="3"
                                          minlength="5" maxlength="200"><%= request.getAttribute("address") != null ? request.getAttribute("address") : "" %></textarea>
                                <div class="invalid-feedback">
                                    Address should be between 5-200 characters
                                </div>
                            </div>
                        </div>

                        <!-- NIC -->
                        <div class="mb-4">
                            <label for="nic" class="form-label">NIC</label>
                            <div class="input-with-icon">
                                <span class="input-icon">
                                    <i class="bi bi-card-text"></i>
                                </span>
                                <input type="text" class="form-control" id="nic" name="nic"
                                       value="<%= request.getAttribute("nic") != null ? request.getAttribute("nic") : "" %>"
                                       pattern="^[A-Za-z0-9]{5,20}$">
                                <div class="invalid-feedback">
                                    NIC should be between 5-20 alphanumeric characters
                                </div>
                            </div>
                        </div>

<%--                        <!-- Password -->--%>
<%--                        <div class="mb-4">--%>
<%--                            <label for="password" class="form-label">Password</label>--%>
<%--                            <div class="input-with-icon">--%>
<%--                                <span class="input-icon">--%>
<%--                                    <i class="bi bi-lock"></i>--%>
<%--                                </span>--%>
<%--                                <input type="password" class="form-control" id="password" name="password"--%>
<%--                                       pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"--%>
<%--                                       required>--%>
<%--                                <span class="password-toggle" id="togglePassword">--%>
<%--                                    <i class="bi bi-eye-slash"></i>--%>
<%--                                </span>--%>
<%--                                <div class="invalid-feedback">--%>
<%--                                    Password must be at least 8 characters with uppercase, lowercase, number and special character--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                            <div class="mt-2">--%>
<%--                                <div class="d-flex justify-content-between">--%>
<%--                                    <small class="progress-label text-secondary">Password Strength:</small>--%>
<%--                                    <small class="progress-value text-secondary" id="strengthValue">0%</small>--%>
<%--                                </div>--%>
<%--                                <div class="password-strength bg-secondary" id="passwordStrength" style="width: 0%"></div>--%>
<%--                            </div>--%>
<%--                        </div>--%>

<%--                        <!-- Confirm Password -->--%>
<%--                        <div class="mb-4">--%>
<%--                            <label for="confirmPassword" class="form-label">Confirm Password</label>--%>
<%--                            <div class="input-with-icon">--%>
<%--                                <span class="input-icon">--%>
<%--                                    <i class="bi bi-lock-fill"></i>--%>
<%--                                </span>--%>
<%--                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>--%>
<%--                                <span class="password-toggle" id="toggleConfirmPassword">--%>
<%--                                    <i class="bi bi-eye-slash"></i>--%>
<%--                                </span>--%>
<%--                                <div class="invalid-feedback">--%>
<%--                                    Passwords do not match--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>

                        <div class="d-grid gap-2 mt-5">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-circle me-2"></i>Update Profile
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Form Validation Script -->
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Form validation
        const form = document.getElementById('profileForm');
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');
        const passwordStrength = document.getElementById('passwordStrength');
        const strengthValue = document.getElementById('strengthValue');

        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            togglePasswordVisibility(password, this);
        });

        document.getElementById('toggleConfirmPassword').addEventListener('click', function() {
            togglePasswordVisibility(confirmPassword, this);
        });

        function togglePasswordVisibility(inputField, toggleButton) {
            if (inputField.type === 'password') {
                inputField.type = 'text';
                toggleButton.innerHTML = '<i class="bi bi-eye"></i>';
            } else {
                inputField.type = 'password';
                toggleButton.innerHTML = '<i class="bi bi-eye-slash"></i>';
            }
        }

        // Password strength meter
        password.addEventListener('input', function() {
            const value = password.value;
            let strength = 0;

            if (value.length >= 8) strength += 20;
            if (value.match(/[a-z]+/)) strength += 20;
            if (value.match(/[A-Z]+/)) strength += 20;
            if (value.match(/[0-9]+/)) strength += 20;
            if (value.match(/[^A-Za-z0-9]+/)) strength += 20;

            strengthValue.textContent = strength + '%';
            passwordStrength.style.width = strength + '%';

            if (strength <= 20) {
                passwordStrength.className = 'password-strength bg-danger';
            } else if (strength <= 40) {
                passwordStrength.className = 'password-strength bg-warning';
            } else if (strength <= 60) {
                passwordStrength.className = 'password-strength bg-info';
            } else if (strength <= 80) {
                passwordStrength.className = 'password-strength bg-primary';
            } else {
                passwordStrength.className = 'password-strength bg-success';
            }
        });

        // Password match validation
        confirmPassword.addEventListener('input', function() {
            if (password.value !== confirmPassword.value) {
                confirmPassword.setCustomValidity('Passwords do not match');
            } else {
                confirmPassword.setCustomValidity('');
            }
        });

        // Prevent form submission if validation fails
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }

            form.classList.add('was-validated');
        });
    });
</script>
</body>
</html>