package ReviewsComplaintsFAQs.servlets;

import ReviewsComplaintsFAQs.service.ReviewService;
import login.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/submitReview")
public class SubmitReviewServlet extends HttpServlet {
    private ReviewService reviewService;

    @Override
    public void init() throws ServletException {
        String userFilePath = getServletContext().getRealPath("/users.txt");
        reviewService = new ReviewService(userFilePath);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("signin.jsp");
            return;
        }

        String ratingStr = request.getParameter("rating");
        String content = request.getParameter("content");

        if (ratingStr == null || content == null || content.trim().isEmpty()) {
            response.sendRedirect("reviews.jsp?error=Missing+fields");
            return;
        }

        int rating = Integer.parseInt(ratingStr);

        // Use the same directory as users.txt
        String reviewFilePath = getServletContext().getRealPath("/reviews.txt");

        reviewService.submitReview(reviewFilePath, user, rating, content);

        response.sendRedirect("viewReviews");
    }
}