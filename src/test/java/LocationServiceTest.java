import com.example.mega_city_cab_service.model.Location;
import com.example.mega_city_cab_service.service.LocationService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

class LocationServiceTest {

    private LocationService locationService;

    @BeforeEach
    void setUp() {
        locationService = new LocationService();
    }

    @AfterEach
    void tearDown() {
        locationService = null;
    }

    @Test
    void testGetAllLocations() throws SQLException {
        List<Location> result = locationService.getAllLocations();
        assertNotNull(result, "Locations list should not be null");
        assertTrue(result.size() > 0, "Locations list should contain data");
    }

    @Test
    void testGetLocationById() throws SQLException {
        int locationId = 1; // Replace with an existing ID for live testing
        Location location = locationService.getLocationById(locationId);
        assertNotNull(location, "Location should not be null");
        assertEquals(locationId, location.getLocationId(), "Location ID should match");
    }

    @Test
    void testGetDistance() throws SQLException {
        int fromLocationId = 1;
        int toLocationId = 2;
        double distance = locationService.getDistance(fromLocationId, toLocationId);

        assertTrue(distance > 0, "Distance should be greater than 0");
    }
}