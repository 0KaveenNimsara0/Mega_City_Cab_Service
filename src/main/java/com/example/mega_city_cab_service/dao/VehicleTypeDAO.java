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
    public List<VehicleType> getAllVehicleTypes() throws SQLException {
        List<VehicleType> vehicleTypes = new ArrayList<>();
        String query = "SELECT * FROM vehicle_type";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                vehicleTypes.add(new VehicleType(
                        resultSet.getInt("typeId"),
                        resultSet.getString("typeName"),
                        resultSet.getDouble("tax"),
                        resultSet.getDouble("perKmRate")
                ));
            }
        }
        return vehicleTypes;
    }

    // Method to retrieve a vehicle type by its ID
    public VehicleType getVehicleTypeById(int typeId) throws SQLException {
        String query = "SELECT * FROM vehicle_type WHERE typeId = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
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
        }
        return null; // Return null if no vehicle type is found
    }

    // Method to retrieve a vehicle type by its name
    public VehicleType getVehicleTypeByTypeName(String typeName) throws SQLException {
        String query = "SELECT * FROM vehicle_type WHERE typeName = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
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
        }
        return null; // Return null if no vehicle type is found
    }

    // Method to add a new vehicle type
    public boolean addVehicleType(VehicleType vehicleType) throws SQLException {
        String query = "INSERT INTO vehicle_type (typeName, tax, perKmRate) VALUES (?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, vehicleType.getTypeName());
            preparedStatement.setDouble(2, vehicleType.getTax());
            preparedStatement.setDouble(3, vehicleType.getPerKmRate());

            return preparedStatement.executeUpdate() > 0;
        }
    }

    // Method to update a vehicle type
    public boolean updateVehicleType(VehicleType vehicleType) throws SQLException {
        String query = "UPDATE vehicle_type SET typeName = ?, tax = ?, perKmRate = ? WHERE typeId = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, vehicleType.getTypeName());
            preparedStatement.setDouble(2, vehicleType.getTax());
            preparedStatement.setDouble(3, vehicleType.getPerKmRate());
            preparedStatement.setInt(4, vehicleType.getTypeId());

            return preparedStatement.executeUpdate() > 0;
        }
    }

    // Method to delete a vehicle type
    public boolean deleteVehicleType(int typeId) throws SQLException {
        String query = "DELETE FROM vehicle_type WHERE typeId = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, typeId);

            return preparedStatement.executeUpdate() > 0;
        }
    }
}