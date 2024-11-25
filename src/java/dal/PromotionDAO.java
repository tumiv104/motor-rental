/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Promotion;

/**
 *
 * @author Nitro
 */
public class PromotionDAO extends DBContext{
    public ArrayList<Promotion> getAllAvailablePromotion(BigDecimal amount) {
        ArrayList<Promotion> promotions = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT * FROM Promotion \n"
                    + "WHERE end_date >= GETDATE() \n"
                    + "AND current_uses < max_uses\n"
                    + "AND status = 'enable'\n"
                    + "AND amount <= ?\n"
                    + "ORDER BY promotion_id DESC";

            stm = connection.prepareStatement(sql);
            stm.setBigDecimal(1, amount);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Promotion p = new Promotion();
                p.setPromotionId(rs.getInt("promotion_id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setDiscountRate(rs.getDouble("discount_rate"));
                p.setStartDate(rs.getDate("start_date"));
                p.setEndDate(rs.getDate("end_date"));
                p.setPromoCode(rs.getString("promo_code"));
                p.setMaxUses(rs.getInt("max_uses"));
                p.setCurrentUses(rs.getInt("current_uses"));
                p.setAmount(rs.getBigDecimal("amount"));
                p.setStatus(rs.getString("status"));

                promotions.add(p);
            }

        } catch (SQLException ex) {
            Logger.getLogger(PromotionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return promotions;
    }

    public double getDiscountById(int pid) {
        double discount = 0;
        PreparedStatement stm = null;
        try {
            String sql = "SELECT discount_rate FROM Promotion WHERE promotion_id = ?";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, pid);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getDouble("discount_rate");
            }

        } catch (SQLException ex) {
            Logger.getLogger(PromotionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return discount;
    }
    
    public void insertBookingPromotion(int pid, int bid) {
        PreparedStatement stm = null;
        try {
            String sql = "INSERT INTO [dbo].[BookingPromotion]\n"
                    + "           ([booking_id]\n"
                    + "           ,[promotion_id])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?)";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, bid);
            stm.setInt(2, pid);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(PromotionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void insertPromotion(String name, String code, String description, double discount, String startDate, String endDate, int maxUse, BigDecimal minAmount) {
        PreparedStatement stm = null;
        try {
            String sql = "INSERT INTO [dbo].[Promotion]\n"
                    + "           ([name]\n"
                    + "           ,[description]\n"
                    + "           ,[discount_rate]\n"
                    + "           ,[start_date]\n"
                    + "           ,[end_date]\n"
                    + "           ,[promo_code]\n"
                    + "           ,[max_uses]\n"
                    + "           ,[current_uses]\n"
                    + "           ,[amount]\n"
                    + "           ,[status])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,0\n"
                    + "           ,?\n"
                    + "           ,'enable')";
            stm = connection.prepareStatement(sql);
            stm.setString(1, name);
            stm.setString(2, description);
            stm.setDouble(3, discount);
            stm.setString(4, startDate);
            stm.setString(5, endDate);
            stm.setString(6, code);
            stm.setInt(7, maxUse);
            stm.setBigDecimal(8, minAmount);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(PromotionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void updatePromotion(int id, String name, String code, String description, double discount, String startDate, String endDate, int maxUse, BigDecimal minAmount) {
        PreparedStatement stm = null;
        try {
            String sql = "UPDATE [dbo].[Promotion]\n"
                    + "   SET [name] = ?\n"
                    + "      ,[description] = ?\n"
                    + "      ,[discount_rate] = ?\n"
                    + "      ,[start_date] = ?\n"
                    + "      ,[end_date] = ?\n"
                    + "      ,[promo_code] = ?\n"
                    + "      ,[max_uses] = ?\n"
                    + "      ,[amount] = ?\n"
                    + " WHERE promotion_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, name);
            stm.setString(2, description);
            stm.setDouble(3, discount);
            stm.setString(4, startDate);
            stm.setString(5, endDate);
            stm.setString(6, code);
            stm.setInt(7, maxUse);
            stm.setBigDecimal(8, minAmount);
            stm.setInt(9, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PromotionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public ArrayList<Promotion> searchPromotion(String search) {
        ArrayList<Promotion> promotions = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT * FROM Promotion \n"
                    + "WHERE name LIKE ? OR promo_code LIKE ?\n"
                    + "ORDER BY promotion_id DESC";

            stm = connection.prepareStatement(sql);
            search = "%" + search + "%";
            stm.setString(1, search);
            stm.setString(2, search);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Promotion p = new Promotion();
                p.setPromotionId(rs.getInt("promotion_id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setDiscountRate(rs.getDouble("discount_rate"));
                p.setStartDate(rs.getDate("start_date"));
                p.setEndDate(rs.getDate("end_date"));
                p.setPromoCode(rs.getString("promo_code"));
                p.setMaxUses(rs.getInt("max_uses"));
                p.setCurrentUses(rs.getInt("current_uses"));
                p.setAmount(rs.getBigDecimal("amount"));
                p.setStatus(rs.getString("status"));

                promotions.add(p);
            }

        } catch (SQLException ex) {
            Logger.getLogger(PromotionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return promotions;
    }
    
    public void updateStatus(int pid, String status) {
        PreparedStatement stm = null;
        try {
            String sql = "UPDATE [dbo].[Promotion]\n"
                    + "   SET [status] = ?\n"
                    + " WHERE promotion_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            stm.setInt(2, pid);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PromotionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void updateCurrentUse(int pid) {
        PreparedStatement stm = null;
        try {
            String sql = "UPDATE [dbo].[Promotion]\n"
                    + "   SET [current_uses] = [current_uses] + 1\n"
                    + " WHERE promotion_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, pid);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PromotionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
