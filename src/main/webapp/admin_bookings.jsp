<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.mega_city_cab_service.model.BookingDetails" %>
<%@ page import="com.example.mega_city_cab_service.model.Car" %>
<%@ page import="com.example.mega_city_cab_service.model.Payment" %>
<%@ page import="java.util.Map" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Bookings | Mega City Cab Service</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .booking-table th, .booking-table td {
      vertical-align: middle;
      white-space: nowrap;
    }
    .payment-details {
      font-size: 0.9rem;
    }
    .actions-column {
      min-width: 220px; /* Increased width to prevent button cutoff */
    }
    .actions-btn {
      width: 80px; /* Fixed width for buttons */
    }
    .table-responsive {
      overflow-x: auto;
    }
    .status-badge {
      width: 90px;
      display: inline-block;
      text-align: center;
    }
    .payment-badge {
      width: 100px;
      display: inline-block;
      text-align: center;
    }
  </style>
</head>
<body>
<div class="container-fluid mt-4"> <!-- Changed to container-fluid for more width -->
  <h2 class="text-center mb-4">Manage Bookings</h2>

  <% String message = request.getParameter("message");
    String error = request.getParameter("error"); %>

  <% if (message != null && !message.isEmpty()) { %>
  <div class="alert alert-success text-center"><%= message %></div>
  <% } %>
  <% if (error != null && !error.isEmpty()) { %>
  <div class="alert alert-danger text-center"><%= error %></div>
  <% } %>

  <div class="card">
    <div class="card-body p-0"> <!-- Removed padding for more space -->
      <div class="table-responsive">
        <table class="table table-striped table-hover booking-table mb-0">
          <thead class="table-dark">
          <tr>
            <th>Booking ID</th>
            <th>Pickup Point</th>
            <th>Destination</th>
            <th>Pickup Date</th>
            <th>Vehicle Model</th>
            <th>Registration</th>
            <th>Driver Name</th>
            <th>Driver Phone</th>
            <th>Amount</th>
            <th>Payment Details</th>
            <th>Status</th>
            <th class="actions-column">Actions</th>
          </tr>
          </thead>
          <tbody>
          <%
            List<BookingDetails> bookings = (List<BookingDetails>) request.getAttribute("bookings");
            if (bookings != null && !bookings.isEmpty()) {
              for (BookingDetails booking : bookings) {
          %>
          <tr>
            <td><%= booking.getBookingID() %></td>
            <td><%= booking.getPickupPointName() %></td>
            <td><%= booking.getDestinationName() %></td>
            <td><%= booking.getPickupDate() %></td>
            <td><%= booking.getVehicleModel() != null ? booking.getVehicleModel() : "Not Assigned" %></td>
            <td><%= booking.getVehicleRegistration() != null ? booking.getVehicleRegistration() : "Not Assigned" %></td>
            <td><%= booking.getDriverName() != null ? booking.getDriverName() : "Not Assigned" %></td>
            <td><%= booking.getDriverPhone() != null ? booking.getDriverPhone() : "Not Assigned" %></td>
            <td>$<%= booking.getAmount() %></td>
            <td class="payment-details">
              <%
                Map<Integer, Payment> paymentDetailsMap = (Map<Integer, Payment>) request.getAttribute("paymentDetailsMap");
                Payment payment = paymentDetailsMap != null ? paymentDetailsMap.get(booking.getBookingID()) : null;
                if (payment != null) {
              %>
              <div class="badge bg-info text-dark mb-1"><%= payment.getStatus() %></div>
              <div><strong>ID:</strong> <%= payment.getPaymentId() %></div>
              <div><strong>Method:</strong> <%= payment.getPaymentMethod() %></div>
              <div><strong>Amount:</strong> $<%= payment.getAmount() %></div>
              <div><strong>Date:</strong> <%= payment.getPaymentDate() %></div>
              <% } else { %>
              <span class="badge bg-warning text-dark">No Payment</span>
              <% } %>
            </td>
            <td>
              <span class="status-badge badge <%= "Pending".equals(booking.getStatus()) ? "bg-warning text-dark" :
                                      "Confirmed".equals(booking.getStatus()) ? "bg-success" :
                                      "Canceled".equals(booking.getStatus()) ? "bg-danger" : "bg-secondary" %>">
                <%= booking.getStatus() %>
              </span>
            </td>
            <td class="actions-column">
              <div class="d-flex gap-2">
                <div class="flex-grow-1">
                  <form action="AdminBookingServlet" method="post" class="mb-2">
                    <input type="hidden" name="action" value="updateStatus">
                    <input type="hidden" name="bookingID" value="<%= booking.getBookingID() %>">
                    <div class="d-flex gap-1">
                      <select name="status" class="form-select form-select-sm">
                        <option value="Pending" <%= "Pending".equals(booking.getStatus()) ? "selected" : "" %>>Pending</option>
                        <option value="Confirmed" <%= "Confirmed".equals(booking.getStatus()) ? "selected" : "" %>>Confirmed</option>
                        <option value="Canceled" <%= "Canceled".equals(booking.getStatus()) ? "selected" : "" %>>Canceled</option>
                      </select>
                      <button type="submit" class="btn btn-sm btn-primary actions-btn">Update</button>
                    </div>
                  </form>
                  <form action="AdminBookingServlet" method="post">
                    <input type="hidden" name="action" value="assignCar">
                    <input type="hidden" name="bookingID" value="<%= booking.getBookingID() %>">
                    <div class="d-flex gap-1">
                      <select name="carId" class="form-select form-select-sm">
                        <option value="">Select Car</option>
                        <%
                          List<Car> cars = (List<Car>) request.getAttribute("cars");
                          if (cars != null) {
                            for (Car car : cars) {
                        %>
                        <option value="<%= car.getCarId() %>"><%= car.getModel() %> (<%= car.getRegistrationNumber() %>)</option>
                        <%
                            }
                          }
                        %>
                      </select>
                      <button type="submit" class="btn btn-sm btn-success actions-btn">Assign</button>
                    </div>
                  </form>
                </div>
              </div>
            </td>
          </tr>
          <%
            }
          } else {
          %>
          <tr>
            <td colspan="12" class="text-center py-4">
              <div class="alert alert-info mb-0">No bookings found</div>
            </td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>