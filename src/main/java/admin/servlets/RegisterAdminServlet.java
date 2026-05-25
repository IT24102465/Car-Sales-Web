package admin.servlets;

import admin.model.Admin;
import admin.repository.AdminRepository;
import admin.service.AdminProfileService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

@WebServlet("/registerAdmin")
@MultipartConfig
public class RegisterAdminServlet extends HttpServlet {
    private AdminProfileService adminService;

    public void init() {
        String path = getServletContext().getRealPath("/WEB-INF/data/admin.txt");
        String deletedPath = getServletContext().getRealPath("/WEB-INF/data/deleted_admins.txt");
        adminService = new AdminProfileService(new AdminRepository(path, deletedPath));
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String adminID = request.getParameter("adminID");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");

        Part filePart = request.getPart("profilePicture");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("/adminProfilePics");
        Files.createDirectories(Paths.get(uploadPath));
        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);
        String profilePicturePath = "adminProfilePics/" + fileName;

        Admin newAdmin = new Admin(adminID, name, username, password,profilePicturePath);
        adminService.registerAdmin(newAdmin);

        response.sendRedirect("adminDashboard");
    }
}
