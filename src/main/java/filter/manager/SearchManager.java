package filter.manager;

import carsale.model.Car;
import filter.ds.LinkedList;
import filter.ds.MergeSort;
import filter.model.CarFilter;
import filter.util.CarLoader;

import javax.servlet.ServletContext;

public class SearchManager {

    public static LinkedList<Car> search(CarFilter filter, boolean sortByPrice, ServletContext context) throws java.io.IOException {

        LinkedList<Car> allCars = CarLoader.loadCars(context);
        LinkedList<Car> filtered = new LinkedList<>();

        //Testing
        System.out.println("Loaded Cars:");

        LinkedList<Car>.LinkedListIterator it = allCars.iterator();
        while (it.hasNext()) {
            Car car = it.next();

            if (matchesFilter(car, filter)) {
                System.out.println("✅ MATCHED: " + car.getMake() + " | " + car.getModel());
                filtered.add(car);
            } else {
                System.out.println("❌ SKIPPED: " + car.getMake() + " | " + car.getModel());
            }
        }

        if (sortByPrice) {
            // Wrap cars for sorting
            LinkedList<filter.util.CarConversionUtil.CarComparable> comparableList = new LinkedList<>();
            LinkedList<Car>.LinkedListIterator fit = filtered.iterator();
            while (fit.hasNext()) {
                comparableList.add(new filter.util.CarConversionUtil.CarComparable(fit.next()));
            }
            MergeSort.sort(comparableList);
            // Unwrap after sorting
            filtered = new LinkedList<>();
            LinkedList<filter.util.CarConversionUtil.CarComparable>.LinkedListIterator cit = comparableList.iterator();
            while (cit.hasNext()) {
                filtered.add(cit.next().getCar());
            }
        }

        return filtered;
    }

    private static boolean matchesFilter(Car car, CarFilter filter) {
        //Testing
        System.out.println("Checking car: " + car.getMake() + " " + car.getModel());
        System.out.println("Against filter: make=" + filter.getMake());

        // Make
        if (filter.getMake() != null && !filter.getMake().trim().isEmpty()) {
            if (!car.getMake().trim().equalsIgnoreCase(filter.getMake().trim())) {
                System.out.println("Filtered out due to make mismatch: " + car.getMake() + " != " + filter.getMake());
                return false;
            }
        }

        // Model
        if (filter.getModel() != null && !filter.getModel().trim().isEmpty()) {
            if (!car.getModel().trim().equalsIgnoreCase(filter.getModel().trim())) {
                return false;
            }
        }

        // Transmission
        if (filter.getTransmission() != null && !filter.getTransmission().trim().isEmpty()) {
            if (!car.getTransmission().trim().equalsIgnoreCase(filter.getTransmission().trim())) {
                return false;
            }
        }

        // Year range (safe parsing)
        try {
            int year = Integer.parseInt(car.getYear().trim());
            if (filter.getMinYear() != null && year < filter.getMinYear()) {
                return false;
            }
            if (filter.getMaxYear() != null && year > filter.getMaxYear()) {
                return false;
            }
        } catch (NumberFormatException e) {
            System.out.println("⚠ Failed to parse year: " + car.getYear());
            return false;
        }

        // Price range (safe parsing)
        try {
            double price = Double.parseDouble(car.getPrice().replaceAll("[^\\d.]", "").trim());
            if (filter.getMinPrice() != null && price < filter.getMinPrice()) {
                return false;
            }
            if (filter.getMaxPrice() != null && price > filter.getMaxPrice()) {
                return false;
            }
        } catch (NumberFormatException e) {
            System.out.println("⚠ Failed to parse price: " + car.getPrice());
            return false;
        }

        return true;
    }

} 