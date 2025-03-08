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

public class ViewCarsServlet extends HttpServlet {
    private final CarService carService;

    public ViewCarsServlet() {
        this.carService = new CarService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Car> cars = carService.getAllCars();
            request.setAttribute("cars", cars);
            request.getRequestDispatcher("view_cars.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin_dashboard.jsp?error=Failed to fetch cars");
        }
    }
}