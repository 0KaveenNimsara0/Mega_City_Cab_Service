package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.model.User;
import com.example.mega_city_cab_service.service.UserAccountServices;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class AdminUserManagementServlet extends HttpServlet {
    private final UserAccountServices userAccountServices;

    public AdminUserManagementServlet() {
        this.userAccountServices = new UserAccountServices();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch all users and set as a request attribute
        List<User> users = userAccountServices.getAllUsers();
        request.setAttribute("users", users);

        // Forward to the users management JSP
        request.getRequestDispatcher("admin_manage_users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int userId = Integer.parseInt(request.getParameter("userId"));

        if ("updateStatus".equals(action)) {
            String status = request.getParameter("status");
            if (userAccountServices.updateUserStatus(userId, status)) {
                response.sendRedirect("AdminUserManagementServlet?message=Status updated successfully");
            } else {
                response.sendRedirect("AdminUserManagementServlet?error=Failed to update status");
            }
        }
    }
}