import carsale.model.Car;
import filter.util.CarLoader;

public class CheckM3Entry {
    public static void main(String[] args) {
        String line = "2025-05-25 10:00:00 | BMW | M3 | 1997 | 25000 | Good | Manual | A/C,Airbags,Alloy Wheels | Rare sporty coupe with classic BMW handling | Vishadi | ramodyavishadi@gmail.com | 0770457072 | Colombo | BMW_E36_M3_1997.jpg";
        Car car = CarLoader.parseLine(line);
        System.out.println(car.getMake());
        System.out.println(car.getModel());
        System.out.println(car.getYear());
        System.out.println(car.getPrice());
        System.out.println(car.getLocation());
        System.out.println(car.getImages());
    }
}
