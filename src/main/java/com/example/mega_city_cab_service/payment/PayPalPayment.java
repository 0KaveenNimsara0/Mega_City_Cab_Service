package com.example.mega_city_cab_service.payment;

public class PayPalPayment implements PaymentStrategy {

    @Override
    public boolean processPayment(double amount) {
        // Simulate PayPal payment processing
        System.out.println("Processing PayPal payment of LKR " + amount);

        // Add logic for PayPal API integration
        // For simplicity, assume the payment is successful
        return true;
    }
}