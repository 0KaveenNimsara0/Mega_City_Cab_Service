package com.example.mega_city_cab_service.service;

import com.example.mega_city_cab_service.dao.BookingDAO;
import com.example.mega_city_cab_service.dao.PaymentDAO;
import com.example.mega_city_cab_service.model.Booking;
import com.example.mega_city_cab_service.model.BookingDetails;
import com.example.mega_city_cab_service.model.Payment;

import java.sql.SQLException;
import java.util.List;

public class UserPaymentService {
    private final BookingDAO bookingDAO;
    private final PaymentDAO paymentDAO;

    public UserPaymentService() {
        this.bookingDAO = new BookingDAO();
        this.paymentDAO = new PaymentDAO();
    }


    public List<BookingDetails> getUserBookingsWithPayments(int customerId) throws SQLException {
        return bookingDAO.getBookingsWithPaymentsByCustomerId(customerId);
    }
}