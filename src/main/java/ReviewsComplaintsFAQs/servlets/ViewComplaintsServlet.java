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
import java.util.List;

@WebServlet("/viewComplaints")
public class ViewComplaintsServlet extends HttpServlet {
    private ComplaintService complaintService;

    @Override
    public void init() throws ServletException {
        // Initialize with user file path only for association during submission
        String userFilePath = getServletContext().getRealPath("/users.txt");
        complaintService = new ComplaintService();
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

        String filePath = getServletContext().getRealPath("/complaints.txt");
        List<Complaints> complaints;

        if ("admin".equals(user.getUserType())) {
            complaints = complaintService.getComplaints(filePath);
        } else {
            complaints = complaintService.getUserComplaints(filePath, user.getEmail());
        }
        System.out.println("Complaints loaded: " + complaints.size());

        request.setAttribute("complaints", complaints);
        request.setAttribute("isAdmin", "admin".equals(user.getUserType()));
        request.getRequestDispatcher("complaints.jsp").forward(request, response);
    }
}
