/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import config.VNPayConfig;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Booking;
import model.BookingCancel;
import model.Motorbike;

/**
 *
 * @author Nitro
 */
public class BookingDAO extends DBContext {

    public ArrayList<Booking> getAllBooking() {
        ArrayList<Booking> bookings = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT booking_id, code, start_date, end_date, total_cost, status, pickup_location,\n"
                    + "dropoff_location, created_at, email, phone_number, receive_time, return_time\n"
                    + "FROM Booking ORDER BY created_at DESC";

            stm = connection.prepareStatement(sql);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                b.setCode(rs.getString("code"));
                b.setBookingId(rs.getInt("booking_id"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                b.setPickupLocation(rs.getString("pickup_location"));
                b.setDropoffLocation(rs.getString("dropoff_location"));
                b.setStartDate(rs.getTimestamp("start_date"));
                b.setEndDate(rs.getTimestamp("end_date"));
                b.setTotalCost(rs.getBigDecimal("total_cost"));
                b.setStatus(rs.getString("status"));
                b.setEmail(rs.getString("email"));
                b.setPhone_number(rs.getString("phone_number"));
                b.setReceiveTime(rs.getTimestamp("receive_time"));
                b.setReturnTime(rs.getTimestamp("return_time"));

                bookings.add(b);
            }

        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return bookings;
    }
    
    public ArrayList<Booking> getAllBookingBy(String status, String startDate, String endDate, String search) {
        ArrayList<Booking> bookings = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT booking_id, code, start_date, end_date, total_cost, status, pickup_location,\n"
                    + "dropoff_location, created_at, email, phone_number, receive_time, return_time, name FROM Booking \n"
                    + "WHERE (1=1)";
            if (status != null && !status.equals("")) {
                sql += " AND status = ?";
            }
            if (startDate != null && !startDate.equals("")) {
                sql += " AND created_at >= ?";
            }
            if (endDate != null && !endDate.equals("")) {
                sql += " AND created_at <= ?";
            }
            if (search != null && !search.equals("")) {
                sql += " AND (code LIKE ? OR name LIKE ?)";
            }
            sql += " ORDER BY created_at DESC";
            stm = connection.prepareStatement(sql);
            int i = 1;
            if (status != null && !status.equals("")) {
                stm.setString(i, status);
                ++i;
            }
            if (startDate != null && !startDate.equals("")) {
                stm.setString(i, startDate);
                ++i;
            }
            if (endDate != null && !endDate.equals("")) {
                stm.setString(i, endDate);
                ++i;
            }
            if (search != null && !search.equals("")) {
                String s = "%" + search;
                s += "%";
                stm.setString(i, s);
                ++i;
                stm.setString(i, s);
            }
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                b.setCode(rs.getString("code"));
                b.setBookingId(rs.getInt("booking_id"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                b.setPickupLocation(rs.getString("pickup_location"));
                b.setDropoffLocation(rs.getString("dropoff_location"));
                b.setStartDate(rs.getTimestamp("start_date"));
                b.setEndDate(rs.getTimestamp("end_date"));
                b.setTotalCost(rs.getBigDecimal("total_cost"));
                b.setStatus(rs.getString("status"));
                b.setEmail(rs.getString("email"));
                b.setPhone_number(rs.getString("phone_number"));
                b.setReceiveTime(rs.getTimestamp("receive_time"));
                b.setReturnTime(rs.getTimestamp("return_time"));
                b.setName(rs.getString("name"));

                bookings.add(b);
            }

        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return bookings;
    }
    
    public ArrayList<Booking> getBookingByUserId(int uid) {
        ArrayList<Booking> bookings = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT booking_id, code, start_date, end_date, total_cost, status, "
                    + "pickup_location, dropoff_location, created_at, email, phone_number, receive_time, return_time FROM Booking\n"
                    + "WHERE user_id = ? ORDER BY created_at DESC";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, uid);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                b.setCode(rs.getString("code"));
                b.setBookingId(rs.getInt("booking_id"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                b.setPickupLocation(rs.getString("pickup_location"));
                b.setDropoffLocation(rs.getString("dropoff_location"));
                b.setStartDate(rs.getTimestamp("start_date"));
                b.setEndDate(rs.getTimestamp("end_date"));
                b.setTotalCost(rs.getBigDecimal("total_cost"));
                b.setStatus(rs.getString("status"));
                b.setEmail(rs.getString("email"));
                b.setPhone_number(rs.getString("phone_number"));
                b.setReceiveTime(rs.getTimestamp("receive_time"));
                b.setReturnTime(rs.getTimestamp("return_time"));

                bookings.add(b);
            }

        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return bookings;
    }

    public void insert(Booking model) {
        PreparedStatement stm = null;
        try {
            String sql_insert = "INSERT INTO [dbo].[Booking]\n"
                    + "           ([user_id]\n"
                    + "           ,[start_date]\n"
                    + "           ,[end_date]\n"
                    + "           ,[total_cost]\n"
                    + "           ,[status]\n"
                    + "           ,[pickup_location]\n"
                    + "           ,[dropoff_location]\n"
                    + "           ,[email]\n"
                    + "           ,[phone_number]\n"
                    + "           ,[name]\n"
                    + "           ,[id_number]\n"
                    + "           ,[license_number]\n"
                    + "           ,[address]\n"
                    + "           ,[code])\n"
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
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?)";
            stm = connection.prepareStatement(sql_insert);
            stm.setInt(1, model.getUserId());
            stm.setTimestamp(2, model.getStartDate());
            stm.setTimestamp(3, model.getEndDate());
            stm.setBigDecimal(4, model.getTotalCost());
            stm.setString(5, model.getStatus());
            stm.setString(6, model.getPickupLocation());
            stm.setString(7, model.getDropoffLocation());
            stm.setString(8, model.getEmail());
            stm.setString(9, model.getPhone_number());
            stm.setString(10, model.getName());
            stm.setString(11, model.getIdNumber());
            stm.setString(12, model.getLicenseNumber());
            stm.setString(13, model.getAddress());
            stm.setString(14, model.getCode());
            stm.executeUpdate();

        } catch (SQLException ex1) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex1);
        }
    }

    public Booking getNewestBookingId() {
        PreparedStatement stm = null;
        try {
            String sql = "SELECT TOP 1 booking_id, created_at FROM Booking\n"
                    + "ORDER BY created_at DESC";

            stm = connection.prepareStatement(sql);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                b.setBookingId(rs.getInt("booking_id"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                return b;
            }

        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insertDetail(int mid, int bid) {
        PreparedStatement stm = null;
        try {
            String sql = "INSERT INTO [dbo].[BookingDetail]\n"
                    + "           ([motorbike_id]\n"
                    + "           ,[booking_id])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?)";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, mid);
            stm.setInt(2, bid);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Booking getBookingById(int bid) {
        PreparedStatement stm = null;
        try {
            String sql = "SELECT booking_id, code, start_date, end_date, total_cost, status, "
                    + "pickup_location, dropoff_location, created_at, email, phone_number, receive_time, return_time, name FROM Booking\n"
                    + "WHERE booking_id = ?";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, bid);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                b.setCode(rs.getString("code"));
                b.setBookingId(rs.getInt("booking_id"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                b.setPickupLocation(rs.getString("pickup_location"));
                b.setDropoffLocation(rs.getString("dropoff_location"));
                b.setStartDate(rs.getTimestamp("start_date"));
                b.setEndDate(rs.getTimestamp("end_date"));
                b.setTotalCost(rs.getBigDecimal("total_cost"));
                b.setStatus(rs.getString("status"));
                b.setEmail(rs.getString("email"));
                b.setPhone_number(rs.getString("phone_number"));
                b.setReceiveTime(rs.getTimestamp("receive_time"));
                b.setReturnTime(rs.getTimestamp("return_time"));
                b.setName(rs.getString("name"));

                return b;
            }

        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<Motorbike> getMotorbikesById(int bid) {
        ArrayList<Motorbike> motorbikes = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT m.motorbike_id, m.model, m.daily_rate, m.image_url, m.color, m.license_plate FROM BookingDetail bd\n"
                    + "JOIN Motorbike m ON bd.motorbike_id = m.motorbike_id\n"
                    + "WHERE bd.booking_id = ?";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, bid);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Motorbike motorbike = new Motorbike();
                motorbike.setMotorbikeId(rs.getInt("motorbike_id"));
                motorbike.setModel(rs.getString("model"));
                motorbike.setDailyRate(rs.getDouble("daily_rate"));
                motorbike.setImageUrl(rs.getString("image_url"));
                motorbike.setColor(rs.getString("color"));
                motorbike.setLicensePlate(rs.getString("license_plate"));

                motorbikes.add(motorbike);
            }

        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return motorbikes;
    }

    public Map<Motorbike, List<Booking>> getMotorbikeBookedByDate(Timestamp startDate, Timestamp endDate) {
        Map<Motorbike, List<Booking>> list = new HashMap<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT m.motorbike_id, m.model, b.start_date, b.end_date FROM Booking b\n"
                    + "JOIN BookingDetail bd ON b.booking_id = bd.booking_id\n"
                    + "JOIN Motorbike m ON bd.motorbike_id = m.motorbike_id\n"
                    + "WHERE (([start_date] >= ? AND [start_date] <= ?) \n"
                    + "OR (end_date >= ? AND end_date <= ?)\n"
                    + "OR ([start_date] <= ? AND end_date >= ?)) \n"
                    + "AND b.status != 'Completed';";

            stm = connection.prepareStatement(sql);
            stm.setTimestamp(1, startDate);
            stm.setTimestamp(2, endDate);
            stm.setTimestamp(3, startDate);
            stm.setTimestamp(4, endDate);
            stm.setTimestamp(5, startDate);
            stm.setTimestamp(6, endDate);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Motorbike motorbike = new Motorbike();
                motorbike.setMotorbikeId(rs.getInt("motorbike_id"));
                motorbike.setModel(rs.getString("model"));

                Booking b = new Booking();
                b.setStartDate(rs.getTimestamp("start_date"));
                b.setEndDate(rs.getTimestamp("end_date"));

                if (!list.containsKey(motorbike)) {
                    list.put(motorbike, new ArrayList<>());
                }
                list.get(motorbike).add(b);
            }

        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public String generateTransactionCode() {
        ArrayList<String> codes = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT code FROM Booking";
            stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                codes.add(rs.getString("code"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        String code = VNPayConfig.getRandomNumber(8);
        while (codes.contains(code)) {
            code = VNPayConfig.getRandomNumber(8);
        }
        return code;
    }
    
    public void updateBookingStatus(int bid, String status) {
        PreparedStatement stm = null;
        try {
            String sql = "UPDATE [dbo].[Booking]\n"
                    + "   SET [status] = ?\n";
            if (status.equals("renting")) {
                sql += "      ,[receive_time] = GETDATE()\n";
            } else if (status.equals("completed")) {
                sql += "      ,[return_time] = GETDATE()\n";
            }
            sql += " WHERE booking_id=?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            stm.setInt(2, bid);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void insertBookingCancel(int bid, String reason, String role) {
        PreparedStatement stm = null;
        try {
            String sql = "INSERT INTO [dbo].[BookingCancel]\n"
                    + "           ([booking_id]\n"
                    + "           ,[reason]\n"
                    + "           ,[role])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,?)";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, bid);
            stm.setString(2, reason);
            stm.setString(3, role);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public BookingCancel getBookingCancel(int bid) {
        BookingCancel bc = new BookingCancel();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT reason, role FROM BookingCancel\n"
                    + "WHERE booking_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, bid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {                
                bc.setReason(rs.getString("reason"));
                bc.setRole(rs.getString("role"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return bc;
    }
    
    public ArrayList<Booking> getBookingByUserIdStatus(int uid, String status) {
        ArrayList<Booking> bookings = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT booking_id, code, start_date, end_date, total_cost, status, "
                    + "pickup_location, dropoff_location, created_at, email, phone_number, receive_time, return_time FROM Booking\n"
                    + "WHERE user_id = ? AND status = ? ORDER BY created_at DESC";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, uid);
            stm.setString(2, status);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                b.setCode(rs.getString("code"));
                b.setBookingId(rs.getInt("booking_id"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                b.setPickupLocation(rs.getString("pickup_location"));
                b.setDropoffLocation(rs.getString("dropoff_location"));
                b.setStartDate(rs.getTimestamp("start_date"));
                b.setEndDate(rs.getTimestamp("end_date"));
                b.setTotalCost(rs.getBigDecimal("total_cost"));
                b.setStatus(rs.getString("status"));
                b.setEmail(rs.getString("email"));
                b.setPhone_number(rs.getString("phone_number"));
                b.setReceiveTime(rs.getTimestamp("receive_time"));
                b.setReturnTime(rs.getTimestamp("return_time"));

                bookings.add(b);
            }

        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return bookings;
    }
}
