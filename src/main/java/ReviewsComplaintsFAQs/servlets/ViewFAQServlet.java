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
import java.util.List;

@WebServlet("/viewFAQs")
public class ViewFAQServlet extends HttpServlet {
    private FAQService faqService;

    @Override
    public void init() throws ServletException {
        faqService = new FAQService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("signin.jsp");
            return;
        }

        String faqsFilePath = getServletContext().getRealPath("/faqs.txt");
        List<FAQ> faqs = faqService.getFAQs(faqsFilePath);

        Boolean isAdmin = "admin".equals(user.getUserType());
        request.setAttribute("faqs", faqs);
        request.setAttribute("isAdmin", isAdmin);
        request.getRequestDispatcher("faq.jsp").forward(request, response);
    }
}