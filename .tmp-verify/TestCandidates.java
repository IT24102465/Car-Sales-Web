import java.net.HttpURLConnection;
import java.net.URL;

public class TestCandidates {
  public static void main(String[] args) throws Exception {
    String[] urls = new String[] {
      "https://images.hgmsites.net/hug/2015-toyota-highlander_100476909_h.jpg",
      "https://images.hgmsites.net/hug/2012-toyota-camry_100353688_h.jpg",
      "https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&w=1200&q=80",
      "https://images.unsplash.com/photo-1511919884226-fd3cad34687c?auto=format&fit=crop&w=1200&q=80",
      "https://cdn.motor1.com/images/mgl/BBnk4/s1/2016-bmw-x5-xdrive40e.webp",
      "https://www.motorbiscuit.com/wp-content/uploads/2025/01/2012-bmw-x5.jpg"
    };
    for (String urlStr : urls) {
      URL url = new URL(urlStr);
      HttpURLConnection conn = (HttpURLConnection) url.openConnection();
      conn.setRequestProperty("User-Agent", "SmartCarzone/1.0 (car listing images)");
      conn.setConnectTimeout(10000);
      conn.setReadTimeout(15000);
      conn.setInstanceFollowRedirects(true);
      int status = conn.getResponseCode();
      System.out.println(urlStr + " => status=" + status + ", contentType=" + conn.getContentType());
      conn.disconnect();
    }
  }
}
