package com.example.mega_city_cab_service.model;

public class Location {
    private int locationId;
    private String locationName;

    // Constructors
    public Location() {}

    public Location(int locationId, String locationName) {
        this.locationId = locationId;
        this.locationName = locationName;
    }

    // Getters and Setters
    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }

    @Override
    public String toString() {
        return "Location{" +
                "locationId=" + locationId +
                ", locationName='" + locationName + '\'' +
                '}';
    }
}