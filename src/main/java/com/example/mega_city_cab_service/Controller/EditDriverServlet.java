package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.model.Driver;
import com.example.mega_city_cab_service.service.DriverService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class EditDriverServlet extends HttpServlet {
    private final DriverService driverService;

    public EditDriverServlet() {
        this.driverService = new DriverService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve driver ID from the request
        int driverId = Integer.parseInt(request.getParameter("driverId"));

        try {
            // Fetch the driver details by ID
            Driver driver = driverService.getDriverById(driverId);
            if (driver != null) {
                request.setAttribute("editDriver", driver);
                request.getRequestDispatcher("editDriver.jsp").forward(request, response);
            } else {
                response.sendRedirect("ViewDrivers?error=Driver not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ViewDrivers?error=Database error occurred");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        int driverId = Integer.parseInt(request.getParameter("driverId"));
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String licenseNumber = request.getParameter("licenseNumber");
        boolean isAvailable = Boolean.parseBoolean(request.getParameter("isAvailable"));

        // Update the driver details
        Driver driver = new Driver();
        driver.setDriverId(driverId);
        driver.setName(name);
        driver.setPhone(phone);
        driver.setEmail(email);
        driver.setLicenseNumber(licenseNumber);
        driver.setAvailable(isAvailable);

        try {
            // Update the driver in the database
            if (driverService.updateDriver(driver)) {
                List<Driver> drivers = driverService.getAllDrivers();
                request.setAttribute("drivers", drivers);

                response.sendRedirect("ViewDrivers?message=Driver updated successfully");
            } else {
                response.sendRedirect("editDriver.jsp?driverId=" + driverId + "&error=Failed to update driver");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editDriver.jsp?driverId=" + driverId + "&error=Database error occurred");
        }
    }
}