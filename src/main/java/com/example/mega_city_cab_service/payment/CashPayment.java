package com.example.mega_city_cab_service.payment;

public class CashPayment implements PaymentStrategy {

    @Override
    public boolean processPayment(double amount) {
        // Simulate cash payment processing
        System.out.println("Processing cash payment of LKR " + amount);
        return true; // Assume cash payment is always successful
    }
}