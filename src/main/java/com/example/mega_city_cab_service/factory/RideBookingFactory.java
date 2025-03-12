package com.example.mega_city_cab_service.factory;

import com.example.mega_city_cab_service.model.Booking;

import java.sql.Timestamp;

public class RideBookingFactory extends BookingFactory {
    @Override
    public Booking createBooking(
            int customerID,
            int pickupPoint,
            int destination,
            String carType,
            Timestamp pickupDate,
            double amount,
            String couponCode
    ) {
        Booking rideBooking = new Booking();
        rideBooking.setCustomerID(customerID);
        rideBooking.setPickupPoint(pickupPoint);
        rideBooking.setDestination(destination);
        rideBooking.setCarType(carType);
        rideBooking.setPickupDate(pickupDate);
        rideBooking.setAmount(amount);
        rideBooking.setStatus("Pending");
        rideBooking.setCouponCode(couponCode);
        return rideBooking;

    }

}