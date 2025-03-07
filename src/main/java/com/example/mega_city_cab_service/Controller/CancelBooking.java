//this method use customer add booking part

package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.dao.BookingDAO;
import com.example.mega_city_cab_service.dao.PaymentDAO;
import com.example.mega_city_cab_service.model.Payment;
import jakarta.servlet.ServletException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.UUID;


public class CancelBooking extends HttpServlet {
    private final BookingDAO bookingDAO;
    private final PaymentDAO paymentDAO;

    public CancelBooking() {
        this.bookingDAO = new BookingDAO();
        this.paymentDAO = new PaymentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve booking ID from the request
            String bookingId = request.getParameter("bookingId");

            if (bookingId == null || bookingId.isEmpty()) {
                response.sendRedirect("error.jsp?message=Booking ID is missing");
                return;
            }

            // Update payment status to "Payment Cancelled"
            Payment payment = new Payment();
            payment.setPaymentId(UUID.randomUUID().toString());
            payment.setBookingId(bookingId);
            payment.setPaymentMethod("Cancelled");
            payment.setAmount(0.0);
            payment.setStatus("Payment Cancelled");


            boolean isPaymentSaved = paymentDAO.addPayment(payment);

            if (!isPaymentSaved) {
                response.sendRedirect("error.jsp?message=Failed to update payment status");
                return;
            }

            // Update booking status to "Booking Cancelled"
            boolean isBookingUpdated = bookingDAO.updateBookingStatus(bookingId, "Booking Cancelled");

            if (isBookingUpdated) {
                response.sendRedirect("thank_you.jsp?message=Booking and payment successfully cancelled");
            } else {
                response.sendRedirect("error.jsp?message=Failed to cancel booking");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Database error occurred");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=An unexpected error occurred");
        }
    }
}