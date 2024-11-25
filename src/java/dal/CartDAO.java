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
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Motorbike;

/**
 *
 * @author Nitro
 */
public class CartDAO extends DBContext {

    public void insert(int uid, int mid) {
        PreparedStatement stm = null;
        try {
            String sql = "INSERT INTO [dbo].[Cart]\n"
                    + "           ([user_id]\n"
                    + "           ,[motorbike_id])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?)";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, uid);
            stm.setInt(2, mid);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void delete(int cartId) {
        PreparedStatement stm = null;
        try {
            String sql = "DELETE FROM [dbo].[Cart]\n"
                    + "      WHERE cart_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, cartId);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteAll(int uid) {
        PreparedStatement stm = null;
        try {
            String sql = "DELETE FROM [dbo].[Cart]\n"
                    + "      WHERE user_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, uid);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean added(int uid, int mid) {
        boolean check = false;
        PreparedStatement stm = null;
        try {
            String sql = "SELECT user_id FROM Cart \n"
                    + "WHERE user_id = ? AND motorbike_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, uid);
            stm.setInt(2, mid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                check = true;
            }

        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return check;
    }

    public int getQuantity(int uid) {
        int quantity = 0;
        PreparedStatement stm = null;
        try {
            String sql = "SELECT COUNT(*) FROM Cart\n"
                    + "WHERE user_id = ?;";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, uid);
            //stm.setInt(2, mid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                quantity = rs.getInt(1);
            }

        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return quantity;
    }

    public HashMap<Integer, Motorbike> getListCartByUid(int uid) {
        HashMap<Integer, Motorbike> carts = new HashMap<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT c.cart_id, c.motorbike_id, m.model, m.daily_rate, m.image_url, m.status FROM Cart c\n"
                    + "JOIN Motorbike m ON c.motorbike_id=m.motorbike_id\n"
                    + "WHERE user_id = ?";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, uid);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int cid = rs.getInt("cart_id");
                Motorbike m = new Motorbike();
                m.setMotorbikeId(rs.getInt("motorbike_id"));
                m.setModel(rs.getString("model"));
                m.setDailyRate(rs.getDouble("daily_rate"));
                m.setImageUrl(rs.getString("image_url"));
                m.setStatus(rs.getString("status"));

                carts.put(cid, m);
            }

        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return carts;
    }

    public ArrayList<Integer> getListMotoridByUid(int uid) {
        ArrayList<Integer> motorbikes = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT motorbike_id FROM Cart \n"
                    + "WHERE user_id = ?";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, uid);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                motorbikes.add(rs.getInt("motorbike_id"));
            }

        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return motorbikes;
    }

    public BigDecimal getDeposit(int uid) {
        ArrayList<Integer> mids = getListMotoridByUid(uid);
        BigDecimal deposit = new BigDecimal(0);
        PreparedStatement stm = null;
        try {
            String sql = "SELECT m.motorbike_id, mt.deposit FROM MotorbikeType mt\n"
                    + "JOIN Motorbike m ON mt.type_id = m.type_id\n"
                    + "WHERE (2 < 1)";
            for (Integer m : mids) {
                sql += " OR m.motorbike_id = ?";
            }
            stm = connection.prepareStatement(sql);
            stm.setInt(1, uid);
            int i = 0;
            for (Integer mid : mids) {
                ++i;
                stm.setInt(i, mid);
            }
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                BigDecimal d = rs.getBigDecimal("deposit");
                deposit = deposit.add(d);
            }

        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return deposit;
    }

}
