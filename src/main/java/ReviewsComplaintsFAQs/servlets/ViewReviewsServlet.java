package ReviewsComplaintsFAQs.servlets;

import ReviewsComplaintsFAQs.model.Reviews;
import ReviewsComplaintsFAQs.service.ReviewService;
import login.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/viewReviews")
public class ViewReviewsServlet extends HttpServlet {
    private ReviewService reviewService;

    @Override
    public void init() throws ServletException {
        String userFilePath = getServletContext().getRealPath("/users.txt");
        reviewService = new ReviewService(userFilePath);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("signin.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("signin.jsp");
            return;
        }

        // use correct secure path
        String reviewsFilePath = getServletContext().getRealPath("/reviews.txt");
        List<Reviews> reviews = reviewService.getAllReviews(reviewsFilePath);

        if (!"admin".equalsIgnoreCase(user.getUserType())) {
            String userEmail = user.getEmail();
            reviews.removeIf(r -> !r.getUser().getEmail().equals(userEmail));
        }

        request.setAttribute("reviews", reviews);
        request.setAttribute("isAdmin", "admin".equalsIgnoreCase(user.getUserType()));
        request.getRequestDispatcher("reviews.jsp").forward(request, response);
    }
}
