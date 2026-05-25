package filter.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.HashSet;
import java.util.Set;

@WebServlet("/favorite")
public class FavoriteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        login.model.User user = (session != null) ? (login.model.User) session.getAttribute("user") : null;
        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        String userEmail = user.getEmail();
        String safeEmail = userEmail.replaceAll("[^a-zA-Z0-9]", "_");
        String FAVORITES_FILE = "/WEB-INF/data/favorites_" + safeEmail + ".txt";

        String carId = request.getParameter("carId");
        String action = request.getParameter("action"); // "add" or "remove"

        if (carId == null || carId.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        String filePath = getServletContext().getRealPath(FAVORITES_FILE);
        File file = new File(filePath);
        file.getParentFile().mkdirs(); // Ensure directory exists

        Set<String> favorites = new HashSet<>();

        // Load existing favorites
        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    favorites.add(line.trim());
                }
            }
        }

        if ("remove".equalsIgnoreCase(action)) {
            favorites.remove(carId);
        } else {
            favorites.add(carId);
        }

        // Write updated favorites back to file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, false))) {
            for (String id : favorites) {
                writer.write(id);
                writer.newLine();
            }
        }

        response.setStatus(HttpServletResponse.SC_OK);
    }
} 