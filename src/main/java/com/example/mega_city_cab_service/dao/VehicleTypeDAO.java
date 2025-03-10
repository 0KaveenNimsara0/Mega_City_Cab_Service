package com.example.mega_city_cab_service.dao;

import com.example.mega_city_cab_service.Util.DatabaseConnection;
import com.example.mega_city_cab_service.model.VehicleType;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VehicleTypeDAO {
    private Connection connection;

    // Constructor: Use the singleton database connection
    public VehicleTypeDAO() {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }

    // Method to retrieve all vehicle types
    public List<VehicleType> getAllVehicleTypes() {
        List<VehicleType> vehicleTypes = new ArrayList<>();
        String GET_ALL_VEHICLE_TYPES_SQL = "SELECT * FROM vehicle_type";

        try (PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_VEHICLE_TYPES_SQL);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                vehicleTypes.add(new VehicleType(
                        resultSet.getInt("typeId"),
                        resultSet.getString("typeName"),
                        resultSet.getDouble("tax"),
                        resultSet.getDouble("perKmRate")
                ));
            }
        } catch (SQLException e) {
            System.err.println("Error fetching vehicle types: " + e.getMessage());
            e.printStackTrace();
        }
        return vehicleTypes;
    }

    // Method to retrieve a vehicle type by its ID
    public VehicleType getVehicleTypeById(int typeId) {
        String GET_VEHICLE_TYPE_BY_ID_SQL = "SELECT * FROM vehicle_type WHERE typeId = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(GET_VEHICLE_TYPE_BY_ID_SQL)) {
            preparedStatement.setInt(1, typeId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return new VehicleType(
                            resultSet.getInt("typeId"),
                            resultSet.getString("typeName"),
                            resultSet.getDouble("tax"),
                            resultSet.getDouble("perKmRate")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching vehicle type by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // Return null if no vehicle type is found
    }

    // Method to retrieve a vehicle type by its name
    public VehicleType getVehicleTypeByTypeName(String typeName) {
        String GET_VEHICLE_TYPE_BY_NAME_SQL = "SELECT * FROM vehicle_type WHERE typeName = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(GET_VEHICLE_TYPE_BY_NAME_SQL)) {
            preparedStatement.setString(1, typeName);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return new VehicleType(
                            resultSet.getInt("typeId"),
                            resultSet.getString("typeName"),
                            resultSet.getDouble("tax"),
                            resultSet.getDouble("perKmRate")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching vehicle type by name: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // Return null if no vehicle type is found
    }

    // Method to add a new vehicle type
    public boolean addVehicleType(VehicleType vehicleType) {
        String ADD_VEHICLE_TYPE_SQL = "INSERT INTO vehicle_type (typeName, tax, perKmRate) VALUES (?, ?, ?)";

        try (PreparedStatement preparedStatement = connection.prepareStatement(ADD_VEHICLE_TYPE_SQL)) {
            // Prepare the SQL statement
            preparedStatement.setString(1, vehicleType.getTypeName());
            preparedStatement.setDouble(2, vehicleType.getTax());
            preparedStatement.setDouble(3, vehicleType.getPerKmRate());

            // Execute the query
            int rowsAffected = preparedStatement.executeUpdate();

            // If one row is affected, insertion is successful
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error adding vehicle type: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Method to update a vehicle type
    public boolean updateVehicleType(VehicleType vehicleType) {
        String UPDATE_VEHICLE_TYPE_SQL = "UPDATE vehicle_type SET typeName = ?, tax = ?, perKmRate = ? WHERE typeId = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_VEHICLE_TYPE_SQL)) {
            // Prepare the SQL statement
            preparedStatement.setString(1, vehicleType.getTypeName());
            preparedStatement.setDouble(2, vehicleType.getTax());
            preparedStatement.setDouble(3, vehicleType.getPerKmRate());
            preparedStatement.setInt(4, vehicleType.getTypeId());

            // Execute the query
            int rowsAffected = preparedStatement.executeUpdate();

            // If one row is affected, update is successful
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error updating vehicle type: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Method to delete a vehicle type
    public boolean deleteVehicleType(int typeId) {
        String DELETE_VEHICLE_TYPE_SQL = "DELETE FROM vehicle_type WHERE typeId = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(DELETE_VEHICLE_TYPE_SQL)) {
            // Prepare the SQL statement
            preparedStatement.setInt(1, typeId);

            // Execute the query
            int rowsAffected = preparedStatement.executeUpdate();

            // If one row is affected, deletion is successful
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error deleting vehicle type: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}