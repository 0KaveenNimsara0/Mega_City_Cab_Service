package com.example.mega_city_cab_service.service;

import com.example.mega_city_cab_service.Util.passwordhash;
import com.example.mega_city_cab_service.dao.userDAO;
import com.example.mega_city_cab_service.model.User;

public class UserRegisterService {
    private userDAO userDao = new userDAO();
    private passwordhash passwordHasher = new passwordhash();

    // Method to validate and register the user
    public boolean registerUser(User user) {
        System.out.println("Validating user: " + user);
        // Perform basic validation (you can add more complex validation if needed)
        if (user.getUsername() == null || user.getUsername().isEmpty() ||
                user.getPassword() == null || user.getPassword().isEmpty() ||
                user.getEmail() == null || user.getEmail() .isEmpty() ||
                user.getPhone() == null || user.getPhone().isEmpty() ||
                user.getName() == null || user.getName().isEmpty()) {
            System.out.println("Validation failed: One or more fields are empty.");


            System.out.println("Username: " + user.getUsername());
            System.out.println("Password: " + user.getPassword());
            System.out.println("Email: " + user.getEmail());
            System.out.println("Phone: " + user.getPhone());
            System.out.println("Name: " + user.getName());
            return false;
        }
        // Hash the password before store the
        String hashedPassword = passwordHasher.hashPassword(user.getPassword());
        user.setPassword(hashedPassword);

        // Delegate the registration process to the DAO
        return userDao.registerUser(user);
    }
}
