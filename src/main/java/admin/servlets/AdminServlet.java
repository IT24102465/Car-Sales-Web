package admin.servlets;

import admin.controller.AdminController;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;


@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024)

@WebServlet("/adminProfile")
public class AdminServlet extends HttpServlet {
    private AdminController controller;

    @Override
    public void init() throws ServletException {
        String filePath = getServletContext().getRealPath("/WEB-INF/data/admin.txt");
        String deletedFilePath = getServletContext().getRealPath("/WEB-INF/data/deleted_admins.txt");
        controller = new AdminController(filePath, deletedFilePath);
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String adminID = UUID.randomUUID().toString().substring(0, 8);

        Part filePart = request.getPart("profilePicture");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();


        String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String savedFileName = username + ".jpg";
        filePart.write(uploadPath + File.separator + savedFileName);
        String profilePicture="images/"+savedFileName;
        controller.registerAdmin(adminID, name, username, password, profilePicture);
        response.sendRedirect("adminDashboard.jsp");
    }
}