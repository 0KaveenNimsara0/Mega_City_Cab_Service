package com.example.mega_city_cab_service.dao;

import com.example.mega_city_cab_service.Util.DatabaseConnection;
import com.example.mega_city_cab_service.model.User;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class userDAO {

    //register New Customer
    public boolean registerUser(User user) {

        // Get database connection
        String REGISTER_USER_SQL = "INSERT INTO customers(username, password, email, phone, name) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(REGISTER_USER_SQL)) {


            // Prepare the SQL statement

            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setString(4, user.getPhone());
            preparedStatement.setString(5, user.getName());


            // Execute the query
            int rowsAffected = preparedStatement.executeUpdate();


            // If one row is affected, registration is successful
            return rowsAffected > 0;
        } catch (Exception e) {
            System.err.println("Error registering user: " + e.getMessage());
            e.printStackTrace();

        }
        return false;
    }
    public User getUserByUsernameOrEmail(String usernameOrEmail) {
        String GET_USER_SQL = "SELECT * FROM customers WHERE username  = ?  OR email = ?";
        try (Connection connection = DatabaseConnection.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_USER_SQL)) {

            preparedStatement.setString(1, usernameOrEmail);
            preparedStatement.setString(2, usernameOrEmail);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int customerId = resultSet.getInt("id");
                String username = resultSet.getString("username");
                String password = resultSet.getString("password");
                String email = resultSet.getString("email");
                String phone = resultSet.getString("phone");
                String name = resultSet.getString("name");

                return new User(customerId, username, password, name, email, phone);
            }
        } catch (Exception e) {
            System.err.println("Error retrieving user: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

}


