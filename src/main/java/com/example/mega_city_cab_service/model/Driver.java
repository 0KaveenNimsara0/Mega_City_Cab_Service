package com.example.mega_city_cab_service.model;

import java.sql.Timestamp;

public class Driver {
    private int driverId;
    private String name;
    private String phone;
    private String email;
    private String licenseNumber;
    private boolean isAvailable;
    private Timestamp createdAt;

    // Default Constructor
    public Driver() {
    }

    // Parameterized Constructor
    public Driver(int driverId, String name, String phone, String email, String licenseNumber, boolean isAvailable, Timestamp createdAt) {
        this.driverId = driverId;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.licenseNumber = licenseNumber;
        this.isAvailable = isAvailable;
        this.createdAt = createdAt;
    }

    // Getters and Setters

    public int getDriverId() {
        return driverId;
    }

    public void setDriverId(int driverId) {
        this.driverId = driverId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    // toString Method for Debugging
    @Override
    public String toString() {
        return "Driver{" +
                "driverId=" + driverId +
                ", name='" + name + '\'' +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", licenseNumber='" + licenseNumber + '\'' +
                ", isAvailable=" + isAvailable +
                ", createdAt=" + createdAt +
                '}';
    }
}