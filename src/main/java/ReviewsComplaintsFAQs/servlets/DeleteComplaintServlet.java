package ReviewsComplaintsFAQs.servlets;

import ReviewsComplaintsFAQs.service.ComplaintService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteComplaint")
public class DeleteComplaintServlet extends HttpServlet {
    private ComplaintService complaintService;

    @Override
    public void init() throws ServletException {
        // Initialize with user file path only for submission purposes
        String userFilePath = getServletContext().getRealPath("/users.txt");
        complaintService = new ComplaintService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String content = request.getParameter("content");

        if (email != null && !email.trim().isEmpty()
                && content != null && !content.trim().isEmpty()) {

            String filePath = getServletContext().getRealPath("/complaints.txt");
            complaintService.deleteComplaint(filePath, email.trim(), content.trim());
        }

        response.sendRedirect("viewComplaints");
    }
}
