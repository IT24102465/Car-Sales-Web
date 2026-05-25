package ReviewsComplaintsFAQs.repository;

import ReviewsComplaintsFAQs.model.Complaints;

import java.io.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class ComplaintsRepository {

    public void saveComplaint(String filePath, Complaints complaint) {
        try {
            // Ensure parent directory exists
            File file = new File(filePath);
            File parent = file.getParentFile();
            if (parent != null && !parent.exists()) {
                parent.mkdirs();
            }

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
                String line = complaint.getUser().getEmail() + ";" +
                        complaint.getContent().replace(";", ",");
                writer.write(line);
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<Complaints> getComplaints(String filePath) throws IOException {
        List<Complaints> complaints = new ArrayList<>();
        File file = new File(filePath);
        if (!file.exists()) return complaints;

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(";", 2);
                if (parts.length == 2) {
                    complaints.add(new Complaints(parts[0], parts[1])); // Using email only
                }
            }
        }
        return complaints;
    }

    public void deleteComplaint(String filePath, String email, String content) throws IOException {
        File file = new File(filePath);
        File parent = file.getParentFile();
        if (parent != null && !parent.exists()) {
            parent.mkdirs();
        }

        if (!file.exists()) return;

        List<String> lines = new ArrayList<>(java.nio.file.Files.readAllLines(file.toPath()));
        Iterator<String> iterator = lines.iterator();

        while (iterator.hasNext()) {
            String line = iterator.next();
            String[] parts = line.split(";", 2);
            if (parts.length == 2 && parts[0].equals(email) && parts[1].equals(content)) {
                iterator.remove(); // remove the exact match
                break;
            }
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, false))) {
            for (String updatedLine : lines) {
                writer.write(updatedLine);
                writer.newLine();
            }
        }
    }
}