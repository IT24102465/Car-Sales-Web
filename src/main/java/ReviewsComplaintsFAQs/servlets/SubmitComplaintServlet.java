package ReviewsComplaintsFAQs.servlets;

import ReviewsComplaintsFAQs.model.Complaints;
import ReviewsComplaintsFAQs.service.ComplaintService;
import login.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/submitComplaint")
public class SubmitComplaintServlet extends HttpServlet {
    private ComplaintService complaintService;

    @Override
    public void init() throws ServletException {
        String userFilePath = getServletContext().getRealPath("/users.txt");
        complaintService = new ComplaintService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String content = request.getParameter("complaintContent");

        if (user != null && content != null && !content.trim().isEmpty()) {
            // Use the same directory as users.txt
            String filePath = getServletContext().getRealPath("/complaints.txt");

            Complaints complaint = new Complaints(user, content.trim());
            complaintService.submitComplaint(filePath, complaint);

            response.sendRedirect("viewComplaints");
        } else {
            session.setAttribute("error", "Please fill in all required fields.");
            response.sendRedirect("complaints.jsp?error=missing");
        }
    }
}