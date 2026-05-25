package admin.servlets;

import admin.model.Admin;
import admin.repository.AdminRepository;
import admin.service.AdminProfileService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/adminUpdateProfile")
public class AdminUpdateProfileServlet extends HttpServlet {
    private AdminProfileService profileService;

    public void init() throws ServletException {
        String filePath = getServletContext().getRealPath("/WEB-INF/data/admin.txt");
        String deletedPath = getServletContext().getRealPath("/WEB-INF/data/deleted_admins.txt");
        this.profileService = new AdminProfileService(new AdminRepository(filePath, deletedPath));
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Admin currentUser = (Admin) session.getAttribute("admin");

        if (currentUser == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        try {
            // Create updated user with all current fields including userType

            Admin updatedAdmin = new Admin();
            updatedAdmin.setAdminID(currentUser.getAdminID());
            updatedAdmin.setUsername(currentUser.getUsername());
            updatedAdmin.setPassword(currentUser.getPassword());
            updatedAdmin.setProfilePicture(currentUser.getProfilePicture());
            updatedAdmin.setName(request.getParameter("fullName"));
            profileService.updateProfile(updatedAdmin.getUsername(), updatedAdmin);

            // Update session with the new user object
            session.setAttribute("admin", updatedAdmin);
            response.sendRedirect("adminProfile.jsp?success=Profile updated successfully");

        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            // Preserve form data in case of error
            request.setAttribute("originalFullName", request.getParameter("fullName"));
            request.getRequestDispatcher("adminProfile.jsp").forward(request, response);
        }
    }
}



