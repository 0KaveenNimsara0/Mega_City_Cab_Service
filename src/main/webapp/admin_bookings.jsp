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
  <!-- Font Awesome for icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    :root {
      --primary-color: #1a73e8;
      --secondary-color: #f8f9fa;
      --success-color: #28a745;
      --warning-color: #ffc107;
      --danger-color: #dc3545;
      --dark-color: #343a40;
      --light-color: #f8f9fa;
    }

    body {
      background-color: #f5f7fa;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .page-header {
      background: linear-gradient(135deg, var(--primary-color), #0d47a1);
      color: white;
      padding: 20px 0;
      border-radius: 0 0 10px 10px;
      margin-bottom: 25px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .card {
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      border: none;
    }

    .booking-table th {
      background-color: var(--primary-color);
      color: white;
      font-weight: 500;
      padding: 12px 15px;
    }

    .booking-table td {
      vertical-align: middle;
      padding: 12px 15px;
    }

    .booking-table tbody tr:hover {
      background-color: rgba(26, 115, 232, 0.05);
    }

    .table-striped>tbody>tr:nth-of-type(odd)>* {
      background-color: rgba(0, 0, 0, 0.02);
    }

    .status-badge {
      width: 100px;
      display: inline-block;
      text-align: center;
      font-weight: 500;
      padding: 5px 10px;
      border-radius: 20px;
    }

    .payment-details {
      background-color: var(--secondary-color);
      border-radius: 8px;
      padding: 8px;
    }

    .payment-badge {
      border-radius: 20px;
      font-weight: 500;
    }

    .form-select, .btn {
      border-radius: 6px;
    }

    .btn-primary {
      background-color: var(--primary-color);
    }

    .actions-column {
      min-width: 240px;
    }

    .actions-btn {
      min-width: 80px;
    }

    .alert {
      border-radius: 8px;
      font-weight: 500;
    }

    .booking-id {
      font-weight: bold;
      color: var(--primary-color);
    }

    .filter-controls {
      background-color: white;
      border-radius: 8px;
      padding: 15px;
      margin-bottom: 20px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    }

    /* Responsive table improvements */
    .table-responsive {
      border-radius: 10px;
      overflow: hidden;
    }

    /* Empty state styling */
    .empty-state {
      padding: 40px 20px;
      text-align: center;
    }

    .empty-state i {
      font-size: 48px;
      color: #cfd8dc;
      margin-bottom: 20px;
    }
  </style>
</head>
<body>

<div class="page-header">
  <div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center">
      <h2 class="mb-0"><i class="fas fa-taxi me-2"></i>Manage Bookings</h2>
      <nav aria-label="breadcrumb">
        <ol class="breadcrumb mb-0">
          <li class="breadcrumb-item"><a href="#" class="text-white">Dashboard</a></li>
          <li class="breadcrumb-item active text-white" aria-current="page">Bookings</li>
        </ol>
      </nav>
    </div>
  </div>
</div>

<div class="container-fluid">
  <% String message = request.getParameter("message");
    String error = request.getParameter("error"); %>

  <% if (message != null && !message.isEmpty()) { %>
  <div class="alert alert-success alert-dismissible fade show">
    <i class="fas fa-check-circle me-2"></i><%= message %>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <% } %>
  <% if (error != null && !error.isEmpty()) { %>
  <div class="alert alert-danger alert-dismissible fade show">
    <i class="fas fa-exclamation-circle me-2"></i><%= error %>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <% } %>

  <!-- Filter Controls -->
  <div class="filter-controls mb-4">
    <div class="row g-3">
      <div class="col-md-2">
        <label for="statusFilter" class="form-label">Status</label>
        <select id="statusFilter" class="form-select">
          <option value="">All Statuses</option>
          <option value="Pending">Pending</option>
          <option value="Confirmed">Confirmed</option>
          <option value="Canceled">Canceled</option>
        </select>
      </div>
      <div class="col-md-3">
        <label for="dateFilter" class="form-label">Pickup Date</label>
        <input type="date" id="dateFilter" class="form-control">
      </div>
      <div class="col-md-3">
        <label for="searchFilter" class="form-label">Search</label>
        <input type="text" id="searchFilter" class="form-control" placeholder="Booking ID, Driver, Location...">
      </div>
      <div class="col-md-2 d-flex align-items-end">
        <button class="btn btn-primary w-100">
          <i class="fas fa-filter me-2"></i>Apply Filters
        </button>
      </div>
      <div class="col-md-2 d-flex align-items-end">
        <button class="btn btn-outline-secondary w-100">
          <i class="fas fa-redo me-2"></i>Reset
        </button>
      </div>
    </div>
  </div>

  <div class="card">
    <div class="card-body p-0">
      <div class="table-responsive">
        <table class="table table-striped table-hover booking-table mb-0">
          <thead>
          <tr>
            <th><i class="fas fa-hashtag me-1"></i>Booking ID</th>
            <th><i class="fas fa-map-marker-alt me-1"></i>Pickup</th>
            <th><i class="fas fa-map-pin me-1"></i>Destination</th>
            <th><i class="fas fa-calendar-alt me-1"></i>Pickup Date</th>
            <th><i class="fas fa-car me-1"></i>Vehicle</th>
            <th><i class="fas fa-id-card me-1"></i>Registration</th>
            <th><i class="fas fa-user me-1"></i>Driver</th>
            <th><i class="fas fa-phone me-1"></i>Phone</th>
            <th><i class="fas fa-dollar-sign me-1"></i>Amount</th>
            <th><i class="fas fa-credit-card me-1"></i>Payment</th>
            <th><i class="fas fa-info-circle me-1"></i>Status</th>
            <th class="actions-column"><i class="fas fa-cogs me-1"></i>Actions</th>
          </tr>
          </thead>
          <tbody>
          <%
            List<BookingDetails> bookings = (List<BookingDetails>) request.getAttribute("bookings");
            if (bookings != null && !bookings.isEmpty()) {
              for (BookingDetails booking : bookings) {
          %>
          <tr>
            <td class="booking-id">#<%= booking.getBookingID() %></td>
            <td><%= booking.getPickupPointName() %></td>
            <td><%= booking.getDestinationName() %></td>
            <td><%= booking.getPickupDate() %></td>
            <td><%= booking.getVehicleModel() != null ? booking.getVehicleModel() : "<span class='text-muted'>Not Assigned</span>" %></td>
            <td><%= booking.getVehicleRegistration() != null ? booking.getVehicleRegistration() : "<span class='text-muted'>Not Assigned</span>" %></td>
            <td><%= booking.getDriverName() != null ? booking.getDriverName() : "<span class='text-muted'>Not Assigned</span>" %></td>
            <td><%= booking.getDriverPhone() != null ? booking.getDriverPhone() : "<span class='text-muted'>Not Assigned</span>" %></td>
            <td><span class="fw-bold">$<%= booking.getAmount() %></span></td>
            <td>
              <%
                Map<Integer, Payment> paymentDetailsMap = (Map<Integer, Payment>) request.getAttribute("paymentDetailsMap");
                Payment payment = paymentDetailsMap != null ? paymentDetailsMap.get(booking.getBookingID()) : null;
                if (payment != null) {
              %>
              <div class="payment-details">
                <div class="payment-badge badge bg-info text-dark mb-2">
                  <i class="fas fa-check-circle me-1"></i><%= payment.getStatus() %>
                </div>
                <div><i class="fas fa-hashtag me-1"></i><strong>ID:</strong> <%= payment.getPaymentId() %></div>
                <div><i class="fas fa-credit-card me-1"></i><strong>Method:</strong> <%= payment.getPaymentMethod() %></div>
                <div><i class="fas fa-dollar-sign me-1"></i><strong>Amount:</strong> $<%= payment.getAmount() %></div>
                <div><i class="fas fa-calendar-day me-1"></i><strong>Date:</strong> <%= payment.getPaymentDate() %></div>
              </div>
              <% } else { %>
              <span class="badge bg-warning text-dark">
                <i class="fas fa-exclamation-circle me-1"></i>No Payment
              </span>
              <% } %>
            </td>
            <td>
              <span class="status-badge badge
                <%= "Pending".equals(booking.getStatus()) ? "bg-warning text-dark" :
                   "Confirmed".equals(booking.getStatus()) ? "bg-success" :
                   "Canceled".equals(booking.getStatus()) ? "bg-danger" : "bg-secondary" %>">
                <i class="<%= "Pending".equals(booking.getStatus()) ? "fas fa-clock" :
                           "Confirmed".equals(booking.getStatus()) ? "fas fa-check-circle" :
                           "Canceled".equals(booking.getStatus()) ? "fas fa-times-circle" : "fas fa-question-circle" %> me-1"></i>
                <%= booking.getStatus() %>
              </span>
            </td>
            <td class="actions-column">
              <div class="d-flex flex-column gap-2">
                <form action="AdminBookingServlet" method="post">
                  <input type="hidden" name="action" value="updateStatus">
                  <input type="hidden" name="bookingID" value="<%= booking.getBookingID() %>">
                  <div class="d-flex gap-1">
                    <select name="status" class="form-select form-select-sm">
                      <option value="Pending" <%= "Pending".equals(booking.getStatus()) ? "selected" : "" %>>Pending</option>
                      <option value="Confirmed" <%= "Confirmed".equals(booking.getStatus()) ? "selected" : "" %>>Confirmed</option>
                      <option value="Canceled" <%= "Canceled".equals(booking.getStatus()) ? "selected" : "" %>>Canceled</option>
                    </select>
                    <button type="submit" class="btn btn-sm btn-primary actions-btn">
                      <i class="fas fa-sync-alt me-1"></i>Update
                    </button>
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
                    <button type="submit" class="btn btn-sm btn-success actions-btn">
                      <i class="fas fa-car me-1"></i>Assign
                    </button>
                  </div>
                </form>
                <button type="button" class="btn btn-sm btn-outline-secondary actions-btn" onclick="viewDetails(<%= booking.getBookingID() %>)">
                  <i class="fas fa-eye me-1"></i>Details
                </button>
              </div>
            </td>
          </tr>
          <%
            }
          } else {
          %>
          <tr>
            <td colspan="12">
              <div class="empty-state">
                <i class="fas fa-taxi"></i>
                <h4>No Bookings Found</h4>
                <p class="text-muted">There are no bookings to display at this time.</p>
                <button class="btn btn-primary">
                  <i class="fas fa-plus me-2"></i>Create New Booking
                </button>
              </div>
            </td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <div class="d-flex justify-content-between align-items-center mt-4">
    <div>
      <span class="text-muted">Showing <%= bookings != null ? bookings.size() : 0 %> bookings</span>
    </div>
    <nav aria-label="Page navigation">
      <ul class="pagination mb-0">
        <li class="page-item disabled">
          <a class="page-link" href="#" aria-label="Previous">
            <span aria-hidden="true">&laquo;</span>
          </a>
        </li>
        <li class="page-item active"><a class="page-link" href="#">1</a></li>
        <li class="page-item"><a class="page-link" href="#">2</a></li>
        <li class="page-item"><a class="page-link" href="#">3</a></li>
        <li class="page-item">
          <a class="page-link" href="#" aria-label="Next">
            <span aria-hidden="true">&raquo;</span>
          </a>
        </li>
      </ul>
    </nav>
  </div>
</div>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // JavaScript for enhanced functionality
  function viewDetails(bookingId) {
    // Placeholder for future implementation of a details modal
    alert("View details for booking #" + bookingId);
  }

  // Filter functionality (placeholder implementation)
  document.addEventListener('DOMContentLoaded', function() {
    const statusFilter = document.getElementById('statusFilter');
    const dateFilter = document.getElementById('dateFilter');
    const searchFilter = document.getElementById('searchFilter');

    // Simple event listeners for demonstration purposes
    statusFilter.addEventListener('change', function() {
      console.log("Status filter changed to:", this.value);
      // Implementation would go here
    });

    // Auto-dismiss alerts after 5 seconds
    setTimeout(function() {
      const alerts = document.querySelectorAll('.alert');
      alerts.forEach(function(alert) {
        const bsAlert = new bootstrap.Alert(alert);
        bsAlert.close();
      });
    }, 5000);
  });
</script>
</body>
</html>