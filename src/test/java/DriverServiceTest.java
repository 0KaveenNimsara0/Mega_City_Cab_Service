import com.example.mega_city_cab_service.model.Driver;
import com.example.mega_city_cab_service.service.DriverService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;
import java.util.List;

class DriverServiceTest {

    private DriverService driverService;

    @BeforeEach
    void setUp() {
        driverService = new DriverService();
    }

    @AfterEach
    void tearDown() {
        driverService = null;
    }

    @Test
    void testGetDriverById() {
        int driverId = 8;
        Driver driver = driverService.getDriverById(driverId);

        assertNotNull(driver, "Driver should not be null");
        assertEquals(driverId, driver.getDriverId(), "Driver ID should match");
    }

    @Test
    void testGetAvailableDrivers() {
        List<Driver> result = driverService.getAvailableDrivers();

        assertNotNull(result, "Available drivers list should not be null");
        assertTrue(result.size() > 0, "Available drivers list should contain data");
    }

    @Test
    void testAddDriver() {
        Driver driver = new Driver();
        driver.setName("Test Driver");
        driver.setPhone("1234567890");
        driver.setLicenseNumber("TEST123");

        boolean result = driverService.addDriver(driver);

        assertTrue(result, "Driver should be added successfully");
    }

    @Test
    void testDeleteDriver() {
        int driverId = 8;
        boolean result = driverService.deleteDriver(driverId);

        assertTrue(result, "Driver should be deleted successfully");
    }
}