package admin.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/deleteCar")
public class DeleteCarServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String FILE_PATH = getServletContext().getRealPath("/SellCarDetails/salecardetails.txt");
        String identifier = request.getParameter("identifier"); // Can be timestamp or image filename

        if (identifier == null || identifier.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Identifier is required");
            return;
        }

        File file = new File(FILE_PATH);
        List<String> updatedLines = new ArrayList<>();

        boolean deleted = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;

            while ((line = reader.readLine()) != null) {
                if (line.contains(identifier)) {
                    deleted = true;
                    continue; // Skip this line (i.e., delete it)
                }
                updatedLines.add(line);
            }
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (String updatedLine : updatedLines) {
                writer.write(updatedLine);
                writer.newLine();
            }
        }

        response.sendRedirect("carListing");

    }

}
