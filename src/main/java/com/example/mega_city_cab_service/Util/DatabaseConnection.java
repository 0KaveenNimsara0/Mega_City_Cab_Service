package com.example.mega_city_cab_service.Util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConnection {
    private static DatabaseConnection instance;
    private Connection connection;

    private DatabaseConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
//             connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/mega_city", "root", "");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error connecting to the database", e);
        }
    }

    public static DatabaseConnection getInstance() {
        if (instance == null) {
            instance = new DatabaseConnection();
        }
        return instance;
    }

    /**
     * Retrieves a fresh database connection.
     *
     * @return A new database connection.
     */
    public Connection getConnection() {
        try {
            // Create and return a new connection for each request
            return DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/mega_city", "root", "");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error connecting to the database", e);
        }
    }


}
