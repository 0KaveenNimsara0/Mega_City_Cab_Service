package com.example.mega_city_cab_service.dao;

import com.example.mega_city_cab_service.Util.DatabaseConnection;
import com.example.mega_city_cab_service.model.Payment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {
    private Connection connection;

    // Constructor: Use the singleton database connection
    public PaymentDAO() {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }

    // Method to add a new payment

    public boolean addPayment(Payment payment) throws SQLException {
        String query = "INSERT INTO payment (paymentId, bookingId, paymentMethod, amount, status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, payment.getPaymentId());
            preparedStatement.setString(2, payment.getBookingId()); // Include booking ID
            preparedStatement.setString(3, payment.getPaymentMethod());
            preparedStatement.setDouble(4, payment.getAmount());
            preparedStatement.setString(5, payment.getStatus());


            return preparedStatement.executeUpdate() > 0;
        }
    }
    public List<Payment> getPaymentsByBookingId(String bookingId) throws SQLException {
        String query = "SELECT * FROM payment WHERE bookingId = ?";
        List<Payment> payments = new ArrayList<>();

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, bookingId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Payment payment = new Payment();
                    payment.setPaymentId(resultSet.getString("paymentId"));
                    payment.setBookingId(resultSet.getString("bookingId"));
                    payment.setPaymentMethod(resultSet.getString("paymentMethod"));
                    payment.setAmount(resultSet.getDouble("amount"));
                    payment.setPaymentDate(resultSet.getTimestamp("paymentDate"));
                    payment.setStatus(resultSet.getString("status"));
                    payments.add(payment);
                }
            }
        }
        return payments;
    }
}