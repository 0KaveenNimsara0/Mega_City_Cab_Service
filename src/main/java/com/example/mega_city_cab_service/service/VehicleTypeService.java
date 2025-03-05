package com.example.mega_city_cab_service.service;

import com.example.mega_city_cab_service.dao.VehicleTypeDAO;
import com.example.mega_city_cab_service.model.VehicleType;

import java.sql.SQLException;
import java.util.List;

public class VehicleTypeService {
    private VehicleTypeDAO vehicleTypeDAO;

    // Constructor: Initialize VehicleTypeDAO
    public VehicleTypeService() {
        this.vehicleTypeDAO = new VehicleTypeDAO();
    }

    // Retrieve all vehicle types
    public List<VehicleType> getAllVehicleTypes() throws SQLException {
        System.out.println("Fetching all vehicle types...");
        return vehicleTypeDAO.getAllVehicleTypes();
    }

    // Retrieve a vehicle type by its ID
    public VehicleType getVehicleTypeById(int typeId) throws SQLException {
        System.out.println("Fetching vehicle type by ID: " + typeId);
        return vehicleTypeDAO.getVehicleTypeById(typeId);
    }

    // Add a new vehicle type
    public boolean addVehicleType(VehicleType vehicleType) throws SQLException {
        return vehicleTypeDAO.addVehicleType(vehicleType);
    }

    // Update a vehicle type
    public boolean updateVehicleType(VehicleType vehicleType) throws SQLException {
        return vehicleTypeDAO.updateVehicleType(vehicleType);
    }

    // Delete a vehicle type
    public boolean deleteVehicleType(int typeId) throws SQLException {
        return vehicleTypeDAO.deleteVehicleType(typeId);
    }
}