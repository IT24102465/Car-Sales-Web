package ReviewsComplaintsFAQs.servlets;

import ReviewsComplaintsFAQs.service.FAQService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteFAQ")
public class DeleteFAQServlet extends HttpServlet {
    private FAQService faqService;

    @Override
    public void init() throws ServletException {
        faqService = new FAQService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String question = request.getParameter("question");

        if (email != null && question != null) {
            String faqsFilePath = getServletContext().getRealPath("/faqs.txt");
            faqService.deleteFAQ(faqsFilePath, email, question);
        }
        response.sendRedirect("viewFAQs");
    }
}