package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.model.Coupon;
import com.example.mega_city_cab_service.service.CouponService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;

public class AdminCouponAddServlet extends HttpServlet {
    private CouponService couponService;

    public void init() {
        couponService = new CouponService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String couponCode = request.getParameter("couponCode");
        double discountPercentage = Double.parseDouble(request.getParameter("discountPercentage"));
        Date validUntil = Date.valueOf(request.getParameter("validUntil"));
        String description = request.getParameter("description");

        Coupon coupon = new Coupon();
        coupon.setCouponCode(couponCode);
        coupon.setDiscountPercentage(discountPercentage);
        coupon.setValidUntil(validUntil);
        coupon.setDescription(description);
        coupon.setCreatedAt(new Date(System.currentTimeMillis())); // Set current date

        try {
            couponService.addCoupon(coupon);
            response.sendRedirect("adminCoupons.jsp?status=added");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminCoupons.jsp?status=error");
        }
    }
}