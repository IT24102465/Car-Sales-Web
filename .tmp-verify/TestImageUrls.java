import java.net.HttpURLConnection;
import java.net.URL;

public class TestImageUrls {
  public static void main(String[] args) throws Exception {
    String[] urls = new String[] {
      "https://images.ctfassets.net/c9t6u0qhbv9e/7YqNXxLJjTqx6q9qz9z9z9/f7b8c8d9e0f1g2h3i4j5k6l7/2020-honda-civic.jpg",
      "https://frankfurt.apollo.olxcdn.com/v1/files/au2xm4rrhnuc2-RO/image;s=2046x1360"
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
