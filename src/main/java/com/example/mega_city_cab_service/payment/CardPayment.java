package com.example.mega_city_cab_service.payment;

public class CardPayment implements PaymentStrategy {

    @Override
    public boolean processPayment(double amount) {
        // Simulate card payment processing
        System.out.println("Processing card payment of LKR " + amount);

        // Add logic for card validation, authorization, etc.
        // For simplicity, assume the payment is successful
        return true;
    }
}