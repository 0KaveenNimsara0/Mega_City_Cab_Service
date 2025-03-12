<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.example.mega_city_cab_service.model.BookingDetails" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Mega City Cab Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2ecc71;
            --warning-color: #f39c12;
            --danger-color: #e74c3c;
            --light-bg: #f9f9f9;
            --dark-bg: #343a40;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
        }

        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .report-box {
            margin-bottom: 20px;
            padding: 20px;
            border: none;
            border-radius: 10px;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }

        .report-box:hover {
            transform: translateY(-5px);
        }

        .report-title {
            font-size: 1.5em;
            font-weight: bold;
            margin-bottom: 15px;
            color: var(--dark-bg);
            display: flex;
            align-items: center;
        }

        .report-title i {
            margin-right: 10px;
            color: var(--primary-color);
        }

        .metric-item {
            margin-bottom: 15px;
            font-size: 1.2em;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .metric-label {
            font-weight: 500;
        }

        .metric-value {
            font-weight: bold;
            padding: 5px 10px;
            border-radius: 20px;
            background-color: rgba(46, 204, 113, 0.2);
            color: var(--secondary-color);
        }

        .metric-value.warning {
            background-color: rgba(243, 156, 18, 0.2);
            color: var(--warning-color);
        }

        .metric-value.danger {
            background-color: rgba(231, 76, 60, 0.2);
            color: var(--danger-color);
        }

        .metric-value.primary {
            background-color: rgba(52, 152, 219, 0.2);
            color: var(--primary-color);
        }

        .date-filter {
            margin-bottom: 20px;
            padding: 15px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .btn-custom {
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 5px;
            padding: 8px 15px;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }

        .btn-print {
            background-color: var(--dark-bg);
            color: white;
            border: none;
            border-radius: 5px;
            padding: 8px 15px;
            transition: all 0.3s ease;
        }

        .btn-print:hover {
            background-color: #23272b;
            transform: translateY(-2px);
        }

        .top-drivers-table, .recent-bookings-table {
            margin-top: 15px;
        }

        .progress {
            height: 15px;
            border-radius: 10px;
        }

        .nav-tabs .nav-link {
            color: var(--dark-bg);
            border: none;
            border-bottom: 3px solid transparent;
            font-weight: 500;
        }

        .nav-tabs .nav-link.active {
            border-bottom: 3px solid var(--primary-color);
            color: var(--primary-color);
            background-color: transparent;
        }

        .chart-container {
            position: relative;
            height: 250px;
            margin-top: 15px;
        }

        /* Print-specific styles */
        @media print {
            body {
                background-color: white;
            }

            .dashboard-container {
                max-width: 100%;
                padding: 0;
            }

            .non-printable {
                display: none !important;
            }

            .report-box {
                box-shadow: none;
                border: 1px solid #ddd;
            }

            .page-break {
                page-break-after: always;
            }

            .print-header {
                text-align: center;
                margin-bottom: 20px;
                display: block !important;
            }

            .print-footer {
                text-align: center;
                margin-top: 20px;
                font-size: 0.8em;
                display: block !important;
            }
        }

        .print-header, .print-footer {
            display: none;
        }
    </style>
</head>
<body>

<div class="dashboard-container">
    <!-- Print Header -->
    <div class="print-header">
        <h1>Mega City Cab Service</h1>
        <p>Administrative Report</p>
        <p>Generated on: <%= LocalDate.now().format(DateTimeFormatter.ofPattern("MMMM dd, yyyy")) %></p>
    </div>

    <!-- Page Header with Print and Export Options -->
    <div class="d-flex justify-content-between align-items-center mb-4 non-printable">
        <h2><i class="fas fa-tachometer-alt"></i> Admin Report</h2>
        <div>
            <button onclick="window.print()" class="btn btn-print me-2">
                <i class="fas fa-print"></i> Print Report
            </button>
            <button onclick="exportToCSV()" class="btn btn-custom">
                <i class="fas fa-file-export"></i> Export Data
            </button>
        </div>
    </div>

    <!-- Date Filter Section -->
    <div class="date-filter row non-printable">
        <div class="col-md-8">
            <form class="row g-3" action="adminReport" method="GET">
                <div class="col-md-4">
                    <label for="startDate" class="form-label">Start Date</label>
                    <input type="date" class="form-control" id="startDate" name="startDate">
                </div>
                <div class="col-md-4">
                    <label for="endDate" class="form-label">End Date</label>
                    <input type="date" class="form-control" id="endDate" name="endDate">
                </div>
                <div class="col-md-4 d-flex align-items-end">
                    <button type="submit" class="btn btn-custom">Apply Filter</button>
                </div>
            </form>
        </div>
        <div class="col-md-4 d-flex align-items-end justify-content-end">
            <div class="btn-group">
                <button type="button" onclick="applyDateRange('today')" class="btn btn-outline-secondary">Today</button>
                <button type="button" onclick="applyDateRange('week')" class="btn btn-outline-secondary">This Week</button>
                <button type="button" onclick="applyDateRange('month')" class="btn btn-outline-secondary">This Month</button>
            </div>
        </div>
    </div>

    <!-- Tab Navigation -->
    <ul class="nav nav-tabs mb-4 non-printable" id="reportTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="overview-tab" data-bs-toggle="tab" data-bs-target="#overview" type="button" role="tab" aria-selected="true">
                <i class="fas fa-chart-line"></i> Overview
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="bookings-tab" data-bs-toggle="tab" data-bs-target="#bookings" type="button" role="tab" aria-selected="false">
                <i class="fas fa-calendar-check"></i> Bookings
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="finance-tab" data-bs-toggle="tab" data-bs-target="#finance" type="button" role="tab" aria-selected="false">
                <i class="fas fa-money-bill-wave"></i> Finance
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="drivers-tab" data-bs-toggle="tab" data-bs-target="#drivers" type="button" role="tab" aria-selected="false">
                <i class="fas fa-user-tie"></i> Drivers
            </button>
        </li>
    </ul>

        <%
        // Retrieve report data from request attributes
        Integer totalBookings = (Integer) request.getAttribute("totalBookings");
        Integer totalPaidBookings = (Integer) request.getAttribute("totalPaidBookings");
        Integer pendingBookings = (Integer) request.getAttribute("pendingBookings");
        Integer cardPayments = (Integer) request.getAttribute("cardPayments");
        Integer paypalPayments = (Integer) request.getAttribute("paypalPayments");
        Integer cashPayments = (Integer) request.getAttribute("cashPayments");
        Double totalIncome = (Double) request.getAttribute("totalIncome");

        // Additional data (you'll need to add these to your controller)
        Integer completedRides = (Integer) request.getAttribute("completedRides");
        Integer cancelledRides = (Integer) request.getAttribute("cancelledRides");
        Double averageRideDistance = (Double) request.getAttribute("averageRideDistance");
        Double averageFare = (Double) request.getAttribute("averageFare");
        Integer activeDrivers = (Integer) request.getAttribute("activeDrivers");
        Integer totalDrivers = (Integer) request.getAttribute("totalDrivers");
        Integer newCustomers = (Integer) request.getAttribute("newCustomers");
        Double previousPeriodIncome = (Double) request.getAttribute("previousPeriodIncome");

        // Get top drivers
        List<Map<String, Object>> topDrivers = (List<Map<String, Object>>) request.getAttribute("topDrivers");

        // Get recent bookings
        List<BookingDetails> recentBookings = (List<BookingDetails>) request.getAttribute("recentBookings");

        // Default values if attributes are null
        totalBookings = totalBookings != null ? totalBookings : 0;
        totalPaidBookings = totalPaidBookings != null ? totalPaidBookings : 0;
        pendingBookings = pendingBookings != null ? pendingBookings : 0;
        cardPayments = cardPayments != null ? cardPayments : 0;
        paypalPayments = paypalPayments != null ? paypalPayments : 0;
        cashPayments = cashPayments != null ? cashPayments : 0;
        totalIncome = totalIncome != null ? totalIncome : 0.0;
        completedRides = completedRides != null ? completedRides : 0;
        cancelledRides = cancelledRides != null ? cancelledRides : 0;
        averageRideDistance = averageRideDistance != null ? averageRideDistance : 0.0;
        averageFare = averageFare != null ? averageFare : 0.0;
        activeDrivers = activeDrivers != null ? activeDrivers : 0;
        totalDrivers = totalDrivers != null ? totalDrivers : 0;
        newCustomers = newCustomers != null ? newCustomers : 0;
        previousPeriodIncome = previousPeriodIncome != null ? previousPeriodIncome : 0.0;

        // Calculate metrics
        double completionRate = totalBookings > 0 ? (double) completedRides / totalBookings * 100 : 0;
        double cancellationRate = totalBookings > 0 ? (double) cancelledRides / totalBookings * 100 : 0;
        double driverActivityRate = totalDrivers > 0 ? (double) activeDrivers / totalDrivers * 100 : 0;
        double incomeChange = previousPeriodIncome > 0 ? (totalIncome - previousPeriodIncome) / previousPeriodIncome * 100 : 0;
    %>

    <!-- Tab Content -->
    <div class="tab-content" id="reportTabsContent">
        <!-- Overview Tab -->
        <div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview-tab">
            <div class="row">
                <!-- Summary Cards -->
                <div class="col-md-3 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-car"></i> Total Rides</div>
                        <h3 class="text-center display-4"><%= totalBookings %></h3>
                        <div class="d-flex justify-content-between mt-3">
                            <span class="badge bg-success"><%= completedRides %> Completed</span>
                            <span class="badge bg-warning"><%= pendingBookings %> Pending</span>
                            <span class="badge bg-danger"><%= cancelledRides %> Cancelled</span>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-money-bill-wave"></i> Revenue</div>
                        <h3 class="text-center display-4">LKR <%= String.format("%,.0f", totalIncome) %></h3>
                        <div class="d-flex justify-content-between mt-3">
                            <span class="badge <%= incomeChange >= 0 ? "bg-success" : "bg-danger" %>">
                                <i class="fas <%= incomeChange >= 0 ? "fa-arrow-up" : "fa-arrow-down" %>"></i>
                                <%= String.format("%.1f", Math.abs(incomeChange)) %>%
                            </span>
                            <span class="badge bg-info">Avg: LKR <%= String.format("%,.0f", averageFare) %></span>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-user-tie"></i> Drivers</div>
                        <h3 class="text-center display-4"><%= activeDrivers %>/<%= totalDrivers %></h3>
                        <div class="progress mt-3">
                            <div class="progress-bar bg-success" role="progressbar"
                                 style="width: <%= driverActivityRate %>%"
                                 aria-valuenow="<%= driverActivityRate %>" aria-valuemin="0" aria-valuemax="100">
                                <%= String.format("%.1f", driverActivityRate) %>%
                            </div>
                        </div>
                        <div class="text-center mt-2">Active Drivers</div>
                    </div>
                </div>

                <div class="col-md-3 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-users"></i> New Customers</div>
                        <h3 class="text-center display-4"><%= newCustomers %></h3>
                        <div class="text-center mt-3">
                            <span class="badge bg-primary">This Period</span>
                        </div>
                    </div>
                </div>

                <!-- Charts -->
                <div class="col-md-6 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-chart-line"></i> Booking Trends</div>
                        <div class="chart-container">
                            <canvas id="bookingTrendsChart"></canvas>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-chart-pie"></i> Payment Methods</div>
                        <div class="chart-container">
                            <canvas id="paymentMethodsChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Recent Bookings Table -->
                <div class="col-md-12 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-list-alt"></i> Recent Bookings</div>
                        <div class="table-responsive recent-bookings-table">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>Booking ID</th>
                                    <th>Pickup Point</th>
                                    <th>Destination</th>
                                    <th>Car Type</th>
                                    <th>Pickup Date</th>
                                    <th>Amount</th>
                                    <th>Status</th>
                                    <th>Vehicle Registration</th>
                                    <th>Driver Name</th>
                                    <th>Driver Phone</th>
                                    <th>Payment Method</th>
                                    <th>Payment Status</th>
                                    <th>Payment Date</th>
                                    <th>Payment Amount</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    // Get the BookingDetails list from the request attribute
                                    List<BookingDetails> bookingDetailsList = (List<BookingDetails>) request.getAttribute("bookingDetailsList");

                                    // Check if the list exists and is not empty
                                    if (bookingDetailsList != null && !bookingDetailsList.isEmpty()) {
                                        for (BookingDetails booking : bookingDetailsList) {
                                %>
                                <tr>
                                    <td><%= booking.getBookingID() %></td>
                                    <td><%= booking.getPickupPointName() %></td>
                                    <td><%= booking.getDestinationName() %></td>
                                    <td><%= booking.getCarTypeName() %></td>
                                    <td><%= booking.getPickupDate() %></td>
                                    <td><%= booking.getAmount() %></td>
                                    <td><%= booking.getStatus() %></td>
                                    <td><%= booking.getVehicleRegistration() %></td>
                                    <td><%= booking.getDriverName() %></td>
                                    <td><%= booking.getDriverPhone() %></td>
                                    <td><%= booking.getPaymentMethod() %></td>
                                    <td><%= booking.getPaymentStatus() %></td>
                                    <td><%= booking.getPaymentDate() %></td>
                                    <td><%= booking.getPaymentAmount() %></td>
                                </tr>
                                <%
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="14" style="text-align: center;">No bookings found.</td>
                                </tr>
                                <%
                                    }
                                %>
                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!-- Bookings Tab -->
        <div class="tab-pane fade" id="bookings" role="tabpanel" aria-labelledby="bookings-tab">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-clipboard-check"></i> Booking Statistics</div>
                        <div class="metric-item">
                            <span class="metric-label">Total Bookings:</span>
                            <span class="metric-value"><%= totalBookings %></span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Completed Rides:</span>
                            <span class="metric-value"><%= completedRides %></span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Pending Bookings:</span>
                            <span class="metric-value warning"><%= pendingBookings %></span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Cancelled Rides:</span>
                            <span class="metric-value danger"><%= cancelledRides %></span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Completion Rate:</span>
                            <span class="metric-value <%= completionRate >= 80 ? "" : (completionRate >= 60 ? "warning" : "danger") %>">
                                <%= String.format("%.1f", completionRate) %>%
                            </span>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-route"></i> Ride Metrics</div>
                        <div class="metric-item">
                            <span class="metric-label">Average Distance:</span>
                            <span class="metric-value primary"><%= String.format("%.1f", averageRideDistance) %> km</span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Average Fare:</span>
                            <span class="metric-value">LKR <%= String.format("%,.2f", averageFare) %></span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Rush Hour Bookings:</span>
                            <span class="metric-value primary">42%</span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Weekend Bookings:</span>
                            <span class="metric-value primary">35%</span>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-map-marker-alt"></i> Popular Locations</div>
                        <div class="metric-item">
                            <span class="metric-label">Top Pickup:</span>
                            <span class="metric-value primary">Colombo City Center</span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Top Destination:</span>
                            <span class="metric-value primary">Bandaranaike Airport</span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Busiest District:</span>
                            <span class="metric-value primary">Colombo 03</span>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-chart-bar"></i> Bookings by Time of Day</div>
                        <div class="chart-container">
                            <canvas id="bookingsByTimeChart"></canvas>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-chart-bar"></i> Bookings by Day of Week</div>
                        <div class="chart-container">
                            <canvas id="bookingsByDayChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Finance Tab -->
        <div class="tab-pane fade" id="finance" role="tabpanel" aria-labelledby="finance-tab">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-money-check-alt"></i> Payment Summary</div>
                        <div class="metric-item">
                            <span class="metric-label">Total Income:</span>
                            <span class="metric-value">LKR <%= String.format("%,.2f", totalIncome) %></span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Card Payments:</span>
                            <span class="metric-value primary">LKR <%= String.format("%,.2f", totalIncome * cardPayments / (cardPayments + paypalPayments + cashPayments)) %></span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">PayPal Payments:</span>
                            <span class="metric-value primary">LKR <%= String.format("%,.2f", totalIncome * paypalPayments / (cardPayments + paypalPayments + cashPayments)) %></span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Cash Payments:</span>
                            <span class="metric-value primary">LKR <%= String.format("%,.2f", totalIncome * cashPayments / (cardPayments + paypalPayments + cashPayments)) %></span>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-receipt"></i> Payment Metrics</div>
                        <div class="metric-item">
                            <span class="metric-label">Total Paid Bookings:</span>
                            <span class="metric-value"><%= totalPaidBookings %></span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Payment Success Rate:</span>
                            <span class="metric-value">
                                <%= String.format("%.1f", totalBookings > 0 ? (double) totalPaidBookings / totalBookings * 100 : 0) %>%
                            </span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Failed Transactions:</span>
                            <span class="metric-value warning">2%</span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Refunds Processed:</span>
                            <span class="metric-value danger">3</span>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-chart-line"></i> Revenue Trends</div>
                        <div class="metric-item">
                            <span class="metric-label">VS Previous Period:</span>
                            <span class="metric-value <%= incomeChange >= 0 ? "" : "danger" %>">
                                <%= String.format("%+.1f", incomeChange) %>%
                            </span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Projected Monthly:</span>
                            <span class="metric-value">LKR <%= String.format("%,.2f", totalIncome * 30 / 7) %></span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Avg. Daily Revenue:</span>
                            <span class="metric-value">LKR <%= String.format("%,.2f", totalIncome / 7) %></span>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-chart-line"></i> Revenue by Day</div>
                        <div class="chart-container">
                            <canvas id="revenueByDayChart"></canvas>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-chart-pie"></i> Payment Method Breakdown</div>
                        <div class="chart-container">
                            <canvas id="paymentBreakdownChart"></canvas>
                        </div>
                    </div>
                </div>

                <div class="col-md-12 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-file-invoice-dollar"></i> Monthly Revenue Summary</div>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>Month</th>
                                    <th>Total Rides</th>
                                    <th>Completed</th>
                                    <th>Cancelled</th>
                                    <th>Gross Revenue</th>
                                    <th>Avg. Fare</th>
                                    <th>Growth</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>Jan 2025</td>
                                    <td>1,245</td>
                                    <td>1,156</td>
                                    <td>89</td>
                                    <td>LKR 1,568,750</td>
                                    <td>LKR 1,357</td>
                                    <td><span class="badge bg-success">+5.2%</span></td>
                                </tr>
                                <tr>
                                    <td>Feb 2025</td>
                                    <td>1,356</td>
                                    <td>1,289</td>
                                    <td>67</td>
                                    <td>LKR 1,897,450</td>
                                    <td>LKR 1,472</td>
                                    <td><span class="badge bg-success">+21.0%</span></td>
                                </tr>
                                <tr>
                                    <td>Mar 2025</td>
                                    <td>1,432</td>
                                    <td>1,350</td>
                                    <td>82</td>
                                    <td>LKR 2,025,600</td>
                                    <td>LKR 1,500</td>
                                    <td><span class="badge bg-success">+6.8%</span></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Drivers Tab -->
        <div class="tab-pane fade" id="drivers" role="tabpanel" aria-labelledby="drivers-tab">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-user-tie"></i> Driver Statistics</div>
                        <div class="metric-item">
                            <span class="metric-label">Total Drivers:</span>
                            <span class="metric-value"><%= totalDrivers %></span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Active Drivers:</span>
                            <span class="metric-value"><%= activeDrivers %></span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Driver Activity Rate:</span>
                            <span class="metric-value <%= driverActivityRate >= 80 ? "" : (driverActivityRate >= 60 ? "warning" : "danger") %>">
                                <%= String.format("%.1f", driverActivityRate) %>%
                            </span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">New Driver Signups:</span>
                            <span class="metric-value primary">12</span>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-star"></i> Driver Performance</div>
                        <div class="metric-item">
                            <span class="metric-label">Average Rating:</span>
                            <span class="metric-value">4.7/5.0</span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">On-Time Arrival:</span>
                            <span class="metric-value">92%</span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Ride Acceptance Rate:</span>
                            <span class="metric-value">95%</span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Cancellation Rate:</span>
                            <span class="metric-value warning">3.5%</span>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-clock"></i> Driver Availability</div>
                        <div class="metric-item">
                            <span class="metric-label">Peak Hour Coverage:</span>
                            <span class="metric-value">86%</span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Off-Peak Coverage:</span>
                            <span class="metric-value warning">65%</span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Avg. Online Hours:</span>
                            <span class="metric-value primary">8.2 hours</span>
                        </div>
                        <div class="metric-item">
                            <span class="metric-label">Weekend Availability:</span>
                            <span class="metric-value warning">72%</span>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-award"></i> Top 5 Drivers</div>
                        <div class="table-responsive top-drivers-table">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Driver Name</th>
                                    <th>Rides</th>
                                    <th>Rating</th>
                                    <th>Revenue Generated</th>
                                </tr>
                                </thead>
                                <tbody>
                                <% if (topDrivers != null && !topDrivers.isEmpty()) {
                                    int rank = 1;
                                    for (Map<String, Object> driver : topDrivers) { %>
                                <tr>
                                    <td><%= rank++ %></td>
                                    <td><%= driver.get("name") %></td>
                                    <td><%= driver.get("rideCount") %></td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <%= driver.get("rating") %>
                                            <div class="ms-2 text-warning">
                                                <% double rating = (double) driver.get("rating");
                                                    for (int i = 0; i < 5; i++) {
                                                        if (i < Math.floor(rating)) { %>
                                                <i class="fas fa-star small"></i>
                                                <% } else if (i < rating) { %>
                                                <i class="fas fa-star-half-alt small"></i>
                                                <% } else { %>
                                                <i class="far fa-star small"></i>
                                                <% }
                                                } %>
                                            </div>
                                        </div>
                                    </td>
                                    <td>LKR <%= String.format("%,.2f", driver.get("revenue")) %></td>
                                </tr>
                                <% }
                                } else { %>
                                <tr>
                                    <td colspan="5" class="text-center">No driver data available</td>
                                </tr>
                                <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 mb-4">
                    <div class="report-box">
                        <div class="report-title"><i class="fas fa-car"></i> Vehicle Distribution</div>
                        <div class="chart-container">
                            <canvas id="vehicleDistributionChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Print Footer -->
    <div class="print-footer">
        <p>Mega City Cab Service - Confidential</p>
        <p>Generated on <%= LocalDate.now().format(DateTimeFormatter.ofPattern("MMMM dd, yyyy")) %></p>
        <p>Page 1 of 1</p>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Chart Initialization -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Booking Trends Chart
        const bookingTrendsCtx = document.getElementById('bookingTrendsChart').getContext('2d');
        const bookingTrendsChart = new Chart(bookingTrendsCtx, {
            type: 'line',
            data: {
                labels: ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
                datasets: [{
                    label: 'Bookings',
                    data: [320, 420, 380, 450],
                    borderColor: '#3498db',
                    backgroundColor: 'rgba(52, 152, 219, 0.1)',
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        // Payment Methods Chart
        const paymentMethodsCtx = document.getElementById('paymentMethodsChart').getContext('2d');
        const paymentMethodsChart = new Chart(paymentMethodsCtx, {
            type: 'doughnut',
            data: {
                labels: ['Card', 'PayPal', 'Cash'],
                datasets: [{
                    data: [<%= cardPayments %>, <%= paypalPayments %>, <%= cashPayments %>],
                    backgroundColor: ['#3498db', '#2ecc71', '#f39c12']
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'right'
                    }
                }
            }
        });

        // Bookings by Time of Day Chart
        const bookingsByTimeCtx = document.getElementById('bookingsByTimeChart').getContext('2d');
        const bookingsByTimeChart = new Chart(bookingsByTimeCtx, {
            type: 'bar',
            data: {
                labels: ['6-9 AM', '9-12 PM', '12-3 PM', '3-6 PM', '6-9 PM', '9-12 AM', '12-6 AM'],
                datasets: [{
                    label: 'Number of Bookings',
                    data: [325, 280, 240, 360, 420, 190, 75],
                    backgroundColor: 'rgba(52, 152, 219, 0.7)'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        // Bookings by Day of Week Chart
        const bookingsByDayCtx = document.getElementById('bookingsByDayChart').getContext('2d');
        const bookingsByDayChart = new Chart(bookingsByDayCtx, {
            type: 'bar',
            data: {
                labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
                datasets: [{
                    label: 'Number of Bookings',
                    data: [210, 190, 205, 240, 280, 350, 320],
                    backgroundColor: 'rgba(46, 204, 113, 0.7)'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        // Revenue by Day Chart
        const revenueByDayCtx = document.getElementById('revenueByDayChart').getContext('2d');
        const revenueByDayChart = new Chart(revenueByDayCtx, {
            type: 'line',
            data: {
                labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
                datasets: [{
                    label: 'Revenue (LKR)',
                    data: [250000, 230000, 245000, 290000, 350000, 420000, 380000],
                    borderColor: '#2ecc71',
                    backgroundColor: 'rgba(46, 204, 113, 0.1)',
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return 'LKR ' + value.toLocaleString();
                            }
                        }
                    }
                }
            }
        });

        // Payment Breakdown Chart
        const paymentBreakdownCtx = document.getElementById('paymentBreakdownChart').getContext('2d');
        const paymentBreakdownChart = new Chart(paymentBreakdownCtx, {
            type: 'pie',
            data: {
                labels: ['Card', 'PayPal', 'Cash'],
                datasets: [{
                    data: [<%= cardPayments %>, <%= paypalPayments %>, <%= cashPayments %>],
                    backgroundColor: ['#3498db', '#2ecc71', '#f39c12']
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'right'
                    }
                }
            }
        });

        // Vehicle Distribution Chart
        const vehicleDistributionCtx = document.getElementById('vehicleDistributionChart').getContext('2d');
        const vehicleDistributionChart = new Chart(vehicleDistributionCtx, {
            type: 'bar',
            data: {
                labels: ['Sedan', 'SUV', 'Van', 'Luxury', 'Tuk Tuk'],
                datasets: [{
                    label: 'Number of Vehicles',
                    data: [45, 28, 15, 10, 32],
                    backgroundColor: [
                        'rgba(52, 152, 219, 0.7)',
                        'rgba(46, 204, 113, 0.7)',
                        'rgba(155, 89, 182, 0.7)',
                        'rgba(243, 156, 18, 0.7)',
                        'rgba(231, 76, 60, 0.7)'
                    ]
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    });

    // Date range functionality
    function applyDateRange(range) {
        const startDateInput = document.getElementById('startDate');
        const endDateInput = document.getElementById('endDate');
        const today = new Date();

        switch(range) {
            case 'today':
                startDateInput.valueAsDate = today;
                endDateInput.valueAsDate = today;
                break;
            case 'week':
                const weekStart = new Date(today);
                weekStart.setDate(today.getDate() - today.getDay());

                startDateInput.valueAsDate = weekStart;
                endDateInput.valueAsDate = today;
                break;
            case 'month':
                const monthStart = new Date(today.getFullYear(), today.getMonth(), 1);

                startDateInput.valueAsDate = monthStart;
                endDateInput.valueAsDate = today;
                break;
        }
    }

    // Export to CSV functionality
    function exportToCSV() {
        // Get table data
        const bookingsTable = document.querySelector('.recent-bookings-table table');
        let csvContent = "data:text/csv;charset=utf-8,";

        // Get headers
        const headers = [];
        bookingsTable.querySelectorAll('thead th').forEach(th => {
            headers.push(th.innerText);
        });
        csvContent += headers.join(',') + "\r\n";

        // Get row data
        bookingsTable.querySelectorAll('tbody tr').forEach(row => {
            const rowData = [];
            row.querySelectorAll('td').forEach(cell => {
                // Remove any commas to avoid CSV issues
                rowData.push('"' + cell.innerText.replace(/,/g, ' ') + '"');
            });
            csvContent += rowData.join(',') + "\r\n";
        });

        // Create download link
        const encodedUri = encodeURI(csvContent);
        const link = document.createElement("a");
        link.setAttribute("href", encodedUri);
        link.setAttribute("download", "mega_city_cab_report_" + new Date().toISOString().slice(0,10) + ".csv");
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }
</script>
</body>
</html>