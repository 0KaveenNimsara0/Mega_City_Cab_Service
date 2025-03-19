<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab - Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <%
        // Check if the user is logged in
        HttpSession sessionObj = request.getSession(false); // Do not create a new session
        if (sessionObj == null || sessionObj.getAttribute("username") == null) {
            // Redirect to login page if the user is not logged in
            response.sendRedirect("Login.jsp");
            return; // Stop further execution of the JSP
        }

        // Retrieve session attributes
        String username = (String) sessionObj.getAttribute("username");
        String name = (String) sessionObj.getAttribute("name");
        String status = (String) sessionObj.getAttribute("status");

    %>


    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }

        .sidebar {
            height: 100vh;
            width: 250px;
            position: fixed;
            background-color: #343a40;
            color: white;
            padding-top: 20px;
        }

        .sidebar-header {
            padding: 0 15px 20px 15px;
            border-bottom: 1px solid #6c757d;
            margin-bottom: 15px;
            text-align: center;
        }

        .sidebar a {
            padding: 10px 15px;
            text-decoration: none;
            color: #adb5bd;
            display: block;
            transition: 0.3s;
        }

        .sidebar a:hover {
            background-color: #495057;
            color: white;
        }

        .sidebar a.active {
            background-color: #007bff;
            color: white;
        }

        .sidebar a i {
            margin-right: 10px;
        }

        .user-info {
            padding: 15px;
            text-align: center;
            border-top: 1px solid #6c757d;
            margin-top: 20px;
        }

        .main-content {
            margin-left: 250px;
            padding: 20px;
        }

        .welcome-bar {
            background-color: white;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .card {
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .card-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
            font-size: 20px;
            color: white;
        }

        .booking-icon { background-color: #007bff; }
        .history-icon { background-color: #28a745; }
        .payment-icon { background-color: #ffc107; }
        .help-icon { background-color: #17a2b8; }
        .profile-icon { background-color: #dc3545; }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }

            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-header">
        <h4>Mega City Cab</h4>
    </div>

    <a href="booking.jsp" class="active">
        <i class="fas fa-taxi"></i> Booking
    </a>
    <a href="viewBookings">
        <i class="fas fa-history"></i> View Bookings
    </a>
    <a href="viewPayments">
        <i class="fas fa-credit-card"></i> Payments
    </a>
    <a href="help.jsp">
        <i class="fas fa-headset"></i> Help & Support
    </a>
    <a href="updateProfile">
        <i class="fas fa-user-edit"></i> Update Profile
    </a>
    <a href="logout">
        <i class="fas fa-sign-out-alt"></i> Logout
    </a>

    <div class="user-info">
        <div class="user-status">
            <p>Status: <span id="userStatus"><%= status %></span></p>
        </div>
    </div>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="welcome-bar">
        <h4>Welcome, <%= name %>!</h4>
    </div>

    <div class="row">
        <!-- Booking Card -->
        <div class="col-md-6 col-lg-4">
            <div class="card">
                <div class="card-body">
                    <div class="card-icon booking-icon">
                        <i class="fas fa-taxi"></i>
                    </div>
                    <h5 class="card-title">Book a Ride</h5>
                    <p class="card-text">Book a cab from anywhere in the city.</p>
                    <a href="booking.jsp" class="btn btn-primary">Book Now</a>
                </div>
            </div>
        </div>

        <!-- View Bookings Card -->
        <div class="col-md-6 col-lg-4">
            <div class="card">
                <div class="card-body">
                    <div class="card-icon history-icon">
                        <i class="fas fa-history"></i>
                    </div>
                    <h5 class="card-title">Ride History</h5>
                    <p class="card-text">View your past and upcoming bookings.</p>
                    <a href="viewBookings" class="btn btn-success">View History</a>
                </div>
            </div>
        </div>

        <!-- Payments Card -->
        <div class="col-md-6 col-lg-4">
            <div class="card">
                <div class="card-body">
                    <div class="card-icon payment-icon">
                        <i class="fas fa-credit-card"></i>
                    </div>
                    <h5 class="card-title">Payment Methods</h5>
                    <p class="card-text">Manage payment methods and transactions.</p>
                    <a href="viewPayments" class="btn btn-warning text-dark">Manage Payments</a>
                </div>
            </div>
        </div>

        <!-- Help Card -->
        <div class="col-md-6 col-lg-4">
            <div class="card">
                <div class="card-body">
                    <div class="card-icon help-icon">
                        <i class="fas fa-headset"></i>
                    </div>
                    <h5 class="card-title">Help & Support</h5>
                    <p class="card-text">Contact our support team for assistance.</p>
                    <a href="help.jsp" class="btn btn-info">Contact Support</a>
                </div>
            </div>
        </div>

        <!-- Update Profile Card -->
        <div class="col-md-6 col-lg-4">
            <div class="card">
                <div class="card-body">
                    <div class="card-icon profile-icon">
                        <i class="fas fa-user-edit"></i>
                    </div>
                    <h5 class="card-title">Profile Settings</h5>
                    <p class="card-text">Update your personal information.</p>
                    <a href="updateProfile" class="btn btn-danger">Update Profile</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS and Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Add active class to current menu item
    document.addEventListener('DOMContentLoaded', function() {
        const currentPath = window.location.pathname;
        const sidebarLinks = document.querySelectorAll('.sidebar a');

        sidebarLinks.forEach(link => {
            if(link.getAttribute('href') === currentPath.split('/').pop()) {
                link.classList.add('active');
            } else {
                link.classList.remove('active');
            }
        });

        // Style user status based on value
        const userStatus = document.getElementById('userStatus');
        if(userStatus) {
            const status = userStatus.textContent.trim();
            if(status === 'Banned') {
                userStatus.classList.add('text-danger', 'fw-bold');
            } else if(status === 'Warning') {
                userStatus.classList.add('text-warning', 'fw-bold');
            } else {
                userStatus.classList.add('text-success', 'fw-bold');
            }
        }
    });
</script>
</body>
</html>