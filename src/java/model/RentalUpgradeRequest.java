/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author hungv
 */
public class RentalUpgradeRequest {
    private int requestId;
    private int userId;
    private String phoneNumber;  // Đổi tên từ phone sang phoneNumber
    private String address;
    private String reason;
    private String status;
    private Date requestDate;
    private Date processedDate;
    private int processedBy;
    private String adminNotes;

    public RentalUpgradeRequest() {
    }

    public RentalUpgradeRequest(int requestId, int userId, String phoneNumber, String address, String reason, String status, Date requestDate, Date processedDate, int processedBy, String adminNotes) {
        this.requestId = requestId;
        this.userId = userId;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.reason = reason;
        this.status = status;
        this.requestDate = requestDate;
        this.processedDate = processedDate;
        this.processedBy = processedBy;
        this.adminNotes = adminNotes;
    }

    public int getRequestId() {
        return requestId;
    }

    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(Date requestDate) {
        this.requestDate = requestDate;
    }

    public Date getProcessedDate() {
        return processedDate;
    }

    public void setProcessedDate(Date processedDate) {
        this.processedDate = processedDate;
    }

    public int getProcessedBy() {
        return processedBy;
    }

    public void setProcessedBy(int processedBy) {
        this.processedBy = processedBy;
    }

    public String getAdminNotes() {
        return adminNotes;
    }

    public void setAdminNotes(String adminNotes) {
        this.adminNotes = adminNotes;
    }
    
    
}
