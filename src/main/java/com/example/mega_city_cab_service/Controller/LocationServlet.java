package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.model.Location;
import com.example.mega_city_cab_service.service.LocationService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


public class LocationServlet extends HttpServlet {

    private final LocationService locationService;

    public LocationServlet() {
        this.locationService = new LocationService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Fetch all locations from the service layer
            List<Location> locations = locationService.getAllLocations();

            // Set the locations as a request attribute
            request.setAttribute("locations", locations);

            // Forward the request to the JSP page
            request.getRequestDispatcher("booking.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }
}