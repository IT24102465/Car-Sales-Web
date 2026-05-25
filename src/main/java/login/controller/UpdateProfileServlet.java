package login.controller;

import login.model.User;
import login.service.ProfileService;
import login.repository.impl.FileUserRepository;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/update-profile")
public class UpdateProfileServlet extends HttpServlet {
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
            // Create updated user with all current fields including userType
            User updatedUser = new User(
                    request.getParameter("fullName"),
                    currentUser.getEmail(), // Email can't be changed
                    request.getParameter("phone"),
                    currentUser.getPassword(), // Handle password separately
                    currentUser.getUserType() // Preserve the user type
            );

            // Preserve the avatar URL from the current user
            updatedUser.setAvatarUrl(currentUser.getAvatarUrl());

            profileService.updateProfile(currentUser.getEmail(), updatedUser);

            // Update session with the new user object
            session.setAttribute("user", updatedUser);
            response.sendRedirect("profile.jsp?success=Profile updated successfully");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            // Preserve form data in case of error
            request.setAttribute("originalFullName", request.getParameter("fullName"));
            request.setAttribute("originalPhone", request.getParameter("phone"));
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }
}