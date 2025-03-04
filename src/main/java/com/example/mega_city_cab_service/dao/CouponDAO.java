package com.example.mega_city_cab_service.dao;

import com.example.mega_city_cab_service.Util.DatabaseConnection;
import com.example.mega_city_cab_service.model.Coupon;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CouponDAO {

    // Reference to the database connection (kept open)
    private Connection connection;

    // Constructor to initialize the connection
    public CouponDAO() {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }

    // Method to retrieve a coupon by its code
    public Coupon getCouponByCode(String couponCode) {
        String GET_COUPON_BY_CODE_SQL = "SELECT * FROM coupon WHERE couponCode = ? AND validUntil >= CURDATE()";
        try (PreparedStatement preparedStatement = connection.prepareStatement(GET_COUPON_BY_CODE_SQL)) {
            preparedStatement.setString(1, couponCode);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return new Coupon(
                            resultSet.getInt("couponId"),
                            resultSet.getString("couponCode"),
                            resultSet.getDouble("discountPercentage"),
                            resultSet.getDate("validUntil"),
                            resultSet.getString("description"),
                            resultSet.getDate("created_at")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving coupon by code: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // Return null if no valid coupon is found
    }

    // Method to retrieve all active coupons
    public List<Coupon> getAllActiveCoupons() {
        String GET_ALL_ACTIVE_COUPONS_SQL = "SELECT * FROM coupon WHERE validUntil >= CURDATE()";
        List<Coupon> coupons = new ArrayList<>();
        try (PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_ACTIVE_COUPONS_SQL);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                coupons.add(new Coupon(
                        resultSet.getInt("couponId"),
                        resultSet.getString("couponCode"),
                        resultSet.getDouble("discountPercentage"),
                        resultSet.getDate("validUntil"),
                        resultSet.getString("description"),
                        resultSet.getDate("created_at")
                ));
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving active coupons: " + e.getMessage());
            e.printStackTrace();
        }
        return coupons;
    }

    // Method to insert a new coupon into the database
    public boolean addCoupon(Coupon coupon) {
        String ADD_COUPON_SQL = "INSERT INTO coupon (couponCode, discountPercentage, validUntil, description) VALUES (?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(ADD_COUPON_SQL)) {
            preparedStatement.setString(1, coupon.getCouponCode());
            preparedStatement.setDouble(2, coupon.getDiscountPercentage());
            preparedStatement.setDate(3, coupon.getValidUntil());
            preparedStatement.setString(4, coupon.getDescription());

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0; // Return true if one or more rows are affected

        } catch (SQLException e) {
            System.err.println("Error adding coupon: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Method to delete an expired or invalid coupon
    public boolean deleteCoupon(int couponId) {
        String DELETE_COUPON_SQL = "DELETE FROM coupon WHERE couponId = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(DELETE_COUPON_SQL)) {
            preparedStatement.setInt(1, couponId);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0; // Return true if one or more rows are affected

        } catch (SQLException e) {
            System.err.println("Error deleting coupon: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}