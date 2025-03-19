<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.mega_city_cab_service.model.Location" %>
<%@ page import="com.example.mega_city_cab_service.model.VehicleType" %>
<%@ page import="com.example.mega_city_cab_service.service.LocationService" %>
<%@ page import="com.example.mega_city_cab_service.service.VehicleTypeService" %>

<%
    // Fetch locations from the database
    List<Location> locations = null;
    try {
        LocationService allLocations = new LocationService();
        locations = allLocations.getAllLocations();
    } catch (Exception e) {
        e.printStackTrace();
    }

    // Fetch vehicle types from the database
    List<VehicleType> vehicleTypes = null;
    try {
        VehicleTypeService allvehicleType = new VehicleTypeService();
        vehicleTypes = allvehicleType.getAllVehicleTypes();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cab Booking Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Basic styling -->
    <style>
        body {
            background-color: #f8f9fa;
            padding-bottom: 20px;
        }

        .header {
            background-color: #0d6efd;
            color: white;
            padding: 10px 0;
            margin-bottom: 20px;
        }

        .booking-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
            margin-top: 20px;
        }

        .section-title {
            color: #0d6efd;
            margin-bottom: 15px;
            padding-bottom: 5px;
            border-bottom: 1px solid #dee2e6;
        }

        .form-group {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
<header class="header">
    <div class="container">
        <h1 class="text-center">Cab Booking Service</h1>
    </div>
</header>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="booking-container">
                <h2 class="text-center mb-4">Book Your Cab</h2>

                <form id="bookingForm" action="ConfirmBookingServlet" method="post" novalidate>
                    <!-- Location Section -->
                    <h4 class="section-title">Trip Details</h4>

                    <div class="form-group">
                        <label for="pickupPoint" class="form-label">Pickup Point <span class="text-danger">*</span></label>
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
                        <div class="invalid-feedback">Please select a pickup point</div>
                    </div>

                    <div class="form-group">
                        <label for="destination" class="form-label">Destination <span class="text-danger">*</span></label>
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
                        <div class="invalid-feedback">Please select a destination</div>
                    </div>

                    <!-- Vehicle Section -->
                    <h4 class="section-title">Vehicle Details</h4>

                    <div class="form-group">
                        <label for="carType" class="form-label">Vehicle Type <span class="text-danger">*</span></label>
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
                        <div class="invalid-feedback">Please select a vehicle type</div>
                    </div>

                    <!-- Timing Section -->
                    <h4 class="section-title">Scheduling</h4>

                    <div class="form-group">
                        <label for="pickupDate" class="form-label">Pickup Date and Time <span class="text-danger">*</span></label>
                        <input type="datetime-local" id="pickupDate" name="pickupDate" class="form-control" required>
                        <div class="invalid-feedback">Please select a valid date and time for pickup</div>
                    </div>

                    <!-- Discount Section -->
                    <h4 class="section-title">Discounts</h4>

                    <div class="form-group">
                        <label for="couponCode" class="form-label">Coupon Code (Optional)</label>
                        <div class="input-group">
                            <input type="text" id="couponCode" name="couponCode" class="form-control" value="${param.couponCode}" placeholder="Enter coupon code if available">
                            <input type="hidden" id="discountPercentage" name="discountPercentage" value="0">
                            <button type="button" id="verifyButton" class="btn btn-outline-secondary">Verify</button>
                        </div>
                        <small id="couponFeedback" class="form-text text-muted">Enter a valid coupon code to get discounts</small>
                    </div>

                    <div class="d-grid gap-2 mt-4">
                        <button type="submit" class="btn btn-primary">Book Your Cab</button>
                        <button type="button" class="btn btn-outline-secondary" onclick="window.location.href='index.jsp'">Back to Home</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Form validation script -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('bookingForm');
        const formInputs = form.querySelectorAll('input[required], select[required]');
        const pickupSelect = document.getElementById('pickupPoint');
        const destinationSelect = document.getElementById('destination');
        const couponField = document.getElementById('couponCode');
        const verifyButton = document.getElementById('verifyButton');
        const couponFeedback = document.getElementById('couponFeedback');

        // Validate field function
        function validateField(field) {
            if (!field.value) {
                field.classList.add('is-invalid');
                field.classList.remove('is-valid');
                return false;
            } else {
                field.classList.remove('is-invalid');
                field.classList.add('is-valid');
                return true;
            }
        }

        // Add validation events to required fields
        formInputs.forEach(input => {
            input.addEventListener('blur', function() {
                validateField(this);
            });

            input.addEventListener('change', function() {
                validateField(this);
            });
        });

        // Check same pickup and destination
        destinationSelect.addEventListener('change', function() {
            if (pickupSelect.value && this.value && pickupSelect.value === this.value) {
                this.classList.add('is-invalid');
                this.classList.remove('is-valid');
                const feedback = this.nextElementSibling;
                feedback.textContent = 'Pickup and destination cannot be the same';
            } else {
                validateField(this);
            }
        });

        // Validate date is not in the past
        document.getElementById('pickupDate').addEventListener('change', function() {
            const selectedDate = new Date(this.value);
            const now = new Date();

            if (selectedDate <= now) {
                this.classList.add('is-invalid');
                this.classList.remove('is-valid');
                const feedback = this.nextElementSibling;
                feedback.textContent = 'Pickup time must be in the future';
                return false;
            } else {
                return validateField(this);
            }
        });

        // Coupon verification
        verifyButton.addEventListener('click', function() {
            const couponCode = couponField.value.trim();

            if (!couponCode) {
                couponFeedback.textContent = 'Please enter a coupon code';
                couponFeedback.className = 'form-text text-warning';
                return;
            }

            couponFeedback.textContent = 'Verifying coupon...';
            couponFeedback.className = 'form-text text-info';

            // AJAX call to validate coupon
            fetch('ValidateCouponServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'couponCode=' + encodeURIComponent(couponCode)
            })
                .then(response => response.json())
                .then(data => {
                    if (data.valid) {
                        couponField.classList.add('is-valid');
                        couponField.classList.remove('is-invalid');
                        couponFeedback.textContent = data.message;
                        couponFeedback.className = 'form-text text-success';
                        document.getElementById('discountPercentage').value = data.discount;
                    } else {
                        couponField.classList.add('is-invalid');
                        couponField.classList.remove('is-valid');
                        couponFeedback.textContent = data.message;
                        couponFeedback.className = 'form-text text-danger';
                        document.getElementById('discountPercentage').value = 0;
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    couponField.classList.add('is-invalid');
                    couponFeedback.textContent = 'Error validating coupon. Please try again.';
                    couponFeedback.className = 'form-text text-danger';
                });
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
                const feedback = destinationSelect.nextElementSibling;
                feedback.textContent = 'Pickup and destination cannot be the same';
                isValid = false;
            }

            // Check if date is in the past
            const pickupDate = document.getElementById('pickupDate');
            const selectedDate = new Date(pickupDate.value);
            const now = new Date();

            if (selectedDate <= now) {
                pickupDate.classList.add('is-invalid');
                const feedback = pickupDate.nextElementSibling;
                feedback.textContent = 'Pickup time must be in the future';
                isValid = false;
            }

            if (!isValid) {
                event.preventDefault();
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