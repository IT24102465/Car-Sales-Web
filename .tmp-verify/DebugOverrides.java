import carsale.model.Car;
import filter.util.CarImageOverrideUrls;
import filter.util.CarImageOverrides;
import java.util.Collections;

public class DebugOverrides {
  public static void main(String[] args) {
    Car h200 = new Car("Honda", "H200", "2020", "", "Excellent", "Manual", Collections.emptyList(), "", "Test", "test@example.com", "0770000000", "Colombo", "t1", "tester", "None", "34000");
    Car bmw = new Car("BMW", "Highlander", "2016", "", "Good", "Automatic", Collections.emptyList(), "", "Test", "test@example.com", "0770000000", "Colombo", "t2", "tester", "None", "34000");
    System.out.println("H200 exact=" + CarImageOverrides.listingKey(h200));
    System.out.println("H200 overrideKey=" + CarImageOverrides.getOverrideKey(h200));
    System.out.println("H200 hasOverride=" + CarImageOverrides.hasOverride(h200));
    System.out.println("H200 image=" + CarImageOverrides.getImageUrl(h200));
    System.out.println("H200 proxy=" + CarImageOverrideUrls.proxySrc("/smartcarzone", h200));
    System.out.println("BMW exact=" + CarImageOverrides.listingKey(bmw));
    System.out.println("BMW overrideKey=" + CarImageOverrides.getOverrideKey(bmw));
    System.out.println("BMW hasOverride=" + CarImageOverrides.hasOverride(bmw));
    System.out.println("BMW image=" + CarImageOverrides.getImageUrl(bmw));
    System.out.println("BMW proxy=" + CarImageOverrideUrls.proxySrc("/smartcarzone", bmw));
  }
}
