package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.model.User;
import com.example.mega_city_cab_service.service.UserAccountServices;

import jakarta.servlet.ServletException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;


public class UpdateProfileServlet extends HttpServlet {

    private final UserAccountServices userAccountServices;

    public UpdateProfileServlet() {
        this.userAccountServices = new UserAccountServices();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Redirect to login if the session is invalid or userId is missing
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Retrieve the customerId from the session
        int customerId = (int) session.getAttribute("userId");

        try {
            // Fetch the user's details from the database
            User user = userAccountServices.getUserById(customerId);
            if (user != null) {
                // Pass the user details as request attributes
                request.setAttribute("name", user.getName());
                request.setAttribute("email", user.getEmail());
                request.setAttribute("phone", user.getPhone());
                request.setAttribute("address", user.getAddress());
                request.setAttribute("nic", user.getNic());

                // Forward to the update profile page
                request.getRequestDispatcher("update_profile.jsp").forward(request, response);
            } else {
                response.sendRedirect("error.jsp?message=User not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=An unexpected error occurred while fetching user details");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Redirect to login if the session is invalid or userId is missing
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Retrieve the customerId from the session
        int customerId = (int) session.getAttribute("userId");

        try {
            // Retrieve form data
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String nic = request.getParameter("nic");

            // Fetch the existing user details
            User user = userAccountServices.getUserById(customerId);
            if (user == null) {
                response.sendRedirect("error.jsp?message=User not found");
                return;
            }

            // Update user details
            user.setName(name);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);
            user.setNic(nic);

            // Save the updated profile
            boolean isUpdated = userAccountServices.updateUserProfile(user);
            if (isUpdated) {
                // Redirect to the dashboard with a success message
                response.sendRedirect("Customer_Dashboard.jsp?message=Profile updated successfully");
            } else {
                // Redirect to an error page if the update fails
                response.sendRedirect("error.jsp?message=Failed to update profile");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=An unexpected error occurred while updating profile");
        }
    }
}