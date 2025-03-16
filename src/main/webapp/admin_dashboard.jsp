<%--
  Created by IntelliJ IDEA.
  User: kavee
  Date: 3/2/2025
  Time: 8:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%
  // Check if the admin is logged in
  HttpSession sessionObj = request.getSession(false); // Do not create a new session
  if (sessionObj == null || sessionObj.getAttribute("admin") == null) {
    // Redirect to admin login page if the admin is not logged in
    response.sendRedirect("admin_login.jsp");
    return; // Stop further execution of the JSP
  }

  // Retrieve session attributes
  String adminUsername = (String) sessionObj.getAttribute("admin");

  // Database variables
  Connection conn = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;

  // Dashboard stats
  int totalUsers = 0;
  int availableCars = 0;
  int totalBookings = 0;
  double monthlyRevenue = 0.0;

  try {
    // Database connection details
    String dbUrl = "jdbc:mysql://localhost:3306/mega_city";
    String dbUser = "root";
    String dbPassword = "";

    // Create connection
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

    // Get total users
    pstmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM customers");
    rs = pstmt.executeQuery();
    if (rs.next()) {
      totalUsers = rs.getInt("total");
    }

    // Get available cars
    pstmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM vehicle WHERE isAvailable = '1'");
    rs = pstmt.executeQuery();
    if (rs.next()) {
      availableCars = rs.getInt("total");
    }

    // Get total bookings
    pstmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM booking");
    rs = pstmt.executeQuery();
    if (rs.next()) {
      totalBookings = rs.getInt("total");
    }

    // Get monthly revenue (current month)
    pstmt = conn.prepareStatement("SELECT SUM(amount) AS total FROM payment WHERE MONTH(paymentDate) = MONTH(CURRENT_DATE()) AND YEAR(paymentDate) = YEAR(CURRENT_DATE())");
    rs = pstmt.executeQuery();
    if (rs.next()) {
      monthlyRevenue = rs.getDouble("total");
    }

  } catch (Exception e) {
    e.printStackTrace();
    // You might want to handle the error appropriately
  } finally {
    // Close resources
    try {
      if (rs != null) rs.close();
      if (pstmt != null) pstmt.close();
      if (conn != null) conn.close();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  // Format the revenue
  DecimalFormat currencyFormatter = new DecimalFormat("LKR#,##0.00");
  String formattedRevenue = currencyFormatter.format(monthlyRevenue);
%>
<html>
<head>
  <title>Admin Dashboard</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome Icons -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      --primary-color: #3498db;
      --secondary-color: #2c3e50;
      --success-color: #2ecc71;
      --info-color: #3498db;
      --warning-color: #f39c12;
      --danger-color: #e74c3c;
      --light-color: #f8f9fa;
      --dark-color: #343a40;
    }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f5f7fa;
      overflow-x: hidden;
    }

    /* Sidebar Styling */
    .sidebar {
      height: 100vh;
      width: 280px;
      position: fixed;
      top: 0;
      left: 0;
      background-color: var(--secondary-color);
      color: white;
      padding-top: 20px;
      z-index: 100;
      box-shadow: 3px 0 10px rgba(0, 0, 0, 0.1);
      transition: all 0.3s;
    }

    .sidebar-header {
      padding: 0 20px 20px 20px;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      margin-bottom: 15px;
    }

    .sidebar a {
      padding: 12px 20px;
      text-decoration: none;
      font-size: 16px;
      color: rgba(255, 255, 255, 0.8);
      display: block;
      transition: 0.3s;
      border-radius: 5px;
      margin: 4px 10px;
    }

    .sidebar a:hover, .sidebar a.active {
      background-color: rgba(255, 255, 255, 0.1);
      color: white;
    }

    .sidebar a i {
      width: 25px;
      margin-right: 10px;
      text-align: center;
    }

    .sidebar-footer {
      position: absolute;
      bottom: 0;
      width: 100%;
      border-top: 1px solid rgba(255, 255, 255, 0.1);
      padding: 15px 0;
    }

    .main-content {
      margin-left: 280px; /* Same as sidebar width */
      padding: 30px;
      transition: all 0.3s;
    }

    .welcome-bar {
      background-color: white;
      padding: 15px 25px;
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      margin-bottom: 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .welcome-message {
      font-size: 22px;
      font-weight: 500;
      color: var(--dark-color);
    }

    .date-time {
      font-size: 14px;
      color: #6c757d;
      display: flex;
      align-items: center;
    }

    .date-time i {
      margin-right: 5px;
      color: var(--primary-color);
    }

    .dashboard-stats {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 20px;
      margin-bottom: 30px;
    }

    .stat-card {
      background-color: white;
      border-radius: 10px;
      padding: 20px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      transition: transform 0.3s;
    }

    .stat-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    .stat-icon {
      font-size: 2.5rem;
      margin-bottom: 15px;
      color: var(--primary-color);
    }

    .stat-number {
      font-size: 1.8rem;
      font-weight: 600;
      margin-bottom: 5px;
    }

    .stat-label {
      color: #6c757d;
      font-size: 0.9rem;
    }

    .dashboard-cards {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
      gap: 25px;
    }

    .action-card {
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      overflow: hidden;
      transition: transform 0.3s;
    }

    .action-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
    }

    .card-header {
      padding: 20px;
      border-bottom: 1px solid rgba(0, 0, 0, 0.05);
      font-size: 18px;
      font-weight: 500;
      color: var(--dark-color);
      background-color: rgba(0, 0, 0, 0.02);
    }

    .card-body {
      padding: 20px;
    }

    .card-icon {
      display: inline-block;
      width: 40px;
      height: 40px;
      line-height: 40px;
      text-align: center;
      border-radius: 50%;
      margin-right: 10px;
      color: white;
    }

    .icon-users { background-color: var(--primary-color); }
    .icon-cars { background-color: var(--success-color); }
    .icon-bookings { background-color: var(--info-color); }
    .icon-reports { background-color: var(--warning-color); }

    .btn-action {
      margin-top: 15px;
      padding: 8px 20px;
      border-radius: 5px;
      font-weight: 500;
      transition: all 0.3s;
    }

    .btn-action:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
    }

    .stat-change {
      font-size: 0.8rem;
      margin-top: 5px;
      display: flex;
      align-items: center;
    }

    .stat-up {
      color: var(--success-color);
    }

    .stat-down {
      color: var(--danger-color);
    }

    @media (max-width: 992px) {
      .sidebar {
        width: 70px;
        padding-top: 15px;
      }

      .sidebar a span, .sidebar-header h4 {
        display: none;
      }

      .sidebar a i {
        font-size: 20px;
        margin: 0;
      }

      .sidebar a {
        padding: 15px 10px;
        text-align: center;
      }

      .main-content {
        margin-left: 70px;
      }
    }
  </style>
