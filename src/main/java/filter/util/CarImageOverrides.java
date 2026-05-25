package filter.util;

import carsale.model.Car;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

public final class CarImageOverrides {

    private static final Map<String, String> OVERRIDES = new HashMap<>();

    static {
        put("Toyota", "Highlander", "2017",
                "https://www.carpro.com/hs-fs/hubfs/car-review-blog/review_189333_1.jpg?width=1020&name=review_189333_1.jpg");
        put("Toyota", "Highlander", "2015",
                "https://imageio.forbes.com/blogs-images/matthewdepaula/files/2014/02/2014_Toyota_Highlander_Hybrid_Platinum_12.jpg?format=jpg&height=900&width=1600&fit=bounds");
        put("Toyota", "Highlander", "2014",
                "https://wildsau.ca/wp-content/uploads/2014/11/front-quarter1.jpg");
        put("Toyota", "Highlander", "2019",
                "https://images.hgmsites.net/hug/2015-toyota-highlander_100476909_h.jpg");
        put("Toyota", "Highlander", "2021",
                "https://hightechtexan.com/wp-content/uploads/2021/06/2021-Toyota-Highlander-Hybrid-Review.jpg");
        put("Toyota", "Highlander", "2022",
                "https://images.ctfassets.net/c9t6u0qhbv9e/2873JaO2D66jLJZFwhF95T/1bad97e742d4330be614800c561721aa/2022_Toyota_Highlander_Review_Lead_In.jpg");
        put("Honda", "Accord", "2014",
                "https://www.pexels.com/search/honda%20accord%202014/");
        put("Honda", "Grace", "2016",
                "https://www.kar-men.com/adminPanel/uploads/avis/veh_images/1658890026_image_11.jpg");
        put("Honda", "Civic", "2020",
                "https://img.autotrader.co.za/46291217");
        put("Hyundai", "H300", "2018",
                "https://en.hyundaiclub.eu/graphics/gallery/full/243_hyundai-i800-2008-03.jpg");
        put("Audi", "Q5", "2016",
                "https://i.gaw.to/vehicles/photos/07/55/075550_2016_audi_Q5.jpg?1024x640");
        put("Audi", "Q5", "2013",
                "https://www.pexels.com/search/audi%20q5%202013/");
        put("BMW", "X5", "2012",
                "https://www.motorbiscuit.com/wp-content/uploads/2025/01/2012-bmw-x5.jpg");
        put("BMW", "X5", "2015",
                "https://www.cnet.com/a/img/resize/a10ef62212429bd7445e7806e25af450fdde99ee/hub/2015/05/30/3e9d7185-46ec-47da-b323-29a2f40ba34c/2015bmwx5m-002.jpg?auto=webp&width=1200");
        put("BMW", "X5", "2016",
                "https://cdn.motor1.com/images/mgl/BBnk4/s1/2016-bmw-x5-xdrive40e.webp");
        put("BMW", "X5", "2017",
                "https://slmautocare.com/wp-content/uploads/2020/12/Photo-Dec-11-10-42-01-AM.jpg");
        put("BMW", "X5", "2023",
                "https://media-r2.carsandbids.com/cdn-cgi/image/width=2080,quality=70/20309e251cb7341d1fb94cb5d4546882260d2202/photos/3goMaOp8-fOg6ou9Fds-(edit).jpg?t=170052040419");
        put("BMW", "M3", "1997",
                "https://uploads.builtforbackroads.com/uploads/2025/04/2025.04.15-BMW-E36-M3-1997_1.jpg");
        // Fix for mislabeled cars (make is wrong but model points to correct brand)
        put("Toyota", "Camry", "2012",
                "https://images.hgmsites.net/hug/2012-toyota-camry_100353688_h.jpg");
        put("BMW", "Camry", "2017",
                "https://www.cnet.com/a/img/resize/a10ef62212429bd7445e7806e25af450fdde99ee/hub/2015/05/30/3e9d7185-46ec-47da-b323-29a2f40ba34c/2015bmwx5m-002.jpg?auto=webp&width=1200");
        put("Toyota", "Highlander", "2016",
                "https://i.gaw.to/vehicles/photos/07/55/075550_2016_audi_Q5.jpg?1024x640");
        put("Honda", "H200", "2020",
                "https://static.cargurus.com/images/forsale/2026/05/07/01/29/2019_honda_hr-v-pic-5088150584693423101-1024x768.jpeg");
        put("BMW", "Highlander", "2016",
                "https://cdn.motor1.com/images/mgl/BBnk4/s1/2016-bmw-x5-xdrive40e.webp");
        put("BMW", "Highlander", "2015",
                "https://c0.carsie.ie/d43864c90df075c94489ddbe4ca5ffe954a3cd5f700ad6141226babe495ae28d.jpg");
        put("BMW", "Highlander", "2015a",
                "https://f7432d8eadcf865aa9d9-9c672a3a4ecaaacdf2fee3b3e6fd2716.ssl.cf3.rackcdn.com/C3083/U594/IMG_9378-large.jpg");
        put("BMW", "Highlander", "2018",
                "https://wildsau.ca/wp-content/uploads/2014/11/front-quarter1.jpg");
        put("Mercedes", "Highlander", "2016",
                "https://www.suvdrive.com/sites/default/files/public/45%20angle%20view/45%20angle%20front%20Mercedes-Benz%20GLE-Class%20350%204MATIC%202018.jpg");
        put("Mercedes", "Highlander", "2018",
                "https://www.suvdrive.com/sites/default/files/public/45%20angle%20view/45%20angle%20front%20Mercedes-Benz%20GLE-Class%20350%204MATIC%202018.jpg");
        put("Audi", "Highlander", "2016",
                "https://i.gaw.to/vehicles/photos/07/55/075550_2016_audi_Q5.jpg?1024x640");
        put("Ford", "Fusion", "2015",
                "https://static.cargurus.com/images/site/2014/11/10/16/54/2015_ford_fusion-pic-727537750283656660-1600x1200.png");
        put("Mercedes", "C-Class", "2015",
                "https://media.drive.com.au/obj/tx_q:50,rs:auto:1920:1080:1/caradvice/private/d83cbdb335377ee1aa93a8293a4463ff");
        put("Mercedes", "C-Class", "2018",
                "https://www.pexels.com/search/mercedes%20c%20class%202018/");
    }

