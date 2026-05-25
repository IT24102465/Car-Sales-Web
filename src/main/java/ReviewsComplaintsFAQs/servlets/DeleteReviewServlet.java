package ReviewsComplaintsFAQs.servlets;

import ReviewsComplaintsFAQs.service.ReviewService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteReview")
public class DeleteReviewServlet extends HttpServlet {
    private ReviewService reviewService;

    @Override
    public void init() throws ServletException {
        // Only used for submission — path needed to initialize repository
        String userFilePath = getServletContext().getRealPath("/users.txt");
        reviewService = new ReviewService(userFilePath);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String content = request.getParameter("content");
        String ratingStr = request.getParameter("rating");

        if (email != null && !email.trim().isEmpty()
                && content != null && !content.trim().isEmpty()
                && ratingStr != null && !ratingStr.trim().isEmpty()) {

            // use correct secure path
            String filePath = getServletContext().getRealPath("/reviews.txt");
            int rating = Integer.parseInt(ratingStr);

            reviewService.deleteReview(filePath, email.trim(), rating, content.trim());
        }

        response.sendRedirect("viewReviews"); // Redirect back to reviews list
    }
}
