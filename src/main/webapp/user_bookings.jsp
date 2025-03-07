<%@ page import="java.util.List" %>
<%@ page import="com.example.mega_city_cab_service.model.BookingDetails" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <title>View Bookings</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      --dark-bg: #121212;
      --card-bg: #1e1e1e;
      --accent: #bb86fc;
      --text-primary: #e0e0e0;
      --text-secondary: #acacac;
      --border: #333333;
      --success: #03dac6;
      --warning: #ff9800;
      --danger: #cf6679;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
      background-color: var(--dark-bg);
      color: var(--text-primary);
      line-height: 1.6;
      padding: 20px;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
    }

    header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 30px;
      padding-bottom: 15px;
      border-bottom: 1px solid var(--border);
    }

    h1 {
      color: var(--accent);
      font-size: 28px;
    }

    .user-info {
      background-color: var(--card-bg);
      padding: 10px 15px;
      border-radius: 8px;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .username-badge {
      background-color: var(--accent);
      color: #000;
      padding: 4px 8px;
      border-radius: 4px;
      font-size: 14px;
      font-weight: bold;
    }

    .card {
      background-color: var(--card-bg);
      border-radius: 8px;
      padding: 20px;
      margin-bottom: 20px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .table-responsive {
      overflow-x: auto;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 15px;
    }

    th {
      background-color: rgba(187, 134, 252, 0.1);
      color: var(--accent);
      text-align: left;
      padding: 12px 15px;
      font-weight: 600;
      border-bottom: 1px solid var(--border);
    }

    td {
      padding: 12px 15px;
      border-bottom: 1px solid var(--border);
      color: var(--text-secondary);
    }

    tr:hover {
      background-color: rgba(187, 134, 252, 0.05);
    }

    .status {
      padding: 4px 8px;
      border-radius: 4px;
      font-size: 14px;
      font-weight: 500;
      display: inline-block;
    }

    .status-confirmed {
      background-color: rgba(3, 218, 198, 0.2);
      color: var(--success);
    }

    .status-pending {
      background-color: rgba(255, 152, 0, 0.2);
      color: var(--warning);
    }

    .status-cancelled {
      background-color: rgba(207, 102, 121, 0.2);
      color: var(--danger);
    }

    .action-buttons {
      display: flex;
      gap: 8px;
    }

    button {
      background-color: transparent;
      border: 1px solid var(--border);
      color: var(--text-primary);
      padding: 6px 12px;
      border-radius: 4px;
      cursor: pointer;
      transition: all 0.3s ease;
      display: flex;
      align-items: center;
      gap: 5px;
    }

    button:hover {
      background-color: rgba(187, 134, 252, 0.1);
      border-color: var(--accent);
    }

    .btn-danger {
      border-color: var(--danger);
      color: var(--danger);
    }

    .btn-danger:hover {
      background-color: rgba(207, 102, 121, 0.1);
    }

    .back-link {
      display: inline-flex;
      align-items: center;
      gap: 5px;
      color: var(--accent);
      text-decoration: none;
      font-weight: 500;
      margin-top: 15px;
    }

    .back-link:hover {
      text-decoration: underline;
    }

    .empty-state {
      text-align: center;
      padding: 40px 0;
      color: var(--text-secondary);
    }

    .empty-state i {
      font-size: 48px;
      margin-bottom: 15px;
      opacity: 0.7;
    }

    @media (max-width: 768px) {
      header {
        flex-direction: column;
        align-items: flex-start;
        gap: 15px;
      }

      .user-info {
        width: 100%;
      }

      td, th {
        padding: 8px 10px;
      }
    }
  </style>
</head>
<body>
<%
  // Debugging: Check if the session exists
  HttpSession sessionObj = request.getSession(false);
  if (sessionObj == null || sessionObj.getAttribute("username") == null) {
    response.sendRedirect("Login.jsp");
    return;
  }

  // Retrieve session attributes
  String username = (String) sessionObj.getAttribute("username");
  String name = (String) sessionObj.getAttribute("name");

  // Debugging: Log session attributes
  System.out.println("Username from session: " + username);
  System.out.println("Name from session: " + name);

  // Retrieve bookings from the request attribute
  List<BookingDetails> bookings = (List<BookingDetails>) request.getAttribute("bookings");
%>

<div class="container">
  <header>
    <h1><i class="fas fa-taxi"></i> Your Bookings</h1>
    <div class="user-info">
      Welcome, <%=name%>! <span class="username-badge"><%=username%></span>
    </div>
  </header>

  <div class="card">
    <% if (bookings != null && !bookings.isEmpty()) { %>
    <div class="table-responsive">
      <table>
        <thead>
        <tr>
          <th>Booking ID</th>
          <th>Pickup</th>
          <th>Destination</th>
          <th>Vehicle Type</th>
          <th>Date</th>
          <th>Amount</th>
          <th>Status</th>
          <th>Driver & Vehicle</th>
          <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% for (BookingDetails booking : bookings) {
          String statusClass = "status-pending";
          if (booking.getStatus().equalsIgnoreCase("Confirmed")) {
            statusClass = "status-confirmed";
          } else if (booking.getStatus().equalsIgnoreCase("Cancelled")) {
            statusClass = "status-cancelled";
          }
        %>
        <tr>
          <td><strong><%=booking.getBookingID()%></strong></td>
          <td><%=booking.getPickupPointName()%></td>
          <td><%=booking.getDestinationName()%></td>
          <td><%=booking.getCarTypeName()%></td>
          <td><%=booking.getPickupDate()%></td>
          <td><strong>$<%=booking.getAmount()%></strong></td>
          <td><span class="status <%=statusClass%>"><%=booking.getStatus()%></span></td>
          <td>
            <% if (booking.getDriverName() != null && !booking.getDriverName().equals("N/A")) { %>
            <strong><%=booking.getDriverName()%></strong><br>
            <small><%=booking.getDriverPhone()%></small><br>
            <small><%=booking.getVehicleModel()%> (<%=booking.getVehicleRegistration()%>)</small>
            <% } else { %>
            <span class="text-muted">Not assigned yet</span>
            <% } %>
          </td>
          <td>
            <div class="action-buttons">
              <% if (!booking.getStatus().equalsIgnoreCase("Cancelled")) { %>
              <!-- Cancel Button - FIXED FORM ACTION AND PARAMETER NAME -->
              <form action="cancelViewBooking" method="post" style="display:inline;">
                <input type="hidden" name="bookingId" value="<%=booking.getBookingID()%>">
                <button type="submit" class="btn-danger" onclick="return confirm('Are you sure you want to cancel this booking?');">
                  <i class="fas fa-times-circle"></i> Cancel
                </button>
              </form>
              <% } %>
            </div>
          </td>
        </tr>
        <% } %>
        </tbody>
      </table>
    </div>
    <% } else { %>
    <div class="empty-state">
      <i class="fas fa-calendar-times"></i>
      <h3>No Bookings Found</h3>
      <p>You haven't made any bookings yet. Ready to plan your next trip?</p>
    </div>
    <% } %>
  </div>

  <a href="Customer_Dashboard.jsp" class="back-link">
    <i class="fas fa-arrow-left"></i> Back to Dashboard
  </a>
</div>

<script>
  // Add any JavaScript functionality here if needed
</script>
</body>
</html>