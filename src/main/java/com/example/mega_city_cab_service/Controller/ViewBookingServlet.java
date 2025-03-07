package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.model.BookingDetails;
import com.example.mega_city_cab_service.service.BookingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


public class ViewBookingServlet extends HttpServlet {

    private final BookingService bookingService = new BookingService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.err.println("Processing GET request for /viewBookings"); // Debugging: Log request start

        // Retrieve session
        HttpSession session = request.getSession(false); // Do not create a new session
        if (session == null || session.getAttribute("userId") == null) {
            System.err.println("Session is invalid or username is missing. Redirecting to Login.jsp.");
            response.sendRedirect("Login.jsp");
            return; // Stop further execution of the servlet
        }

        // Retrieve customerID from session
        int id = (int) session.getAttribute("userId");
        String customerID = String.valueOf(id);
        System.err.println("Customer ID retrieved from session: " + customerID); // Debugging: Log customerID

        if (customerID == null || customerID.isEmpty()) {
            System.err.println("Error: Customer ID is null or empty in session.");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Customer ID not found in session.");
            return;
        }

        try {
            // Fetch bookings for the customer, including vehicle and driver details
            System.err.println("Fetching bookings for customerID: " + customerID); // Debugging: Log fetching process
            List<BookingDetails> bookings = bookingService.getBookingsByCustomerID(customerID);

            // Pass bookings to the JSP
            request.setAttribute("bookings", bookings);
            System.err.println("Bookings passed to request attribute. Total bookings: " + bookings.size());

            // Forward to the JSP page - CHANGE THIS LINE TO MATCH YOUR JSP FILE NAME
            System.err.println("Forwarding request to user_bookings.jsp");
            request.getRequestDispatcher("user_bookings.jsp").forward(request, response);

        } catch (SQLException e) {
            System.err.println("Database error occurred: " + e.getMessage()); // Debugging: Log SQL exception
            e.printStackTrace(); // Print stack trace for detailed debugging
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "A database error occurred.");
        } catch (Exception e) {
            System.err.println("Unexpected error occurred: " + e.getMessage()); // Debugging: Log unexpected errors
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
        }
    }
}