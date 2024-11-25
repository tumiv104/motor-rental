/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.Users;
import java.sql.ResultSet;
import java.sql.*;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 *
 * @author hungv
 */
public class CRUDUser extends DBContext {

    private static final Logger LOGGER = Logger.getLogger(CRUDUser.class.getName());

    public List<Users> getAllUsers() {
        List<Users> userList = new ArrayList<>();
        String sql = "SELECT * FROM [User]";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Users user = new Users();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setDateOfBirth(rs.getDate("date_of_birth"));
                user.setUserType(rs.getString("user_type"));
                user.setProfilePicture(rs.getString("profile_picture"));
                user.setAddress(rs.getString("address"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setLastLogin(rs.getTimestamp("last_login"));
                user.setIsActive(rs.getBoolean("is_active"));
                user.setBannedReason(rs.getString("banned_reason"));
                user.setBannedUntil(rs.getDate("banned_until"));
                user.setRole(rs.getString("role"));

                userList.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }

    public Users getUserById(int userId) throws SQLException {
        String sql = "SELECT * FROM [User] WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Users user = new Users();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setFullName(rs.getString("full_name"));
                    user.setPhoneNumber(rs.getString("phone_number"));
                    user.setDateOfBirth(rs.getDate("date_of_birth"));
                    user.setUserType(rs.getString("user_type"));
                    user.setRole(rs.getString("role"));
                    return user;
                }
            }
        }
        return null;
    }

    public void addUser(Users user) throws SQLException {
        String sql = "INSERT INTO [User] (username, email, password, full_name, phone_number, date_of_birth, user_type, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getFullName());

            if (user.getPhoneNumber() == null || user.getPhoneNumber().isEmpty()) {
                pstmt.setNull(5, java.sql.Types.VARCHAR);
            } else {
                pstmt.setString(5, user.getPhoneNumber());
            }

            pstmt.setDate(6, user.getDateOfBirth());
            pstmt.setString(7, user.getUserType());
            pstmt.setString(8, user.getRole());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi thêm user: " + e.getMessage(), e);
            throw new SQLException("Lỗi khi thêm user vào cơ sở dữ liệu: " + e.getMessage());
        }
    }
    
    

    public Users getFirstAdmin() {
        String sql = "SELECT * FROM [User] WHERE username = ? AND email = ? AND password = ? AND full_name = ? AND phone_number = ? AND date_of_birth = ? AND user_type = ? AND role = ?";
        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Thay các giá trị dưới đây bằng thông tin của Admin đầu tiên
            pstmt.setString(1, "hung");
            pstmt.setString(2, "hungvd18@gmail.com");
            pstmt.setString(3, "123");
            pstmt.setString(4, "Vu Duc Hung");
            pstmt.setString(5, "00826078586");
            pstmt.setDate(6, Date.valueOf("2003-06-18"));
            pstmt.setString(7, "Staff");
            pstmt.setString(8, "Admin");

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Users admin = new Users();
                    admin.setUserId(rs.getInt("user_id")); // Giả sử bạn đã có phương thức getUserId()
                    admin.setUsername(rs.getString("username"));
                    admin.setEmail(rs.getString("email"));
                    admin.setFullName(rs.getString("full_name"));
                    admin.setPhoneNumber(rs.getString("phone_number"));
                    admin.setDateOfBirth(rs.getDate("date_of_birth"));
                    admin.setUserType(rs.getString("user_type"));
                    admin.setRole(rs.getString("role"));
                    return admin;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy Admin
    }

    public void banUser(int userId, String reason, Date bannedUntil) {
        String sql = "UPDATE [User] SET is_active = 0, banned_reason = ?, banned_until = ? WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, reason);
            ps.setDate(2, bannedUntil);
            ps.setInt(3, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void unbanUser(int userId) {
        String sql = "UPDATE [User] SET is_active = 1, banned_reason = NULL, banned_until = NULL WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteUser(int userId) {
        String sql = "DELETE FROM [User] WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<Users> getPaginatedUsers(int offset, int recordsPerPage) {
        List<Users> userList = new ArrayList<>();
        String sql = "SELECT * FROM [User] ORDER BY user_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, offset);
            ps.setInt(2, recordsPerPage);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Users user = new Users();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setFullName(rs.getString("full_name"));
                    user.setPhoneNumber(rs.getString("phone_number"));
                    user.setDateOfBirth(rs.getDate("date_of_birth"));
                    user.setUserType(rs.getString("user_type"));
                    user.setProfilePicture(rs.getString("profile_picture"));
                    user.setAddress(rs.getString("address"));
                    user.setCreatedAt(rs.getTimestamp("created_at"));
                    user.setLastLogin(rs.getTimestamp("last_login"));
                    user.setIsActive(rs.getBoolean("is_active"));
                    user.setBannedReason(rs.getString("banned_reason"));
                    user.setBannedUntil(rs.getDate("banned_until"));
                    user.setRole(rs.getString("role"));
                    userList.add(user);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }
    
    public int getTotalUsers() {
        int count = 0;
        String sql = "SELECT COUNT(*) as total FROM [User]";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

}
