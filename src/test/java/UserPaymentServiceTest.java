import com.example.mega_city_cab_service.model.BookingDetails;
import com.example.mega_city_cab_service.service.UserPaymentService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;
import java.sql.SQLException;
import java.util.List;

class UserPaymentServiceTest {

    private UserPaymentService userPaymentService;

    @BeforeEach
    void setUp() {
        userPaymentService = new UserPaymentService();
    }

    @AfterEach
    void tearDown() {
        userPaymentService = null;
    }

    @Test
    void testGetUserBookingsWithPayments() throws SQLException {
        int customerId = 1; // Replace with a valid customer ID for testing
        List<BookingDetails> result = userPaymentService.getUserBookingsWithPayments(customerId);

        assertNotNull(result, "Booking details list should not be null");
        assertTrue(result.size() > 0, "Booking details list should contain data");
    }
}