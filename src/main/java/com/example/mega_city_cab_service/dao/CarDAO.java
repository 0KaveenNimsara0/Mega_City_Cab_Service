package com.example.mega_city_cab_service.dao;

import com.example.mega_city_cab_service.model.Car;
import com.example.mega_city_cab_service.Util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CarDAO {
    private Connection connection;

    public CarDAO() {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }

    // Add a new car
    public boolean addCar(Car car) throws SQLException {
        String query = "INSERT INTO vehicle (carId, model, capacity, isAvailable, registrationNumber, driverId, typeId, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, car.getCarId());
            preparedStatement.setString(2, car.getModel());
            preparedStatement.setInt(3, car.getCapacity());
            preparedStatement.setBoolean(4, car.isAvailable());
            preparedStatement.setString(5, car.getRegistrationNumber());
            preparedStatement.setInt(6, car.getDriverId());
            preparedStatement.setInt(7, car.getTypeId());
            preparedStatement.setTimestamp(8, car.getCreatedAt());
            return preparedStatement.executeUpdate() > 0;
        }
    }

    // Get all cars
    public List<Car> getAllCars() throws SQLException {
        String query = "SELECT * FROM vehicle";
        List<Car> cars = new ArrayList<>();
        try (PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            while (resultSet.next()) {
                cars.add(new Car(
                        resultSet.getString("carId"),
                        resultSet.getString("model"),
                        resultSet.getInt("capacity"),
                        resultSet.getBoolean("isAvailable"),
                        resultSet.getString("registrationNumber"),
                        resultSet.getInt("driverId"),
                        resultSet.getInt("typeId"),
                        resultSet.getTimestamp("created_at")
                ));
            }
        }
        return cars;
    }

    // Update car details
    public boolean updateCar(Car car) throws SQLException {
        String query = "UPDATE vehicle SET model = ?, capacity = ?, isAvailable = ?, registrationNumber = ?, driverId = ?, typeId = ? WHERE carId = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, car.getModel());
            preparedStatement.setInt(2, car.getCapacity());
            preparedStatement.setBoolean(3, car.isAvailable());
            preparedStatement.setString(4, car.getRegistrationNumber());
            preparedStatement.setInt(5, car.getDriverId());
            preparedStatement.setInt(6, car.getTypeId());
            preparedStatement.setString(7, car.getCarId());
            return preparedStatement.executeUpdate() > 0;
        }
    }

    // Change car availability
    public boolean changeAvailability(String carId, boolean isAvailable) throws SQLException {
        String query = "UPDATE vehicle SET isAvailable = ? WHERE carId = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setBoolean(1, isAvailable);
            preparedStatement.setString(2, carId);
            return preparedStatement.executeUpdate() > 0;
        }
    }

    // Delete a car
    public boolean deleteCar(String carId) throws SQLException {
        String query = "DELETE FROM vehicle WHERE carId = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, carId);
            return preparedStatement.executeUpdate() > 0;
        }
    }

    // Method to retrieve a car by its ID
    public Car getCarById(String carId) throws SQLException {
        String query = "SELECT * FROM vehicle WHERE carId = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, carId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return new Car(
                            resultSet.getString("carId"),
                            resultSet.getString("model"),
                            resultSet.getInt("capacity"),
                            resultSet.getBoolean("isAvailable"),
                            resultSet.getString("registrationNumber"),
                            resultSet.getInt("driverId"),
                            resultSet.getInt("typeId"),
                            resultSet.getTimestamp("created_at")
                    );
                }
            }
        }
        return null; // Return null if no car is found
    }

    // Method to assign a driver to a car
    public boolean assignDriverToCar(String carId, int driverId) throws SQLException {
        String query = "UPDATE vehicle SET driverId = ? WHERE carId = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, driverId);
            preparedStatement.setString(2, carId);
            return preparedStatement.executeUpdate() > 0;
        }
    }


    public int addCarAndGetId(Car car) {
        String ADD_CAR_SQL = "INSERT INTO vehicle (model, capacity, isAvailable, registrationNumber, typeId, driverId, created_at) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement preparedStatement = connection.prepareStatement(ADD_CAR_SQL, Statement.RETURN_GENERATED_KEYS)) {
            // Set parameters for the prepared statement
            preparedStatement.setString(1, car.getModel());
            preparedStatement.setInt(2, car.getCapacity());
            preparedStatement.setBoolean(3, car.isAvailable());
            preparedStatement.setString(4, car.getRegistrationNumber());
            preparedStatement.setInt(5, car.getTypeId());

            if (car.getDriverId() > 0) {
                preparedStatement.setInt(6, car.getDriverId());
            } else {
                preparedStatement.setNull(6, Types.INTEGER);
            }

            preparedStatement.setTimestamp(7, car.getCreatedAt());

            // Execute the query
            int rowsAffected = preparedStatement.executeUpdate();

            // Retrieve the generated key (car ID)
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1); // Return the generated car ID
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error adding car: " + e.getMessage());
            e.printStackTrace();
        }
        return -1; // Return -1 if the operation fails
    }

    public boolean updateCarDriver(Car car) {
        String UPDATE_CAR_DRIVER_SQL = "UPDATE vehicle SET driverId = ? WHERE carId = ?";


        try (PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_CAR_DRIVER_SQL)) {
            // Set the driverId parameter
            if (car.getDriverId() > 0) {
                preparedStatement.setInt(1, car.getDriverId());
            } else {
                preparedStatement.setNull(1, Types.INTEGER);
            }

            // Set the carId parameter
            preparedStatement.setString(2, car.getCarId());

            // Execute the query
            int rowsAffected = preparedStatement.executeUpdate();

            // Return true if at least one row was updated
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating car driver: " + e.getMessage());
            e.printStackTrace();
        }

        return false; // Return false if the operation fails
    }
    // Method to fetch all available cars
    public List<Car> getAvailableCars() throws SQLException {
        String query = "SELECT * FROM vehicle WHERE isAvailable = 1 ";
        List<Car> availableCars = new ArrayList<>();

        try (PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Car car = new Car(
                        resultSet.getString("carId"),
                        resultSet.getString("model"),
                        resultSet.getInt("capacity"),
                        resultSet.getBoolean("isAvailable"),
                        resultSet.getString("registrationNumber"),
                        resultSet.getInt("driverId"), // This will be 0 if NULL in the database
                        resultSet.getInt("typeId"),
                        resultSet.getTimestamp("created_at")
                );
                availableCars.add(car);
            }
        }
        return availableCars;
    }


}