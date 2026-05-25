package admin.servlets;

import admin.model.Admin;
import admin.repository.AdminRepository;
import admin.service.AdminProfileService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/adminChangePicture")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10
)
public class AdminPictureServlet extends HttpServlet {
    private AdminProfileService profileService;
    private static final String UPLOAD_DIR = "adminProfilePics";

    @Override
    public void init() throws ServletException {
        String filePath = getServletContext().getRealPath("/WEB-INF/data/admin.txt");
        String deletedPath = getServletContext().getRealPath("/WEB-INF/data/deleted_admins.txt");
        this.profileService = new AdminProfileService(new AdminRepository(filePath,deletedPath));
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Admin currentUser = (Admin) session.getAttribute("admin");

        if (currentUser == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String fullName = request.getParameter("fullName");
        Part filePart = request.getPart("profilePicture");

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadDir = getServletContext().getRealPath("/adminProfilePics");
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) uploadDirFile.mkdirs();

        String savedPath = uploadDir + File.separator + fileName;
        filePart.write(savedPath);

       String profilePicturePath = "adminProfilePics/" + fileName; // relative path for web



        try {
            Admin updatedAdmin = new Admin();
            updatedAdmin.setAdminID(currentUser.getAdminID());
            updatedAdmin.setUsername(currentUser.getUsername());
            updatedAdmin.setPassword(currentUser.getPassword());
            updatedAdmin.setProfilePicture(profilePicturePath);
            updatedAdmin.setName(currentUser.getName());

            profileService.updateProfilePicture(updatedAdmin.getUsername(),updatedAdmin.getProfilePicture());

            session.setAttribute("admin", updatedAdmin);
            response.sendRedirect("adminProfile.jsp?success=Profile updated successfully");

        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("originalFullName", fullName);
            request.getRequestDispatcher("adminProfile.jsp").forward(request, response);
        }
    }
}
