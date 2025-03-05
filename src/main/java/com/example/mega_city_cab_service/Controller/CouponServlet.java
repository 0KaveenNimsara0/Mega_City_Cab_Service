package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.service.CouponService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;


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

        if ("validate".equals(action)) {
            String couponCode = request.getParameter("couponCode");

            response.setContentType("application/json");
            PrintWriter out = response.getWriter();

            try {
                if (couponCode == null || couponCode.trim().isEmpty()) {
                    out.print("{\"valid\": false, \"message\": \"Coupon code is required.\"}");
                    return;
                }

                double discount = couponService.validateCoupon(couponCode);

                if (discount > 0) {
                    out.print("{\"valid\": true, \"discount\": " + discount + "}");
                } else {
                    out.print("{\"valid\": false, \"message\": \"Invalid or expired coupon.\"}");
                }
            } catch (Exception e) {
                out.print("{\"valid\": false, \"message\": \"Error validating coupon: " + e.getMessage() + "\"}");
            }
        }
    }
}