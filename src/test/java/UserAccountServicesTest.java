import com.example.mega_city_cab_service.model.User;
import com.example.mega_city_cab_service.service.UserAccountServices;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class UserAccountServicesTest {
    private UserAccountServices userAccountServices;

    @BeforeEach
    void setUp() {
        // Initialize the service
        userAccountServices = new UserAccountServices();
    }

    @AfterEach
    void tearDown() {
        userAccountServices = null;
    }

    @Test
    void testRegisterUser() {
        User user = new User();
        user.setUsername("testuser");
        user.setPassword("test123");
        user.setEmail("testuser@example.com");
        user.setPhone("1234567890");
        user.setName("Test User");

        boolean result = userAccountServices.registerUser(user);
        assertTrue(result, "User should be registered successfully");
    }

    @Test
    void testAuthenticateUser() {
        // Test with valid credentials
        User user = userAccountServices.authenticateUser("testuser", "test123");
        assertNotNull(user, "Authenticated user should not be null");
        assertEquals("testuser", user.getUsername(), "Username must match");

        // Test with invalid credentials
        User invalidUser = userAccountServices.authenticateUser("wronguser", "wrongpassword");
        assertNull(invalidUser, "Invalid credentials should return null");
    }

    @Test
    void testGetUserById() {
        User user = userAccountServices.getUserById(1);
        assertNotNull(user, "User should not be null");
        assertEquals(1, user.getCustomerId(), "User ID should be 1");
    }

    @Test
    void testUpdateUserProfile() {
        User user = new User();
        user.setCustomerId(1);
        user.setUsername("updatedUser");
        user.setEmail("updated@example.com");
        user.setPhone("0987654321");
        user.setName("Updated User");

        boolean result = userAccountServices.updateUserProfile(user);
        assertTrue(result, "User profile should be updated successfully");
    }
}