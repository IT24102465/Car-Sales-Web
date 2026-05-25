package com.carval.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    // Fix file path to match project structure
    private static final String FILE_PATH = "d:/friends/car certification/car-sales-myBranch/car-sales-myBranch/src/main/java/storage/carcert.txt";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isAdminLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }
        List<Map<String, String>> requests = readRequests();
        request.setAttribute("requests", requests);
        request.getRequestDispatcher("/views/admin_dashboard.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isAdminLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }
        String action = request.getParameter("action");
        int index = Integer.parseInt(request.getParameter("index"));
        List<Map<String, String>> requests = readRequests();
        if (index >= 0 && index < requests.size()) {
            Map<String, String> req = requests.get(index);
            if ("approve".equals(action)) {
                req.put("Status", "Approved");
            } else if ("reject".equals(action)) {
                req.put("Status", "Rejected");
            }
            writeRequests(requests);
        }
        response.sendRedirect(request.getContextPath() + "/admin-dashboard");
    }

    private boolean isAdminLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && Boolean.TRUE.equals(session.getAttribute("adminLoggedIn"));
    }

    private List<Map<String, String>> readRequests() throws IOException {
        List<Map<String, String>> requests = new ArrayList<>();
        BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH));
        String line;
        Map<String, String> req = new LinkedHashMap<>();
        while ((line = reader.readLine()) != null) {
            if (line.trim().equals("---")) {
                if (!req.isEmpty()) {
                    requests.add(new LinkedHashMap<>(req));
                    req.clear();
                }
            } else if (line.contains(":")) {
                int idx = line.indexOf(":");
                String key = line.substring(0, idx).trim();
                String value = line.substring(idx + 1).trim();
                // Handle multi-line damages
                if ("Damages".equals(key) && value.isEmpty()) {
                    StringBuilder damages = new StringBuilder();
                    while ((line = reader.readLine()) != null && !line.contains("Status:")) {
                        damages.append(line).append("\n");
                    }
                    if (line != null && line.contains("Status:")) {
                        int sidx = line.indexOf(":");
                        req.put("Damages", damages.toString().trim());
                        req.put("Status", line.substring(sidx + 1).trim());
                        continue;
                    }
                }
                req.put(key, value);
            }
        }
        reader.close();
        return requests;
    }

    private void writeRequests(List<Map<String, String>> requests) throws IOException {
        BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, false));
        for (Map<String, String> req : requests) {
            writer.write("Brand: " + req.getOrDefault("Brand", "") + "\n");
            writer.write("Model: " + req.getOrDefault("Model", "") + "\n");
            writer.write("Year: " + req.getOrDefault("Year", "") + "\n");
            writer.write("Mileage: " + req.getOrDefault("Mileage", "") + "\n");
            writer.write("Price: " + req.getOrDefault("Price", "") + "\n");
            writer.write("Location: " + req.getOrDefault("Location", "") + "\n");
            writer.write("Owner Contact: " + req.getOrDefault("Owner Contact", "") + "\n");
            writer.write("Damages: " + req.getOrDefault("Damages", "") + "\n");
            writer.write("Status: " + req.getOrDefault("Status", "") + "\n");
            writer.write("Submission Date: " + req.getOrDefault("Submission Date", "") + "\n");
            writer.write("---\n");
        }
        writer.close();
    }
}
