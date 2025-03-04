package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.service.CouponService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


public class CouponServlet extends HttpServlet {
    private CouponService couponService;

    @Override
    public void init() throws ServletException {
        // Initialize the CouponService
        this.couponService = new CouponService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("validate".equals(action)) {
                String couponCode = request.getParameter("couponCode");

                if (couponCode == null || couponCode.trim().isEmpty()) {
                    response.getWriter().write("{\"valid\": false, \"message\": \"Coupon code is required.\"}");
                    return;
                }

                double discount = couponService.validateCoupon(couponCode);

                if (discount > 0) {
                    response.getWriter().write("{\"valid\": true, \"discount\": " + discount + "}");
                } else {
                    response.getWriter().write("{\"valid\": false, \"message\": \"Invalid or expired coupon.\"}");
                }
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Error validating coupon: " + e.getMessage() + "\"}");
        }
    }
}