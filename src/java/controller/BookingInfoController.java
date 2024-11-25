/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AddressDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.Booking;
import model.Province;

/**
 *
 * @author Nitro
 */
public class BookingInfoController extends HttpServlet {

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
            out.println("<title>Servlet BookingInfoController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookingInfoController at " + request.getContextPath() + "</h1>");
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
        AddressDAO adb = new AddressDAO();
        ArrayList<Province> provinces = adb.getAllProvince();
        request.setAttribute("provinces", provinces);
        request.getRequestDispatcher("bookinginfo.jsp").forward(request, response);
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
        int check = Integer.parseInt(request.getParameter("check"));
        if (check == 1) {
            AddressDAO adb = new AddressDAO();
            ArrayList<Province> provinces = adb.getAllProvince();
            request.setAttribute("provinces", provinces);
            request.setAttribute("mess", "Có xe không khả dụng! Vui lòng thay đổi ngày đặt hoặc chọn xe khác !");
            request.getRequestDispatcher("bookinginfo.jsp").forward(request, response);
            return;
        }
        AddressDAO adb = new AddressDAO();
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone_number");
        String idNumber = request.getParameter("idNumber");
        String licenseNumber = request.getParameter("licenseNumber");
        String province3 = request.getParameter("province3");
        String district3 = request.getParameter("district3");
        String ward3 = request.getParameter("ward3");

        int pid3 = Integer.parseInt(province3);
        int did3 = Integer.parseInt(district3);
        int wid3 = Integer.parseInt(ward3);
        String address3 = adb.getAddress(pid3, did3, wid3);

        String address1 = "";
        String address2 = "";
        if (request.getParameter("pickup").equals("hide")) {
            address1 += "Tại cửa hàng";
        } else {
            int pid1 = Integer.parseInt(request.getParameter("province"));
            int did1 = Integer.parseInt(request.getParameter("district"));
            int wid1 = Integer.parseInt(request.getParameter("ward"));
            address1 += adb.getAddress(pid1, did1, wid1);
        }

        if (request.getParameter("dropoff").equals("hide")) {
            address2 += "Tại cửa hàng";
        } else {
            int pid2 = Integer.parseInt(request.getParameter("province2"));
            int did2 = Integer.parseInt(request.getParameter("district2"));
            int wid2 = Integer.parseInt(request.getParameter("ward2"));
            address2 += adb.getAddress(pid2, did2, wid2);
        }

        HttpSession session = request.getSession();
        Booking booking = (Booking) session.getAttribute("booking");
        booking.setPickupLocation(address1);
        booking.setDropoffLocation(address2);
        booking.setPhone_number(phone);
        booking.setAddress(address3);
        booking.setEmail(email);
        booking.setName(name);
        booking.setIdNumber(idNumber);
        booking.setLicenseNumber(licenseNumber);
        session.setAttribute("booking", booking);
        response.sendRedirect("payment");
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
