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
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import model.Motorbike;
import model.MotorbikeType;

/**
 *
 * @author Nitro
 */
public class AdvancedSearchController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        ListMotoDAO motordb = new ListMotoDAO();
        
        ArrayList<String> brands = motordb.getDistinctField("brand", String.class);
        ArrayList<Integer> years = motordb.getDistinctField("year", Integer.class);
        ArrayList<Double> daily_rates = motordb.getDistinctField("daily_rate", Double.class);
        ArrayList<MotorbikeType> types = motordb.getDistinctType();
        ArrayList<String> colors = motordb.getDistinctField("color", String.class);
        ArrayList<String> engine_sizes = motordb.getDistinctField("engine_size", String.class);
        ArrayList<String> fuel_types = motordb.getDistinctField("fuel_type", String.class);
        
        Collections.sort(engine_sizes, new Comparator<String>() {
            @Override
            public int compare(String s1, String s2) {
                // Extract the numeric part and convert it to a double
                Double num1 = Double.valueOf(s1.replaceAll("[^\\d.]", ""));
                Double num2 = Double.valueOf(s2.replaceAll("[^\\d.]", ""));
                return num1.compareTo(num2);
            }
        });
        
        String brand = request.getParameter("brand");
        String yearStr = request.getParameter("year");
        String dailyRateStr = request.getParameter("daily_rate");
        String typeStr = request.getParameter("type");
        String color = request.getParameter("color");
        String engine_size = request.getParameter("engine_size");
        String fuel_type = request.getParameter("fuel_type");
        
        int year = yearStr == null || yearStr.isEmpty() ? -1 : Integer.parseInt(yearStr);
        double daily_rate = dailyRateStr == null || dailyRateStr.isEmpty() ? -1 : Double.parseDouble(dailyRateStr);
        int type = typeStr == null || typeStr.isEmpty() ? -1 : Integer.parseInt(typeStr);
        
        String pageStr = request.getParameter("page");
        int page = 1; 
        int pageSize = 6;
        if (pageStr != null) {
            page = Integer.parseInt(pageStr);
        }
        
        //MotorbikeDAO motordb = new MotorbikeDAO();
        ArrayList<Motorbike> motorbikes = motordb.filterMotorbikesByPaging(page, pageSize, brand, year, daily_rate, type, color, engine_size, fuel_type);
        int quantity = motordb.getFilterQuantity(brand, year, daily_rate, type, color, engine_size, fuel_type);
        int totalPage = quantity / pageSize;
        if (quantity % pageSize != 0) totalPage++;
        
        request.setAttribute("brand", brand);
        request.setAttribute("year", year);
        request.setAttribute("daily_rate", daily_rate);
        request.setAttribute("type", type);
        request.setAttribute("color", color);
        request.setAttribute("engine_size", engine_size);
        request.setAttribute("fuel_type", fuel_type);
        
        request.setAttribute("currentPage", page);
        request.setAttribute("motorbikes", motorbikes);
        request.setAttribute("totalPage", totalPage);

        request.setAttribute("brands", brands);
        request.setAttribute("years", years);
        request.setAttribute("daily_rates", daily_rates);
        request.setAttribute("types", types);
        request.setAttribute("colors", colors);
        request.setAttribute("engine_sizes", engine_sizes);
        request.setAttribute("fuel_types", fuel_types);
        request.getRequestDispatcher("search.jsp").forward(request, response);
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
