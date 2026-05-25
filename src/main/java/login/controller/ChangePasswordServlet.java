package login.controller;

import login.model.User;
import login.service.ProfileService;
import login.repository.impl.FileUserRepository;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {
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

        try {
            profileService.changePassword(
                    currentUser.getEmail(),
                    request.getParameter("currentPassword"),
                    request.getParameter("newPassword"),
                    request.getParameter("confirmPassword")
            );
            response.sendRedirect("profile.jsp?success=Password changed");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }
}