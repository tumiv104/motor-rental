/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ListMotoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Motorbike;
import model.MotorbikeType;

/**
 *
 * @author hungv
 */
public class MCreateMotorServlet extends HttpServlet {

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
            out.println("<title>Servlet MCreateMotorServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MCreateMotorServlet at " + request.getContextPath() + "</h1>");
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
        ListMotoDAO l = new ListMotoDAO();
        try {
            // Lấy danh sách các loại xe máy
            request.setAttribute("motorbikeTypes", l.getMotorbikeTypes());
        } catch (SQLException ex) {
            Logger.getLogger(MCreateMotorServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.getRequestDispatcher("createmotorbike.jsp").forward(request, response);
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
        ListMotoDAO l = new ListMotoDAO();

        try {
            // Lấy dữ liệu từ form
            String model = request.getParameter("model");
            String brand = request.getParameter("brand");
            int year = Integer.parseInt(request.getParameter("year"));
            double dailyRate = Double.parseDouble(request.getParameter("daily_rate"));
            String licensePlate = request.getParameter("license_plate");
            int mileage = Integer.parseInt(request.getParameter("mileage"));
            String color = request.getParameter("color");
            String engineSize = request.getParameter("engine_size");
            String fuelType = request.getParameter("fuel_type");
            String imageUrl = request.getParameter("image_url");
            int typeId = Integer.parseInt(request.getParameter("type_id"));


            Motorbike motorbike = new Motorbike();
            motorbike.setModel(model);
            motorbike.setBrand(brand);
            motorbike.setYear(year);
            motorbike.setDailyRate(dailyRate);
            motorbike.setLicensePlate(licensePlate);
            motorbike.setMileage(mileage);
            motorbike.setColor(color);
            motorbike.setEngineSize(engineSize);
            motorbike.setFuelType(fuelType);
            motorbike.setImageUrl(imageUrl);
            MotorbikeType mt = new MotorbikeType();
            mt.setTypeId(typeId);
            motorbike.setTypeId(mt);

            boolean isAdded = l.addMotorbike(motorbike);
            if (isAdded) {
                response.sendRedirect("viewmotorbike");
            } else {
                request.setAttribute("errorMessage", "Không thể thêm xe. Vui lòng thử lại.");
                request.setAttribute("motorbikeTypes", l.getMotorbikeTypes());
                request.getRequestDispatcher("createmotorbike.jsp").forward(request, response);
            }
        } catch (NumberFormatException ex) {
            request.setAttribute("errorMessage", "Invalid input format. Please check your input.");
            try {
                request.setAttribute("motorbikeTypes", l.getMotorbikeTypes());
            } catch (SQLException ex1) {
                Logger.getLogger(MCreateMotorServlet.class.getName()).log(Level.SEVERE, null, ex1);
            }
            request.getRequestDispatcher("createmotorbike.jsp").forward(request, response);
        } catch (SQLException ex) {
            request.setAttribute("errorMessage", "Database error: " + ex.getMessage());
            try {
                request.setAttribute("motorbikeTypes", l.getMotorbikeTypes());
            } catch (SQLException ex1) {
                Logger.getLogger(MCreateMotorServlet.class.getName()).log(Level.SEVERE, null, ex1);
            }
            request.getRequestDispatcher("createmotorbike.jsp").forward(request, response);
        }
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