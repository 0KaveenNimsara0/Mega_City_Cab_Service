package com.example.mega_city_cab_service.dao;

import com.example.mega_city_cab_service.model.Location;
import com.example.mega_city_cab_service.Util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LocationDAO {

    // Reference to the database connection (kept open)
    private Connection connection;

    // Constructor to initialize the connection
    public LocationDAO() {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }

    // Method to fetch all locations from the database
    public List<Location> getAllLocations() throws SQLException {
        List<Location> locations = new ArrayList<>();
        String GET_ALL_LOCATIONS_SQL = "SELECT location_id, location_name FROM locations";

        try (PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_LOCATIONS_SQL);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                int locationId = resultSet.getInt("location_id");
                String locationName = resultSet.getString("location_name");
                locations.add(new Location(locationId, locationName));
            }
        } catch (SQLException e) {
            System.err.println("Error fetching locations: " + e.getMessage());
            e.printStackTrace();
            throw e; // Rethrow the exception for the caller to handle
        }

        return locations;
    }

    // Method to fetch the distance between two locations
    public double getDistance(int fromLocationId, int toLocationId) throws SQLException {
        String GET_DISTANCE_SQL = "SELECT distance_km FROM distances WHERE from_location_id = ? AND to_location_id = ?";
        double distance = -1; // Default value if no distance is found

        try (PreparedStatement preparedStatement = connection.prepareStatement(GET_DISTANCE_SQL)) {
            preparedStatement.setInt(1, fromLocationId);
            preparedStatement.setInt(2, toLocationId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    distance = resultSet.getDouble("distance_km");
                    System.out.println("Fetched distance: " + distance + " km for fromLocationId=" + fromLocationId + ", toLocationId=" + toLocationId);
                } else {
                    System.out.println("No distance found for fromLocationId=" + fromLocationId + ", toLocationId=" + toLocationId);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching distance: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }

        return distance;
    }
    public int getLocationByName(String locationName) throws SQLException {
        String query = "SELECT location_id FROM locations WHERE location_name = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, locationName);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt("location_id");
                }
            }
        }
        return -1; // Return -1 if no matching location is found
    }
    public Location getLocationById(int locationId) throws SQLException {
        String query = "SELECT * FROM locations WHERE location_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, locationId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return new Location(
                            resultSet.getInt("location_id"),
                            resultSet.getString("location_name")
                    );
                }
            }
        }
        return null; // Return null if no location is found
    }



}