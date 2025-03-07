package com.example.mega_city_cab_service.service;

import com.example.mega_city_cab_service.dao.CarDAO;
import com.example.mega_city_cab_service.model.Car;

import java.sql.SQLException;
import java.util.List;

public class CarService {
    private CarDAO carDAO;

    // Constructor: Initialize CarDAO
    public CarService() {
        this.carDAO = new CarDAO();
    }

    // Add a new vehicle
    public boolean addCar(Car car) throws SQLException {
        return carDAO.addCar(car);
    }

    // Retrieve all vehicles
    public List<Car> getAllCars() throws SQLException {
        return carDAO.getAllCars();
    }

    // Retrieve a vehicle by its ID
    public Car getCarById(String carId) throws SQLException {
        return carDAO.getCarById(carId);
    }

    // Update a vehicle's availability
    public boolean updateCarAvailability(String carId, boolean isAvailable) throws SQLException {
        return carDAO.updateCarAvailability(carId, isAvailable);
    }

    // Delete a vehicle
    public boolean deleteCar(String carId) throws SQLException {
        return carDAO.deleteCar(carId);
    }
}