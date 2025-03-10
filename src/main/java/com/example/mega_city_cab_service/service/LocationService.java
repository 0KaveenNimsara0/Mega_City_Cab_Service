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
        try {
            System.out.println("Fetching all locations...");
            return locationDAO.getAllLocations();
        } catch (Exception e) {
            System.err.println("Error fetching locations: " + e.getMessage());
            throw e;
        }
    }
    public Location getLocationById(int locationId) throws SQLException {
        return locationDAO.getLocationById(locationId);
    }


    // Fetch the distance between two locations
    public double getDistance(int fromLocationId, int toLocationId) throws SQLException {
        System.out.println("Fetching distance for fromLocationId=" + fromLocationId + ", toLocationId=" + toLocationId);
        double distance = locationDAO.getDistance(fromLocationId, toLocationId);

        if (distance < 0) {
            System.err.println("Invalid distance fetched: " + distance);
            throw new SQLException("Distance not found for fromLocationId=" + fromLocationId + ", toLocationId=" + toLocationId);
        }

        return distance;
    }
}