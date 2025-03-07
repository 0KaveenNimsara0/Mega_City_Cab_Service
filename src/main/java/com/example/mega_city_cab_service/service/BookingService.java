package com.example.mega_city_cab_service.service;

import com.example.mega_city_cab_service.dao.BookingDAO;
import com.example.mega_city_cab_service.model.BookingDetails;

import java.sql.SQLException;
import java.util.List;

public class BookingService {

    private final BookingDAO bookingDAO = new BookingDAO();

    /**
     * Fetch all booking details for a specific customer.
     */
    public List<BookingDetails> getBookingsByCustomerID(String customerID) throws SQLException {
        return bookingDAO.getBookingsByCustomerID(customerID);

    }

}