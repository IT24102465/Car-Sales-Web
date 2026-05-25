import carsale.model.Car;
import filter.util.CarImageOverrideUrls;
import filter.util.CarImageOverrides;
import java.util.Collections;

public class Verify {
  public static void main(String[] args) {
    Car camry = new Car("BMW", "Camry", "2012", "", "Fair", "Automatic", Collections.emptyList(), "", "Test", "test@example.com", "0770000000", "Colombo", "t1", "tester", "None", "34000");
    Car mercedes = new Car("Mercedes", "Highlander", "2018", "", "Fair", "Automatic", Collections.emptyList(), "", "Test", "test@example.com", "0770000000", "Colombo", "t2", "tester", "None", "34000");
    System.out.println("BMW Camry proxy: " + CarImageOverrideUrls.proxySrc("/smartcarzone", camry));
    System.out.println("BMW Camry hasOverride: " + CarImageOverrides.hasOverride(camry));
    System.out.println("Mercedes Highlander hasOverride: " + CarImageOverrides.hasOverride(mercedes));
    System.out.println("Mercedes Highlander image: " + CarImageOverrides.getImageUrl(mercedes));
  }
}
