package com.example.mega_city_cab_service.factory;


import com.example.mega_city_cab_service.model.User;

public class UserFactory {

    // Factory method to create a User instance
    public static User createUser(String username, String password, String name, String email, String phone) {
        return new User(username, password, name, email, phone);
    }


}