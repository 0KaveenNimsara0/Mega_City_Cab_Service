package com.example.mega_city_cab_service.dao;

import com.example.mega_city_cab_service.Util.DatabaseConnection;
import com.example.mega_city_cab_service.model.Payment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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
}