package filter.util;

import carsale.model.Car;
import filter.ds.LinkedList;

import java.util.ArrayList;
import java.util.List;

/**
 * Utility for converting between java.util.List and filter.ds.LinkedList,
 * and for providing a Comparable wrapper for Car.
 */
public class CarConversionUtil {
    // Convert java.util.List<String> to filter.ds.LinkedList<String>
    public static LinkedList<String> toCustomLinkedList(List<String> list) {
        LinkedList<String> custom = new LinkedList<>();
        if (list != null) {
            for (String s : list) {
                custom.add(s);
            }
        }
        return custom;
    }

    // Convert filter.ds.LinkedList<String> to java.util.List<String>
    public static List<String> toJavaList(LinkedList<String> custom) {
        List<String> list = new ArrayList<>();
        if (custom != null) {
            LinkedList<String>.LinkedListIterator it = custom.iterator();
            while (it.hasNext()) {
                list.add(it.next());
            }
        }
        return list;
    }

    /**
     * Wrapper for Car to provide Comparable<CarConversionUtil.CarComparable> by price.
     */
    public static class CarComparable implements Comparable<CarComparable> {
        private final Car car;
        public CarComparable(Car car) {
            this.car = car;
        }
        public Car getCar() {
            return car;
        }
        @Override
        public int compareTo(CarComparable other) {
            try {
                double thisPrice = Double.parseDouble(this.car.getPrice().replaceAll("[^\\d.]", ""));
                double otherPrice = Double.parseDouble(other.car.getPrice().replaceAll("[^\\d.]", ""));
                return Double.compare(thisPrice, otherPrice);
            } catch (Exception e) {
                return 0;
            }
        }
    }
} 