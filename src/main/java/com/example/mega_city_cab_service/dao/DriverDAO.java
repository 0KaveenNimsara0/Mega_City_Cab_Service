package com.example.mega_city_cab_service.dao;

import com.example.mega_city_cab_service.Util.DatabaseConnection;
import com.example.mega_city_cab_service.model.Driver;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DriverDAO {
    private Connection connection;

    // Constructor: Use the singleton database connection
    public DriverDAO() {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }


    public Driver getDriverById(int driverId) {
        String GET_DRIVER_BY_ID_SQL = "SELECT * FROM driver WHERE driverId = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(GET_DRIVER_BY_ID_SQL)) {
            preparedStatement.setInt(1, driverId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return new Driver(
                            resultSet.getInt("driverId"),
                            resultSet.getString("name"),
                            resultSet.getString("phone"),
                            resultSet.getString("email"),
                            resultSet.getString("licenseNumber"),
                            resultSet.getBoolean("isAvailable"),
                            resultSet.getTimestamp("created_at")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving driver by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // Return null if no driver is found
    }


    public Driver getDriverByPhone(String phone) {
        String GET_DRIVER_BY_PHONE_SQL = "SELECT * FROM driver WHERE phone = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(GET_DRIVER_BY_PHONE_SQL)) {
            preparedStatement.setString(1, phone);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return new Driver(
                            resultSet.getInt("driverId"),
                            resultSet.getString("name"),
                            resultSet.getString("phone"),
                            resultSet.getString("email"),
                            resultSet.getString("licenseNumber"),
                            resultSet.getBoolean("isAvailable"),
                            resultSet.getTimestamp("created_at")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving driver by phone: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // Return null if no driver is found
    }


    public List<Driver> getAllDrivers() {
        List<Driver> drivers = new ArrayList<>();
        String GET_ALL_DRIVERS_SQL = "SELECT * FROM driver";

        try (PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_DRIVERS_SQL);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                drivers.add(new Driver(
                        resultSet.getInt("driverId"),
                        resultSet.getString("name"),
                        resultSet.getString("phone"),
                        resultSet.getString("email"),
                        resultSet.getString("licenseNumber"),
                        resultSet.getBoolean("isAvailable"),
                        resultSet.getTimestamp("created_at")
                ));
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving all drivers: " + e.getMessage());
            e.printStackTrace();
        }

        return drivers; // Return an empty list if no drivers are found
    }


    public List<Driver> getAvailableDrivers() {
        List<Driver> drivers = new ArrayList<>();
        String GET_AVAILABLE_DRIVERS_SQL = "SELECT * FROM driver WHERE isAvailable = 1";

        try (PreparedStatement preparedStatement = connection.prepareStatement(GET_AVAILABLE_DRIVERS_SQL);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                drivers.add(new Driver(
                        resultSet.getInt("driverId"),
                        resultSet.getString("name"),
                        resultSet.getString("phone"),
                        resultSet.getString("email"),
                        resultSet.getString("licenseNumber"),
                        resultSet.getBoolean("isAvailable"),
                        resultSet.getTimestamp("created_at")
                ));
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving available drivers: " + e.getMessage());
            e.printStackTrace();
        }

        return drivers; // Return an empty list if no available drivers are found
    }



    public boolean addDriver(Driver driver) {
        String ADD_DRIVER_SQL = "INSERT INTO driver (name, phone, email, licenseNumber, isAvailable, created_at) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(ADD_DRIVER_SQL)) {
            preparedStatement.setString(1, driver.getName());
            preparedStatement.setString(2, driver.getPhone());
            preparedStatement.setString(3, driver.getEmail());
            preparedStatement.setString(4, driver.getLicenseNumber());
            preparedStatement.setBoolean(5, driver.isAvailable());
            preparedStatement.setTimestamp(6, driver.getCreatedAt());

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error adding driver: " + e.getMessage());
            e.printStackTrace();
        }
        return false; // Return false if the operation fails
    }


    public boolean updateDriver(Driver driver) {
        String UPDATE_DRIVER_SQL = "UPDATE driver SET name = ?, phone = ?, email = ?, licenseNumber = ?, isAvailable = ? WHERE driverId = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_DRIVER_SQL)) {
            preparedStatement.setString(1, driver.getName());
            preparedStatement.setString(2, driver.getPhone());
            preparedStatement.setString(3, driver.getEmail());
            preparedStatement.setString(4, driver.getLicenseNumber());
            preparedStatement.setBoolean(5, driver.isAvailable());
            preparedStatement.setInt(6, driver.getDriverId());

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating driver: " + e.getMessage());
            e.printStackTrace();
        }
        return false; // Return false if the operation fails
    }


    public boolean deleteDriver(int driverId) {
        String DELETE_DRIVER_SQL = "DELETE FROM driver WHERE driverId = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(DELETE_DRIVER_SQL)) {
            preparedStatement.setInt(1, driverId);

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting driver: " + e.getMessage());
            e.printStackTrace();
        }
        return false; // Return false if the operation fails
    }

    public int addDriverAndGetId(Driver driver) throws SQLException {
        String query = "INSERT INTO Driver (name, phone, email, licenseNumber, isAvailable, created_at) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, driver.getName());
            statement.setString(2, driver.getPhone());
            statement.setString(3, driver.getEmail());
            statement.setString(4, driver.getLicenseNumber());
            statement.setBoolean(5, driver.isAvailable());
            statement.setTimestamp(6, driver.getCreatedAt());

            int rowsInserted = statement.executeUpdate();

            if (rowsInserted > 0) {
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1); // Return the generated driver ID
                }
            }
        }
        return -1; // Return -1 if insertion fails
    }
}