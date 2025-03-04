package com.example.mega_city_cab_service.service;

import com.example.mega_city_cab_service.dao.CouponDAO;
import com.example.mega_city_cab_service.model.Coupon;

import java.sql.SQLException;
import java.util.List;

public class CouponService {
    private CouponDAO couponDAO;

    // Constructor: Initialize CouponDAO
    public CouponService() {
        this.couponDAO = new CouponDAO(); // DAO handles database connection internally
    }

    // Validate a coupon code and return the discount percentage
    public double validateCoupon(String couponCode) throws SQLException {
        Coupon coupon = couponDAO.getCouponByCode(couponCode);
        if (coupon != null && coupon.getValidUntil().after(new java.util.Date())) { // Ensure the coupon is not expired
            return coupon.getDiscountPercentage();
        }
        return 0; // Return 0 if the coupon is invalid or expired
    }

    // Retrieve all active coupons
    public List<Coupon> getAllActiveCoupons() throws SQLException {
        return couponDAO.getAllActiveCoupons();
    }

    // Add a new coupon
    public boolean addCoupon(Coupon coupon) throws SQLException {
        return couponDAO.addCoupon(coupon);
    }

    // Delete a coupon
    public boolean deleteCoupon(int couponId) throws SQLException {
        return couponDAO.deleteCoupon(couponId);
    }
}