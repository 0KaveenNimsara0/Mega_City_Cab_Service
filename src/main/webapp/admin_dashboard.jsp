<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%
  // Session authentication check (unchanged)
  HttpSession sessionObj = request.getSession(false);
  if (sessionObj == null || sessionObj.getAttribute("admin") == null) {
    response.sendRedirect("admin_login.jsp");
    return;
  }
  String adminUsername = (String) sessionObj.getAttribute("admin");

  // Database variables and connection (unchanged)
  Connection conn = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;
  int totalUsers = 0, availableCars = 0, totalBookings = 0;
  double monthlyRevenue = 0.0;

  try {
    // Database connection code (unchanged)
    String dbUrl = "jdbc:mysql://localhost:3306/mega_city";
    String dbUser = "root";
    String dbPassword = "";
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

    // Database queries (unchanged)
    pstmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM customers");
    rs = pstmt.executeQuery();
    if (rs.next()) totalUsers = rs.getInt("total");

    pstmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM vehicle WHERE isAvailable = '1'");
    rs = pstmt.executeQuery();
    if (rs.next()) availableCars = rs.getInt("total");

    pstmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM booking");
    rs = pstmt.executeQuery();
    if (rs.next()) totalBookings = rs.getInt("total");

    pstmt = conn.prepareStatement("SELECT SUM(amount) AS total FROM payment WHERE MONTH(paymentDate) = MONTH(CURRENT_DATE()) AND YEAR(paymentDate) = YEAR(CURRENT_DATE())");
    rs = pstmt.executeQuery();
    if (rs.next()) monthlyRevenue = rs.getDouble("total");
  } catch (Exception e) {
    e.printStackTrace();
  } finally {
    // Close resources (unchanged)
    try {
      if (rs != null) rs.close();
      if (pstmt != null) pstmt.close();
      if (conn != null) conn.close();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  // Format currency (unchanged)
  DecimalFormat currencyFormatter = new DecimalFormat("LKR#,##0.00");
  String formattedRevenue = currencyFormatter.format(monthlyRevenue);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome Icons -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f8f9fa;
    }
    .sidebar {
      min-height: 100vh;
      background-color: #343a40;
    }
    .nav-link {
      color: rgba(255,255,255,.75);
      padding: 10px 15px;
      margin-bottom: 5px;
    }
    .nav-link:hover, .nav-link.active {
      color: #fff;
      background-color: rgba(255,255,255,.1);
    }
    .nav-link i {
      width: 20px;
      text-align: center;
      margin-right: 10px;
    }
    .stat-card {
      transition: transform 0.2s;
    }
    .stat-card:hover {
      transform: translateY(-5px);
    }
  </style>
</head>
<body>
<div class="container-fluid">
  <div class="row">
    <!-- Sidebar -->
    <div class="col-md-3 col-lg-2 d-md-block sidebar px-0">
      <div class="d-flex flex-column p-3 text-white">
        <h5 class="text-center mb-4">Admin Panel</h5>
        <ul class="nav nav-pills flex-column mb-auto">
          <li class="nav-item">
            <a href="AdminUserManagementServlet" class="nav-link active">
              <i class="fas fa-users"></i> Manage Users
            </a>
          </li>
          <li class="nav-item">
            <a href="ViewCarsServlet" class="nav-link">
              <i class="fas fa-car"></i> Manage Cars
            </a>
          </li>
          <li class="nav-item">
            <a href="AdminBookingServlet" class="nav-link">
              <i class="fas fa-list-alt"></i> Manage Bookings
            </a>
          </li>
          <li class="nav-item">
            <a href="adminReport" class="nav-link">
              <i class="fas fa-chart-bar"></i> Reports
            </a>
          </li>
          <li class="nav-item">
            <a href="adminCoupons.jsp" class="nav-link">
              <i class="fas fa-tags"></i> Coupons
            </a>
          </li>
          <li class="nav-item">
            <a href="ViewDrivers" class="nav-link">
              <i class="fas fa-user-tie"></i> Drivers
            </a>
          </li>
        </ul>
        <hr>
        <a href="AdminLogoutServlet" class="nav-link text-white">
          <i class="fas fa-sign-out-alt"></i> Logout
        </a>
      </div>
    </div>

    <!-- Main Content -->
    <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
      <!-- Welcome header -->
      <div class="d-flex justify-content-between align-items-center bg-white p-3 rounded shadow-sm mb-4">
        <h4 class="mb-0">Welcome back, <span class="text-primary"><%= adminUsername %></span></h4>
        <div class="text-muted small">
          <i class="fas fa-clock me-1"></i>
          <span id="current-date-time"></span>
        </div>
      </div>

      <!-- Stats Row -->
      <div class="row g-4 mb-4">
        <div class="col-md-6 col-xl-3">
          <div class="card stat-card border-0 shadow-sm h-100">
            <div class="card-body">
              <div class="d-flex align-items-center mb-3">
                <div class="bg-primary bg-opacity-10 p-3 rounded me-3">
                  <i class="fas fa-users text-primary fs-4"></i>
                </div>
                <h5 class="card-title mb-0">Total Users</h5>
              </div>
              <h2 class="mb-2"><%= totalUsers %></h2>
              <p class="card-text text-success small mb-0">
                <i class="fas fa-arrow-up me-1"></i> 5% from last month
              </p>
            </div>
          </div>
        </div>

        <div class="col-md-6 col-xl-3">
          <div class="card stat-card border-0 shadow-sm h-100">
            <div class="card-body">
              <div class="d-flex align-items-center mb-3">
                <div class="bg-success bg-opacity-10 p-3 rounded me-3">
                  <i class="fas fa-car text-success fs-4"></i>
                </div>
                <h5 class="card-title mb-0">Available Cars</h5>
              </div>
              <h2 class="mb-2"><%= availableCars %></h2>
              <p class="card-text text-danger small mb-0">
                <i class="fas fa-arrow-down me-1"></i> 2 since yesterday
              </p>
            </div>
          </div>
        </div>

        <div class="col-md-6 col-xl-3">
          <div class="card stat-card border-0 shadow-sm h-100">
            <div class="card-body">
              <div class="d-flex align-items-center mb-3">
                <div class="bg-info bg-opacity-10 p-3 rounded me-3">
                  <i class="fas fa-clipboard-list text-info fs-4"></i>
                </div>
                <h5 class="card-title mb-0">Total Bookings</h5>
              </div>
              <h2 class="mb-2"><%= totalBookings %></h2>
              <p class="card-text text-success small mb-0">
                <i class="fas fa-arrow-up me-1"></i> 12% from last month
              </p>
            </div>
          </div>
        </div>

        <div class="col-md-6 col-xl-3">
          <div class="card stat-card border-0 shadow-sm h-100">
            <div class="card-body">
              <div class="d-flex align-items-center mb-3">
                <div class="bg-warning bg-opacity-10 p-3 rounded me-3">
                  <i class="fas fa-rupee-sign text-warning fs-4"></i>
                </div>
                <h5 class="card-title mb-0">Monthly Revenue</h5>
              </div>
              <h2 class="mb-2"><%= formattedRevenue %></h2>
              <p class="card-text text-success small mb-0">
                <i class="fas fa-arrow-up me-1"></i> 8% from last month
              </p>
            </div>
          </div>
        </div>
      </div>

      <!-- Quick Actions -->
      <div class="row g-4">
        <div class="col-md-6">
          <div class="card border-0 shadow-sm h-100">
            <div class="card-body">
              <h5 class="card-title mb-3">
                <i class="fas fa-users text-primary me-2"></i>
                Manage Users
              </h5>
              <p class="card-text">View, edit, and manage all registered users in the system. Add new users or update existing user information.</p>
              <a href="AdminUserManagementServlet" class="btn btn-primary">Go to Users</a>
            </div>
          </div>
        </div>

        <div class="col-md-6">
          <div class="card border-0 shadow-sm h-100">
            <div class="card-body">
              <h5 class="card-title mb-3">
                <i class="fas fa-car text-success me-2"></i>
                Manage Cars
              </h5>
              <p class="card-text">Maintain your car inventory. Add new vehicles, update details, or remove cars that are no longer available.</p>
              <a href="ViewCarsServlet" class="btn btn-success">Go to Cars</a>
            </div>
          </div>
        </div>

        <div class="col-md-6">
          <div class="card border-0 shadow-sm h-100">
            <div class="card-body">
              <h5 class="card-title mb-3">
                <i class="fas fa-list-alt text-info me-2"></i>
                Manage Bookings
              </h5>
              <p class="card-text">Monitor all current and past bookings. Track booking status, approve or reject pending requests.</p>
              <a href="AdminBookingServlet" class="btn btn-info">Go to Bookings</a>
            </div>
          </div>
        </div>

        <div class="col-md-6">
          <div class="card border-0 shadow-sm h-100">
            <div class="card-body">
              <h5 class="card-title mb-3">
                <i class="fas fa-chart-bar text-warning me-2"></i>
                Generate Reports
              </h5>
              <p class="card-text">Generate detailed reports on bookings, payments, user activity, and overall system performance.</p>
              <a href="adminReport" class="btn btn-warning">Go to Reports</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Set active link based on current page
  document.addEventListener('DOMContentLoaded', function() {
    const currentLocation = window.location.href;
    const navLinks = document.querySelectorAll('.nav-link');

    navLinks.forEach(link => {
      if(currentLocation.includes(link.getAttribute('href'))) {
        navLinks.forEach(item => item.classList.remove('active'));
        link.classList.add('active');
      }
    });

    // Real-time clock
    updateDateTime();
    setInterval(updateDateTime, 1000);

    // Auto refresh every 5 minutes
    setTimeout(function() {
      location.reload();
    }, 300000);
  });

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
</script>
</body>
</html>