package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.model.Car;
import com.example.mega_city_cab_service.model.Driver;
import com.example.mega_city_cab_service.service.CarService;
import com.example.mega_city_cab_service.service.DriverService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

public class AddDriverServlet extends HttpServlet {
    private final DriverService driverService;
    private final CarService carService;

    public AddDriverServlet() {
        this.driverService = new DriverService();
        this.carService = new CarService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String carIdStr = request.getParameter("carId");

        if (carIdStr == null || carIdStr.isEmpty()) {
            response.sendRedirect("ViewCarsServlet?error=No car specified");
            return;
        }

        try {
            int carId = Integer.parseInt(carIdStr);

            // Get car details
            Car car = carService.getCarById(String.valueOf(carId));
            if (car == null) {
                response.sendRedirect("ViewCarsServlet?error=Car not found");
                return;
            }

            // Get available drivers
            List<Driver> drivers = driverService.getAvailableDrivers();

            // Set attributes for the JSP
            request.setAttribute("car", car);
            request.setAttribute("drivers", drivers);

            // Forward to the JSP
            request.getRequestDispatcher("assignDriver.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("ViewCarsServlet?error=Invalid car ID");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("ViewCarsServlet?error=Database error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String licenseNumber = request.getParameter("licenseNumber");
        boolean isAvailable = Boolean.parseBoolean(request.getParameter("isAvailable"));
        String carIdStr = request.getParameter("carId");

        // Validate the car ID
        if (carIdStr == null || carIdStr.isEmpty()) {
            response.sendRedirect("assignDriver.jsp?error=Car ID is missing.");
            return;
        }

        int carId = Integer.parseInt(carIdStr);


        Driver driver = new Driver();
        driver.setName(name);
        driver.setPhone(phone);
        driver.setEmail(email);
        driver.setLicenseNumber(licenseNumber);
        driver.setAvailable(isAvailable);
        driver.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        try {
            // Save the new driver to the database

            int newDriverId = driverService.addDriverAndGetId(driver); // Update DriverService to return the generated driver ID

            if (newDriverId > 0) {
                // Assign the driver to the car
                boolean updated = carService.assignDriverToCar(String.valueOf(carId), newDriverId);

                if (updated) {
                    response.sendRedirect("ViewCarsServlet?message=Driver assigned to car successfully");

                } else {
                    response.sendRedirect("assignDriver.jsp?error=Failed to add driver");
                }
            }
        }
        catch(Exception e){
            e.printStackTrace();
            response.sendRedirect("assignDriver.jsp?error=Database error");
        }
    }
}