package admin.servlets;

import admin.repository.AdminRepository;
import admin.service.AdminProfileService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteOtherAdmins")
public class DeleteOtherAdminServlet extends HttpServlet {
    private AdminProfileService adminService;

    public void init() {
        String activePath = getServletContext().getRealPath("/WEB-INF/data/admin.txt");
        String deletedPath = getServletContext().getRealPath("/WEB-INF/data/deleted_admins.txt");
        adminService = new AdminProfileService(new AdminRepository(activePath, deletedPath));
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("id");

        try {
            adminService.deleteAccount(email);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }


        response.sendRedirect("adminDashboard");
    }
}
