package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.model.BookingDetails;
import com.example.mega_city_cab_service.service.UserPaymentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ViewPaymentsServlet extends HttpServlet {

    private final UserPaymentService userService;

    public ViewPaymentsServlet() {
        this.userService = new UserPaymentService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int customerId = (int) session.getAttribute("userId");

        try {
            List<BookingDetails> bookings = userService.getUserBookingsWithPayments(customerId);
            request.setAttribute("bookings", bookings);
            
            request.getRequestDispatcher("view_payments.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=An error occurred while fetching payment details");
        }
    }
}