package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.service.VehicleTypeService;
import com.example.mega_city_cab_service.model.VehicleType;

import jakarta.servlet.ServletException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class VehicleTypeServlet extends HttpServlet {
    private final VehicleTypeService vehicleTypeService;

    public VehicleTypeServlet() {
        this.vehicleTypeService = new VehicleTypeService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Fetch all vehicle types from the service layer
            List<com.example.mega_city_cab_service.model.VehicleType> vehicleTypes = vehicleTypeService.getAllVehicleTypes();

            // Set the vehicle types as a request attribute
            request.setAttribute("vehicleTypes", vehicleTypes);

            // Forward the request to the JSP file
            request.getRequestDispatcher("vehicle_types.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Failed to fetch vehicle types");
        }
    }
}