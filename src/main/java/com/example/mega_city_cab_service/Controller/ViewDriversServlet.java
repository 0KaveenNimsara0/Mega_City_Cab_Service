package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.model.Driver;
import com.example.mega_city_cab_service.service.DriverService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;


public class ViewDriversServlet extends HttpServlet {
    private final DriverService driverService;

    public ViewDriversServlet() {
        this.driverService = new DriverService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Driver> drivers = driverService.getAllDrivers();
            request.setAttribute("drivers", drivers);
            request.getRequestDispatcher("manageDriver.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manageDriver.jsp?error=Database error occurred");
        }
    }
}
