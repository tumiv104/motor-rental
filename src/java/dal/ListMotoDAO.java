package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Motorbike;
import model.MotorbikeType;
import java.sql.Statement;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Feedback;
import model.HotMotorbike;
import model.MotorbikeChange;
import model.Users;

public class ListMotoDAO extends DBContext {

    //list motor
    // Lấy danh sách xe máy phân trang
    public List<Motorbike> getMotorbikes(int page, int pageSize) throws SQLException {
        List<Motorbike> motorbikes = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        String sql = "SELECT * FROM Motorbike ORDER BY motorbike_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, offset);
            stmt.setInt(2, pageSize);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Motorbike motorbike = extractMotorbikeFromResultSet(rs);
                    motorbikes.add(motorbike);
                }
            }
        }
        return motorbikes;
    }

    public List<Motorbike> getAllMotorbikes() throws SQLException {
        List<Motorbike> motorbikes = new ArrayList<>();
        String sql = "SELECT * FROM motorbikes";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Motorbike motorbike = new Motorbike();
                motorbike.setMotorbikeId(rs.getInt("id"));
                motorbike.setModel(rs.getString("model"));
                motorbike.setBrand(rs.getString("brand"));
                motorbike.setDailyRate(rs.getDouble("dailyRate"));
                motorbike.setImageUrl(rs.getString("imageUrl"));
                // Thiết lập thêm các thuộc tính nếu cần

                motorbikes.add(motorbike);
            }
        }
        return motorbikes;
    }

    public List<HotMotorbike> getHotMotorbikes() {
        List<HotMotorbike> hotMotorbikes = new ArrayList<>();

        String sql = "SELECT TOP 6 m.motorbike_id, m.brand, m.model, m.color, m.daily_rate, m.image_url, "
                + "COUNT(bd.booking_id) AS booking_count "
                + "FROM Motorbike m "
                + "JOIN BookingDetail bd ON m.motorbike_id = bd.motorbike_id "
                + "GROUP BY m.motorbike_id, m.brand, m.model, m.color, m.daily_rate, m.image_url "
                + "ORDER BY booking_count DESC";

        System.out.println("Executing SQL: " + sql);  // In câu lệnh SQL để kiểm tra

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                HotMotorbike motorbike = new HotMotorbike();
                motorbike.setMotorbikeId(rs.getInt("motorbike_id"));
                motorbike.setBrand(rs.getString("brand"));
                motorbike.setModel(rs.getString("model"));
                motorbike.setColor(rs.getString("color"));
                motorbike.setDailyRate(rs.getDouble("daily_rate"));
                motorbike.setBookingCount(rs.getInt("booking_count"));
                motorbike.setImageUrl(rs.getString("image_url"));
                hotMotorbikes.add(motorbike);
            }

            System.out.println("Hot motorbikes: " + hotMotorbikes.size()); // Kiểm tra số lượng xe

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return hotMotorbikes;
    }

    public List<Motorbike> searchMotorbikes(String searchTerm, int page, int pageSize) throws SQLException {
        List<Motorbike> motorbikes = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM Motorbike WHERE "
                + "model LIKE ? OR brand LIKE ? OR "
                + "CONCAT(brand, ' ', model) LIKE ? "
                + "ORDER BY motorbike_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            String searchPattern = "%" + searchTerm.toLowerCase() + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            stmt.setInt(4, offset);
            stmt.setInt(5, pageSize);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Motorbike motorbike = extractMotorbikeFromResultSet(rs);
                    motorbikes.add(motorbike);
                }
            }
        }
        return motorbikes;
    }

    public int getTotalMotorbikes() throws SQLException {
        String sql = "SELECT COUNT(*) FROM Motorbike";
        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public int getTotalSearchResults(String searchTerm) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Motorbike WHERE "
                + "model LIKE ? OR brand LIKE ? OR "
                + "CONCAT(brand, ' ', model) LIKE ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            String searchPattern = "%" + searchTerm.toLowerCase() + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    private Motorbike extractMotorbikeFromResultSet(ResultSet rs) throws SQLException {
        Motorbike motorbike = new Motorbike();
        motorbike.setMotorbikeId(rs.getInt("motorbike_id"));
        motorbike.setModel(rs.getString("model"));
        motorbike.setBrand(rs.getString("brand"));
        motorbike.setYear(rs.getInt("year"));
        motorbike.setDailyRate(rs.getDouble("daily_rate"));
        motorbike.setStatus(rs.getString("status"));
        motorbike.setLicensePlate(rs.getString("license_plate"));
        motorbike.setColor(rs.getString("color"));
        motorbike.setFuelType(rs.getString("fuel_type"));
        motorbike.setImageUrl(rs.getString("image_url"));
        motorbike.setMileage(rs.getInt("mileage"));
        motorbike.setEngineSize(rs.getString("engine_size"));
        return motorbike;
    }

    public Motorbike getMotorbikeById(int motorbikeId) {
        Motorbike motorbike = null;
        String sql = "SELECT * FROM Motorbike WHERE motorbike_id = ?";
        try (PreparedStatement stmt = getConnection().prepareStatement(sql)) {
            stmt.setInt(1, motorbikeId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    motorbike = extractMotorbikeFromResultSet(rs);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ListMotoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return motorbike;
    }

    public List<Motorbike> getMotorbikesByPrice(int page, int pageSize, boolean ascending) throws SQLException {
        List<Motorbike> motorbikes = new ArrayList<>();
        String orderBy = ascending ? "ASC" : "DESC";
        String sql = "SELECT * FROM Motorbike ORDER BY daily_rate " + orderBy + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, (page - 1) * pageSize);
            stmt.setInt(2, pageSize);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Motorbike motorbike = extractMotorbikeFromResultSet(rs); // Sử dụng hàm đã có
                    motorbikes.add(motorbike);
                }
            }
        }
        return motorbikes;
    }

    public int getTotalMotorbikesByPrice(boolean ascending) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Motorbike"; // Giữ nguyên nếu không cần điều chỉnh
        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    //use to crud motorbike
    public boolean addMotorbike(Motorbike motorbike) throws SQLException {
        String status = (motorbike.getStatus() != null) ? motorbike.getStatus() : "available";
        String sql = "INSERT INTO Motorbike (model, brand, year, daily_rate, status, license_plate, type_id, color, engine_size, fuel_type, image_url, mileage) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, motorbike.getModel());
            stmt.setString(2, motorbike.getBrand());
            stmt.setInt(3, motorbike.getYear());
            stmt.setDouble(4, motorbike.getDailyRate());
            stmt.setString(5, status);
            stmt.setString(6, motorbike.getLicensePlate());

            if (motorbike.getTypeId() != null) {
                stmt.setInt(7, motorbike.getTypeId().getTypeId());
            } else {
                stmt.setNull(7, java.sql.Types.INTEGER);
            }

            stmt.setString(8, motorbike.getColor());
            stmt.setString(9, motorbike.getEngineSize());
            stmt.setString(10, motorbike.getFuelType());
            stmt.setString(11, motorbike.getImageUrl());
            stmt.setInt(12, motorbike.getMileage());

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }

    public boolean addPendingMotorbike(Motorbike motorbike) throws SQLException {
        String sql = "INSERT INTO PendingMotorbikes (model, brand, year, daily_rate, status, "
                + "license_plate, type_id, color, engine_size, fuel_type, image_url, mileage) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, motorbike.getModel());
            stmt.setString(2, motorbike.getBrand());
            stmt.setInt(3, motorbike.getYear());
            stmt.setDouble(4, motorbike.getDailyRate());
            stmt.setString(5, "Pending");
            stmt.setString(6, motorbike.getLicensePlate());
            stmt.setInt(7, motorbike.getTypeId().getTypeId());
            stmt.setString(8, motorbike.getColor());
            stmt.setString(9, motorbike.getEngineSize());
            stmt.setString(10, motorbike.getFuelType());
            stmt.setString(11, motorbike.getImageUrl());
            stmt.setInt(12, motorbike.getMileage());

            return stmt.executeUpdate() > 0;
        }
    }

    public void updateMotorbikeStatus(int motorbikeId, String status) throws SQLException {
        String sql = "UPDATE Motorbike SET status = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, motorbikeId);
            ps.executeUpdate();
        }
    }

    // Phương thức lấy danh sách xe chờ duyệt
    public List<Motorbike> getPendingMotorbikes() throws SQLException {
        List<Motorbike> pendingMotorbikes = new ArrayList<>();
        String sql = "SELECT p.*, t.type_name FROM PendingMotorbikes p LEFT JOIN MotorbikeType t ON p.type_id = t.type_id WHERE p.status = 'PENDING';";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Motorbike motorbike = new Motorbike();
                // Set all the motorbike properties
                motorbike.setId(rs.getInt("id"));
                motorbike.setModel(rs.getString("model"));
                motorbike.setBrand(rs.getString("brand"));
                motorbike.setYear(rs.getInt("year"));
                motorbike.setDailyRate(rs.getDouble("daily_rate"));
                motorbike.setLicensePlate(rs.getString("license_plate"));
                MotorbikeType mbt = new MotorbikeType();
                mbt.setTypeId(rs.getInt("type_id"));
                mbt.setTypeName(rs.getString("type_name"));
                motorbike.setTypeId(mbt);
                motorbike.setColor(rs.getString("color"));
                motorbike.setEngineSize(rs.getString("engine_size"));
                motorbike.setFuelType(rs.getString("fuel_type"));
                motorbike.setMileage(rs.getInt("mileage"));
                motorbike.setStatus(rs.getString("status"));

                pendingMotorbikes.add(motorbike);
            }
        }
        return pendingMotorbikes;
    }

    // Phương thức phê duyệt xe
    public boolean approveMotorbike(int pendingId) throws SQLException {
        connection.setAutoCommit(false);
        try {
            // First get the pending motorbike data
            String selectSql = "SELECT * FROM PendingMotorbikes WHERE id = ?";
            try (PreparedStatement selectStmt = connection.prepareStatement(selectSql)) {
                selectStmt.setInt(1, pendingId);
                try (ResultSet rs = selectStmt.executeQuery()) {
                    if (rs.next()) {
                        // Create new motorbike in Motorbike table
                        String insertSql = "INSERT INTO Motorbike (model, brand, year, daily_rate, status, "
                                + "license_plate, type_id, color, engine_size, fuel_type, image_url, mileage) "
                                + "VALUES (?, ?, ?, ?, 'Available', ?, ?, ?, ?, ?, ?, ?)";
                        try (PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {
                            insertStmt.setString(1, rs.getString("model"));
                            insertStmt.setString(2, rs.getString("brand"));
                            insertStmt.setInt(3, rs.getInt("year"));
                            insertStmt.setDouble(4, rs.getDouble("daily_rate"));
                            insertStmt.setString(5, rs.getString("license_plate"));
                            insertStmt.setInt(6, rs.getInt("type_id"));
                            insertStmt.setString(7, rs.getString("color"));
                            insertStmt.setString(8, rs.getString("engine_size"));
                            insertStmt.setString(9, rs.getString("fuel_type"));
                            insertStmt.setString(10, rs.getString("image_url"));
                            insertStmt.setInt(11, rs.getInt("mileage"));
                            insertStmt.executeUpdate();
                        }

                        // Update status in PendingMotorbikes
                        String updateSql = "UPDATE PendingMotorbikes SET status = 'APPROVED' WHERE id = ?";
                        try (PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {
                            updateStmt.setInt(1, pendingId);
                            updateStmt.executeUpdate();
                        }
                    }
                }
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

    // Phương thức từ chối xe
    public boolean rejectMotorbike(int pendingId) throws SQLException {
        String sql = "UPDATE PendingMotorbikes SET status = 'REJECTED' WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, pendingId);
            return stmt.executeUpdate() > 0;
        }
    }

    public void updateMotorbike(Motorbike motorbike) throws SQLException {
        if (!isValidTypeId(motorbike.getTypeId().getTypeId())) {
            throw new SQLException("Invalid type_id: " + motorbike.getTypeId());
        }

        String sql = "UPDATE Motorbike SET model=?, brand=?, year=?, daily_rate=?, status=?, license_plate=?, type_id=?, mileage=?, color=?, engine_size=?, fuel_type=?, image_url=? WHERE motorbike_id=?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, motorbike.getModel());
            stmt.setString(2, motorbike.getBrand());
            stmt.setInt(3, motorbike.getYear());
            stmt.setDouble(4, motorbike.getDailyRate());
            stmt.setString(5, motorbike.getStatus());
            stmt.setString(6, motorbike.getLicensePlate());
            stmt.setInt(7, motorbike.getTypeId().getTypeId());
            stmt.setInt(8, motorbike.getMileage());
            stmt.setString(9, motorbike.getColor());
            stmt.setString(10, motorbike.getEngineSize());
            stmt.setString(11, motorbike.getFuelType());
            stmt.setString(12, motorbike.getImageUrl());
            stmt.setInt(13, motorbike.getMotorbikeId());
            stmt.executeUpdate();
        }
    }

    public int getTypeIdFromTypeName(String typeName) throws SQLException {
        String sql = "SELECT type_id FROM MotorbikeType WHERE type_name = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, typeName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("type_id");
            }
        }
        return 0; // Trả về 0 nếu không tìm thấy
    }

    public boolean isValidTypeId(int typeId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM MotorbikeType WHERE type_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, typeId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    public boolean deleteMotorbike(int motorbikeId) throws SQLException {
        String sql = "DELETE FROM Motorbike WHERE motorbike_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, motorbikeId);

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }

    public List<MotorbikeType> getMotorbikeTypes() throws SQLException {
        List<MotorbikeType> types = new ArrayList<>();
        String sql = "SELECT * FROM MotorbikeType";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                MotorbikeType type = new MotorbikeType();
                type.setTypeId(rs.getInt("type_id"));
                type.setTypeName(rs.getString("type_name"));
                type.setDescription(rs.getString("description"));
                types.add(type);
            }
        }
        return types;
    }

    public int getTypeIdByMotorbikeId(int motorbikeId) throws SQLException {
        int typeId = -1; // Giá trị mặc định nếu không tìm thấy
        String sql = "SELECT type_id FROM Motorbike WHERE motorbike_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, motorbikeId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    typeId = rs.getInt("type_id");
                }
            }
        }
        return typeId;
    }

    public <T> ArrayList<T> getDistinctField(String field, Class<T> type) {
        ArrayList<T> fields = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT DISTINCT " + field + " FROM Motorbike WHERE status = 'Available'";

            stm = connection.prepareStatement(sql);
            //stm.setString(1, field);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                fields.add(rs.getObject(field, type));
            }

        } catch (SQLException ex) {
            Logger.getLogger(ListMotoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return fields;
    }

    public ArrayList<MotorbikeType> getDistinctType() {
        ArrayList<MotorbikeType> fields = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT DISTINCT m.type_id, mt.type_name FROM Motorbike m\n"
                    + "JOIN MotorbikeType mt ON m.type_id = mt.type_id\n"
                    + "WHERE status = 'Available'";

            stm = connection.prepareStatement(sql);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                MotorbikeType mt = new MotorbikeType();
                mt.setTypeId(rs.getInt("type_id"));
                mt.setTypeName(rs.getString("type_name"));
                fields.add(mt);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ListMotoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return fields;
    }

    public int getFilterQuantity(String brand, int year, double daily_rate, int type_id,
            String color, String engine_size, String fuel_type) {
        PreparedStatement stm = null;
        try {
            int i = 0;
            String sql = "SELECT COUNT(*) FROM Motorbike\n"
                    + "WHERE status = 'Available' AND 1=1 \n";
            if (brand != null && !"".equals(brand)) {
                sql += "AND brand = ?";
            }
            if (year != -1) {
                sql += "AND year = ?";
            }
            if (daily_rate != -1) {
                sql += "AND daily_rate = ?";
            }
            if (type_id != -1) {
                sql += "AND type_id = ?";
            }
            if (color != null && !"".equals(color)) {
                sql += "AND color = ?";
            }
            if (engine_size != null && !"".equals(engine_size)) {
                sql += "AND engine_size = ?";
            }
            if (fuel_type != null && !"".equals(fuel_type)) {
                sql += "AND fuel_type = ?";
            }
            stm = connection.prepareStatement(sql);
            if (brand != null && !"".equals(brand)) {
                ++i;
                stm.setString(i, brand);
            }
            if (year != -1) {
                ++i;
                stm.setInt(i, year);
            }
            if (daily_rate != -1) {
                ++i;
                stm.setDouble(i, daily_rate);
            }
            if (type_id != -1) {
                ++i;
                stm.setInt(i, type_id);
            }
            if (color != null && !"".equals(color)) {
                ++i;
                stm.setString(i, color);
            }
            if (engine_size != null && !"".equals(engine_size)) {
                ++i;
                stm.setString(i, engine_size);
            }
            if (fuel_type != null && !"".equals(fuel_type)) {
                ++i;
                stm.setString(i, fuel_type);
            }
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ListMotoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public ArrayList<Motorbike> filterMotorbikesByPaging(int page, int pageSize, String brand, int year,
            double daily_rate, int type_id, String color, String engine_size, String fuel_type) {
        ArrayList<Motorbike> motorbikes = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            int i = 0;
            String sql = "SELECT motorbike_id, model, brand, year, daily_rate, status, license_plate, \n"
                    + "type_id, mileage, color, engine_size, fuel_type, image_url FROM Motorbike\n"
                    + "WHERE status = 'Available' AND 1=1 \n";
            if (brand != null && !"".equals(brand)) {
                sql += "AND brand = ?";
            }
            if (year != -1) {
                sql += "AND year = ?";
            }
            if (daily_rate != -1) {
                sql += "AND daily_rate = ?";
            }
            if (type_id != -1) {
                sql += "AND type_id = ?";
            }
            if (color != null && !"".equals(color)) {
                sql += "AND color = ?";
            }
            if (engine_size != null && !"".equals(engine_size)) {
                sql += "AND engine_size = ?";
            }
            if (fuel_type != null && !"".equals(fuel_type)) {
                sql += "AND fuel_type = ?";
            }
            sql += " Order by motorbike_id\n"
                    + "offset (?-1)*? row fetch next ? rows only";
            stm = connection.prepareStatement(sql);
            if (brand != null && !"".equals(brand)) {
                ++i;
                stm.setString(i, brand);
            }
            if (year != -1) {
                ++i;
                stm.setInt(i, year);
            }
            if (daily_rate != -1) {
                ++i;
                stm.setDouble(i, daily_rate);
            }
            if (type_id != -1) {
                ++i;
                stm.setInt(i, type_id);
            }
            if (color != null && !"".equals(color)) {
                ++i;
                stm.setString(i, color);
            }
            if (engine_size != null && !"".equals(engine_size)) {
                ++i;
                stm.setString(i, engine_size);
            }
            if (fuel_type != null && !"".equals(fuel_type)) {
                ++i;
                stm.setString(i, fuel_type);
            }
            stm.setInt(++i, page);
            stm.setInt(++i, pageSize);
            stm.setInt(++i, pageSize);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Motorbike motorbike = new Motorbike();
                motorbike.setMotorbikeId(rs.getInt("motorbike_id"));
                motorbike.setModel(rs.getString("model"));
                motorbike.setBrand(rs.getString("brand"));
                motorbike.setYear(rs.getInt("year"));
                motorbike.setDailyRate(rs.getDouble("daily_rate"));
                motorbike.setStatus(rs.getString("status"));
                motorbike.setLicensePlate(rs.getString("license_plate"));
                MotorbikeType mType = new MotorbikeType();
                mType.setTypeId(rs.getInt("type_id"));
                motorbike.setTypeId(mType);
                motorbike.setMileage(rs.getInt("mileage"));
                motorbike.setColor(rs.getString("color"));
                motorbike.setEngineSize(rs.getString("engine_size"));
                motorbike.setFuelType(rs.getString("fuel_type"));
                motorbike.setImageUrl(rs.getString("image_url"));

                motorbikes.add(motorbike);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ListMotoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return motorbikes;
    }

    public int insertMotorbikeChange(int bid, int mid, String descriptoin, String role) {
        PreparedStatement stm = null;
        PreparedStatement stm1 = null;
        try {
            String sql1 = "INSERT INTO [dbo].[MotorbikeChange]\n"
                    + "           ([booking_id]\n"
                    + "           ,[motorbike_id]\n"
                    + "           ,[description]\n"
                    + "           ,[role])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?)";
            String sql2 = "SELECT @@IDENTITY as LastID";
            stm = connection.prepareStatement(sql1);
            stm1 = connection.prepareStatement(sql2);
            stm.setInt(1, bid);
            stm.setInt(2, mid);
            stm.setString(3, descriptoin);
            stm.setString(4, role);
            stm.executeUpdate();
            ResultSet rs = stm1.executeQuery();
            while (rs.next()) {
                return rs.getInt("LastID");
            }

        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public void insertChangeImage(int cid, String url) {
        PreparedStatement stm = null;
        try {
            String sql = "INSERT INTO [dbo].[MotorbikeChangeImage]\n"
                    + "           ([change_id]\n"
                    + "           ,[imageUrl])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?)";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, cid);
            stm.setString(2, url);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<MotorbikeChange> getMotorbikeChange(int bid) {
        HashMap<MotorbikeChange, ArrayList<String>> changes = new HashMap<>();
        ArrayList<MotorbikeChange> list = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT m.change_id, booking_id, motorbike_id, description, role, imageUrl \n"
                    + "FROM MotorbikeChange m JOIN MotorbikeChangeImage mi ON m.change_id = mi.change_id\n"
                    + "WHERE booking_id = ?";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, bid);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                MotorbikeChange mc = new MotorbikeChange();
                mc.setChangeId(rs.getInt("change_id"));
                mc.setBookingId(rs.getInt("booking_id"));
                mc.setMotorbikeId(rs.getInt("motorbike_id"));
                mc.setDescription(rs.getString("description"));
                mc.setRole(rs.getString("role"));
                if (!changes.containsKey(mc)) {
                    changes.put(mc, new ArrayList<>());
                }
                changes.get(mc).add(rs.getString("imageUrl"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ListMotoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        for (MotorbikeChange entry : changes.keySet()) {
            entry.setImages(changes.get(entry));
            list.add(entry);
        }
        return list;
    }

    public List<Feedback> getFeedbackByMotorbikeId(int motorbikeId) {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT fb.* FROM FeedbackBooking fb "
                + "JOIN BookingDetail bd ON fb.booking_id = bd.booking_id "
                + "WHERE bd.motorbike_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, motorbikeId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackId(rs.getInt("feedback_id"));
                feedback.setBookingId(rs.getInt("booking_id"));
                feedback.setComment(rs.getString("comment"));
                feedback.setRating(rs.getInt("rating"));
                feedback.setFeedbackDate(rs.getDate("feedback_date"));
                // Set other feedback fields as needed
                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbackList;
    }
}
