package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.dao.BookingDAO;
import com.example.mega_city_cab_service.dao.PaymentDAO;
import com.example.mega_city_cab_service.model.Booking;
import com.example.mega_city_cab_service.model.Payment;
import com.example.mega_city_cab_service.payment.PaymentContext;
import com.example.mega_city_cab_service.payment.CashPayment;
import com.example.mega_city_cab_service.payment.CardPayment;
import com.example.mega_city_cab_service.payment.PayPalPayment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.UUID;


public class PaymentServlet extends HttpServlet {
    private final PaymentDAO paymentDAO;
    private final BookingDAO bookingDAO;

    public PaymentServlet() {
        this.paymentDAO = new PaymentDAO();
        this.bookingDAO = new BookingDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve form data
            String paymentId = UUID.randomUUID().toString(); // Generate a unique payment ID
            String bookingId = request.getParameter("bookingId"); // Retrieve booking ID from the form
            double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
            String paymentMethod = request.getParameter("paymentMethod");

            Booking booking = bookingDAO.getBookingById(Integer.parseInt(bookingId));


            if (bookingId == null || bookingId.isEmpty()) {
                response.sendRedirect("error.jsp?message=Booking ID is missing");
                return;
            }

            // Process payment using Strategy Pattern
            PaymentContext paymentContext = new PaymentContext();

            switch (paymentMethod.toLowerCase()) {
                case "cash":
                    paymentContext.setPaymentStrategy(new CashPayment());
                    break;
                case "creditcard":
                    paymentContext.setPaymentStrategy(new CardPayment());
                    break;
                case "paypal":
                    paymentContext.setPaymentStrategy(new PayPalPayment());
                    break;
                default:
                    response.sendRedirect("error.jsp?message=Invalid payment method");
                    return;
            }

            // Process the payment
            boolean isPaymentSuccessful = paymentContext.processPayment(totalAmount);

            if (isPaymentSuccessful) {
                // Create Payment object
                Payment payment = new Payment();
                payment.setPaymentId(paymentId);
                payment.setBookingId(bookingId); // Set the booking ID
                payment.setPaymentMethod(paymentMethod);
                payment.setAmount(totalAmount);


                // Set payment status based on the payment method
                if ("cash".equalsIgnoreCase(paymentMethod)) {
                    payment.setStatus("Cash Payment");
                } else if (isPaymentSuccessful) {
                    payment.setStatus("Successfully Paid via " + paymentMethod.substring(0, 1).toUpperCase() + paymentMethod.substring(1));
                } else {
                    payment.setStatus("Payment Failed");
                }

                // Save payment details to the database
                boolean isPaymentSaved = paymentDAO.addPayment(payment);

                if (isPaymentSaved) {

                    request.setAttribute("bookingId", bookingId);

                    request.setAttribute("totalAmount", totalAmount);
                    request.setAttribute("bookingId", booking.getBookingID());
                    request.setAttribute("pickupPoint", booking.getPickupPoint());
                    request.setAttribute("destination", booking.getDestination());
                    request.setAttribute("carType", booking.getCarType());
                    request.setAttribute("pickupDate", booking.getPickupDate().toString());
                    request.setAttribute("couponCode", booking.getCouponCode());
                    request.setAttribute("amount", booking.getAmount());

                    request.getRequestDispatcher("thank_you.jsp").forward(request, response);
                } else {
                    response.sendRedirect("error.jsp?message=Failed to save payment details");
                }
            } else {
                // Payment failed or was canceled
                Payment payment = new Payment();
                payment.setPaymentId(UUID.randomUUID().toString());
                payment.setBookingId(bookingId);
                payment.setPaymentMethod(paymentMethod);
                payment.setAmount(totalAmount);
                payment.setStatus("Payment Cancelled");
                payment.setPaymentDate(new Timestamp(System.currentTimeMillis()));

                // Save payment details with "Payment Cancelled" status
                boolean isPaymentSaved = paymentDAO.addPayment(payment);

                if (isPaymentSaved) {
                    // Update booking status to "Booking Cancelled"
                    bookingDAO.updateBookingStatus(bookingId, "Booking Cancelled");
                    response.sendRedirect("error.jsp?message=Payment cancelled. Booking has been marked as cancelled.");
                } else {
                    response.sendRedirect("error.jsp?message=Failed to save payment details");
                }
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp?message=Invalid input format. Please check your inputs.");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Database error occurred");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=An unexpected error occurred");
        }
    }
}