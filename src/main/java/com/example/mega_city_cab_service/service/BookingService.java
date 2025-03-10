package com.example.mega_city_cab_service.service;

import com.example.mega_city_cab_service.dao.BookingDAO;
import com.example.mega_city_cab_service.dao.CarDAO;
import com.example.mega_city_cab_service.model.BookingDetails;
import com.example.mega_city_cab_service.model.Car;
import com.example.mega_city_cab_service.model.Payment;

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
    // Get all bookings
    public List<BookingDetails> getAllBookings() {
        try {
            return bookingDAO.getAllBookings();
        } catch (SQLException e) {
            System.err.println("Error retrieving bookings: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // Update booking status
    public boolean updateBookingStatus(int bookingID, String status) {
        try {
            return bookingDAO.updateBookingStatus(bookingID, status);
        } catch (SQLException e) {
            System.err.println("Error updating booking status: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Assign a car to a booking
    public boolean assignCarToBooking(int bookingID, String carId) {
        try {
            return bookingDAO.assignCarToBooking(bookingID, carId);
        } catch (SQLException e) {
            System.err.println("Error assigning car to booking: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    public Payment getPaymentDetailsByBookingId(int bookingId) {
        try {
            return bookingDAO.getPaymentDetailsByBookingId(bookingId);
        } catch (SQLException e) {
            System.err.println("Error fetching payment details: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // Return null if an error occurs
    }

    public Car getCarById(String carId) {
        try {
            return new CarDAO().getCarById(carId);
        } catch (SQLException e) {
            System.err.println("Error fetching car details: " + e.getMessage());
            return null;
        }
    }

    public BookingDetails getCarAndDriverDetailsByBookingId(int bookingId) {
        try {
            return bookingDAO.getCarAndDriverDetailsByBookingId(bookingId);
        } catch (SQLException e) {
            System.err.println("Error fetching car and driver details: " + e.getMessage());
            e.printStackTrace();
            return null; // Return null in case of exceptions
        }
    }
}