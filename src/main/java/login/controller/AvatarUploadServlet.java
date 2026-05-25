package login.controller;

import login.model.User;
import login.service.ProfileService;
import login.repository.impl.FileUserRepository;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;

@WebServlet("/upload-avatar")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 5,   // 5MB
        maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class AvatarUploadServlet extends HttpServlet {
    private ProfileService profileService;
    private static final String UPLOAD_DIR = "uploads/avatars";

    @Override
    public void init() throws ServletException {
        String filePath = getServletContext().getRealPath("/users.txt");
        this.profileService = new ProfileService(new FileUserRepository(filePath));

        // Rest of the init code remains the same
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
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
            Part filePart = request.getPart("avatar");
            if (filePart == null || filePart.getSize() == 0) {
                throw new Exception("No file selected");
            }

            // Validate image type
            String contentType = filePart.getContentType();
            if (!contentType.startsWith("image/")) {
                throw new Exception("Only image files are allowed");
            }

            // Generate unique filename
            String fileName = UUID.randomUUID() +
                    getFileExtension(filePart.getSubmittedFileName());

            // Save file
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);

            // Create web-accessible URL
            String relativeUrl = request.getContextPath() + "/" + UPLOAD_DIR + "/" + fileName;

            // Update user
            profileService.updateAvatar(currentUser.getEmail(), relativeUrl);
            currentUser.setAvatarUrl(relativeUrl);
            session.setAttribute("user", currentUser);

            // Return JSON response
            response.setContentType("application/json");
            response.getWriter().write(
                    String.format("{\"success\": true, \"avatarUrl\": \"%s\"}", relativeUrl)
            );

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            response.getWriter().write(
                    String.format("{\"success\": false, \"error\": \"%s\"}", e.getMessage())
            );
        }
    }

    private void sendError(HttpServletResponse response, String message, int status) throws IOException {
        response.setStatus(status);
        response.setContentType("application/json");
        response.getWriter().write(String.format("{\"success\": false, \"error\": \"%s\"}", message));
    }
    private String getFileExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf('.');
        return (dotIndex == -1) ? "" : fileName.substring(dotIndex);
    }

}