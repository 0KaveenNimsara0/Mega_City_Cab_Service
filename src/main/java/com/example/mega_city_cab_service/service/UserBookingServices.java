package com.example.mega_city_cab_service.service;

import com.example.mega_city_cab_service.dao.BookingDAO;
import com.example.mega_city_cab_service.dao.CouponDAO;
import com.example.mega_city_cab_service.dao.LocationDAO;
import com.example.mega_city_cab_service.dao.VehicleTypeDAO;
import com.example.mega_city_cab_service.model.Booking;

import java.sql.SQLException;

public class UserBookingServices {

    private final BookingDAO bookingDAO;
    private final LocationDAO locationDAO;
    private final VehicleTypeDAO vehicleTypeDAO;
    private final CouponDAO couponDAO;

    public UserBookingServices() {
        this.bookingDAO = new BookingDAO();
        this.locationDAO = new LocationDAO();
        this.vehicleTypeDAO = new VehicleTypeDAO();
        this.couponDAO = new CouponDAO();
    }

    // Method to calculate the total amount for a booking
    public double calculateTotalAmount(int fromLocationId, int toLocationId, int vehicleTypeId, String couponCode) throws SQLException {
        // Fetch distance
        double distance = locationDAO.getDistance(fromLocationId, toLocationId);

        // Fetch vehicle type details
        double tax = vehicleTypeDAO.getVehicleTypeById(vehicleTypeId).getTax();
        double perKmRate = vehicleTypeDAO.getVehicleTypeById(vehicleTypeId).getPerKmRate();

        // Calculate base amount
        double baseAmount = distance * perKmRate;

        // Apply tax
        double taxAmount = (baseAmount * tax) / 100;

        // Validate coupon code
        double discount = 0;
        if (couponCode != null && !couponCode.isEmpty()) {
            double discountPercentage = couponDAO.getCouponByCode(couponCode).getDiscountPercentage();
            discount = (baseAmount * discountPercentage) / 100;
        }

        // Calculate total amount
        return baseAmount + taxAmount - discount;
    }

    // Method to save a booking
    public boolean bookCab(Booking booking) throws SQLException {
        return bookingDAO.addBooking(booking);
    }
}