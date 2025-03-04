package com.example.mega_city_cab_service.model;

import java.sql.Date;

public class Coupon {
    private int couponId;
    private String couponCode;
    private double discountPercentage;
    private Date validUntil;
    private String description;
    private Date createdAt;

    // Constructors
    public Coupon() {}

    public Coupon(int couponId, String couponCode, double discountPercentage, Date validUntil, String description, Date createdAt) {
        this.couponId = couponId;
        this.couponCode = couponCode;
        this.discountPercentage = discountPercentage;
        this.validUntil = validUntil;
        this.description = description;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getCouponId() {
        return couponId;
    }

    public void setCouponId(int couponId) {
        this.couponId = couponId;
    }

    public String getCouponCode() {
        return couponCode;
    }

    public void setCouponCode(String couponCode) {
        this.couponCode = couponCode;
    }

    public double getDiscountPercentage() {
        return discountPercentage;
    }

    public void setDiscountPercentage(double discountPercentage) {
        this.discountPercentage = discountPercentage;
    }

    public Date getValidUntil() {
        return validUntil;
    }

    public void setValidUntil(Date validUntil) {
        this.validUntil = validUntil;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}