</head>
<body>
<!-- Sidebar -->
<div class="sidebar">
  <div class="sidebar-header">
    <h4 class="text-center">Admin Panel</h4>
  </div>

  <a href="AdminUserManagementServlet" class="active">
    <i class="fas fa-users"></i>
    <span>Manage Users</span>
  </a>
  <a href="ViewCarsServlet">
    <i class="fas fa-car"></i>
    <span>Manage Cars</span>
  </a>
  <a href="AdminBookingServlet">
    <i class="fas fa-list-alt"></i>
    <span>Manage Bookings</span>
  </a>
  <a href="adminReport">
    <i class="fas fa-chart-bar"></i>
    <span>Reports</span>
  </a>
  <a href="adminCoupons.jsp">
    <i class="fas fa-tags me-2"></i>
    <span>Coupon</span>
  </a>
  <a href="ViewDrivers">
    <i class="fas fa-user-tie me-2"></i>
    <span>Driver</span>
  </a>
  <div class="sidebar-footer">
    <a href="AdminLogoutServlet">
      <i class="fas fa-sign-out-alt"></i>
      <span>Logout</span>
    </a>
  </div>

</div>

<!-- Main Content -->
<div class="main-content">
  <div class="welcome-bar">
    <div class="welcome-message">
      Welcome back, <span class="text-primary"><%= adminUsername %></span>
    </div>
    <div class="date-time">
      <i class="fas fa-clock"></i>
      <span id="current-date-time"></span>
    </div>
  </div>

  <!-- Dashboard Stats -->
  <div class="dashboard-stats">
    <div class="stat-card">
      <div class="stat-icon"><i class="fas fa-users"></i></div>
      <div class="stat-number"><%= totalUsers %></div>
      <div class="stat-label">Total Users</div>
      <%
        // Example of how you could show change from previous period
        // You would need to calculate this from your database
        int userChange = 5; // This is just a placeholder
        String userChangeClass = userChange >= 0 ? "stat-up" : "stat-down";
        String userChangeIcon = userChange >= 0 ? "fa-arrow-up" : "fa-arrow-down";
      %>
      <div class="stat-change <%= userChangeClass %>">
        <i class="fas <%= userChangeIcon %> me-1"></i> <%= Math.abs(userChange) %>% from last month
      </div>
    </div>

    <div class="stat-card">
      <div class="stat-icon"><i class="fas fa-car"></i></div>
      <div class="stat-number"><%= availableCars %></div>
      <div class="stat-label">Available Cars</div>
      <%
        // Placeholder for car availability change
        int carChange = -2; // This is just a placeholder
        String carChangeClass = carChange >= 0 ? "stat-up" : "stat-down";
        String carChangeIcon = carChange >= 0 ? "fa-arrow-up" : "fa-arrow-down";
      %>
      <div class="stat-change <%= carChangeClass %>">
        <i class="fas <%= carChangeIcon %> me-1"></i> <%= Math.abs(carChange) %> since yesterday
      </div>
    </div>

    <div class="stat-card">
      <div class="stat-icon"><i class="fas fa-clipboard-list"></i></div>
      <div class="stat-number"><%= totalBookings %></div>
      <div class="stat-label">Total Bookings</div>
      <%
        // Placeholder for booking change
        int bookingChange = 12; // This is just a placeholder
        String bookingChangeClass = bookingChange >= 0 ? "stat-up" : "stat-down";
        String bookingChangeIcon = bookingChange >= 0 ? "fa-arrow-up" : "fa-arrow-down";
      %>
      <div class="stat-change <%= bookingChangeClass %>">
        <i class="fas <%= bookingChangeIcon %> me-1"></i> <%= Math.abs(bookingChange) %>% from last month
      </div>
    </div>

    <div class="stat-card">
      <div class="stat-icon"><i class="fa-sharp fa-solid fa-rupee-sign"></i></div>
      <div class="stat-number"><%= formattedRevenue %></div>
      <div class="stat-label">Monthly Revenue</div>
      <%
        // Placeholder for revenue change
        int revenueChange = 8; // This is just a placeholder
        String revenueChangeClass = revenueChange >= 0 ? "stat-up" : "stat-down";
        String revenueChangeIcon = revenueChange >= 0 ? "fa-arrow-up" : "fa-arrow-down";
      %>
      <div class="stat-change <%= revenueChangeClass %>">
        <i class="fas <%= revenueChangeIcon %> me-1"></i> <%= Math.abs(revenueChange) %>% from last month
      </div>
    </div>
  </div>

  <!-- Dashboard Cards -->
  <div class="dashboard-cards">
    <div class="action-card">
      <div class="card-header">
        <span class="card-icon icon-users"><i class="fas fa-users"></i></span>
        Manage Users
      </div>
      <div class="card-body">
        <p>View, edit, and manage all registered users in the system. Add new users or update existing user information.</p>
        <a href="AdminUserManagementServlet" class="btn btn-primary btn-action">Manage Users</a>
      </div>
    </div>

    <div class="action-card">
      <div class="card-header">
        <span class="card-icon icon-cars"><i class="fas fa-car"></i></span>
        Manage Cars
      </div>
      <div class="card-body">
        <p>Maintain your car inventory. Add new vehicles, update details, or remove cars that are no longer available.</p>
        <a href="ViewCarsServlet" class="btn btn-success btn-action">Manage Cars</a>
      </div>
    </div>

    <div class="action-card">
      <div class="card-header">
        <span class="card-icon icon-bookings"><i class="fas fa-list-alt"></i></span>
        Manage Bookings
      </div>
      <div class="card-body">
        <p>Monitor all current and past bookings. Track booking status, approve or reject pending requests.</p>
        <a href="AdminBookingServlet" class="btn btn-info btn-action">Manage Bookings</a>
      </div>
    </div>

    <div class="action-card">
      <div class="card-header">
        <span class="card-icon icon-reports"><i class="fas fa-chart-bar"></i></span>
        Generate Reports
      </div>
      <div class="card-body">
        <p>Generate detailed reports on bookings, payments, user activity, and overall system performance.</p>
        <a href="adminReport" class="btn btn-warning btn-action">Generate Reports</a>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap JS and Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<script>
  // Add active class to current page
  document.addEventListener('DOMContentLoaded', function() {
    const currentLocation = window.location.href;
    const menuItems = document.querySelectorAll('.sidebar a');

    menuItems.forEach(item => {
      if(currentLocation.includes(item.getAttribute('href'))) {
        menuItems.forEach(link => link.classList.remove('active'));
        item.classList.add('active');
      }
    });

    // Initialize real-time clock
    updateDateTime();
    // Update every second
    setInterval(updateDateTime, 1000);
  });

  // Function to update date and time
  function updateDateTime() {
    const now = new Date();
    const options = {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit'
    };
    document.getElementById('current-date-time').textContent = now.toLocaleDateString('en-US', options);
  }

  // Auto refresh dashboard data every 5 minutes (300000 milliseconds)
  // This will reload the page to get fresh data from the database
  setTimeout(function() {
    location.reload();
  }, 300000);
</script>
</body>
</html>