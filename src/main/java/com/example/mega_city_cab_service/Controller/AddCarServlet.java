package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.model.Car;
import com.example.mega_city_cab_service.model.Driver;
import com.example.mega_city_cab_service.service.CarService;
import com.example.mega_city_cab_service.service.DriverService;
import com.example.mega_city_cab_service.service.VehicleTypeService;
import com.example.mega_city_cab_service.model.VehicleType;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

public class AddCarServlet extends HttpServlet {
    private final CarService carService;
    private final VehicleTypeService vehicleTypeService;
    private final DriverService driverService;

    public AddCarServlet() {
        this.carService = new CarService();
        this.vehicleTypeService = new VehicleTypeService();
        this.driverService = new DriverService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED); // 405 Status
        response.getWriter().write("GET method is not supported at this endpoint. Please use POST.");
        System.out.println("GET request received at AddCarServlet");


        try {
            // Fetch all vehicle types from the database
            List<VehicleType> vehicleTypes = vehicleTypeService.getAllVehicleTypes();

            // Fetch available drivers from the database
            List<Driver> drivers = driverService.getAvailableDrivers();

            // Pass the data to the JSP page
            request.setAttribute("vehicleTypes", vehicleTypes);
            request.setAttribute("drivers", drivers);

            // Forward the request to the add_car.jsp page
            request.getRequestDispatcher("addCar.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to fetch data: " + e.getMessage());
            request.getRequestDispatcher("addCar.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data with validation
        String model = request.getParameter("model");
        String capacityStr = request.getParameter("capacity");
        String isAvailableStr = request.getParameter("isAvailable");
        String registrationNumber = request.getParameter("registrationNumber");
        String typeIdStr = request.getParameter("typeId");
        String driverIdStr = request.getParameter("driverId");

        try {
            // Re-fetch the data for form redisplay in case of error
            List<VehicleType> vehicleTypes = vehicleTypeService.getAllVehicleTypes();
            List<Driver> drivers = driverService.getAvailableDrivers();
            request.setAttribute("vehicleTypes", vehicleTypes);
            request.setAttribute("drivers", drivers);

            // Validate inputs
            if (model == null || model.isEmpty()) {
                request.setAttribute("error", "Model cannot be empty");
                request.getRequestDispatcher("addCar.jsp").forward(request, response);
                return;
            }
            if (capacityStr == null || capacityStr.isEmpty()) {
                request.setAttribute("error", "Capacity cannot be empty");
                request.getRequestDispatcher("addCar.jsp").forward(request, response);
                return;
            }
            if (registrationNumber == null || registrationNumber.isEmpty()) {
                request.setAttribute("error", "Registration number cannot be empty");
                request.getRequestDispatcher("addCar.jsp").forward(request, response);
                return;
            }
            if (typeIdStr == null || typeIdStr.isEmpty()) {
                request.setAttribute("error", "Vehicle type must be selected");
                request.getRequestDispatcher("addCar.jsp").forward(request, response);
                return;
            }

            int capacity = Integer.parseInt(capacityStr);
            boolean isAvailable = Boolean.parseBoolean(isAvailableStr);
            int typeId = Integer.parseInt(typeIdStr);

            // Process driver ID - always set to -1 initially, will be assigned later if selected
            int driverId = -1;
            boolean redirectToAddDriver = "-1".equals(driverIdStr) || driverIdStr == null || driverIdStr.isEmpty();

            // Create a Car object
            Car car = new Car();
            car.setModel(model);
            car.setCapacity(capacity);
            car.setAvailable(isAvailable);
            car.setRegistrationNumber(registrationNumber);
            car.setTypeId(typeId);
            car.setDriverId(driverId);
            car.setCreatedAt(new Timestamp(System.currentTimeMillis()));

            // Add the car to the database and get the newly generated car ID
            int newCarId = carService.addCarAndGetId(car);

            if (newCarId > 0) {
                if (redirectToAddDriver) {
                    // Redirect to add driver page with the new car ID
                    response.sendRedirect("AddDriverServlet?carId=" + newCarId);
                } else {
                    // If a driver was selected, update the car with the driver ID
                    try {
                        driverId = Integer.parseInt(driverIdStr);
                        if (driverId > 0) {
                            car.setCarId(String.valueOf(newCarId));
                            car.setDriverId(driverId);
                            carService.updateCarDriver(car);
                        }
                        response.sendRedirect("ViewCarsServlet?message=Car added successfully");
                    } catch (NumberFormatException e) {
                        response.sendRedirect("assignDriver.jsp?message=Car added successfully, but driver assignment failed");
                    }
                }
            } else {
                request.setAttribute("error", "Failed to add car");
                request.getRequestDispatcher("addCar.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid numeric input: " + e.getMessage());
            request.getRequestDispatcher("addCar.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("addCar.jsp").forward(request, response);
        }
    }
}