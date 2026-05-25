package filter.util;

import carsale.model.Car;
import filter.ds.LinkedList;

import javax.servlet.ServletContext;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class CarLoader {

    private CarLoader() {}

    public static LinkedList<Car> loadCars(ServletContext context) throws IOException {
        LinkedList<Car> cars = new LinkedList<>();
        String path = context.getRealPath("/SellCarDetails/salecardetails.txt");
        System.out.println("[CarLoader] Loading cars from: " + path);

        File file = new File(path);
        if (!file.exists()) {
            System.err.println("[CarLoader] File not found: " + path);
            return cars;
        }

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            int lineNum = 0;
            while ((line = br.readLine()) != null) {
                lineNum++;
                if (line.trim().isEmpty()) {
                    continue;
                }
                Car car = parseLine(line);
                if (isValidCar(car)) {
                    normalizeCarImage(car);
                    cars.add(car);
                } else {
                    System.err.println("[CarLoader] Skipping invalid line " + lineNum);
                }
            }
        }
        System.out.println("[CarLoader] Loaded cars: " + cars.size());
        return cars;
    }

    public static List<Car> loadCarsAsList(ServletContext context) throws IOException {
        LinkedList<Car> linked = loadCars(context);
        List<Car> list = new ArrayList<>();
        LinkedList<Car>.LinkedListIterator it = linked.iterator();
        while (it.hasNext()) {
            list.add(it.next());
        }
        return list;
    }

    static Car parseLine(String line) {
        String[] raw = line.split("\\|");
        String[] parts = new String[raw.length];
        for (int i = 0; i < raw.length; i++) {
            parts[i] = raw[i].trim();
        }

        if (parts.length < 13) {
            return null;
        }

        List<String> featuresList = Arrays.asList(parts[7].split(","));

        // 16-field format (ProcessSellServlet): timestamp | make | model | year | mileage | ...
        if (parts.length >= 16) {
            return new Car(
                    parts[1],
                    parts[2],
                    parts[3],
                    parts[4],
                    parts[5],
                    parts[6],
                    featuresList,
                    emptyToNull(parts[8]),
                    parts[9],
                    parts[10],
                    parts[11],
                    parts[13],
                    parts[0],
                    parts[14],
                    parts[15],
                    parts[12]
            );
        }

        // Legacy 14-field format: price at index 4, location at 12, image optional at 13
        String images = parts.length > 13 ? parts[13] : "";
        return new Car(
                parts[1],
                parts[2],
                parts[3],
                "",
                parts[5],
                parts[6],
                featuresList,
                emptyToNull(parts[8]),
                parts[9],
                parts[10],
                parts[11],
                parts[12],
                parts[0],
                "",
                images,
                parts[4]
        );
    }

    private static void normalizeCarImage(Car car) {
        // Display image comes from the web (see car-image-loader.js), not local files
    }

    public static boolean isValidCar(Car car) {
        if (car == null) {
            return false;
        }
        if (isBlankOrNull(car.getMake()) || isBlankOrNull(car.getModel())) {
            return false;
        }
        try {
            Integer.parseInt(car.getYear().trim());
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    public static String resolveImagePath(String contextPath, String images) {
        return resolveImagePath(contextPath, images, null);
    }

    public static String resolveImagePath(String contextPath, String images, Car car) {
        if (car != null) {
            return CarImageResolver.LOADING_PLACEHOLDER;
        }
        if (images == null || images.trim().isEmpty() || images.startsWith("data:") || images.startsWith("http")) {
            return images != null && !images.isEmpty() ? images : CarImageResolver.LOADING_PLACEHOLDER;
        }
        return CarImageResolver.LOADING_PLACEHOLDER;
    }

    private static boolean isBlankOrNull(String value) {
        return value == null || value.trim().isEmpty() || "null".equalsIgnoreCase(value.trim());
    }

    private static String emptyToNull(String value) {
        if (value == null || value.trim().isEmpty() || "None".equalsIgnoreCase(value.trim())) {
            return null;
        }
        return value.trim();
    }
}
