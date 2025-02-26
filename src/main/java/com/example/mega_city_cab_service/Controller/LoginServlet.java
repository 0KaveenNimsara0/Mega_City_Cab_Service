package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.model.User;
import com.example.mega_city_cab_service.service.UserAccountServices;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class LoginServlet extends HttpServlet {

    private UserAccountServices userAccountServices =new UserAccountServices();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String usernameOrEmail = request.getParameter("usernameOrEmail");
        String password = request.getParameter("password");


        // Authenticate the user
        User user = userAccountServices.authenticateUser(usernameOrEmail, password);

        if (user != null) {
            // Create a session for the logged-in user
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getCustomerId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("email", user.getEmail());
            session.setAttribute("name", user.getName());

            // Redirect to the success page
            response.sendRedirect("Customer_Dashboard.jsp");
        } else {
            // Redirect to the error page
            response.sendRedirect("Login.jsp?error=true");
        }
    }



}
