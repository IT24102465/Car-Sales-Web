package filter.util;

import carsale.model.Car;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/** Builds same-origin URLs for {@link filter.servlets.FixedCarImageServlet}. */
public final class CarImageOverrideUrls {

    private CarImageOverrideUrls() {}

    public static String proxySrc(String contextPath, Car car) {
        String key = CarImageOverrides.getOverrideKey(car);
        if (key == null) {
            return null;
        }
        try {
            return contextPath + "/fixed-car-image?key="
                    + URLEncoder.encode(key, StandardCharsets.UTF_8.name());
        } catch (UnsupportedEncodingException e) {
            return contextPath + "/fixed-car-image?key=" + key;
        }
    }
}
