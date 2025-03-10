package com.example.mega_city_cab_service.Controller;

import com.example.mega_city_cab_service.model.BookingDetails;
import com.example.mega_city_cab_service.model.Car;
import com.example.mega_city_cab_service.model.Payment;
import com.example.mega_city_cab_service.service.BookingService;
import com.example.mega_city_cab_service.service.CarService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminBookingServlet extends HttpServlet {
    private final BookingService bookingService;
    private final CarService carService;

    public AdminBookingServlet() {
        this.bookingService = new BookingService();
        this.carService = new CarService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Fetch all bookings
            List<BookingDetails> bookings = bookingService.getAllBookings();
            request.setAttribute("bookings", bookings);
            // Fetch available cars
            List<Car> cars = carService.getAvailableCars();
            request.setAttribute("cars", cars);
            // Fetch payment details for each booking
            Map<Integer, Payment> paymentDetailsMap = new HashMap<>();
            for (BookingDetails booking : bookings) {

                Payment payment = bookingService.getPaymentDetailsByBookingId(booking.getBookingID());
                if (payment != null) {
                    paymentDetailsMap.put(booking.getBookingID(), payment);
                }
                BookingDetails carAndDriverDetails = bookingService.getCarAndDriverDetailsByBookingId(booking.getBookingID());
                if (carAndDriverDetails != null) {
                    booking.setVehicleModel(carAndDriverDetails.getVehicleModel());
                    booking.setVehicleRegistration(carAndDriverDetails.getVehicleRegistration());
                    booking.setDriverName(carAndDriverDetails.getDriverName());
                    booking.setDriverPhone(carAndDriverDetails.getDriverPhone());
                }

            }
            request.setAttribute("paymentDetailsMap", paymentDetailsMap);
            // Set the bookings as a request attribute
            request.setAttribute("bookings", bookings);

            // Forward to the JSP page
            request.getRequestDispatcher("admin_bookings.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Failed to fetch bookings");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("updateStatus".equals(action)) {
            int bookingID = Integer.parseInt(request.getParameter("bookingID"));
            String status = request.getParameter("status");

            if (bookingService.updateBookingStatus(bookingID, status)) {
                response.sendRedirect("AdminBookingServlet?message=Booking status updated successfully");
            } else {
                response.sendRedirect("AdminBookingServlet?error=Failed to update booking status");
            }
        } else if ("assignCar".equals(action)) {
            int bookingID = Integer.parseInt(request.getParameter("bookingID"));
            String carId = request.getParameter("carId");

            if (bookingService.assignCarToBooking(bookingID, carId)) {
                response.sendRedirect("AdminBookingServlet?message=Car assigned successfully");
            } else {
                response.sendRedirect("AdminBookingServlet?error=Failed to assign car");
            }
        }
    }
}