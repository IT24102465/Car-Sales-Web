package filter.util;

import carsale.model.Car;
import junit.framework.TestCase;

import java.util.Collections;

public class CarImageOverrideUrlsTest extends TestCase {

    public void testProxyUsesResolvedOverrideKeyForMislabeledBMWCamry() {
        Car car = new Car(
                "BMW",
                "Camry",
                "2012",
                "",
                "Fair",
                "Automatic",
                Collections.emptyList(),
                "",
                "Test",
                "test@example.com",
                "0770000000",
                "Colombo",
                "timestamp-1",
                (String) null,
                "None",
                "34000"
        );

        String src = CarImageOverrideUrls.proxySrc("/smartcarzone", car);

        assertNotNull(src);
        assertTrue(src.contains("key=toyota%7Ccamry%7C2012"));
    }

    public void testMercedesHighlander2018UsesOverride() {
        Car car = new Car(
                "Mercedes",
                "Highlander",
                "2018",
                "",
                "Fair",
                "Automatic",
                Collections.emptyList(),
                "",
                "Test",
                "test@example.com",
                "0770000000",
                "Colombo",
                "timestamp-2",
                (String) null,
                "None",
                "34000"
        );

        assertTrue(CarImageOverrides.hasOverride(car));
        assertNotNull(CarImageOverrides.getImageUrl(car));
    }
}
