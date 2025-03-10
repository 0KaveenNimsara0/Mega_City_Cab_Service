package com.example.mega_city_cab_service.dao;

import com.example.mega_city_cab_service.Util.DatabaseConnection;
import com.example.mega_city_cab_service.model.Payment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {
    private Connection connection;

    // Constructor: Use the singleton database connection
    public PaymentDAO() {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }

    // Method to add a new payment
    public boolean addPayment(Payment payment) {
        String ADD_PAYMENT_SQL = "INSERT INTO payment (paymentId, bookingId, paymentMethod, amount, status) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement preparedStatement = connection.prepareStatement(ADD_PAYMENT_SQL)) {
            // Prepare the SQL statement
            preparedStatement.setString(1, payment.getPaymentId());
            preparedStatement.setString(2, payment.getBookingId()); // Include booking ID
            preparedStatement.setString(3, payment.getPaymentMethod());
            preparedStatement.setDouble(4, payment.getAmount());
            preparedStatement.setString(5, payment.getStatus());

            // Execute the query
            int rowsAffected = preparedStatement.executeUpdate();

            // If one row is affected, insertion is successful
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error adding payment: " + e.getMessage());
            e.printStackTrace();
        }
        return false; // Return false if the insertion fails
    }

    // Method to retrieve payments by booking ID
    public List<Payment> getPaymentsByBookingId(String bookingId) {
        String GET_PAYMENTS_BY_BOOKING_ID_SQL = "SELECT * FROM payment WHERE bookingId = ?";
        List<Payment> payments = new ArrayList<>();

        try (PreparedStatement preparedStatement = connection.prepareStatement(GET_PAYMENTS_BY_BOOKING_ID_SQL)) {
            // Set the query parameter for booking ID
            preparedStatement.setString(1, bookingId);

            // Execute the query
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Payment payment = new Payment();
                    payment.setPaymentId(resultSet.getString("paymentId"));
                    payment.setBookingId(resultSet.getString("bookingId"));
                    payment.setPaymentMethod(resultSet.getString("paymentMethod"));
                    payment.setAmount(resultSet.getDouble("amount"));
                    payment.setPaymentDate(resultSet.getTimestamp("paymentDate"));
                    payment.setStatus(resultSet.getString("status"));

                    payments.add(payment); // Add the payment to the list
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching payments by booking ID: " + e.getMessage());
            e.printStackTrace();
        }
        return payments; // Return the list of payments (empty if none found)
    }
}