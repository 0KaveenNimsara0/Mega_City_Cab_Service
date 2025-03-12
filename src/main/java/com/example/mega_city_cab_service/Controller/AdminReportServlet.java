package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.dao.BookingDAO;
import com.example.mega_city_cab_service.dao.DriverDAO;
import com.example.mega_city_cab_service.dao.PaymentDAO;
import com.example.mega_city_cab_service.model.BookingDetails;
import com.example.mega_city_cab_service.model.Driver;
import com.example.mega_city_cab_service.service.DriverService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


public class AdminReportServlet extends HttpServlet {
    private final BookingDAO bookingDAO;
    private final PaymentDAO paymentDAO;
    private final DriverDAO driverDAO ;
    

    public AdminReportServlet() {
        this.bookingDAO = new BookingDAO();
        this.paymentDAO = new PaymentDAO();
        this.driverDAO = new DriverDAO();
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<BookingDetails> bookingDetailsList = bookingDAO.getAllBookingDetails();



            // Fetch report data from the DAO layer
            int totalBookings = bookingDAO.getTotalBookings();
            int totalPaidBookings = bookingDAO.getTotalPaidBookings();
            int pendingBookings = paymentDAO.getPendingBookings();
            int cardPayments = paymentDAO.getCardPayments();
            int paypalPayments = paymentDAO.getPaypalPayments();
            int cashPayments = paymentDAO.getCashPayments();
            double totalIncome = bookingDAO.getTotalIncome();
            int totalDrivers  = driverDAO.getTotalDrivers();

            // Set attributes for the JSP
            request.setAttribute("bookingDetailsList", bookingDetailsList);
            // Set attributes for the JSP
            request.setAttribute("totalBookings", totalBookings);
            request.setAttribute("totalPaidBookings", totalPaidBookings);
            request.setAttribute("pendingBookings", pendingBookings);
            request.setAttribute("cardPayments", cardPayments);
            request.setAttribute("paypalPayments", paypalPayments);
            request.setAttribute("cashPayments", cashPayments);
            request.setAttribute("totalIncome", totalIncome);
            request.setAttribute("pendingPayments", pendingBookings + cardPayments + paypalPayments + cashPayments);
            request.setAttribute("totalPayments", pendingBookings + cardPayments + paypalPayments + cashPayments + totalIncome);
            request.setAttribute("totalRevenue", totalIncome);
            request.setAttribute("totalProfit", totalIncome - totalIncome);
            request.setAttribute("totalProfitPercentage", (totalIncome - totalIncome) / totalIncome * 100);
            request.setAttribute("totalProfitPercentageString", String.format("%.2f", (totalIncome - totalIncome) / totalIncome * 100) + "%");
            request.setAttribute("totalDrivers",totalDrivers);
            int availableDrivers = driverDAO.getAvailableDrivers().size(); // Assuming getAvailableDrivers() returns a List<Driver>
            request.setAttribute("activeDrivers", availableDrivers);




            // Forward to the JSP
            request.getRequestDispatcher("admin_report.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Failed to generate report");
        }
    }
}