/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.District;
import model.Province;
import model.Ward;

/**
 *
 * @author Nitro
 */
public class AddressDAO extends DBContext {

    public ArrayList<Province> getAllProvince() {
        ArrayList<Province> provinces = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT Id, Name FROM Province";

            stm = connection.prepareStatement(sql);
            //stm.setInt(1, id);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Province p = new Province();
                p.setId(rs.getInt("Id"));
                p.setName(rs.getString("Name"));
                provinces.add(p);
            }

        } catch (SQLException ex) {
            Logger.getLogger(AddressDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return provinces;
    }

    public ArrayList<District> getDistrictByProvince(int pid) {
        ArrayList<District> districts = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT Id, Name FROM District\n"
                    + "WHERE ProvinceId = ?";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, pid);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                District d = new District();
                d.setId(rs.getInt("Id"));
                d.setName(rs.getString("Name"));
                districts.add(d);
            }

        } catch (SQLException ex) {
            Logger.getLogger(AddressDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return districts;
    }

    public ArrayList<Ward> getWardByDistrict(int did) {
        ArrayList<Ward> wards = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT Id, Name FROM Ward\n"
                    + "WHERE DistrictId = ?";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, did);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Ward w = new Ward();
                w.setId(rs.getInt("Id"));
                w.setName(rs.getString("Name"));
                wards.add(w);
            }

        } catch (SQLException ex) {
            Logger.getLogger(AddressDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return wards;
    }

    public String getAddress(int pid, int did, int wid) {
        String address = "";
        PreparedStatement stm = null;
        try {
            String sql = "SELECT p.Name as province_name, d.Name as district_name, w.Name as ward_name \n"
                    + "FROM Province p\n"
                    + "JOIN District d ON p.Id = d.ProvinceId\n"
                    + "JOIN Ward w ON d.Id =  w.DistrictId\n"
                    + "WHERE p.Id = ? AND d.Id = ? AND w.Id = ?";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, pid);
            stm.setInt(2, did);
            stm.setInt(3, wid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                address += rs.getString("ward_name") + " - " + rs.getString("district_name") + " - " + rs.getString("province_name");
            }

        } catch (SQLException ex) {
            Logger.getLogger(AddressDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return address;
    }
}
