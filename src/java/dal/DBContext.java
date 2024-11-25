package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 */
public class DBContext {

    protected Connection connection;

    // Constructor thực hiện kết nối cơ sở dữ liệu
    public DBContext() {
        try {

            String user = "tunvh";
            String pass = "sa";
            String url = "jdbc:sqlserver://LAPTOP-T1Q2491Q\\SQLEXPRESS:1499;databaseName=Motorbike_v3;encript=true;trustservercertificate=true;";

            // Load driver và thiết lập kết nối
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
            System.out.println("Database connection established.");
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "Failed to connect to the database!", ex);
        }
    }

    // Getter cho đối tượng Connection
    public Connection getConnection() {
        return connection;
    }

    // Main method để kiểm tra kết nối
    public static void main(String[] args) {
        // Tạo một instance của DBContext và kiểm tra kết nối
        DBContext dbContext = new DBContext();
        if (dbContext.getConnection() != null) {
            System.out.println("Database connection successful!");
        } else {
            System.out.println("Failed to connect to the database.");
        }
    }
}
