package filter.util;

import login.model.User;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashSet;

public final class BuyNowHelper {

    private BuyNowHelper() {}

    public static HashSet<String> loadFavoriteIds(HttpServletRequest request, ServletContext context)
            throws IOException {
        HashSet<String> favoriteIds = new HashSet<>();
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            return favoriteIds;
        }

        String safeEmail = user.getEmail().replaceAll("[^a-zA-Z0-9]", "_");
        String favoritesFile = "/WEB-INF/data/favorites_" + safeEmail + ".txt";
        String filePath = context.getRealPath(favoritesFile);
        File file = new File(filePath);
        if (!file.exists()) {
            return favoriteIds;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                favoriteIds.add(line.trim());
            }
        }
        return favoriteIds;
    }
}
