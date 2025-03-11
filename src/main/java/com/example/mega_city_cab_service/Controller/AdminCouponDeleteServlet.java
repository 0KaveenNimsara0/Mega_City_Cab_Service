package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.service.CouponService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class AdminCouponDeleteServlet extends HttpServlet {
    private CouponService couponService;

    public void init() {
        couponService = new CouponService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int couponId = Integer.parseInt(request.getParameter("couponId"));

        try {
            couponService.deleteCoupon(couponId);
            response.sendRedirect("adminCoupons.jsp?status=deleted");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminCoupons.jsp?status=error");
        }
    }
}