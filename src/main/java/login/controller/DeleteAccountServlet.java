package login.controller;

import login.model.User;
import login.service.ProfileService;
import login.repository.impl.FileUserRepository;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.File;
import java.io.IOException;

@WebServlet("/delete-account")
public class DeleteAccountServlet extends HttpServlet {
    private ProfileService profileService;

    @Override
    public void init() throws ServletException {
        String filePath = getServletContext().getRealPath("/users.txt");
        this.profileService = new ProfileService(new FileUserRepository(filePath));
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("signin.jsp");
            return;
        }

        String currentPassword = request.getParameter("currentPassword");

        try {
            // Verify current password
            if (!currentUser.getPassword().equals(currentPassword)) {
                request.setAttribute("error", "Incorrect password");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            // Get the real server path for file deletion
            String contextPath = getServletContext().getRealPath("");

            // Delete account with context path
            profileService.deleteAccount(currentUser.getEmail(), contextPath);

            // Invalidate session
            session.invalidate();

            // Redirect with success message
            response.sendRedirect("signin.jsp?message=Your+account+has+been+permanently+deleted");

        } catch (Exception e) {
            request.setAttribute("error", "Account deletion failed: " + e.getMessage());
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }
}