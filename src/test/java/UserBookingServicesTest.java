import com.example.mega_city_cab_service.model.Booking;
import com.example.mega_city_cab_service.service.UserBookingServices;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;
import java.sql.Timestamp;

import static org.junit.jupiter.api.Assertions.*;

class UserBookingServicesTest {

    private UserBookingServices userBookingServices;

    @BeforeEach
    void setUp() {
        // Initialize the service
        userBookingServices = new UserBookingServices();
    }

    @AfterEach
    void tearDown() {
        userBookingServices = null;
    }

    @Test
    void testCalculateTotalAmount() throws SQLException {

        int fromLocationId = 1;
        int toLocationId = 2;
        int vehicleTypeId = 1;
        String couponCode = "HELLO";

        double totalAmount = userBookingServices.calculateTotalAmount(
                fromLocationId, toLocationId, vehicleTypeId, couponCode
        );

        assertTrue(totalAmount > 0, "The total amount should be calculated and be greater than 0");
    }

    @Test
    void testBookCab() throws SQLException {
        // Create a sample Booking object
        Booking booking = new Booking();
        booking.setCustomerID(1);
        booking.setPickupPoint(1);
        booking.setDestination(2);
        booking.setPickupDate(new Timestamp(System.currentTimeMillis()));
        booking.setCarType("Sedan");
        booking.setAmount(500.00);
        booking.setStatus("Confirmed");
        booking.setCouponCode("DISCOUNT2025");

        // Call the bookCab method
        boolean result = userBookingServices.bookCab(booking);

        // Assertions
        assertTrue(result, "Booking should be successful and return true");
    }
}