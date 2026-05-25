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

@WebServlet("/adminChangePassword")
public class AdminPasswordServlet extends HttpServlet {
    private AdminProfileService profileService;


    @Override
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
            profileService.changePassword(
                    currentUser.getUsername(),
                    request.getParameter("currentPassword"),
                    request.getParameter("newPassword"),
                    request.getParameter("confirmPassword")
            );
            Admin updatedAdmin = new Admin();
            updatedAdmin.setAdminID(currentUser.getAdminID());
            updatedAdmin.setName(currentUser.getName());
            updatedAdmin.setUsername(currentUser.getUsername());
            updatedAdmin.setPassword(request.getParameter("confirmPassword"));
            updatedAdmin.setProfilePicture(currentUser.getProfilePicture());




            session.setAttribute("admin", updatedAdmin);
            response.sendRedirect("adminProfile.jsp?success=Password changed");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("adminProfile.jsp").forward(request, response);
        }
    }
}
