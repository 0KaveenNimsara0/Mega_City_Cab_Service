package com.example.mega_city_cab_service.service;

import com.example.mega_city_cab_service.Util.passwordhash;
import com.example.mega_city_cab_service.dao.userDAO;
import com.example.mega_city_cab_service.model.User;
import com.example.mega_city_cab_service.factory.UserFactory;
import java.sql.SQLException;

public class UserAccountServices {
    private userDAO userDao;
    private passwordhash passwordHasher;

    // Constructor to initialize dependencies
    public UserAccountServices() {
        try {
            this.userDao = new userDAO(); // Initialize userDAO with persistent connection
        } catch (SQLException e) {
            System.err.println("Failed to initialize userDAO: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Database connection failed", e); // Wrap as runtime exception
        }
        this.passwordHasher = new passwordhash();
    }

    // Method to validate and register the user
    public boolean registerUser(String username, String password, String name, String email, String phone) {

        User user = UserFactory.createUser(username, password, name, email, phone);

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

    public User authenticateUser(String usernameOrEmail, String password) {
        // Retrieve the user from the database by username or email
        User user = userDao.getUserByUsernameOrEmail(usernameOrEmail);
        if (user == null) {
            System.out.println("User not found.");
            return null;
        }

        // Hash the entered password and compare it with the stored hash
        String hashedPassword = passwordHasher.hashPassword(password);
        if (hashedPassword.equals(user.getPassword())) {
            System.out.println("Authentication successful.");
            System.out.println("Username: " + user.getUsername());
            System.out.println("userID: " + user.getCustomerId());

            return user;
        } else {
            System.out.println("Authentication failed.");
            return null;
        }
    }
}
