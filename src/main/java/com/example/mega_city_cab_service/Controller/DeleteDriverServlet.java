package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.model.Driver;
import com.example.mega_city_cab_service.service.DriverService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class DeleteDriverServlet extends HttpServlet {
    private final DriverService driverService;

    public DeleteDriverServlet() {
        this.driverService = new DriverService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve driver ID from the request
        int driverId = Integer.parseInt(request.getParameter("driverId"));

        try {
            // Delete the driver from the database
            if (driverService.deleteDriver(driverId)) {
                List<Driver> drivers = driverService.getAllDrivers();
                request.setAttribute("drivers", drivers);
                response.sendRedirect("ViewDrivers?message=Driver deleted successfully");
            } else {
                response.sendRedirect("ViewDrivers?error=Failed to delete driver");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ViewDrivers?error=Database error occurred");
        }
    }
}