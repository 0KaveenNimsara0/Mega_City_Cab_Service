import com.example.mega_city_cab_service.model.Coupon;
import com.example.mega_city_cab_service.service.CouponService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CouponServiceTest {
    private CouponService couponService;

    @BeforeEach
    void setUp() {
        // Initialize service
        couponService = new CouponService();
    }

    @AfterEach
    void tearDown() {
        couponService = null;
    }

    @Test
    void testValidateCoupon() throws Exception {
        double discount = couponService.validateCoupon("HELLO");
        assertTrue(discount > 0, "Discount should be greater than 0 for valid coupons");
    }

    @Test
    void testGetCouponByCode() throws Exception {
        Coupon coupon = couponService.getCouponByCode("HELLO");
        assertNotNull(coupon, "Coupon should not be null");
        assertEquals("HELLO", coupon.getCouponCode(), "Coupon code must match");
    }

    @Test
    void testAddCoupon() throws Exception {
        Coupon coupon = new Coupon();
        coupon.setCouponCode("NEWCOUPON");
        coupon.setDiscountPercentage(15.0);
        coupon.setValidUntil(java.sql.Date.valueOf("2025-06-30"));

        boolean result = couponService.addCoupon(coupon);
        assertTrue(result, "New coupon should be added successfully");
    }

    @Test
    void testDeleteCoupon() throws Exception {
        boolean result = couponService.deleteCoupon(11);
        assertTrue(result, "Coupon should be deleted successfully");
    }

    @Test
    void testUpdateCoupon() throws Exception {
        Coupon coupon = new Coupon();
        coupon.setCouponId(3);
        coupon.setCouponCode("UPDATEDCOUPON");
        coupon.setDiscountPercentage(20.0);
        coupon.setValidUntil(java.sql.Date.valueOf("2025-06-30"));

        boolean result = couponService.updateCoupon(coupon);
        assertTrue(result, "Coupon should be updated successfully");
    }
}