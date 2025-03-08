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

public class ChangeAvailabilityServlet extends HttpServlet {
    private final CarService carService;

    public ChangeAvailabilityServlet() {
        this.carService = new CarService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String carId = request.getParameter("carId");
        String isAvailableParam = request.getParameter("isAvailable");

        if (carId == null || carId.isEmpty() || isAvailableParam == null || isAvailableParam.isEmpty()) {
            response.sendRedirect("view_cars.jsp?error=Invalid request parameters");
            return;
        }

        try {
            // Parse the availability parameter
            boolean isAvailable = Boolean.parseBoolean(isAvailableParam);

            // Update the car's availability
            if (carService.changeAvailability(carId, isAvailable)) {
                List<Car> cars =carService.getAllCars();
                request.setAttribute("cars", cars);
                response.sendRedirect("ViewCarsServlet?message=Car availability updated successfully");
            } else {
                response.sendRedirect("ViewCarsServlet?error=Failed to update car availability");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("view_cars.jsp?error=Database error");
        }
    }
}