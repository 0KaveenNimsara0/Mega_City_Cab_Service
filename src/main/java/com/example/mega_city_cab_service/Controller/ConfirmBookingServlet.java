package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.model.Booking;
import com.example.mega_city_cab_service.model.Location;
import com.example.mega_city_cab_service.model.VehicleType;
import com.example.mega_city_cab_service.service.LocationService;
import com.example.mega_city_cab_service.service.VehicleTypeService;
import com.example.mega_city_cab_service.service.CouponService;

import jakarta.servlet.ServletException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;


public class ConfirmBookingServlet extends HttpServlet {
    private final LocationService locationService;
    private final VehicleTypeService vehicleTypeService;
    private final CouponService couponService;

    public ConfirmBookingServlet() {
        this.locationService = new LocationService();
        this.vehicleTypeService = new VehicleTypeService();
        this.couponService = new CouponService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve form parameters
            int pickupPointId = Integer.parseInt(request.getParameter("pickupPoint"));
            int destinationId = Integer.parseInt(request.getParameter("destination"));
            int carTypeId = Integer.parseInt(request.getParameter("carType"));
            String pickupDate = request.getParameter("pickupDate");
            String couponCode = request.getParameter("couponCode");

            // Fetch location names for pickup point and destination
            Location pickupLocation = locationService.getLocationById(pickupPointId);
            Location destinationLocation = locationService.getLocationById(destinationId);

            // Fetch vehicle type details
            VehicleType vehicleType = vehicleTypeService.getVehicleTypeById(carTypeId);

            // Fetch distance
            double distance = locationService.getDistance(pickupPointId, destinationId);

            // Calculate base amount
            double baseAmount = distance * vehicleType.getPerKmRate();

            // Validate coupon code
            double discount = 0;
            if (couponCode != null && !couponCode.isEmpty()) {
                var coupon = couponService.getCouponByCode(couponCode);
                if (coupon != null) {
                    discount = coupon.getDiscountPercentage();
                }
            }

            // Calculate total amount
            double tax = vehicleType.getTax(); // Tax is now treated as a fixed amount
            double totalAmount = baseAmount + tax - ((baseAmount * discount) / 100);

            // Set attributes for the confirmation page
            request.setAttribute("pickupPoint", pickupLocation.getLocationName());
            request.setAttribute("destination", destinationLocation.getLocationName());
            request.setAttribute("carType", vehicleType.getTypeName());
            request.setAttribute("pickupDate", pickupDate);
            request.setAttribute("couponCode", couponCode);
            request.setAttribute("distance", distance);
            request.setAttribute("tax", tax);
            request.setAttribute("perKmRate", vehicleType.getPerKmRate());
            request.setAttribute("discount", discount);
            request.setAttribute("totalAmount", totalAmount);

            request.setAttribute("pickupPointId", pickupLocation.getLocationId());
            request.setAttribute("destinationId", destinationLocation.getLocationId());
            request.setAttribute("carTypeId", vehicleType.getTypeId());

            // Forward to the confirmation page
            request.getRequestDispatcher("booking_confirmation.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            System.err.println("Invalid input format: " + e.getMessage());
            response.sendRedirect("error.jsp?message=Invalid input format");
        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
            response.sendRedirect("error.jsp?message=Database error occurred");
        } catch (Exception e) {
            System.err.println("Unexpected error: " + e.getMessage());
            response.sendRedirect("error.jsp?message=An unexpected error occurred");
        }
    }
}