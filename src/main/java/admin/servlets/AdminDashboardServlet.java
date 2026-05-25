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
import java.util.List;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {
    private AdminProfileService profileService;



    public void init() {
        String filePath = getServletContext().getRealPath("/WEB-INF/data/admin.txt");
        String deletedAdminsFile = getServletContext().getRealPath("/WEB-INF/data/deleted_admins.txt");
        this.profileService = new AdminProfileService(new AdminRepository(filePath,deletedAdminsFile));

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Admin> admins = profileService.getAllAdmins();
        List<Admin> deletedAdmins = profileService.getAllDeletedAdmins();
        request.setAttribute("adminList", admins);
        request.setAttribute("deletedAdminList", deletedAdmins);
        request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
    }

}