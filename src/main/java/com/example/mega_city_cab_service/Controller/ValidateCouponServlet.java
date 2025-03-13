package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.model.Coupon;
import com.example.mega_city_cab_service.service.CouponService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;


public class ValidateCouponServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get coupon code parameter
        String couponCode = request.getParameter("couponCode");

        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        CouponService couponService = new CouponService();

        try {
            // Use the CouponService to validate the coupon
            Coupon coupon = couponService.getCouponByCode(couponCode);

            if (coupon != null && coupon.getValidUntil().after(new java.util.Date())) {
                // Valid coupon
                out.print("{\"valid\": true, \"discount\": " + coupon.getDiscountPercentage() +
                        ", \"message\": \"Valid coupon! You will receive a " +
                        coupon.getDiscountPercentage() + "% discount.\"}");
            } else {
                // Invalid or expired coupon
                out.print("{\"valid\": false, \"message\": \"Invalid or expired coupon code\"}");
            }

        } catch (SQLException e) {
            // Database error
            e.printStackTrace();
            out.print("{\"valid\": false, \"message\": \"Error processing coupon. Please try again.\"}");
        }
    }
}