package dal;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Users;
import model.GoogleAccount;
import model.RentalRequest;
import model.RentalUpgradeRequest;

public class UserDAO extends DBContext {

    // Phương thức kiểm tra đăng nhập
    public boolean checkLogin(String username, String password) {
        String sql = "SELECT * FROM [User] WHERE username = ? AND password = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            return rs.next(); // Nếu có kết quả thì đăng nhập thành công
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Phương thức lấy dữ liệu người dùng sau khi đăng nhập thành công
    public Users setDataUser(String username, String password) {
        String sql = "SELECT * FROM [User] WHERE username = ? AND password = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Users user = new Users();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setDateOfBirth(rs.getDate("date_of_birth"));
                user.setUserType(rs.getString("user_type"));
                user.setProfilePicture(rs.getString("profile_picture"));
                user.setAddress(rs.getString("address"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setLastLogin(rs.getTimestamp("last_login"));
                user.setIsActive(rs.getBoolean("is_active")); // Cập nhật trường is_active
                user.setRole(rs.getString("role"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy
    }

    // Phương thức kiểm tra tên người dùng đã tồn tại
    public boolean checkUserNameExist(String username) {
        String sql = "SELECT * FROM [User] WHERE username = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Phương thức lấy thông tin người dùng qua user_id
    public Users getUserById(int userId) {
        String sql = "SELECT * FROM [User] WHERE user_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Users user = new Users();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setDateOfBirth(rs.getDate("date_of_birth"));
                user.setUserType(rs.getString("user_type"));
                user.setProfilePicture(rs.getString("profile_picture"));
                user.setAddress(rs.getString("address"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setLastLogin(rs.getTimestamp("last_login"));
                user.setIsActive(rs.getBoolean("is_active"));
                user.setRole(rs.getString("role"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Phương thức thêm người dùng mới
    public void addUser(String username, String password, String fullName, String email, String phoneNumber, Date dob, String address) {
        String sql = "INSERT INTO [User] (username, password, full_name, email, phone_number, date_of_birth, address, user_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            st.setString(2, password);
            st.setString(3, fullName);
            st.setString(4, email);
            st.setString(5, phoneNumber);
            st.setDate(6, dob);
            st.setString(7, address);
            st.setString(8, "Customer"); // Thêm giá trị mặc định cho cột user_type
            st.executeUpdate();
            System.out.println("Người dùng mới đã được thêm thành công!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Phương thức lấy UID từ username và password
    public String setDataUid(String username, String password) {
        String sql = "SELECT user_id FROM [User] WHERE username = ? AND password = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getString("user_id"); // Trả về UID nếu tìm thấy
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Phương thức cập nhật thông tin người dùng
    public boolean updateUser(Users user) {
        String sql = "UPDATE [User] SET email = ?, phone_number = ?, address = ?, date_of_birth = ? WHERE user_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            // Thiết lập các tham số cho câu lệnh SQL
            st.setString(1, user.getEmail());
            st.setString(2, user.getPhoneNumber());
            st.setString(3, user.getAddress());
            st.setDate(4, user.getDateOfBirth());
            st.setInt(5, user.getUserId()); // Sử dụng userId để cập nhật

            // Thực hiện cập nhật và kiểm tra kết quả
            int result = st.executeUpdate();
            return result > 0; // Nếu cập nhật thành công thì trả về true
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Phương thức xóa người dùng
    public void deleteUser(String username) {
        String sql = "DELETE FROM [User] WHERE username = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Phương thức cập nhật mật khẩu người dùng
    public void updatePassword(int userId, String newPassword) {
        String sql = "UPDATE [User] SET password = ? WHERE user_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, newPassword); // Lưu mật khẩu mới
            st.setInt(2, userId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean checkPassword(String username, String currentPassword) {
        String sql = "SELECT password FROM [User] WHERE username = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                String storedPassword = rs.getString("password");
                return storedPassword.equals(currentPassword); // Kiểm tra mật khẩu
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Nếu không tìm thấy người dùng
    }

    public void updatePasswordByEmail(String email, String newPassword1) {
        String sql = "UPDATE [dbo].[User] SET [password] = ? WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newPassword1);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean checkEmailExists(String email) {
        String sql = "SELECT * FROM [User] WHERE email = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, email);
            return st.executeQuery().next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Users getUserByEmail(String email) {
        String sql = "SELECT * FROM [User] WHERE email = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Users user = new Users();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
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
                    return user; // Trả về đối tượng user nếu tìm thấy
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Print the stack trace to debug any issues
        }
        return null; // Nếu không tìm thấy người dùng
    }

    public boolean userExists(String email) {
        try {
            String sql = "SELECT * FROM [User] WHERE email = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0; // Trả về true nếu có ít nhất một bản ghi
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Print the stack trace to debug any issues
        }
        return false; // Trả về false nếu không có bản ghi nào
    }

    public void createUser(String full_name, String password, String email, String phone_number) {
        String sql = "INSERT INTO [User] ([full_name], [password], [email], [phone_number], [role]) "
                + "VALUES (?, ?, ?, ?, ?,?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, full_name);
            st.setString(2, password);
            st.setString(3, email);
            st.setString(4, phone_number);
            st.setString(5, "Customer");
            st.executeUpdate();
            System.out.println("User created successfully.");
        } catch (SQLException e) {
            System.out.println("Error inserting new user: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public boolean checkIfUserExists(String email) {
        UserDAO userDAO = new UserDAO();
        Users user = userDAO.getUserByEmail(email); // Lấy người dùng theo email
        return user != null; // Kiểm tra xem người dùng có tồn tại không
    }

    public void saveUserToDatabase(GoogleAccount googleAccount) {
        UserDAO userDAO = new UserDAO();

        // Lấy thông tin từ email của Google
        String email = googleAccount.getEmail();
        String username = email.substring(0, email.indexOf('@')); // Tên người dùng lấy từ email

        // Mật khẩu mặc định
        String defaultPassword = "111111111"; // 9 số 1

        // Lưu người dùng vào cơ sở dữ liệu
        userDAO.addUser(
                username, // Tên người dùng
                defaultPassword, // Mật khẩu mặc định
                googleAccount.getName(), // Tên đầy đủ
                email, // Email từ Google
                null, // Số điện thoại - không có sẵn từ Google API
                null, // Ngày sinh - không có sẵn từ Google API
                null // Địa chỉ - không có sẵn từ Google API
        );
    }

    public List<Users> getAllUsers() {
        List<Users> userList = new ArrayList<>();
        String sql = "SELECT * FROM [User]";
        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Users user = new Users();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
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
                user.setRole(rs.getString("role"));
                userList.add(user); // Thêm người dùng vào danh sách
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList; // Trả về danh sách người dùng
    }

    public void saveRentalUpgradeRequest(RentalUpgradeRequest request) throws SQLException {
        String sql = "INSERT INTO rental_upgrade_requests "
                + "(user_id, phone_number, address, reason, status, request_date) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            // In ra log để debug
            System.out.println("Saving rental request:");
            System.out.println("User ID: " + request.getUserId());
            System.out.println("Phone: " + request.getPhoneNumber());
            System.out.println("Address: " + request.getAddress());
            System.out.println("Reason: " + request.getReason());
            System.out.println("Status: " + request.getStatus());

            ps.setInt(1, request.getUserId());
            ps.setString(2, request.getPhoneNumber());
            ps.setString(3, request.getAddress());
            ps.setString(4, request.getReason());
            ps.setString(5, request.getStatus());
            ps.setTimestamp(6, new Timestamp(request.getRequestDate().getTime()));

            int result = ps.executeUpdate();
            System.out.println("Insert result: " + result + " row(s) affected");

            if (result == 0) {
                throw new SQLException("Failed to insert rental upgrade request");
            }
        } catch (SQLException e) {
            System.out.println("Error saving rental request: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    public void updateUserType(int userId, String newType) throws SQLException {
        String sql = "UPDATE [User] SET role = ? WHERE user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            System.out.println("Updating user " + userId + " to role: " + newType); // Log để debug
            ps.setString(1, newType);
            ps.setInt(2, userId);
            int rowsAffected = ps.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected); // Kiểm tra số rows bị ảnh hưởng
            if (rowsAffected == 0) {
                throw new SQLException("No user found with ID: " + userId);
            }
        } catch (SQLException e) {
            System.out.println("Error updating user type: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    // Pending access role rental
    public boolean hasPendingUpgradeRequest(int userId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM [dbo].[rental_upgrade_requests] "
                + "WHERE [user_id] = ? AND [status] = 'Pending'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    // Lấy danh sách tất cả các yêu cầu nâng cấp
    public List<RentalRequest> getAllRentalRequests() throws SQLException {
        List<RentalRequest> requests = new ArrayList<>();
        String sql = "SELECT r.*, u.full_name, u.email, u.phone_number, u.address "
                + "FROM [dbo].[rental_upgrade_requests] r "
                + "JOIN [dbo].[User] u ON r.user_id = u.user_id "
                + "ORDER BY r.request_date DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                RentalRequest request = new RentalRequest();
                request.setId(rs.getInt("request_id"));
                request.setUserId(rs.getInt("user_id"));
                request.setFullName(rs.getString("full_name"));
                request.setEmail(rs.getString("email"));
                request.setPhoneNumber(rs.getString("phone_number"));
                request.setAddress(rs.getString("address"));
                request.setReason(rs.getString("reason"));
                request.setRequestDate(rs.getTimestamp("request_date"));
                request.setStatus(rs.getString("status"));
                request.setProcessDate(rs.getTimestamp("processed_date"));
                request.setProcessedBy(rs.getInt("processed_by"));
                request.setRejectReason(rs.getString("admin_notes"));
                requests.add(request);
            }
        }
        return requests;
    }

// Phê duyệt yêu cầu nâng cấp
    public boolean approveRentalRequest(int requestId, int userId, int adminId) throws SQLException {
        connection.setAutoCommit(false);
        try {
            // Cập nhật trạng thái yêu cầu
            String updateRequestSql = "UPDATE [dbo].[rental_upgrade_requests] "
                    + "SET [status] = 'Approved', [processed_date] = GETDATE(), [processed_by] = ? "
                    + "WHERE [request_id] = ? AND [status] = 'Pending'";

            try (PreparedStatement ps = connection.prepareStatement(updateRequestSql)) {
                ps.setInt(1, adminId);
                ps.setInt(2, requestId);
                ps.executeUpdate();
            }

            String updateUserSql = "UPDATE [dbo].[User] "
                    + "SET [role] = 'rental' "
                    + "WHERE [user_id] = ?";

            try (PreparedStatement ps = connection.prepareStatement(updateUserSql)) {
                ps.setInt(1, userId);
                ps.executeUpdate();
            }

            connection.commit();
            return true;
        } catch (SQLException e) {
            connection.rollback();
            throw e;
        } finally {
            connection.setAutoCommit(true);
        }
    }

    public boolean rejectRentalRequest(int requestId, int adminId, String rejectReason) throws SQLException {
        String sql = "UPDATE [dbo].[rental_upgrade_requests] "
                + "SET [status] = 'Rejected', [processed_date] = GETDATE(), "
                + "[processed_by] = ?, [reject_reason] = ? "
                + "WHERE [request_id] = ? AND [status] = 'Pending'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, adminId);
            ps.setString(2, rejectReason);
            ps.setInt(3, requestId);

            int updatedRows = ps.executeUpdate();
            System.out.println("Affected rows: " + updatedRows);

            if (updatedRows == 0) {
                // Kiểm tra xem request có tồn tại không
                String checkSql = "SELECT [status] FROM [rental_upgrade_requests] WHERE [request_id] = ?";
                try (PreparedStatement checkPs = connection.prepareStatement(checkSql)) {
                    checkPs.setInt(1, requestId);
                    ResultSet rs = checkPs.executeQuery();
                    if (rs.next()) {
                        System.out.println("Request exists with status: " + rs.getString("status"));
                    } else {
                        System.out.println("Request not found");
                    }
                }
            }

            return updatedRows > 0;
        }
    }

// Lấy số liệu thống kê
    public Map<String, Integer> getRentalRequestStats() throws SQLException {
        Map<String, Integer> stats = new HashMap<>();

        String sql = "SELECT "
                + "SUM(CASE WHEN status = 'Pending' THEN 1 ELSE 0 END) as pending_count, "
                + "SUM(CASE WHEN status = 'Approved' THEN 1 ELSE 0 END) as approved_count, "
                + "SUM(CASE WHEN status = 'Rejected' THEN 1 ELSE 0 END) as rejected_count "
                + "FROM [dbo].[rental_upgrade_requests]";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                stats.put("pendingCount", rs.getInt("pending_count"));
                stats.put("approvedCount", rs.getInt("approved_count"));
                stats.put("rejectedCount", rs.getInt("rejected_count"));
            }
        }

        return stats;
    }

// Kiểm tra xem yêu cầu có tồn tại và đang ở trạng thái Pending không
    public boolean isRequestPending(int requestId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM [dbo].[rental_upgrade_requests] "
                + "WHERE [request_id] = ? AND [status] = 'Pending'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, requestId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    public boolean createRentalRequest(int userId, String phoneNumber, String address, String reason) throws SQLException {
    String sql = "INSERT INTO rental_requests (user_id, phone_number, address, reason, status, request_date) VALUES (?, ?, ?, ?, 'PENDING', GETDATE())";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, userId);
        ps.setString(2, phoneNumber);
        ps.setString(3, address);
        ps.setString(4, reason);
        return ps.executeUpdate() > 0;
    }
}
}
