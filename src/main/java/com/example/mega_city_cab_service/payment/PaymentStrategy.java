package com.example.mega_city_cab_service.payment;

public interface PaymentStrategy {
    boolean processPayment(double amount);
}