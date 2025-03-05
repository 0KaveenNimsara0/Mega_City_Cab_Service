package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.dao.BookingDAO;
import com.example.mega_city_cab_service.model.Booking;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

public class BookingServlet extends HttpServlet {
    private final BookingDAO bookingDAO;

    public BookingServlet() {
        this.bookingDAO = new BookingDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve form parameters
            int pickupPoint = Integer.parseInt(request.getParameter("pickupPoint"));
            int destination = Integer.parseInt(request.getParameter("destination"));
            String carType = request.getParameter("carType");
            String pickupDate = request.getParameter("pickupDate");
            String couponCode = request.getParameter("couponCode");
            double distance = Double.parseDouble(request.getParameter("distance"));
            double tax = Double.parseDouble(request.getParameter("tax"));
            double perKmRate = Double.parseDouble(request.getParameter("perKmRate"));
            double discount = Double.parseDouble(request.getParameter("discount"));
            double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));

            // Validate user session
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Retrieve user ID from session
            int userId = (int) session.getAttribute("userId");

            // Create a new Booking object
            Booking booking = new Booking();
            booking.setCustomerID(userId); // Set user ID from session
            booking.setPickupPoint(pickupPoint); // Pickup point as an ID
            booking.setDestination(destination); // Destination as an ID
            booking.setPickupDate(Timestamp.valueOf(LocalDateTime.parse(pickupDate)));
            booking.setCarType(carType);
            booking.setAmount(totalAmount);
            booking.setStatus("Pending");
            booking.setCouponCode(couponCode);

            // Save the booking to the database
            boolean isBooked = bookingDAO.addBooking(booking);

            if (isBooked) {
                // Forward to payment page with total amount
                request.setAttribute("totalAmount", totalAmount);
                request.getRequestDispatcher("payment.jsp").forward(request, response);
            } else {
                response.sendRedirect("error.jsp?message=Failed to confirm booking");
            }
        } catch (SQLException e) {
            response.sendRedirect("error.jsp?message=Database error occurred");
        } catch (Exception e) {
            response.sendRedirect("error.jsp?message=An unexpected error occurred");
        }
    }
}