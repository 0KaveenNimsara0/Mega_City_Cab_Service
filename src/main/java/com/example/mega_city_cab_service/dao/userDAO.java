package com.example.mega_city_cab_service.dao;

import com.example.mega_city_cab_service.Util.DatabaseConnection;
import com.example.mega_city_cab_service.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
        String GET_USER_SQL = "SELECT * FROM customers WHERE username = ? OR email = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(GET_USER_SQL)) {
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
        } catch (SQLException e) {
            System.err.println("Error retrieving user: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
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
            System.err.println("Error retrieving user by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // Return null if no user is found
    }

    /**
     * Updates a user's profile in the database.
     *
     * @param user The updated User object.
     * @return True if the update was successful, false otherwise.
     */
    public boolean updateUserProfile(User user) {
        String UPDATE_USER_SQL = "UPDATE customers SET name = ?, email = ?, phone = ?, address = ?, nic = ? WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USER_SQL)) {
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
}