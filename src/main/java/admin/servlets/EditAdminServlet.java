package admin.servlets;

import admin.model.Admin;
import admin.repository.AdminRepository;
import admin.service.AdminProfileService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/editAdmin")
public class EditAdminServlet extends HttpServlet {
    private AdminProfileService adminService;

    @Override
    public void init() {
        String activePath = getServletContext().getRealPath("/WEB-INF/data/admin.txt");
        String deletedPath = getServletContext().getRealPath("/WEB-INF/data/deleted_admins.txt");
        adminService = new AdminProfileService(new AdminRepository(activePath, deletedPath));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("id");
        Admin admin = adminService.getUserByEmail(email);
        request.setAttribute("admin", admin);
        request.getRequestDispatcher("editAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String name = request.getParameter("fullName");
        String password = request.getParameter("password");

        adminService.editAdmin(email, name, password);

        response.sendRedirect("adminDashboard");
    }
}
