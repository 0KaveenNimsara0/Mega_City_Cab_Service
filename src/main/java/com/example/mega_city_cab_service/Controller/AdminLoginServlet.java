package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.service.AdminAccountService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class AdminLoginServlet extends HttpServlet {

    private AdminAccountService adminAccountService;

    public AdminLoginServlet() {
        this.adminAccountService = new AdminAccountService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate admin credentials using the service
        if (adminAccountService.authenticateAdmin(username, password)) {
            // Create a session for the admin
            HttpSession session = request.getSession();
            session.setAttribute("admin", username);

            // Redirect to the admin dashboard
            response.sendRedirect("admin_dashboard.jsp");
        } else {
            // Redirect back to the login page with an error message
            response.sendRedirect("admin_login.jsp?error=invalid_credentials");
        }
    }
}