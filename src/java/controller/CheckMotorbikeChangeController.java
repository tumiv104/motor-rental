/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import config.CloudinaryConfig;

import dal.BookingDAO;
import dal.ListMotoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Map;
import model.Booking;
import model.Motorbike;
import model.Users;

/**
 *
 * @author Nitro
 */
@MultipartConfig
public class CheckMotorbikeChangeController extends HttpServlet {

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
            out.println("<title>Servlet CheckMotorbikeChange</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckMotorbikeChange at " + request.getContextPath() + "</h1>");
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
        int bid = Integer.parseInt(request.getParameter("bid"));
        BookingDAO bdb = new BookingDAO();
        ArrayList<Motorbike> motorbikes = bdb.getMotorbikesById(bid);
        Booking booking = bdb.getBookingById(bid);
        request.setAttribute("booking", booking);
        request.setAttribute("motorbikes", motorbikes);
        request.getRequestDispatcher("motorbikechange.jsp").forward(request, response);
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
        int mid = Integer.parseInt(request.getParameter("motorbike"));
        int bid = Integer.parseInt(request.getParameter("bid"));
        String description = request.getParameter("description");
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        ListMotoDAO mdb = new ListMotoDAO();
        int lastId = mdb.insertMotorbikeChange(bid, mid, description, user.getRole());
        Cloudinary cloudinary = CloudinaryConfig.config();
        for (Part filePart : request.getParts()) {
            if (filePart.getName().equals("images") && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

                // Lưu ảnh vào thư mục tạm thời
                File uploads = new File("/tmp/uploads");
                if (!uploads.exists()) {
                    uploads.mkdirs();
                }
                Path filePath = Paths.get(uploads.getAbsolutePath(), fileName);
                Files.copy(filePart.getInputStream(), filePath);

                try {
                    // Upload ảnh lên Cloudinary
                    Map uploadResult = cloudinary.uploader().upload(filePath.toFile(), ObjectUtils.emptyMap());
                    String imageUrl = (String) uploadResult.get("url");
                    mdb.insertChangeImage(lastId, imageUrl);

                } catch (Exception e) {
                    throw new ServletException("Upload ảnh thất bại", e);
                } finally {
                    // Xóa file tạm sau khi upload xong
                    Files.delete(filePath);
                }
            }
        }
        request.setAttribute("check", bid);
        request.getRequestDispatcher("motorbikechange.jsp").forward(request, response);
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
