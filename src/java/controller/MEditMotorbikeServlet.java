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
import model.Motorbike;
import java.sql.*;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.MotorbikeType;

/**
 *
 * @author hungv
 */
public class MEditMotorbikeServlet extends HttpServlet {

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
            out.println("<title>Servlet MEditMotorbikeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MEditMotorbikeServlet at " + request.getContextPath() + "</h1>");
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
            int id = Integer.parseInt(request.getParameter("id"));
            Motorbike existingMotorbike = l.getMotorbikeById(id);
            if (existingMotorbike != null) {
                request.setAttribute("motorbike", existingMotorbike);
                request.setAttribute("motorbikeTypes", l.getMotorbikeTypes());
                request.getRequestDispatcher("editmotorbike.jsp").forward(request, response);
            } else {
                response.sendRedirect("viewmotorbike");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
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
        //processRequest(request, response);
        ListMotoDAO l = new ListMotoDAO();
        try {
            String idStr = request.getParameter("id");
            int id = (idStr != null && !idStr.isEmpty()) ? Integer.parseInt(idStr) : 0;

            String model = request.getParameter("model");
            String brand = request.getParameter("brand");

            String yearStr = request.getParameter("year");
            int year = (yearStr != null && !yearStr.isEmpty()) ? Integer.parseInt(yearStr) : 0;

            String dailyRateStr = request.getParameter("dailyRate");
            double dailyRate = (dailyRateStr != null && !dailyRateStr.isEmpty()) ? Double.parseDouble(dailyRateStr) : 0.0;

            String status = request.getParameter("status");
            String licensePlate = request.getParameter("licensePlate");

            String typeIdStr = request.getParameter("type_id");
            int typeId = (typeIdStr != null && !typeIdStr.isEmpty()) ? Integer.parseInt(typeIdStr) : 0;
            MotorbikeType mt = new MotorbikeType();
            mt.setTypeId(typeId);

            String mileageStr = request.getParameter("mileage");
            int mileage = (mileageStr != null && !mileageStr.isEmpty()) ? Integer.parseInt(mileageStr) : 0;

            String color = request.getParameter("color");
            String engineSize = request.getParameter("engineSize");
            String fuelType = request.getParameter("fuelType");
            String imageUrl = request.getParameter("imageUrl");

            Motorbike motorbike = new Motorbike();
            motorbike.setMotorbikeId(id);
            motorbike.setModel(model);
            motorbike.setBrand(brand);
            motorbike.setYear(year);
            motorbike.setDailyRate(dailyRate);
            motorbike.setStatus(status);
            motorbike.setLicensePlate(licensePlate);
            motorbike.setTypeId(mt);
            motorbike.setMileage(mileage);
            motorbike.setColor(color);
            motorbike.setEngineSize(engineSize);
            motorbike.setFuelType(fuelType);
            motorbike.setImageUrl(imageUrl);
            
            
            if (!l.isValidTypeId(typeId)) {
            request.setAttribute("errorMessage", "Invalid motorbike type. Please select a valid type.");
            request.setAttribute("motorbike", motorbike);
            request.getRequestDispatcher("editmotorbike.jsp").forward(request, response);
            return;
        }

        motorbike.setTypeId(mt);
            l.updateMotorbike(motorbike);
            response.sendRedirect("viewmotorbike");
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("editmotorbike.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid number format. Please check your input.");
            request.getRequestDispatcher("editmotorbike.jsp").forward(request, response);
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
