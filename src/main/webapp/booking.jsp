<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.mega_city_cab_service.model.Location" %>
<%@ page import="com.example.mega_city_cab_service.model.VehicleType" %>
<%@ page import="com.example.mega_city_cab_service.dao.VehicleTypeDAO" %>
<%@ page import="com.example.mega_city_cab_service.service.LocationService" %>
<%@ page import="com.example.mega_city_cab_service.service.VehicleTypeService" %>

<%
    // Fetch locations from the database using LocationDAO
    List<Location> locations = null;
    try {
        LocationService allLocations = new LocationService();
        locations = allLocations.getAllLocations(); // Assuming getAllLocations() returns a list of Location objects
    } catch (Exception e) {
        e.printStackTrace();
    }

    // Fetch vehicle types from the database using VehicleTypeDAO
    List<VehicleType> vehicleTypes = null;
    try {
        VehicleTypeService allvehicleType = new VehicleTypeService();
        vehicleTypes = allvehicleType.getAllVehicleTypes(); // Assuming getAllVehicleTypes() returns a list of VehicleType objects
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab Service - Book Your Ride</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #3498db;
            --primary-dark: #2980b9;
            --secondary-color: #f39c12;
            --text-color: #2c3e50;
            --light-bg: #f8f9fa;
            --success-color: #2ecc71;
            --error-color: #e74c3c;
            --border-radius: 10px;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-bottom: 50px;
        }

        .header {
            background-color: var(--primary-color);
            color: white;
            padding: 15px 0;
            margin-bottom: 40px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .booking-container {
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            padding: 30px;
            margin-top: 20px;
            position: relative;
            overflow: hidden;
        }

        .booking-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
        }

        .booking-title {
            color: var(--text-color);
            text-align: center;
            margin-bottom: 30px;
            font-weight: 700;
        }

        .form-label {
            color: var(--text-color);
            font-weight: 500;
            margin-bottom: 8px;
        }

        .form-control, .form-select {
            border-radius: var(--border-radius);
            border: 2px solid #e0e0e0;
            padding: 12px 15px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(52,152,219,0.25);
        }

        .input-group-text {
            background-color: var(--light-bg);
            border-radius: var(--border-radius) 0 0 var(--border-radius);
            border: 2px solid #e0e0e0;
            border-right: none;
        }

        .form-group {
            margin-bottom: 24px;
            position: relative;
        }

        .validation-icon {
            position: absolute;
            right: 15px;
            top: 45px;
            font-size: 16px;
            display: none;
        }

        .is-valid .validation-icon.valid-icon {
            display: block;
            color: var(--success-color);
        }

        .is-invalid .validation-icon.invalid-icon {
            display: block;
            color: var(--error-color);
        }

        .form-control.is-valid, .form-select.is-valid {
            border-color: var(--success-color);
            padding-right: 40px;
            background-image: none;
        }

        .form-control.is-invalid, .form-select.is-invalid {
            border-color: var(--error-color);
            padding-right: 40px;
            background-image: none;
        }

        .invalid-feedback {
            color: var(--error-color);
            font-size: 14px;
            margin-top: 5px;
        }

        .btn-primary {
            background: linear-gradient(to right, var(--primary-color), var(--primary-dark));
            border: none;
            border-radius: var(--border-radius);
            padding: 12px 20px;
            font-weight: 600;
            font-size: 16px;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .btn-primary:hover {
            background: linear-gradient(to right, var(--primary-dark), var(--primary-color));
            transform: translateY(-2px);
            box-shadow: 0 6px 8px rgba(0,0,0,0.15);
        }

        .btn-primary:active {
            transform: translateY(0);
        }

        .cab-icon {
            max-width: 120px;
            margin-bottom: 20px;
            display: block;
            margin-left: auto;
            margin-right: auto;
            filter: drop-shadow(0 4px 6px rgba(0,0,0,0.1));
        }

        .form-section {
            position: relative;
            padding-left: 30px;
        }

        .form-section::before {
            content: '';
            position: absolute;
            left: 15px;
            top: 0;
            bottom: 0;
            width: 2px;
            background-color: #e0e0e0;
        }

        .step-circle {
            position: absolute;
            left: 5px;
            width: 22px;
            height: 22px;
            border-radius: 50%;
            background-color: var(--primary-color);
            color: white;
            text-align: center;
            line-height: 22px;
            font-size: 12px;
            font-weight: bold;
            z-index: 1;
        }

        .section-title {
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 15px;
            padding-bottom: 8px;
            border-bottom: 2px solid #f0f0f0;
        }

        .tooltip-icon {
            color: #95a5a6;
            margin-left: 5px;
            font-size: 14px;
            cursor: help;
        }

        .location-icon {
            color: var(--primary-color);
        }

        .vehicle-icon {
            color: var(--secondary-color);
        }

        .time-icon {
            color: #9b59b6;
        }

        .coupon-icon {
            color: #e67e22;
        }
    </style>
</head>
<body>
<header class="header">
    <div class="container">
        <div class="d-flex justify-content-center align-items-center">
            <i class="fas fa-taxi me-2" style="font-size: 24px;"></i>
            <h1 class="m-0">Mega City Cab Service</h1>
        </div>
    </div>
</header>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-7">
            <div class="booking-container">
                <img src="/api/placeholder/120/120" alt="Cab Icon" class="cab-icon">
                <h2 class="booking-title">Book Your Cab</h2>

                <form id="bookingForm" action="ConfirmBookingServlet" method="post" novalidate>
                    <!-- Location Section -->
                    <div class="form-section mb-4">
                        <div class="step-circle">1</div>
                        <h4 class="section-title"><i class="fas fa-map-marker-alt me-2 location-icon"></i>Trip Details</h4>

                        <div class="form-group">
                            <label for="pickupPoint" class="form-label">Pickup Point <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-location-dot"></i></span>
                                <select id="pickupPoint" name="pickupPoint" class="form-select" required>
                                    <option value="">Select Pickup Point</option>
                                    <% if (locations != null && !locations.isEmpty()) { %>
                                    <% for (Location location : locations) { %>
                                    <option value="<%= location.getLocationId() %>"><%= location.getLocationName() %></option>
                                    <% } %>
                                    <% } else { %>
                                    <option value="">No locations available</option>
                                    <% } %>
                                </select>
                                <span class="validation-icon valid-icon"><i class="fas fa-check-circle"></i></span>
                                <span class="validation-icon invalid-icon"><i class="fas fa-exclamation-circle"></i></span>
                            </div>
                            <div class="invalid-feedback">Please select a pickup point</div>
                        </div>

                        <div class="form-group">
                            <label for="destination" class="form-label">Destination <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-location-arrow"></i></span>
                                <select id="destination" name="destination" class="form-select" required>
                                    <option value="">Select Destination</option>
                                    <% if (locations != null && !locations.isEmpty()) { %>
                                    <% for (Location location : locations) { %>
                                    <option value="<%= location.getLocationId() %>"><%= location.getLocationName() %></option>
                                    <% } %>
                                    <% } else { %>
                                    <option value="">No destinations available</option>
                                    <% } %>
                                </select>
                                <span class="validation-icon valid-icon"><i class="fas fa-check-circle"></i></span>
                                <span class="validation-icon invalid-icon"><i class="fas fa-exclamation-circle"></i></span>
                            </div>
                            <div class="invalid-feedback">Please select a destination</div>
                        </div>
                    </div>

                    <!-- Vehicle Section -->
                    <div class="form-section mb-4">
                        <div class="step-circle">2</div>
                        <h4 class="section-title"><i class="fas fa-car me-2 vehicle-icon"></i>Vehicle Details</h4>

                        <div class="form-group">
                            <label for="carType" class="form-label">Vehicle Type <span class="text-danger">*</span>
                                <i class="fas fa-circle-info tooltip-icon" data-bs-toggle="tooltip" title="Select the type of vehicle that best suits your needs"></i>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-taxi"></i></span>
                                <select id="carType" name="carType" class="form-select" required>
                                    <option value="">Select Vehicle Type</option>
                                    <% if (vehicleTypes != null && !vehicleTypes.isEmpty()) { %>
                                    <% for (VehicleType vehicleType : vehicleTypes) { %>
                                    <option value="<%= vehicleType.getTypeId() %>"><%= vehicleType.getTypeName() %></option>
                                    <% } %>
                                    <% } else { %>
                                    <option value="">No car types available</option>
                                    <% } %>
                                </select>
                                <span class="validation-icon valid-icon"><i class="fas fa-check-circle"></i></span>
                                <span class="validation-icon invalid-icon"><i class="fas fa-exclamation-circle"></i></span>
                            </div>
                            <div class="invalid-feedback">Please select a vehicle type</div>
                        </div>
                    </div>

                    <!-- Timing Section -->
                    <div class="form-section mb-4">
                        <div class="step-circle">3</div>
                        <h4 class="section-title"><i class="fas fa-clock me-2 time-icon"></i>Scheduling</h4>

                        <div class="form-group">
                            <label for="pickupDate" class="form-label">Pickup Date and Time <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-calendar-alt"></i></span>
                                <input type="datetime-local" id="pickupDate" name="pickupDate" class="form-control" required>
                                <span class="validation-icon valid-icon"><i class="fas fa-check-circle"></i></span>
                                <span class="validation-icon invalid-icon"><i class="fas fa-exclamation-circle"></i></span>
                            </div>
                            <div class="invalid-feedback">Please select a valid date and time for pickup</div>
                        </div>
                    </div>

                    <!-- Discount Section -->
                    <div class="form-section mb-4">
                        <div class="step-circle">4</div>
                        <h4 class="section-title"><i class="fas fa-tag me-2 coupon-icon"></i>Discounts</h4>

                        <div class="form-group">
                            <label for="couponCode" class="form-label">Coupon Code (Optional)
                                <i class="fas fa-circle-info tooltip-icon" data-bs-toggle="tooltip" title="Enter a valid coupon code to get a discount on your ride"></i>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-ticket"></i></span>
                                <input type="text" id="couponCode" name="couponCode" class="form-control" value="${param.couponCode}" placeholder="Enter coupon code if available">
                                <button type="button" id="verifyButton" class="btn btn-outline-secondary">Verify</button>
                            </div>
                            <small id="couponFeedback" class="form-text text-muted">Enter a valid coupon code to get discounts</small>
                        </div>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-check-circle me-2"></i> Book Your Cab
                        </button>
                        <button type="button" class="btn btn-outline-secondary" onclick="window.location.href='index.jsp'">
                            <i class="fas fa-arrow-left me-2"></i> Back to Home
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Form validation script -->
<script>
    // Initialize tooltips
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));

    // Form validation
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('bookingForm');
        const formInputs = form.querySelectorAll('input[required], select[required]');
        const pickupSelect = document.getElementById('pickupPoint');
        const destinationSelect = document.getElementById('destination');
        const couponField = document.getElementById('couponCode');
        const verifyButton = document.getElementById('verifyButton');
        const couponFeedback = document.getElementById('couponFeedback');

        // Real-time validation for required fields
        formInputs.forEach(input => {
            input.addEventListener('blur', function() {
                validateField(this);
            });

            input.addEventListener('change', function() {
                validateField(this);
            });
        });

        // Validate individual field
        function validateField(field) {
            const formGroup = field.closest('.form-group');

            if (!field.value) {
                field.classList.add('is-invalid');
                field.classList.remove('is-valid');
                formGroup.classList.add('is-invalid');
                formGroup.classList.remove('is-valid');
                return false;
            } else {
                field.classList.remove('is-invalid');
                field.classList.add('is-valid');
                formGroup.classList.remove('is-invalid');
                formGroup.classList.add('is-valid');
                return true;
            }
        }

        // Validate same pickup and destination
        destinationSelect.addEventListener('change', function() {
            if (pickupSelect.value && this.value && pickupSelect.value === this.value) {
                this.classList.add('is-invalid');
                this.classList.remove('is-valid');
                const formGroup = this.closest('.form-group');
                formGroup.classList.add('is-invalid');
                formGroup.classList.remove('is-valid');

                const feedback = formGroup.querySelector('.invalid-feedback');
                feedback.textContent = 'Pickup and destination cannot be the same';
            } else {
                validateField(this);
            }
        });

        // Validate date is not in the past
        document.getElementById('pickupDate').addEventListener('change', function() {
            const selectedDate = new Date(this.value);
            const now = new Date();
            const formGroup = this.closest('.form-group');

            if (selectedDate <= now) {
                this.classList.add('is-invalid');
                this.classList.remove('is-valid');
                formGroup.classList.add('is-invalid');
                formGroup.classList.remove('is-valid');

                const feedback = formGroup.querySelector('.invalid-feedback');
                feedback.textContent = 'Pickup time must be in the future';
                return false;
            } else {
                return validateField(this);
            }
        });

        // Mock coupon verification
        verifyButton.addEventListener('click', function() {
            const couponCode = couponField.value.trim();

            if (!couponCode) {
                couponFeedback.textContent = 'Please enter a coupon code';
                couponFeedback.className = 'form-text text-warning';
                return;
            }

            // Mock verification - you would replace this with an actual AJAX call
            setTimeout(() => {
                if (couponCode.toUpperCase() === 'MEGACITY' || couponCode.toUpperCase() === 'WELCOME10') {
                    couponField.classList.add('is-valid');
                    couponField.classList.remove('is-invalid');
                    couponFeedback.textContent = 'Valid coupon! You will receive a 10% discount.';
                    couponFeedback.className = 'form-text text-success';
                } else {
                    couponField.classList.add('is-invalid');
                    couponField.classList.remove('is-valid');
                    couponFeedback.textContent = 'Invalid coupon code';
                    couponFeedback.className = 'form-text text-danger';
                }
            }, 500);
        });

        // Form submission validation
        form.addEventListener('submit', function(event) {
            let isValid = true;

            // Validate all required fields
            formInputs.forEach(input => {
                if (!validateField(input)) {
                    isValid = false;
                }
            });

            // Check if pickup and destination are the same
            if (pickupSelect.value && destinationSelect.value && pickupSelect.value === destinationSelect.value) {
                destinationSelect.classList.add('is-invalid');
                const formGroup = destinationSelect.closest('.form-group');
                formGroup.classList.add('is-invalid');
                const feedback = formGroup.querySelector('.invalid-feedback');
                feedback.textContent = 'Pickup and destination cannot be the same';
                isValid = false;
            }

            // Check if date is in the past
            const pickupDate = document.getElementById('pickupDate');
            const selectedDate = new Date(pickupDate.value);
            const now = new Date();

            if (selectedDate <= now) {
                pickupDate.classList.add('is-invalid');
                const formGroup = pickupDate.closest('.form-group');
                formGroup.classList.add('is-invalid');
                const feedback = formGroup.querySelector('.invalid-feedback');
                feedback.textContent = 'Pickup time must be in the future';
                isValid = false;
            }

            if (!isValid) {
                event.preventDefault();

                // Scroll to the first invalid element
                const firstInvalid = form.querySelector('.is-invalid');
                if (firstInvalid) {
                    firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            }
        });
    });
</script>
</body>
</html>