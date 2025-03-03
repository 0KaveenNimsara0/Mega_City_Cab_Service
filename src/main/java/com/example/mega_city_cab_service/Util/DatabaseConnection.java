package com.example.mega_city_cab_service.Util;

import java.sql.Connection;
import java.sql.DriverManager;


// use singleton design pattern to create database
public class DatabaseConnection {
    private static DatabaseConnection instance;
    private Connection connection;

    private DatabaseConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://127.0.0.1:3306/mega_city";
            String user = "root";
            String password = "";
            connection = DriverManager.getConnection(url, user, password);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error connecting to the database", e);
        }
    }
//lazy initialization/double-checked locking
    public static synchronized DatabaseConnection getInstance() {
        if (instance == null) {
            instance = new DatabaseConnection();
        }
        return instance;
    }

    public Connection getConnection() {
        return connection;
    }


}

//public class DatabaseConnection {
//
//    // Static method to create and return a new connection
//    public static Connection getConnection() {
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//            return DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/mega_city", "root", "");
//        } catch (Exception e) {
//            e.printStackTrace();
//            throw new RuntimeException("Error connecting to the database", e);
//        }
//    }
//
//    // Utility method to close a connection
//    public static void closeConnection(Connection connection) {
//        if (connection != null) {
//            try {
//                connection.close();
//            } catch (SQLException e) {
//                e.printStackTrace();
//            }
//        }
//    }
//}