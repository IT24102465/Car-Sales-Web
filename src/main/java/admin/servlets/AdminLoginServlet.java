package admin.servlets;

import admin.model.Admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {
    private String filePath;

    @Override
    public void init() throws ServletException {
        filePath = getServletContext().getRealPath("/WEB-INF/data/admin.txt");
    }



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("email");
        String password = request.getParameter("password");

        boolean authenticated = false;

        File file = new File(filePath);
        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length == 5 && parts[2].equals(username) && parts[3].equals(password)) {
                        authenticated = true;
                        Admin admin = new Admin(parts[0], parts[1], parts[2], parts[3], parts[4]);
                        request.getSession().setAttribute("admin",admin);
                        request.getSession().setAttribute("profilePic", parts[4]); // path to profile image
                        break;
                    }
                }
            }
        }

        if (authenticated) {
            response.sendRedirect(request.getContextPath() + "/adminDashboard");
        } else {
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
        }
    }
}
