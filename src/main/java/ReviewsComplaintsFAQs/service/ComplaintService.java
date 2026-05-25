package ReviewsComplaintsFAQs.service;

import ReviewsComplaintsFAQs.model.Complaints;
import ReviewsComplaintsFAQs.repository.ComplaintsRepository;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ComplaintService {
    private final ComplaintsRepository repository;

    public ComplaintService() {
        this.repository = new ComplaintsRepository();
    }

    // Submit complaint – uses full User association
    public void submitComplaint(String filePath, Complaints complaint) throws IOException {
        repository.saveComplaint(filePath, complaint);
    }

    // View all complaints – no association
    public List<Complaints> getComplaints(String filePath) throws IOException {
        return repository.getComplaints(filePath);
    }

    // View complaints for specific user by email – no association
    public List<Complaints> getUserComplaints(String filePath, String email) throws IOException {
        List<Complaints> all = repository.getComplaints(filePath);
        List<Complaints> filtered = new ArrayList<>();
        for (Complaints c : all) {
            if (c.getUserEmail().equals(email)) {
                filtered.add(c);
            }
        }
        return filtered;
    }

    // Delete complaint – uses email and content only
    public void deleteComplaint(String filePath, String email, String content) throws IOException {
        repository.deleteComplaint(filePath, email, content);
    }
}
