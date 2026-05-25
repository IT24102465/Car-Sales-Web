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

@WebServlet("/deleteAdmin")
public class DeleteAdminServlet extends HttpServlet {
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

        String currentPassword = request.getParameter("currentPassword");

        try {
            // Verify current password
            if (!currentUser.getPassword().equals(currentPassword)) {
                request.setAttribute("error", "Incorrect password");
                request.getRequestDispatcher("adminProfile.jsp").forward(request, response);
                return;
            }


            profileService.deleteAccount(currentUser.getUsername());

            // Invalidate session
            session.invalidate();

            // Redirect with success message
            response.sendRedirect("adminLogin.jsp?message=Your+account+has+been+permanently+deleted");

        } catch (Exception e) {
            request.setAttribute("error", "Account deletion failed: " + e.getMessage());
            request.getRequestDispatcher("adminProfile.jsp").forward(request, response);
        }
    }
}