package ReviewsComplaintsFAQs.service;

import ReviewsComplaintsFAQs.model.Reviews;
import ReviewsComplaintsFAQs.repository.ReviewRepository;
import login.model.User;

import java.io.IOException;
import java.util.List;

public class ReviewService {
    private final ReviewRepository reviewRepository;

    public ReviewService(String userFilePath) {
        // Pass user file path only for association during submission
        this.reviewRepository = new ReviewRepository();
    }

    // Use association when submitting the review
    public void submitReview(String filePath, User user, int rating, String content) {
        Reviews review = new Reviews(user, rating, content);
        reviewRepository.saveReview(filePath, review);
    }

    // Do not use association during view
    public List<Reviews> getAllReviews(String filePath) throws IOException {
        return reviewRepository.getAllReviews(filePath);
    }

    // Optional: Delete review by raw email and content without using User object
    public void deleteReview(String filePath, String email, int rating, String content) throws IOException {
        reviewRepository.deleteReview(filePath, email, rating, content);
    }
}


