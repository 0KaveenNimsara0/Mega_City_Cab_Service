package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.model.Driver;
import com.example.mega_city_cab_service.service.DriverService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Timestamp;

public class AddDriver extends HttpServlet {
    private final DriverService driverService;

    public AddDriver() {
        this.driverService = new DriverService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String licenseNumber = request.getParameter("licenseNumber");
        boolean isAvailable = Boolean.parseBoolean(request.getParameter("isAvailable"));

        // Create a new Driver object
        Driver driver = new Driver();
        driver.setName(name);
        driver.setPhone(phone);
        driver.setEmail(email);
        driver.setLicenseNumber(licenseNumber);
        driver.setAvailable(isAvailable);
        driver.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        try {
            // Add the driver to the database
            if (driverService.addDriver(driver)) {
                response.sendRedirect("manageDriver.jsp?message=Driver added successfully");
            } else {
                response.sendRedirect("addDriver.jsp?error=Failed to add driver");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addDriver.jsp?error=Database error occurred");
        }
    }
}