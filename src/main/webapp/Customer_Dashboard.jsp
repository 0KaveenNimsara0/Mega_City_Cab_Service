<%--
  Created by IntelliJ IDEA.
  User: kavee
  Date: 2/25/2025
  Time: 5:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<html>
<head>
    <title>Mega City Cab - Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6c5ce7;
            --primary-hover: #5649c0;
            --secondary: #00b894;
            --dark-bg: #121212;
            --card-bg: #1e1e1e;
            --sidebar-bg: #1a1a2e;
            --text-primary: #ffffff;
            --text-secondary: #b3b3b3;
            --accent: #fd79a8;
        }
        body.light-theme {
            /* Light Theme Variables */
            --primary: #f7c427;
            --dark-bg: #f5f5f5;
            --card-bg: #ffffff;
            --text-primary: #333333;
            --text-secondary: #666666;
        }

        body.dark-theme {
            /* Explicitly set dark theme variables (same as root) */
            --primary: #f7c427;
            --dark-bg: #121212;
            --card-bg: #1e1e1e;
            --text-primary: #ffffff;
            --text-secondary: #b3b3b3;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--dark-bg);
            color: var(--text-primary);
            overflow-x: hidden;
            margin: 0;
            padding: 0;
        }

        /* Sidebar Styling */
        .sidebar {
            height: 100vh;
            width: 260px;
            position: fixed;
            top: 0;
            left: 0;
            background-color: var(--sidebar-bg);
            color: white;
            padding-top: 20px;
            transition: all 0.3s ease;
            z-index: 1000;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
        }

        .sidebar-header {
            padding: 0 15px 20px 15px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            margin-bottom: 15px;
        }

        .logo {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
        }

        .logo-img {
            width: 50px;
            height: 50px;
            margin-right: 10px;
        }

        .sidebar a {
            padding: 12px 20px;
            text-decoration: none;
            font-size: 16px;
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            transition: 0.3s;
            border-radius: 8px;
            margin: 4px 10px;
        }

        .sidebar a:hover {
            background-color: rgba(108, 92, 231, 0.2);
            color: var(--text-primary);
        }

        .sidebar a.active {
            background-color: var(--primary);
            color: white;
        }

        .sidebar a i {
            min-width: 25px;
            margin-right: 10px;
            font-size: 18px;
        }

        .user-info {
            padding: 15px;
            text-align: center;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            margin-top: auto;
            position: absolute;
            bottom: 20px;
            width: 100%;
        }

        .user-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background-color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 10px;
            font-size: 24px;
            color: white;
        }

        /* Main Content */
        .main-content {
            margin-left: 260px;
            padding: 30px;
            transition: all 0.3s ease;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            background-color: var(--card-bg);
            padding: 15px 25px;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .welcome-message {
            font-size: 20px;
            font-weight: 500;
        }

        .search-container {
            position: relative;
            width: 300px;
        }

        .search-container input {
            width: 100%;
            padding: 10px 15px 10px 40px;
            border-radius: 20px;
            border: none;
            background-color: rgba(255, 255, 255, 0.1);
            color: var(--text-primary);
        }

        .search-container i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-top: 25px;
        }

        .dashboard-card {
            background-color: var(--card-bg);
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .card-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
            font-size: 24px;
            color: white;
        }

        .booking-icon { background-color: #6c5ce7; }
        .history-icon { background-color: #00b894; }
        .payment-icon { background-color: #fdcb6e; }
        .help-icon { background-color: #fd79a8; }
        .profile-icon { background-color: #e17055; }

        .dashboard-card h5 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 15px;
            color: var(--text-primary);
        }

        .dashboard-card p {
            color: var(--text-secondary);
            margin-bottom: 20px;
            flex-grow: 1;
        }

        .btn {
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 500;
            text-transform: uppercase;
            font-size: 14px;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background-color: var(--primary);
            border-color: var(--primary);
        }

        .btn-primary:hover {
            background-color: var(--primary-hover);
            border-color: var(--primary-hover);
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .sidebar {
                width: 80px;
                overflow: hidden;
            }

            .sidebar a span, .logo span, .user-info p {
                display: none;
            }

            .logo {
                justify-content: center;
            }

            .logo-img {
                margin-right: 0;
            }

            .sidebar a {
                padding: 15px;
                justify-content: center;
            }

            .sidebar a i {
                margin-right: 0;
                font-size: 20px;
            }

            .main-content {
                margin-left: 80px;
            }

            .user-avatar {
                width: 40px;
                height: 40px;
                font-size: 18px;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 15px;
            }

            .top-bar {
                flex-direction: column;
                gap: 15px;
            }

            .search-container {
                width: 100%;
            }

            .dashboard-grid {
                grid-template-columns: 1fr;
            }

        }
    </style>
</head>
<body>
<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-header">
        <div class="logo">
            <div class="logo-img">
                <i class="fas fa-taxi fa-2x"></i>
            </div>
            <span>Mega City Cab</span>
        </div>
    </div>

    <a href="booking.jsp" class="active">
        <i class="fas fa-taxi"></i>
        <span>Booking</span>
    </a>
    <a href="viewBookings">
        <i class="fas fa-history"></i>
        <span>View Bookings</span>
    </a>
    <a href="viewPayments">
        <i class="fas fa-credit-card"></i>
        <span>Payments</span>
    </a>
    <a href="help.jsp">
        <i class="fas fa-headset"></i>
        <span>Help & Support</span>
    </a>
    <a href="updateProfile">
        <i class="fas fa-user-edit"></i>
        <span>Update Profile</span>
    </a>

    <a href="logout">
        <i class="fas fa-sign-out-alt"></i>
        <span>Logout</span>
    </a>

    <div class="user-info">
        <div class="user-avatar">
            <%= name.substring(0, 1).toUpperCase() %>
        </div>
        <p><%= name %></p>
        <p class="text-center">Your account status:
            <strong class="<%= "Banned".equalsIgnoreCase(status) ? "text-danger" :
        ("Warning".equalsIgnoreCase(status) ? "text-warning" : "text-success") %>">
                <%= status %>
            </strong>
        </p>


    </div>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="top-bar">
        <div class="welcome-message">
            Welcome back, <%= name %>!
        </div>
        <div class="search-container">
            <i class="fas fa-search"></i>
            <input type="text" placeholder="Search...">
        </div>
    </div>

    <div class="dashboard-grid">
        <!-- Booking Card -->
        <div class="dashboard-card">
            <div class="card-icon booking-icon">
                <i class="fas fa-taxi"></i>
            </div>
            <h5>Book a Ride</h5>
            <p>Need a ride? Book a cab instantly from anywhere in the city.</p>
            <a href="booking.jsp" class="btn btn-primary w-100">Book Now</a>
        </div>

        <!-- View Bookings Card -->
        <div class="dashboard-card">
            <div class="card-icon history-icon">
                <i class="fas fa-history"></i>
            </div>
            <h5>Ride History</h5>
            <p>View all your past rides and upcoming bookings in one place.</p>
            <a href="viewBookings" class="btn btn-outline-light w-100">View History</a>
        </div>

        <!-- Payments Card -->
        <div class="dashboard-card">
            <div class="card-icon payment-icon">
                <i class="fas fa-credit-card"></i>
            </div>
            <h5>Payment Methods</h5>
            <p>Manage your payment methods and view transaction history.</p>
            <a href="viewPayments" class="btn btn-outline-light w-100">Manage Payments</a>
        </div>

        <!-- Help Card -->
        <div class="dashboard-card">
            <div class="card-icon help-icon">
                <i class="fas fa-headset"></i>
            </div>
            <h5>Help & Support</h5>
            <p>Need assistance? Our support team is available 24/7 to help you.</p>
            <a href="help.jsp" class="btn btn-outline-light w-100">Contact Support</a>
        </div>

        <!-- Update Profile Card -->
        <div class="dashboard-card">
            <div class="card-icon profile-icon">
                <i class="fas fa-user-edit"></i>
            </div>
            <h5>Profile Settings</h5>
            <p>Update your personal information and account settings.</p>
            <a href="updateProfile" class="btn btn-outline-light w-100">Update Profile</a>
        </div>
    </div>
</div>

<!-- Bootstrap JS and Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<script>
    // Add active class to the current menu item
    document.addEventListener('DOMContentLoaded', function() {
        const currentLocation = window.location.hash;
        const menuItems = document.querySelectorAll('.sidebar a');

        menuItems.forEach(item => {
            if(item.getAttribute('href') === currentLocation) {
                item.classList.add('active');
            } else {
                item.classList.remove('active');
            }
        });

        // Add click event to menu items
        menuItems.forEach(item => {
            item.addEventListener('click', function() {
                menuItems.forEach(i => i.classList.remove('active'));
                this.classList.add('active');
            });
        });
    });
    // Theme toggle functionality
    document.addEventListener('DOMContentLoaded', function() {
        // Check for saved theme preference or use default dark theme
        const currentTheme = localStorage.getItem('theme') || 'dark';
        document.body.classList.add(currentTheme + '-theme');

        // Update toggle button state based on current theme
        const themeToggle = document.getElementById('theme-toggle');
        if (themeToggle) {
            themeToggle.checked = currentTheme === 'light';
        }
    });

    function toggleTheme() {
        const themeToggle = document.getElementById('theme-toggle');
        const isDark = !themeToggle.checked;
        const newTheme = isDark ? 'dark' : 'light';

        // Remove old theme class and add new one
        document.body.classList.remove('dark-theme', 'light-theme');
        document.body.classList.add(newTheme + '-theme');

        // Save preference to localStorage
        localStorage.setItem('theme', newTheme);
    }
</script>
</body>
</html>