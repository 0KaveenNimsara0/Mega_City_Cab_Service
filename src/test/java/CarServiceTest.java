import com.example.mega_city_cab_service.model.Car;
import com.example.mega_city_cab_service.service.CarService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;
import java.util.List;

class CarServiceTest {

    private CarService carService;

    @BeforeEach
    void setUp() {
        carService = new CarService();
    }

    @AfterEach
    void tearDown() {
        carService = null;
    }

    @Test
    void testGetAllCars() {
        List<Car> result = carService.getAllCars();

        assertNotNull(result, "Cars list should not be null");
        assertTrue(result.size() > 0, "Cars list should contain data");
    }

    @Test
    void testAddCar() {
        Car car = new Car();
        car.setCarId(String.valueOf(1));
        car.setModel("Toyota Corolla");
        car.setCapacity(4);
        car.setRegistrationNumber("ACU1839");

        boolean result = carService.addCar(car);
        assertTrue(result, "Car should be added successfully");
    }

    @Test
    void testChangeAvailability() {
        String carId = "1";
        boolean result = carService.changeAvailability(carId, true);

        assertTrue(result, "Car availability should be changed successfully");
    }

    @Test
    void testDeleteCar() {
        String carId = "1";
        boolean result = carService.deleteCar(carId);

        assertTrue(result, "Car should be deleted successfully");
    }
}