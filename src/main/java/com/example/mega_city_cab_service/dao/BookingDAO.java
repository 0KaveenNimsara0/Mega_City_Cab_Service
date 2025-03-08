package com.example.mega_city_cab_service.dao;

import com.example.mega_city_cab_service.Util.DatabaseConnection;
import com.example.mega_city_cab_service.model.Booking;
import com.example.mega_city_cab_service.model.BookingDetails;

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

   // Method to retrieve a booking by its ID
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

    //Method to get booking detail
    public List<BookingDetails> getBookingsByCustomerID(String customerID) throws SQLException {
        List<BookingDetails> bookings = new ArrayList<>();
        String query = "SELECT b.bookingID, l1.location_name AS pickupPointName, l2.location_name AS destinationName, " +
                "vt.typeName AS carTypeName, b.pickupDate, b.amount, b.status, b.couponCode, b.carId " +
                "FROM booking b " +
                "JOIN locations l1 ON b.pickupPoint = l1.location_id " +
                "JOIN locations l2 ON b.destination = l2.location_id " +
                "JOIN vehicle_type vt ON b.carType = vt.typeId " +
                "WHERE b.customerID = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, customerID);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    BookingDetails booking = new BookingDetails();
                    booking.setBookingID(resultSet.getInt("bookingID"));
                    booking.setPickupPointName(resultSet.getString("pickupPointName"));
                    booking.setDestinationName(resultSet.getString("destinationName"));
                    booking.setCarTypeName(resultSet.getString("carTypeName"));
                    booking.setPickupDate(resultSet.getDate("pickupDate"));
                    booking.setAmount(resultSet.getDouble("amount"));
                    booking.setStatus(resultSet.getString("status"));
                    booking.setCouponCode(resultSet.getString("couponCode"));
                    booking.setCarId(resultSet.getString("carId"));


                    // Fetch vehicle and driver details using carId
                    String carId = resultSet.getString("carId");
                    if (carId != null) {
                        fetchVehicleAndDriverDetails(booking, carId);
                    }

                    bookings.add(booking);
                }
            }
        }

        return bookings;
    }

    private void fetchVehicleAndDriverDetails(BookingDetails booking, String carId) throws SQLException {
        String vehicleQuery = "SELECT v.model, v.registrationNumber, d.name AS driverName, d.phone AS driverPhone " +
                "FROM vehicle v " +
                "JOIN driver d ON v.driverId = d.driverId " +
                "WHERE v.carId = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(vehicleQuery)) {
            preparedStatement.setString(1, carId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    booking.setVehicleModel(resultSet.getString("model"));
                    booking.setVehicleRegistration(resultSet.getString("registrationNumber"));
                    booking.setDriverName(resultSet.getString("driverName"));
                    booking.setDriverPhone(resultSet.getString("driverPhone"));
                }
            }
        }
    }

    public boolean cancelBooking(String bookingId) throws SQLException {
        String query = "UPDATE booking SET status = 'Cancelled' WHERE bookingID = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, bookingId);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0; // Return true if at least one row was updated
        }
    }

    public List<BookingDetails> getBookingsWithPaymentsByCustomerId(int customerId) throws SQLException {
        String query = "SELECT b.bookingID, l1.location_name AS pickupPointName, l2.location_name AS destinationName, " +
                "vt.typeName AS carTypeName, b.pickupDate, b.amount AS bookingAmount, b.status AS bookingStatus, " +
                "b.couponCode, b.carId, p.paymentId, p.paymentMethod, p.amount AS paymentAmount, " +
                "p.paymentDate, p.status AS paymentStatus " +
                "FROM booking b " +
                "JOIN locations l1 ON b.pickupPoint = l1.location_id " +
                "JOIN locations l2 ON b.destination = l2.location_id " +
                "JOIN vehicle_type vt ON b.carType = vt.typeId " +
                "LEFT JOIN payment p ON b.bookingID = p.bookingId " +
                "WHERE b.customerID = ?";

        List<BookingDetails> bookings = new ArrayList<>();

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, customerId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    BookingDetails booking = new BookingDetails();
                    booking.setBookingID(resultSet.getInt("bookingID"));
                    booking.setPickupPointName(resultSet.getString("pickupPointName"));
                    booking.setDestinationName(resultSet.getString("destinationName"));
                    booking.setCarTypeName(resultSet.getString("carTypeName"));
                    booking.setPickupDate(resultSet.getDate("pickupDate"));
                    booking.setAmount(resultSet.getDouble("bookingAmount"));
                    booking.setStatus(resultSet.getString("bookingStatus"));
                    booking.setCouponCode(resultSet.getString("couponCode"));
                    booking.setCarId(resultSet.getString("carId"));

                    // Payment details
                    booking.setPaymentId(resultSet.getString("paymentId"));
                    booking.setPaymentMethod(resultSet.getString("paymentMethod")!= null ? resultSet.getString("paymentMethod") : "N/A");
                    booking.setPaymentAmount(resultSet.getDouble("paymentAmount")); // Add this field to BookingDetails
                    booking.setPaymentDate(resultSet.getTimestamp("paymentDate"));
                    booking.setPaymentStatus(resultSet.getString("paymentStatus")!= null ? resultSet.getString("paymentMethod") : "N/A");

                    bookings.add(booking);
                }
            }
        }
        return bookings;
    }
}