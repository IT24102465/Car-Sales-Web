package ReviewsComplaintsFAQs.servlets;

import ReviewsComplaintsFAQs.model.FAQ;
import ReviewsComplaintsFAQs.service.FAQService;
import login.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/submitFAQ")
public class SubmitFAQServlet extends HttpServlet {
    private FAQService faqService;

    @Override
    public void init() throws ServletException {
        String userFilePath = getServletContext().getRealPath("/users.txt");
        faqService = new FAQService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String question = request.getParameter("faqQuestion");

        if (user != null && question != null && !question.trim().isEmpty()) {
            // Use the same directory as users.txt
            String filePath = getServletContext().getRealPath("/faqs.txt");

            FAQ faq = new FAQ(user, question.trim());
            faqService.submitFAQ(filePath, faq);

            response.sendRedirect("viewFAQs");
        } else {
            session.setAttribute("error", "Please fill in all required fields.");
            response.sendRedirect("faq.jsp?error=missing");
        }
    }
}