package com.example.mega_city_cab_service.service;

import com.example.mega_city_cab_service.dao.LocationDAO;
import com.example.mega_city_cab_service.model.Location;

import java.sql.SQLException;
import java.util.List;

public class LocationService {

    private final LocationDAO locationDAO;

    // Constructor to initialize the DAO
    public LocationService() {
        this.locationDAO = new LocationDAO();
    }

    // Fetch all locations using the DAO
    public List<Location> getAllLocations() throws SQLException {
        return locationDAO.getAllLocations();
    }

    public double getDistance(int fromLocationId, int toLocationId) throws SQLException {
        double distance = locationDAO.getDistance(fromLocationId, toLocationId);

        if (distance < 0) {
            throw new SQLException("Distance not found for fromLocationId=" + fromLocationId + ", toLocationId=" + toLocationId);
        }

        return distance;
    }

    // Calculate the amount based on the distance and rate per kilometer
    public double calculateAmount(double distance) {
        double ratePerKm = 100.0; // Example rate per kilometer (you can make this configurable)
        return distance * ratePerKm;
    }
}