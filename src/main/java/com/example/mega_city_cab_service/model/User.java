package com.example.mega_city_cab_service.model;

public class User {
    private int customerId;
    private String username;
    private String password;
    private String Name;
    private String email;
    private String phone;


    public User(int customerId, String username, String password, String Name, String email, String phone) {
        this.customerId = customerId;
        this.username = username;
        this.password = password;
        this.Name = Name;
        this.email = email;
        this.phone = phone;
    }

    public User(int customerId, String username, String password) {
        this.customerId = customerId;
        this.username = username;
        this.password = password;
    }

    // Default constructor
    public User() {}



    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

}
