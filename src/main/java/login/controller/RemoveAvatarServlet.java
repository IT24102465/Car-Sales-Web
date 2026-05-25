package login.controller;

import login.model.User;
import login.service.ProfileService;
import login.repository.impl.FileUserRepository;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;

@WebServlet("/remove-avatar")
public class RemoveAvatarServlet extends HttpServlet {
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
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        try {
            // Remove physical file if exists
            if (currentUser.getAvatarUrl() != null &&
                    currentUser.getAvatarUrl().contains("/uploads/avatars/")) {
                String filePath = getServletContext().getRealPath("") +
                        currentUser.getAvatarUrl().replace(request.getContextPath(), "");
                new File(filePath).delete();
            }

            // Update user in database
            profileService.updateAvatar(currentUser.getEmail(), null);

            // Update session
            currentUser.setAvatarUrl(null);
            session.setAttribute("user", currentUser);

            // Return JSON response instead of redirect
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": true}");

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
    }
}