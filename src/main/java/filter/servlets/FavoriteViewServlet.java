package filter.servlets;

import carsale.model.Car;
import filter.ds.LinkedList;
import filter.util.CarLoader;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashSet;

@WebServlet("/view-favorites")
public class FavoriteViewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        login.model.User user = (session != null) ? (login.model.User) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect("signin.jsp");
            return;
        }
        String userEmail = user.getEmail();
        String safeEmail = userEmail.replaceAll("[^a-zA-Z0-9]", "_");
        String FAVORITES_FILE = "/WEB-INF/data/favorites_" + safeEmail + ".txt";

        ServletContext context = getServletContext();
        String favoritesPath = context.getRealPath(FAVORITES_FILE);

        // Load favorite IDs
        HashSet<String> favoriteIds = new HashSet<>();
        File favFile = new File(favoritesPath);
        if (favFile.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(favFile))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    favoriteIds.add(line.trim());
                }
            }
        }

        // Load all cars
        LinkedList<Car> allCars = CarLoader.loadCars(context);

        // Filter favorites
        LinkedList<Car> favoriteCars = new LinkedList<>();
        LinkedList<Car>.LinkedListIterator it = allCars.iterator();
        while (it.hasNext()) {
            Car car = it.next();
            if (favoriteIds.contains(car.getTimestamp())) {
                favoriteCars.add(car);
            }
        }

        request.setAttribute("favorites", favoriteCars);
        request.getRequestDispatcher("/favorites.jsp").forward(request, response);
    }
} 