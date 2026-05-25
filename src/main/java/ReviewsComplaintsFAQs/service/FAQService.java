package ReviewsComplaintsFAQs.service;

import ReviewsComplaintsFAQs.model.FAQ;
import ReviewsComplaintsFAQs.repository.FAQRepository;

import java.io.IOException;
import java.util.List;

public class FAQService {
    private FAQRepository repository;

    public FAQService() {
        this.repository = new FAQRepository();
    }

    public void submitFAQ(String filePath, FAQ faq) {
        repository.saveFAQ(filePath, faq);
    }

    public List<FAQ> getFAQs(String filePath) throws IOException {
        return repository.getAllFAQs(filePath);
    }

    public void deleteFAQ(String filePath, String email, String question) throws IOException {
        repository.deleteFAQ(filePath, email, question);
    }
}