package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.service.LocationService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


public class CalculateDistanceServlet extends HttpServlet {

    private final LocationService locationService;

    public CalculateDistanceServlet() {
        this.locationService = new LocationService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fromLocationIdParam = request.getParameter("pickupPoint");
        String toLocationIdParam = request.getParameter("destination");

        if (fromLocationIdParam == null || toLocationIdParam == null) {
            request.setAttribute("error", "Please select both pickup point and destination.");
            request.getRequestDispatcher("/bookCab.jsp").forward(request, response);
            return;
        }

        try {
            int fromLocationId = Integer.parseInt(fromLocationIdParam);
            int toLocationId = Integer.parseInt(toLocationIdParam);

            // Fetch the distance using the LocationService
            double distance = locationService.getDistance(fromLocationId, toLocationId);

            // Calculate the amount using the LocationService
            double amount = locationService.calculateAmount(distance);

            // Set the calculated values as request attributes
            request.setAttribute("distance", distance);
            request.setAttribute("amount", amount);

            // Forward the request back to the JSP page
            request.getRequestDispatcher("booking.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid location IDs.");
            request.getRequestDispatcher("booking.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error calculating distance or amount.");
            request.getRequestDispatcher("booking.jsp").forward(request, response);
        }
    }
}