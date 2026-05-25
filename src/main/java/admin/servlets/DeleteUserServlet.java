package admin.servlets;

import login.repository.impl.FileUserRepository;
import login.service.ProfileService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet {
    private ProfileService profileService;

    @Override
    public void init() throws ServletException {
        String filePath = getServletContext().getRealPath("/users.txt");
        this.profileService = new ProfileService(new FileUserRepository(filePath));
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String contextPath = getServletContext().getRealPath("");

        // Delete account with context path
        try {
            profileService.deleteAccount(email, contextPath);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect("userListing");
    }
}
