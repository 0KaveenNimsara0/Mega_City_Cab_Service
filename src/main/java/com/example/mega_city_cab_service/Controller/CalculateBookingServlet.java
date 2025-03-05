package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.service.LocationService;
import com.example.mega_city_cab_service.service.VehicleTypeService;
import com.example.mega_city_cab_service.service.CouponService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/CalculateBookingServlet")
public class CalculateBookingServlet extends HttpServlet {
    private final LocationService locationService;
    private final VehicleTypeService vehicleTypeService;
    private final CouponService couponService;

    public CalculateBookingServlet() {
        this.locationService = new LocationService();
        this.vehicleTypeService = new VehicleTypeService();
        this.couponService = new CouponService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            // Parse request body manually
            StringBuilder requestBody = new StringBuilder();
            String line;
            BufferedReader reader = request.getReader();
            while ((line = reader.readLine()) != null) {
                requestBody.append(line);
            }

            // Extract values from the JSON-like string
            String pickupPointStr = extractValue(requestBody.toString(), "pickupPoint");
            String destinationStr = extractValue(requestBody.toString(), "destination");
            String carTypeStr = extractValue(requestBody.toString(), "carType");
            String couponCode = extractValue(requestBody.toString(), "couponCode");

            int pickupPoint = Integer.parseInt(pickupPointStr);
            int destination = Integer.parseInt(destinationStr);
            int carType = Integer.parseInt(carTypeStr);

            // Fetch distance
            double distance = locationService.getDistance(pickupPoint, destination);

            // Fetch vehicle type details
            var vehicleType = vehicleTypeService.getVehicleTypeById(carType);
            double tax = vehicleType.getTax();
            double perKmRate = vehicleType.getPerKmRate();

            // Calculate base amount
            double baseAmount = distance * perKmRate;

            // Validate coupon code
            double discount = 0;
            if (couponCode != null && !couponCode.isEmpty()) {
                var coupon = couponService.getCouponByCode(couponCode);
                if (coupon != null) {
                    discount = coupon.getDiscountPercentage();
                }
            }

            // Calculate total amount
            double totalAmount = baseAmount + tax - ((baseAmount * discount) / 100);

            // Construct JSON response manually
            String jsonResponse = String.format(
                    "{\"distance\": %.2f, \"tax\": %.2f, \"perKmRate\": %.2f, \"discount\": %.2f, \"totalAmount\": %.2f}",
                    distance, tax, perKmRate, discount, totalAmount
            );

            out.print(jsonResponse);
        } catch (SQLException e) {
            out.print("{\"error\": \"Database error occurred.\"}");
        } catch (Exception e) {
            out.print("{\"error\": \"An unexpected error occurred.\"}");
        }
    }

    // Helper method to extract values from a JSON-like string
    private String extractValue(String json, String key) {
        String pattern = "\"" + key + "\":\"([^\"]*)\"";
        java.util.regex.Pattern r = java.util.regex.Pattern.compile(pattern);
        java.util.regex.Matcher m = r.matcher(json);
        if (m.find()) {
            return m.group(1);
        }
        return "";
    }
}