package com.example.mega_city_cab_service.dao;

import com.example.mega_city_cab_service.Util.DatabaseConnection;
import com.example.mega_city_cab_service.model.Booking;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    private Connection connection;

    // Constructor: Use the singleton database connection
    public BookingDAO() {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }

    // Method to add a new booking
    public boolean addBooking(Booking booking) throws SQLException {
        String query = "INSERT INTO booking (customerID, pickupPoint, destination, pickupDate, carType, amount, status, couponCode) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setInt(1, booking.getCustomerID());
            preparedStatement.setInt(2, booking.getPickupPoint());
            preparedStatement.setInt(3, booking.getDestination());
            preparedStatement.setTimestamp(4, booking.getPickupDate());
            preparedStatement.setString(5, booking.getCarType());
            preparedStatement.setDouble(6, booking.getAmount());
            preparedStatement.setString(7, booking.getStatus());
            preparedStatement.setString(8, booking.getCouponCode());

            int rowsAffected = preparedStatement.executeUpdate();

            // Retrieve the auto-generated bookingID if needed
            try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    booking.setBookingID(Integer.parseInt(generatedKeys.getString(1))); // Set the generated bookingID in the Booking object
                }
            }

            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error adding booking: " + e.getMessage());
            throw e; // Re-throw the exception for proper handling in the calling layer
        }
    }

//    // Method to retrieve all bookings
//    public List<Booking> getAllBookings() throws SQLException {
//        List<Booking> bookings = new ArrayList<>();
//        String query = "SELECT * FROM booking";
//
//        try (PreparedStatement preparedStatement = connection.prepareStatement(query);
//             ResultSet resultSet = preparedStatement.executeQuery()) {
//
//            while (resultSet.next()) {
//                bookings.add(new Booking(
//                        resultSet.getString("bookingID"),
//                        resultSet.getInt("customerID"), // Changed to int as customerID is likely an integer
//                        resultSet.getInt("pickupPoint"), // Changed to int as pickupPoint is likely an integer
//                        resultSet.getInt("destination"), // Changed to int as destination is likely an integer
//                        resultSet.getTimestamp("pickupDate"),
//                        resultSet.getString("carType"),
//                        resultSet.getDouble("amount"),
//                        resultSet.getString("status"),
//                        resultSet.getString("couponCode"),
//                        resultSet.getTimestamp("bookedDate")
//                ));
//            }
//        } catch (SQLException e) {
//            System.err.println("Error retrieving bookings: " + e.getMessage());
//            throw e; // Re-throw the exception for proper handling in the calling layer
//        }
//        return bookings;
//    }
//
//    // Method to retrieve a booking by its ID
public Booking getBookingById(int bookingID) throws SQLException {
    String query = "SELECT * FROM booking WHERE bookingID = ?";
    try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
        preparedStatement.setInt(1, bookingID);

        try (ResultSet resultSet = preparedStatement.executeQuery()) {
            if (resultSet.next()) {
                // Map the result set to a Booking object
                Booking booking = new Booking();
                booking.setBookingID(resultSet.getInt("bookingID"));
                booking.setCustomerID(resultSet.getInt("customerID"));
                booking.setPickupPoint(resultSet.getInt("pickupPoint"));
                booking.setDestination(resultSet.getInt("destination"));
                booking.setPickupDate(resultSet.getTimestamp("pickupDate"));
                booking.setCarType(resultSet.getString("carType"));
                booking.setAmount(resultSet.getDouble("amount"));
                booking.setStatus(resultSet.getString("status"));
                booking.setCouponCode(resultSet.getString("couponCode"));

                return booking;
            }
        }
    } catch (SQLException e) {
        System.err.println("Error retrieving booking by ID: " + e.getMessage());
        throw e; // Re-throw the exception for proper handling in the calling layer
    }
    return null; // Return null if no booking is found
}


    // Method to update a booking's status
    public boolean updateBookingStatus(String bookingID, String status) throws SQLException {
        String query = "UPDATE booking SET status = ? WHERE bookingID = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, status);
            preparedStatement.setString(2, bookingID);

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating booking status: " + e.getMessage());
            throw e; // Re-throw the exception for proper handling in the calling layer
        }
    }

    // Method to delete a booking
    public boolean deleteBooking(String bookingID) throws SQLException {
        String query = "DELETE FROM booking WHERE bookingID = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, bookingID);

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting booking: " + e.getMessage());
            throw e; // Re-throw the exception for proper handling in the calling layer
        }
    }
    // Method to get the latest booking ID
    public String getLatestBookingId() throws SQLException {
        String query = "SELECT MAX(bookingID) AS latestBookingId FROM booking";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getString("latestBookingId");
            }
        }
        return null;
    }
}