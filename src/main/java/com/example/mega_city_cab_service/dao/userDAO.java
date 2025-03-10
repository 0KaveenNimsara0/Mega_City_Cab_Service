package com.example.mega_city_cab_service.dao;

import com.example.mega_city_cab_service.Util.DatabaseConnection;
import com.example.mega_city_cab_service.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class userDAO {

    // Reference to the database connection (kept open)
    private Connection connection;

    // Constructor to initialize the connection
    public userDAO() {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }

    // Method to register a new user
    public boolean registerUser(User user) {
        String REGISTER_USER_SQL = "INSERT INTO customers(username, password, email, phone, name) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement preparedStatement = connection.prepareStatement(REGISTER_USER_SQL)) {
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

        } catch (SQLException e) {
            System.err.println("Error registering user: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Method to retrieve a user by username or email
    public User getUserByUsernameOrEmail(String usernameOrEmail) {
        String GET_USER_BY_USERNAME_OR_EMAIL_SQL = "SELECT * FROM customers WHERE username = ? OR email = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(GET_USER_BY_USERNAME_OR_EMAIL_SQL)) {
            // Set the query parameters for username and email
            preparedStatement.setString(1, usernameOrEmail);
            preparedStatement.setString(2, usernameOrEmail);

            // Execute the query
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    // Create a new User object and populate its fields
                    User user = new User(
                            resultSet.getInt("id"),                // Customer ID
                            resultSet.getString("username"),       // Username
                            resultSet.getString("password"),       // Password
                            resultSet.getString("name"),           // Name
                            resultSet.getString("email"),          // Email
                            resultSet.getString("phone"),          // Phone
                            resultSet.getString("address"),        // Address
                            resultSet.getString("nic")             // NIC
                    );

                    // Set the user's status
                    user.setStatus(resultSet.getString("status"));

                    return user; // Return the populated User object
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching user by username or email: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // Return null if no user is found
    }

    // Method to explicitly close the connection when needed
    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("Database connection closed.");
            }
        } catch (SQLException e) {
            System.err.println("Error closing connection: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Method to retrieve a user by ID
    public User getUserById(int customerId) {
        String GET_USER_BY_ID_SQL = "SELECT * FROM customers WHERE id = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(GET_USER_BY_ID_SQL)) {
            preparedStatement.setInt(1, customerId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return new User(
                            resultSet.getInt("id"),
                            resultSet.getString("username"),
                            resultSet.getString("password"),
                            resultSet.getString("name"),
                            resultSet.getString("email"),
                            resultSet.getString("phone"),
                            resultSet.getString("address"),
                            resultSet.getString("nic")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching user by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // Return null if no user is found
    }

    // Method to update a user's profile
    public boolean updateUserProfile(User user) {
        String UPDATE_USER_PROFILE_SQL = "UPDATE customers SET name = ?, email = ?, phone = ?, address = ?, nic = ? WHERE id = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USER_PROFILE_SQL)) {
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getPhone());
            preparedStatement.setString(4, user.getAddress());
            preparedStatement.setString(5, user.getNic());
            preparedStatement.setInt(6, user.getCustomerId());

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0; // Return true if at least one row was updated

        } catch (SQLException e) {
            System.err.println("Error updating user profile: " + e.getMessage());
            e.printStackTrace();
        }
        return false; // Return false if the update fails
    }

    // Method to fetch all users
    public List<User> getAllUsers() {
        String GET_ALL_USERS_SQL = "SELECT * FROM customers";
        List<User> users = new ArrayList<>();

        try (PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_USERS_SQL);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                User user = new User(
                        resultSet.getInt("id"),
                        resultSet.getString("username"),
                        resultSet.getString("password"),
                        resultSet.getString("name"),
                        resultSet.getString("email"),
                        resultSet.getString("phone"),
                        resultSet.getString("address"),
                        resultSet.getString("nic")
                );
                user.setStatus(resultSet.getString("status"));
                users.add(user);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching all users: " + e.getMessage());
            e.printStackTrace();
        }
        return users;
    }

    // Method to update a user's status
    public boolean updateUserStatus(int userId, String status) {
        String UPDATE_USER_STATUS_SQL = "UPDATE customers SET status = ? WHERE id = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USER_STATUS_SQL)) {
            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, userId);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0; // Returns true if rows were updated

        } catch (SQLException e) {
            System.err.println("Error updating user status: " + e.getMessage());
            e.printStackTrace();
        }
        return false; // Return false if an error occurs
    }
}