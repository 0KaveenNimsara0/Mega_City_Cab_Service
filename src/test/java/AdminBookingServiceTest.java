import com.example.mega_city_cab_service.model.BookingDetails;
import com.example.mega_city_cab_service.model.Car;
import com.example.mega_city_cab_service.model.Payment;
import com.example.mega_city_cab_service.service.AdminBookingService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class AdminBookingServiceTest {

    private AdminBookingService adminBookingService;

    @BeforeEach
    void setUp() {
        // Initialize the service
        adminBookingService = new AdminBookingService();
    }

    @AfterEach
    void tearDown() {
        adminBookingService = null;
    }

    @Test
    void testGetBookingsByCustomerID() throws SQLException {

        String customerID = "2";
        List<BookingDetails> bookings = adminBookingService.getBookingsByCustomerID(customerID);

        assertNotNull(bookings, "Bookings list should not be null");
        assertTrue(bookings.size() >= 0, "Bookings list size should be valid (0 or more)");
    }

    @Test
    void testGetAllBookings() {
        List<BookingDetails> bookings = adminBookingService.getAllBookings();

        assertNotNull(bookings, "Bookings list should not be null");
        assertTrue(bookings.size() >= 0, "Bookings list size should be valid (0 or more)");
    }

    @Test
    void testUpdateBookingStatus() {
        int bookingID = 64;
        String newStatus = "Completed";

        boolean result = adminBookingService.updateBookingStatus(bookingID, newStatus);

        assertTrue(result, "Booking status should be updated successfully");
    }

    @Test
    void testAssignCarToBooking() {
        int bookingID = 64;
        int carId = 39;

        boolean result = adminBookingService.assignCarToBooking(bookingID, String.valueOf(carId));

        assertTrue(result, "Car should be successfully assigned to the booking");
    }

    @Test
    void testGetPaymentDetailsByBookingId() {
        int bookingId = 65;
        Payment payment = adminBookingService.getPaymentDetailsByBookingId(bookingId);

        assertNotNull(payment, "Payment details should not be null");
        assertEquals(String.valueOf(bookingId), payment.getBookingId(), "Payment booking ID must match the input booking ID");
    }

    @Test
    void testGetCarById() {
        int carId = 39;
        Car car = adminBookingService.getCarById(String.valueOf(carId));

        assertNotNull(car, "Car should not be null");
        assertEquals(carId, Integer.parseInt(car.getCarId()), "Car ID must match the input car ID");
    }

    @Test
    void testGetCarAndDriverDetailsByBookingId() throws SQLException {
        int bookingId = 64;

        BookingDetails bookingDetails = adminBookingService.getCarAndDriverDetailsByBookingId(bookingId);

        assertNotNull(bookingDetails, "Booking Details should not be null");
        assertNotNull(bookingDetails.getVehicleModel(), "Vehicle model should not be null");
        assertNotNull(bookingDetails.getVehicleRegistration(), "Vehicle registration should not be null");
        assertNotNull(bookingDetails.getDriverName(), "Driver name should not be null");
        assertNotNull(bookingDetails.getDriverPhone(), "Driver phone should not be null");


    }
}