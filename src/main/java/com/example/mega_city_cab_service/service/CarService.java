package com.example.mega_city_cab_service.service;

import com.example.mega_city_cab_service.dao.CarDAO;
import com.example.mega_city_cab_service.model.Car;

import java.sql.SQLException;
import java.util.List;

public class CarService {
    private final CarDAO carDAO;

    // Constructor: Initialize the CarDAO
    public CarService() {
        this.carDAO = new CarDAO();
    }


    public boolean addCar(Car car) {
        try {
            return carDAO.addCar(car);
        } catch (SQLException e) {
            System.err.println("Error adding car: " + e.getMessage());
            e.printStackTrace();
        }
        return false; // Return false if the operation fails
    }


    public List<Car> getAllCars() {
        try {
            return carDAO.getAllCars();
        } catch (SQLException e) {
            System.err.println("Error retrieving all cars: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // Return null if an error occurs
    }


    public boolean updateCar(Car car) {
        try {
            return carDAO.updateCar(car);
        } catch (SQLException e) {
            System.err.println("Error updating car: " + e.getMessage());
            e.printStackTrace();
        }
        return false; // Return false if the operation fails
    }


    public boolean changeAvailability(String carId, boolean isAvailable) {
        try {
            return carDAO.changeAvailability(carId, isAvailable);
        } catch (SQLException e) {
            System.err.println("Error changing car availability: " + e.getMessage());
            e.printStackTrace();
        }
        return false; // Return false if the operation fails
    }


    public boolean deleteCar(String carId) {
        try {
            return carDAO.deleteCar(carId);
        } catch (SQLException e) {
            System.err.println("Error deleting car: " + e.getMessage());
            e.printStackTrace();
        }
        return false; // Return false if the operation fails
    }


    public Car getCarById(String carId) throws SQLException
    {
        try {
            return carDAO.getCarById(carId);
        } catch (SQLException e) {
            System.err.println("Error retrieving car by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // Return null if no car is found
    }


    public boolean assignDriverToCar(String carId, int driverId) {
        try {
            return carDAO.assignDriverToCar(carId, driverId);
        } catch (SQLException e) {
            System.err.println("Error assigning driver to car: " + e.getMessage());
            e.printStackTrace();
        }
        return false; // Return false if the operation fails
    }


    public int addCarAndGetId(Car car) {
        try {
            System.out.println("Attempting to add car: " + car);
            int generatedId = carDAO.addCarAndGetId(car);
            System.out.println("Car added successfully. Generated ID: " + generatedId);
            return generatedId;
        } catch (Exception e) {
            System.err.println("Error adding car and getting ID: " + e.getMessage());
            e.printStackTrace();
        }
        return -1; // Return -1 if the operation fails
    }

    public boolean updateCarDriver(Car car) {
        try {
            return carDAO.updateCarDriver(car);
        } catch (Exception e) {
            System.err.println("Error updating car driver in service: " + e.getMessage());
            e.printStackTrace();
        }
        return false; // Return false if the operation fails
    }

    // Method to fetch all available cars
    public List<Car> getAvailableCars() {
        try {
            return carDAO.getAvailableCars();
        } catch (SQLException e) {
            System.err.println("Error fetching available cars: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // Return null if an error occurs
    }
}