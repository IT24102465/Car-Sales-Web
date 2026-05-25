package admin.servlets;

import login.model.User;
import login.repository.impl.FileUserRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/editUser")
public class ViewUserServlet extends HttpServlet {
    private FileUserRepository fileUserRepository;

    @Override
    public void init() {
        String filePath = getServletContext().getRealPath("/users.txt");
        this.fileUserRepository=new FileUserRepository(filePath);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        User user = null;
        try {
            user = fileUserRepository.getUserByEmail(email);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        request.setAttribute("user", user);
        request.getRequestDispatcher("viewUser.jsp").forward(request, response);
    }

}
