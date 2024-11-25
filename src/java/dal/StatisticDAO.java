/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author hungv
 */
public class StatisticDAO extends DBContext {

    //này get số lượng booking
    public int getTotalBookings() throws SQLException {
        String query = "SELECT COUNT(*) AS totalBookings FROM Booking";
        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("totalBookings");
            }
        }
        return 0;
    }

    //sẽ tính toonger số tiền thanh toán từ table payment
    public Map<String, BigDecimal> getTotalRevenue() throws SQLException {
        String query = "SELECT payment_status, SUM(total_amount) AS total_payment "
                + "FROM dbo.Payment "
                + "GROUP BY payment_status "
                + "ORDER BY total_payment DESC";
        Map<String, BigDecimal> revenueData = new HashMap<>();

        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                String paymentStatus = rs.getString("payment_status");
                BigDecimal totalPayment = rs.getBigDecimal("total_payment"); // đổi sang BigDecimal
                revenueData.put(paymentStatus, totalPayment);
            }
        }

        return revenueData;
    }

    // trung bình điểm đánh giá của user
    public double getAverageRating() throws SQLException {
        String query = "SELECT SUM(total_reviews) AS totalRating FROM BookingReviewStats";
        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble("totalRating");
            }
        }
        return 0.0;
    }

    //thống kế các phụ phí 
    public double getTotalAdditionalFees() throws SQLException {
        String query = "SELECT SUM(amount) AS totalAmount FROM AdditionFee";
        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble("totalAmount");
            }
        }
        return 0.0;
    }

    //kiểu như quản lý tần xuất thanh toán
    public int getTotalPayments() throws SQLException {
        String query = "SELECT COUNT(*) AS totalPayments FROM Payment";
        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("totalPayments");
            }
        }
        return 0;
    }

    // Thống kê theo ngày
    public Map<String, Double> getRevenueByDay() throws SQLException {
        String query = "SELECT CONVERT(varchar, period_start, 23) as day_date, "
                + "SUM(total_revenue) AS total_revenue "
                + "FROM RevenueStats "
                + "WHERE period_type = 'daily' "
                + "GROUP BY CONVERT(varchar, period_start, 23) "
                + "ORDER BY CONVERT(varchar, period_start, 23)";

        Map<String, Double> result = new HashMap<>();
        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                String day = rs.getString("day_date");
                double revenue = rs.getDouble("total_revenue");
                result.put(day, revenue);
            }
        }
        return result;
    }

// Thống kê theo tuần
    public Map<String, Double> getRevenueByWeek() throws SQLException {
        String query = "SELECT "
                + "CONCAT(DATEPART(YEAR, period_start), '-W', DATEPART(WEEK, period_start)) AS week_range, "
                + "SUM(total_revenue) AS total_revenue "
                + "FROM RevenueStats "
                + "WHERE period_type = 'weekly' "
                + "GROUP BY DATEPART(YEAR, period_start), DATEPART(WEEK, period_start) "
                + "ORDER BY DATEPART(YEAR, period_start), DATEPART(WEEK, period_start)";

        Map<String, Double> result = new HashMap<>();
        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                String weekRange = rs.getString("week_range");
                double revenue = rs.getDouble("total_revenue");
                result.put(weekRange, revenue);
            }
        }
        return result;
    }

// Thống kê theo tháng
    public Map<String, Double> getRevenueByMonth() throws SQLException {
        String query = "SELECT "
                + "CONCAT(YEAR(period_start), '-', FORMAT(MONTH(period_start), '00')) AS month_date, "
                + "SUM(total_revenue) AS total_revenue "
                + "FROM RevenueStats "
                + "WHERE period_type = 'monthly' "
                + "GROUP BY YEAR(period_start), MONTH(period_start) "
                + "ORDER BY YEAR(period_start), MONTH(period_start)";

        Map<String, Double> result = new HashMap<>();
        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                String month = rs.getString("month_date");
                double revenue = rs.getDouble("total_revenue");
                result.put(month, revenue);
            }
        }
        return result;
    }

// Thống kê theo năm
    public Map<String, Double> getRevenueByYear() throws SQLException {
        String query = "SELECT "
                + "CAST(YEAR(period_start) AS VARCHAR) as year, "
                + "SUM(total_revenue) AS total_revenue "
                + "FROM RevenueStats "
                + "WHERE period_type = 'yearly' "
                + "GROUP BY YEAR(period_start) "
                + "ORDER BY YEAR(period_start)";

        Map<String, Double> result = new HashMap<>();
        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                String year = rs.getString("year");
                double revenue = rs.getDouble("total_revenue");
                result.put(year, revenue);
            }
        }
        return result;
    }

    public List<Object[]> getMotorbikeStatisticsByType() throws SQLException {
        List<Object[]> statistics = new ArrayList<>();
        String sql = """
        SELECT 
            mt.type_name,
            COUNT(m.motorbike_id) AS total_bikes,
            AVG(m.daily_rate) AS avg_rate
        FROM Motorbike m
        JOIN MotorbikeType mt ON m.type_id = mt.type_id
        GROUP BY mt.type_name
        ORDER BY total_bikes DESC;
    """;
        System.out.println("Executing SQL: " + sql);

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Object[] stat = new Object[3];
                stat[0] = rs.getString("type_name");
                stat[1] = rs.getInt("total_bikes");
                stat[2] = rs.getDouble("avg_rate");
                statistics.add(stat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return statistics;
    }

}
