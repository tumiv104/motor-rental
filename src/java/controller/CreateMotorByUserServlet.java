/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ListMotoDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import model.Motorbike;
import model.MotorbikeType;

/**
 *
 * @author hungv
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class CreateMotorByUserServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CreateMotorByUserServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateMotorByUserServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        request.getRequestDispatcher("createmotorbyuser.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Validation
            String model = request.getParameter("model");
            String brand = request.getParameter("brand");
            int year = Integer.parseInt(request.getParameter("year"));
            double dailyRate = Double.parseDouble(request.getParameter("daily_rate"));
            String licensePlate = request.getParameter("license_plate");
            String fuelType = request.getParameter("fuel_type");

            // Server-side validation
            StringBuilder errorMessage = new StringBuilder();

            // Existing validation code...
            if (errorMessage.length() > 0) {
                request.setAttribute("errorMessage", errorMessage.toString());
                request.getRequestDispatcher("createmotorbyuser.jsp").forward(request, response);
                return;
            }

            // Handle file upload
            Part filePart = request.getPart("image"); // Matches the file input name in your form
            String fileName = "";

            if (filePart != null && filePart.getSize() > 0) {
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                // Generate unique filename
                fileName = System.currentTimeMillis() + "_" + getSubmittedFileName(filePart);
                String filePath = uploadPath + File.separator + fileName;

                // Save file
                filePart.write(filePath);

                // Set the relative path for database storage
                fileName = "uploads/" + fileName;
            }

            // Optional fields
            String color = request.getParameter("color");
            String engineSize = request.getParameter("engine_size");
            int mileage = 0;
            try {
                mileage = Integer.parseInt(request.getParameter("mileage"));
            } catch (NumberFormatException e) {
                // Use default value if mileage is not provided or invalid
            }

            // Set initial status as Pending
            String status = "Pending";
            int typeId = 1; // Default type ID

            // Create objects
            MotorbikeType motorbikeType = new MotorbikeType();
            motorbikeType.setTypeId(typeId);

            Motorbike motorbike = new Motorbike(typeId, typeId, model, brand, year, dailyRate,
                    status, licensePlate, motorbikeType, color, engineSize, fuelType, fileName, mileage, status);

            ListMotoDAO list = new ListMotoDAO();
            boolean isAdded = list.addPendingMotorbike(motorbike);

            if (isAdded) {
                request.setAttribute("successMessage", "Xe đã được gửi và đang chờ admin phê duyệt");
                request.getRequestDispatcher("adminapproval.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Không thể thêm xe. Vui lòng thử lại");
                request.getRequestDispatcher("createmotorbyuser.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("createmotorbyuser.jsp").forward(request, response);
        }
    }
    
    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return fileName.substring(fileName.lastIndexOf('/') + 1)
                        .substring(fileName.lastIndexOf('\\') + 1);
            }
        }
        return null;
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
