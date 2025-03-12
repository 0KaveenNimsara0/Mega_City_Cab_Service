package com.example.mega_city_cab_service.factory;

import com.example.mega_city_cab_service.model.Booking;

import java.sql.Timestamp;

public abstract class BookingFactory {
    public abstract Booking createBooking(
            int customerID,
            int pickupPoint,
            int destination,
            String carType,
            Timestamp pickupDate,
            double amount,
            String couponCode
    );
}