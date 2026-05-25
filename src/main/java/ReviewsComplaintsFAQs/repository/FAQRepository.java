package ReviewsComplaintsFAQs.repository;

import ReviewsComplaintsFAQs.model.FAQ;
import login.model.User;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FAQRepository {

    public void saveFAQ(String filePath, FAQ faq) {
        try {
            File file = new File(filePath);
            File parent = file.getParentFile();
            if (parent != null && !parent.exists()) {
                parent.mkdirs();
            }
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
                String line = faq.getUserEmail() + ";" + faq.getQuestion().replace(";", ",");
                writer.write(line);
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<FAQ> getAllFAQs(String filePath) throws IOException {
        List<FAQ> faqs = new ArrayList<>();
        File file = new File(filePath);
        if (!file.exists()) return faqs;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(";", 2);
                if (parts.length == 2) {
                    String email = parts[0];
                    String question = parts[1];
                    User user = new User();
                    user.setEmail(email);
                    faqs.add(new FAQ(user, question));
                }
            }
        }
        return faqs;
    }

    public void deleteFAQ(String filePath, String email, String question) throws IOException {
        List<FAQ> faqs = getAllFAQs(filePath);
        faqs.removeIf(f -> f.getUserEmail().equals(email) && f.getQuestion().equals(question));

        File file = new File(filePath);
        File parent = file.getParentFile();
        if (parent != null && !parent.exists()) {
            parent.mkdirs();
        }
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, false))) {
            for (FAQ faq : faqs) {
                String line = faq.getUserEmail() + ";" + faq.getQuestion().replace(";", ",");
                writer.write(line);
                writer.newLine();
            }
        }
    }
}