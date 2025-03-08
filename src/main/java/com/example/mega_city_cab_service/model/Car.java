package com.example.mega_city_cab_service.model;

import java.sql.Timestamp;

public class Car {
    private String carId;
    private String model;
    private int capacity;
    private boolean isAvailable;
    private String registrationNumber;
    private int driverId;
    private int typeId;
    private Timestamp createdAt;

    // Constructors
    public Car() {}

    public Car(String carId, String model, int capacity, boolean isAvailable, String registrationNumber, int driverId, int typeId, Timestamp createdAt) {
        this.carId = carId;
        this.model = model;
        this.capacity = capacity;
        this.isAvailable = isAvailable;
        this.registrationNumber = registrationNumber;
        this.driverId = driverId;
        this.typeId = typeId;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    public String getRegistrationNumber() {
        return registrationNumber;
    }

    public void setRegistrationNumber(String registrationNumber) {
        this.registrationNumber = registrationNumber;
    }

    public int getDriverId() {
        return driverId;
    }

    public void setDriverId(int driverId) {
        this.driverId = driverId;
    }

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}