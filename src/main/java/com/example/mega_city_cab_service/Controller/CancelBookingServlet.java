//this method use customer view booking part

package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.dao.BookingDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

public class CancelBookingServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve booking ID from the form
        String bookingId = request.getParameter("bookingId");

        if (bookingId == null || bookingId.isEmpty()) {
            response.sendRedirect("error.jsp?message=Invalid booking ID");
            return;
        }

        try {
            // Update the booking status to "Cancelled"
            boolean isCancelled = bookingDAO.cancelBooking(bookingId);

            if (isCancelled) {
                System.err.println("Booking with ID " + bookingId + " has been successfully cancelled.");
                response.sendRedirect("Customer_Dashboard.jsp?message=Booking cancelled successfully");
            } else {
                System.err.println("Failed to cancel booking with ID " + bookingId);
                response.sendRedirect("error.jsp?message=Failed to cancel booking");
            }
        } catch (SQLException e) {
            System.err.println("Database error occurred while cancelling booking: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Database error occurred while cancelling booking");
        }
    }
}