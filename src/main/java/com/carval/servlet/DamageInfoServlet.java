package com.carval.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/damage-info")
public class DamageInfoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if we have session data (if user came from step 1)
        HttpSession session = request.getSession();
        if (session.getAttribute("brand") == null) {
            // Redirect to step 1 if no session data
            response.sendRedirect(request.getContextPath() + "/car-details");
            return;
        }
        
        request.getRequestDispatcher("/views/damage_info.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String damages = request.getParameter("damages");
        
        // Save to session
        HttpSession session = request.getSession();
        session.setAttribute("damages", damages);
        
        // Redirect to next step
        response.sendRedirect(request.getContextPath() + "/submit-review");
    }
}
