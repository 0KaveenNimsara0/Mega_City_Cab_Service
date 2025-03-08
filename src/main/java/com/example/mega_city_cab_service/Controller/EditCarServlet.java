package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.model.Car;
import com.example.mega_city_cab_service.service.CarService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class EditCarServlet extends HttpServlet {
    private final CarService carService;

    public EditCarServlet() {
        this.carService = new CarService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve car ID from the request parameter
        String carId = request.getParameter("carId");

        if (carId == null || carId.isEmpty()) {
            response.sendRedirect("view_cars.jsp?error=Invalid car ID");
            return;
        }

        try {
            // Fetch the car details by car ID
            Car car = carService.getCarById(carId); // Implement getCarById in CarService and CarDAO
            if (car != null) {
                request.setAttribute("car", car);
                request.getRequestDispatcher("edit_car.jsp").forward(request, response);
            } else {
                response.sendRedirect("view_cars.jsp?error=Car not found");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("view_cars.jsp?error=Database error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String carId = request.getParameter("carId");
        String model = request.getParameter("model");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        boolean isAvailable = Boolean.parseBoolean(request.getParameter("isAvailable"));
        String registrationNumber = request.getParameter("registrationNumber");
        int driverId = Integer.parseInt(request.getParameter("driverId"));
        int typeId = Integer.parseInt(request.getParameter("typeId"));

        // Create a Car object
        Car car = new Car();
        car.setCarId(carId);
        car.setModel(model);
        car.setCapacity(capacity);
        car.setAvailable(isAvailable);
        car.setRegistrationNumber(registrationNumber);
        car.setDriverId(driverId);
        car.setTypeId(typeId);

        try {
            // Update the car details
            if (carService.updateCar(car)) {
                List<Car> cars =carService.getAllCars();
                request.setAttribute("cars", cars);
                response.sendRedirect("ViewCarsServlet?message=Car updated successfully");
            } else {
                response.sendRedirect("ViewCarsServlet?error=Failed to update car");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ViewCarsServlet?error=Database error");
        }
    }
}