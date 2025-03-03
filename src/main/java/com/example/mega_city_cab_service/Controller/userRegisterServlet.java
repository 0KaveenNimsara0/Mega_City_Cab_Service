package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.model.User;
import com.example.mega_city_cab_service.service.UserAccountServices;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


public class userRegisterServlet extends HttpServlet {
    private UserAccountServices userAccountServices = new UserAccountServices();

@Override
   protected void doPost (HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
            User user = new User();
           // Retrieve form data
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String Name = request.getParameter("Name");

            user.setUsername(username);
            user.setPassword(password);
            user.setEmail(email);
            user.setPhone(phone);
            user.setName(Name);
// Attempt to register the user
    boolean isRegistered = userAccountServices.registerUser(user);
       // Redirect based on registration result
       if (isRegistered) {
           // Registration successful, redirect to success page
           response.sendRedirect("Login.jsp");
       } else {
           // Registration failed, redirect to error page
           response.sendRedirect("Register.jsp");
           response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
       }
    }
}
