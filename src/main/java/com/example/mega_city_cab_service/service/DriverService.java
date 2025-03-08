package com.example.mega_city_cab_service.service;

import com.example.mega_city_cab_service.dao.DriverDAO;
import com.example.mega_city_cab_service.model.Driver;

import java.sql.SQLException;
import java.util.List;

public class DriverService {
    private final DriverDAO driverDAO;

    // Constructor: Initialize the DriverDAO
    public DriverService() {
        this.driverDAO = new DriverDAO();
    }


    public Driver getDriverById(int driverId) {
        try {
            return driverDAO.getDriverById(driverId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    public Driver getDriverByPhone(String phone) {
        try {
            return driverDAO.getDriverByPhone(phone);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    public List<Driver> getAllDrivers() {
        try {
            return driverDAO.getAllDrivers();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    public List<Driver> getAvailableDrivers() {
        try {
            return driverDAO.getAvailableDrivers();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    public boolean addDriver(Driver driver) {
        try {
            return driverDAO.addDriver(driver);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public boolean updateDriver(Driver driver) {
        try {
            return driverDAO.updateDriver(driver);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public boolean deleteDriver(int driverId) {
        try {
            return driverDAO.deleteDriver(driverId);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}