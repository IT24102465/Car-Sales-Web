package filter.servlets;

import filter.util.CarImageOverrides;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * Serves fixed override car images through the app (avoids broken hotlinks / referrer blocks).
 */
@WebServlet("/fixed-car-image")
public class FixedCarImageServlet extends HttpServlet {

    private static final String USER_AGENT = "SmartCarzone/1.0 (car listing images)";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String key = request.getParameter("key");
        String imageUrl = CarImageOverrides.getImageUrlByKey(key);
        if (imageUrl == null || imageUrl.isEmpty()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        HttpURLConnection connection = null;
        try {
            connection = (HttpURLConnection) new URL(imageUrl).openConnection();
            connection.setRequestProperty("User-Agent", USER_AGENT);
            connection.setConnectTimeout(10000);
            connection.setReadTimeout(15000);
            connection.setInstanceFollowRedirects(true);

            int status = connection.getResponseCode();
            if (status < 200 || status >= 300) {
                response.sendError(HttpServletResponse.SC_BAD_GATEWAY);
                return;
            }

            String contentType = connection.getContentType();
            if (contentType != null && contentType.startsWith("image/")) {
                response.setContentType(contentType);
            } else {
                response.setContentType("image/jpeg");
            }
            response.setHeader("Cache-Control", "public, max-age=86400");

            try (InputStream in = connection.getInputStream();
                 OutputStream out = response.getOutputStream()) {
                byte[] buffer = new byte[8192];
                int read;
                while ((read = in.read(buffer)) != -1) {
                    out.write(buffer, 0, read);
                }
            }
        } catch (IOException e) {
            response.sendError(HttpServletResponse.SC_BAD_GATEWAY);
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }
    }
}
