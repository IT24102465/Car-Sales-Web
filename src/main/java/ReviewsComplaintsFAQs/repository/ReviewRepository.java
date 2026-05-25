package ReviewsComplaintsFAQs.repository;

import ReviewsComplaintsFAQs.model.Reviews;
import login.model.User;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewRepository {

    // Only used in submission (to get user email from User object)
    public void saveReview(String filePath, Reviews review) {
        try {
            System.out.println("Review file path: " + filePath);

            // Ensure parent directory exists
            File file = new File(filePath);
            File parent = file.getParentFile();
            if (parent != null && !parent.exists()) {
                parent.mkdirs();
            }

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
                String line = review.getUser().getEmail() + ";" +
                        review.getRating() + ";" +
                        review.getContent().replace(";", ",");
                writer.write(line);
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // No association used here: email is treated as string
    public List<Reviews> getAllReviews(String filePath) throws IOException {
        System.out.println("Review file path: " + filePath);

        List<Reviews> reviews = new ArrayList<>();
        File file = new File(filePath);
        if (!file.exists()) return reviews;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(";");
                if (parts.length == 3) {
                    String email = parts[0];
                    int rating = Integer.parseInt(parts[1]);
                    String content = parts[2];
                    // Create dummy User with only email
                    User user = new User();
                    user.setEmail(email);
                    reviews.add(new Reviews(user, rating, content));
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return reviews;
    }

    // Delete review by matching email + content + rating
    public void deleteReview(String filePath, String email, int rating, String content) throws IOException {
        System.out.println("Review file path: " + filePath);

        List<Reviews> reviews = getAllReviews(filePath);

        reviews.removeIf(r ->
                r.getUser().getEmail().equals(email) &&
                        r.getRating() == rating &&
                        r.getContent().equals(content)
        );

        // Ensure parent directory exists
        File file = new File(filePath);
        File parent = file.getParentFile();
        if (parent != null && !parent.exists()) {
            parent.mkdirs();
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, false))) {
            for (Reviews review : reviews) {
                String line = review.getUser().getEmail() + ";" +
                        review.getRating() + ";" +
                        review.getContent().replace(";", ",");
                writer.write(line);
                writer.newLine();
            }
        }
    }
}