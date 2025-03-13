import com.example.mega_city_cab_service.model.VehicleType;
import com.example.mega_city_cab_service.service.VehicleTypeService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class VehicleTypeServiceTest {
    private VehicleTypeService vehicleTypeService;

    @BeforeEach
    void setUp() {
        // Initialize the service
        vehicleTypeService = new VehicleTypeService();
    }

    @AfterEach
    void tearDown() {
        vehicleTypeService = null;
    }

    @Test
    void testGetAllVehicleTypes() throws SQLException {
        List<VehicleType> mockVehicleTypes = new ArrayList<>();
        mockVehicleTypes.add(new VehicleType(1, "Sedan", 10.0, 1.5)); // Fake data
        mockVehicleTypes.add(new VehicleType(2, "SUV", 15.0, 2.0)); // Fake data

        List<VehicleType> result = vehicleTypeService.getAllVehicleTypes();
        assertNotNull(result, "Vehicle types should not be null");
        // Uncomment real comparison if DAO returns hardcoded values
        // assertEquals(mockVehicleTypes.size(), result.size(), "Vehicle types count must match");
    }

    @Test
    void testGetVehicleTypeById() throws SQLException {
        VehicleType result = vehicleTypeService.getVehicleTypeById(1);

        assertNotNull(result, "Vehicle type should not be null");
        assertEquals(1, result.getTypeId(), "VehicleType ID must be 1");
    }

    @Test
    void testAddVehicleType() throws SQLException {
        VehicleType vehicleType = new VehicleType(3, "Hatchback", 8.0, 1.2);

        boolean result = vehicleTypeService.addVehicleType(vehicleType);
        assertTrue(result, "VehicleType should be added successfully");
    }

    @Test
    void testUpdateVehicleType() throws SQLException {
        VehicleType vehicleType = new VehicleType(1, "Updated Sedan", 12.0, 1.8);

        boolean result = vehicleTypeService.updateVehicleType(vehicleType);
        assertTrue(result, "VehicleType should be updated successfully");
    }

    @Test
    void testDeleteVehicleType() throws SQLException {
        boolean result = vehicleTypeService.deleteVehicleType(2);
        assertTrue(result, "VehicleType should be deleted successfully");
    }
}