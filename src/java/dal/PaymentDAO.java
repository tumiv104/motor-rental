/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import config.VNPayConfig;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.AdditionFee;
import model.Payment;
import model.PaymentMethod;

/**
 *
 * @author Nitro
 */
public class PaymentDAO extends DBContext {

    public ArrayList<PaymentMethod> getAllMethod() {
        ArrayList<PaymentMethod> methods = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT method_id, method_name, image_url, code FROM PaymentMethod";
            stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                PaymentMethod p = new PaymentMethod();
                p.setMethod_id(rs.getInt("method_id"));
                p.setMethod_name(rs.getString("method_name"));
                p.setImage_url(rs.getString("image_url"));
                p.setCode(rs.getString("code"));

                methods.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return methods;
    }
    
    public PaymentMethod getMethodById(int id) {
        PreparedStatement stm = null;
        try {
            String sql = "SELECT method_id, method_name, image_url, code FROM PaymentMethod WHERE method_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {                
                PaymentMethod p = new PaymentMethod();
                p.setMethod_id(rs.getInt("method_id"));
                p.setMethod_name(rs.getString("method_name"));
                p.setImage_url(rs.getString("image_url"));
                p.setCode(rs.getString("code"));
                return p;
            }
        } catch (SQLException e) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return null;
    }

    public void insertPayment(int bid, BigDecimal total_amount, Timestamp date, String method, String payment_status, 
            String tid, BigDecimal discount_amount,BigDecimal rental_amount,BigDecimal deposit_amount, String deposit_status) {
        PreparedStatement stm = null;
        try {
            String sql = "INSERT INTO [dbo].[Payment]\n"
                    + "           ([booking_id]\n"
                    + "           ,[total_amount]\n"
                    + "           ,[payment_date]\n"
                    + "           ,[method_id]\n"
                    + "           ,[payment_status]\n"
                    + "           ,[transaction_id]\n"
                    + "           ,[discount_amount]\n"
                    + "           ,[rental_amount]\n"
                    + "           ,[deposit_amount]\n"
                    + "           ,[deposit_status])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?)";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, bid);
            stm.setBigDecimal(2, total_amount);
            stm.setTimestamp(3, date);
            stm.setInt(4, getMethodIdByCode(method));
            stm.setString(5, payment_status);
            stm.setString(6, tid);
            stm.setBigDecimal(7, discount_amount);
            stm.setBigDecimal(8, rental_amount);
            stm.setBigDecimal(9, deposit_amount);
            stm.setString(10, deposit_status);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public String generateTransactionCode(String method) {
        ArrayList<String> codes = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT transaction_id FROM Payment";
            stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                codes.add(rs.getString("transaction_id"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        String random = VNPayConfig.getRandomNumber(8);
        String code = method.toUpperCase() + random;
        while (codes.contains(code)) {
            random = VNPayConfig.getRandomNumber(8);
            code = method.toUpperCase() + random;
        }
        return code;
    }
    
    public Payment getPaymentByBookingId(int bid) {
        PreparedStatement stm = null;
        try {
            String sql = "SELECT payment_id, booking_id, total_amount, method_id, payment_date, payment_status, transaction_id, "
                    + "discount_amount, rental_amount, deposit_amount, deposit_status "
                    + "FROM Payment WHERE booking_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, bid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Payment p = new Payment();
                p.setPaymentId(rs.getInt("payment_id"));
                p.setBookingId(rs.getInt("booking_id"));
                p.setTotal_amount(rs.getBigDecimal("total_amount"));
                p.setMethodId(rs.getInt("method_id"));
                p.setDate(rs.getTimestamp("payment_date"));
                p.setPayment_status(rs.getString("payment_status"));
                p.setTransactionId(rs.getString("transaction_id"));
                p.setRental_amount(rs.getBigDecimal("rental_amount"));
                p.setDiscount_amount(rs.getBigDecimal("discount_amount"));
                p.setDeposit_amount(rs.getBigDecimal("deposit_amount"));
                p.setDeposit_status(rs.getString("deposit_status"));
                return p;
            }
        } catch (SQLException e) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return null;
    }
    
    public void insertAdditionFee(BigDecimal amount, String reason, String status, int bid) {
        PreparedStatement stm = null;
        try {
            String sql = "INSERT INTO [dbo].[AdditionFee]\n"
                    + "           ([amount]\n"
                    + "           ,[reason]\n"
                    + "           ,[status]\n"
                    + "           ,[booking_id])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?)";
            stm = connection.prepareStatement(sql);
            stm.setBigDecimal(1, amount);
            stm.setString(2, reason);
            stm.setString(3, status);
            stm.setInt(4, bid);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateAdditionStatus(int bid, String status) {
        PreparedStatement stm = null;
        try {
            String sql = "UPDATE [dbo].[AdditionFee]\n"
                    + "   SET [status] = ?\n"
                    + " WHERE booking_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            stm.setInt(2, bid);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<AdditionFee> getAdditionFeeByBid(int bid) {
        ArrayList<AdditionFee> additions = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT id, amount, reason, status, booking_id FROM AdditionFee\n"
                    + "WHERE booking_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, bid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                AdditionFee a = new AdditionFee();
                a.setId(rs.getInt("id"));
                a.setAmount(rs.getBigDecimal("amount"));
                a.setReason(rs.getString("reason"));
                a.setStatus(rs.getString("status"));
                a.setBookingId(rs.getInt("booking_id"));

                additions.add(a);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return additions;
    }
    
    private int getMethodIdByCode(String code) {
        PreparedStatement stm = null;
        try {
            String sql = "SELECT method_id FROM PaymentMethod WHERE code = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, code);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {                
                return rs.getInt("method_id");
            }
        } catch (SQLException e) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return 0;
    }
    
    public void updatePaymentStatus(int pid, String status) {
        PreparedStatement stm = null;
        try {
            String sql = "UPDATE [dbo].[Payment]\n"
                    + "   SET [payment_status] = ?\n"
                    + " WHERE payment_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            stm.setInt(2, pid);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateDepositStatus(int pid, String status) {
        PreparedStatement stm = null;
        try {
            String sql = "UPDATE [dbo].[Payment]\n"
                    + "   SET [deposit_status] = ?\n"
                    + " WHERE payment_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            stm.setInt(2, pid);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