    private CarImageOverrides() {}

    private static void put(String make, String model, String year, String imageUrl) {
        OVERRIDES.put(listingKey(make, model, year), imageUrl);
    }

    public static String listingKey(Car car) {
        if (car == null) return "";
        return listingKey(car.getMake(), car.getModel(), car.getYear());
    }

    private static String listingKey(String make, String model, String year) {
        return normalize(make) + "|" + normalize(model) + "|" + normalize(year);
    }

    private static String normalize(String value) {
        if (value == null) return "";
        return value.trim().toLowerCase(Locale.ROOT);
    }

    /**
     * Looks up by model+year only, ignoring the (possibly wrong) make on the listing.
     * e.g. "BMW Highlander 2015" → finds "toyota|highlander|2015" entry.
     */
    private static String modelYearKey(String model, String year) {
        return normalize(model) + "|" + normalize(year);
    }

    private static String getByModelYear(Car car) {
        if (car == null) return null;
        String targetKey = modelYearKey(car.getModel(), car.getYear());
        for (Map.Entry<String, String> entry : OVERRIDES.entrySet()) {
            // OVERRIDES key format is "make|model|year"
            String[] parts = entry.getKey().split("\\|", 3);
            if (parts.length == 3) {
                String entryModelYear = parts[1] + "|" + parts[2];
                if (entryModelYear.equals(targetKey)) {
                    return entry.getKey();
                }
            }
        }
        return null;
    }

    private static String resolvedKey(Car car) {
        if (car == null) return "";
        String[] resolved = CarImageResolver.resolveSearchTerms(car);
        return listingKey(resolved[0], resolved[1], car.getYear());
    }

    private static String getMatchingKey(Car car) {
        if (car == null) return null;

        String exactKey = listingKey(car);
        if (OVERRIDES.containsKey(exactKey)) {
            return exactKey;
        }

        String resolved = resolvedKey(car);
        if (!resolved.isEmpty() && OVERRIDES.containsKey(resolved)) {
            return resolved;
        }

        return getByModelYear(car);
    }

    public static String getOverrideKey(Car car) {
        return getMatchingKey(car);
    }

    public static boolean hasOverride(Car car) {
        return getMatchingKey(car) != null;
    }

    public static String getImageUrl(Car car) {
        String key = getMatchingKey(car);
        if (key == null) {
            return null;
        }
        return OVERRIDES.get(key);
    }

    public static String getImageUrlByKey(String key) {
        if (key == null) return null;
        return OVERRIDES.get(key.trim().toLowerCase(Locale.ROOT));
    }
}