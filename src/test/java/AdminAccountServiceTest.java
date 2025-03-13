

import com.example.mega_city_cab_service.service.AdminAccountService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class AdminAccountServiceTest {

    private AdminAccountService adminAccountService;

    @BeforeEach
    void setUp() {
        adminAccountService = new AdminAccountService();
    }

    @AfterEach
    void tearDown() {
        adminAccountService = null;
    }

    @Test
    void testAuthenticateAdmin() {
        // Test with correct credentials
        assertTrue(adminAccountService.authenticateAdmin("admin", "admin123"), "Admin authentication should succeed with valid credentials");

        // Test with incorrect credentials
        assertFalse(adminAccountService.authenticateAdmin("wronguser", "wrongpassword"), "Admin authentication should fail with invalid credentials");
    }
}