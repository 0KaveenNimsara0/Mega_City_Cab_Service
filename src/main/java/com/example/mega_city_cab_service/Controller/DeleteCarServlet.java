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

public class DeleteCarServlet extends HttpServlet {
    private final CarService carService;

    public DeleteCarServlet() {
        this.carService = new CarService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the car ID from the request parameter
        String carId = request.getParameter("carId");

        if (carId == null || carId.isEmpty()) {
            response.sendRedirect("error.jsp?error=Invalid car ID");
            return;
        }

        try {
            // Attempt to delete the car
            if (carService.deleteCar(carId)) {
                List<Car> cars =carService.getAllCars();
                request.setAttribute("cars", cars);
                response.sendRedirect("ViewCarsServlet?message=Car deleted successfully");
            } else {
                response.sendRedirect("ViewCarsServlet?error=Failed to delete car");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?error=Database error");
        }
    }
}