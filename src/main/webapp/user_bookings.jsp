<%@ page import="java.util.List" %>
<%@ page import="com.example.mega_city_cab_service.model.BookingDetails" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <title>View Bookings</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
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

  // Retrieve bookings from the request attribute
  List<BookingDetails> bookings = (List<BookingDetails>) request.getAttribute("bookings");
%>

<div class="container py-4">
  <div class="row mb-4">
    <div class="col">
      <h2 class="mb-0"><i class="bi bi-taxi-front"></i> Your Bookings</h2>
    </div>
    <div class="col-auto">
      <div class="bg-light border rounded p-2">
        Welcome, <%=name%>! <span class="badge bg-primary"><%=username%></span>
      </div>
    </div>
  </div>

  <div class="card shadow-sm">
    <div class="card-body">
      <% if (bookings != null && !bookings.isEmpty()) { %>
      <div class="table-responsive">
        <table class="table table-hover">
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
            String badgeClass = "bg-warning";
            if (booking.getStatus().equalsIgnoreCase("Confirmed")) {
              badgeClass = "bg-success";
            } else if (booking.getStatus().equalsIgnoreCase("Cancelled")) {
              badgeClass = "bg-danger";
            }
          %>
          <tr>
            <td><strong><%=booking.getBookingID()%></strong></td>
            <td><%=booking.getPickupPointName()%></td>
            <td><%=booking.getDestinationName()%></td>
            <td><%=booking.getCarTypeName()%></td>
            <td><%=booking.getPickupDate()%></td>
            <td><strong>$<%=booking.getAmount()%></strong></td>
            <td><span class="badge <%=badgeClass%>"><%=booking.getStatus()%></span></td>
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
              <% if (!booking.getStatus().equalsIgnoreCase("Cancelled")) { %>
              <form action="cancelViewBooking" method="post" style="display:inline;">
                <input type="hidden" name="bookingId" value="<%=booking.getBookingID()%>">
                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to cancel this booking?');">
                  <i class="bi bi-x-circle"></i> Cancel
                </button>
              </form>
              <% } %>
            </td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
      <% } else { %>
      <div class="text-center py-5">
        <i class="bi bi-calendar-x fs-1 text-muted"></i>
        <h4 class="mt-3">No Bookings Found</h4>
        <p class="text-muted">You haven't made any bookings yet. Ready to plan your next trip?</p>
      </div>
      <% } %>
    </div>
  </div>

  <div class="mt-3">
    <a href="Customer_Dashboard.jsp" class="btn btn-outline-primary">
      <i class="bi bi-arrow-left"></i> Back to Dashboard
    </a>
  </div>
</div>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>