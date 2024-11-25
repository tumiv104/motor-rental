/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;


import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import model.Motorbike;

public class EmailSender {
    public static void sendEmail(String to, String messageContent, String emailContent) {
        String from = "thang0941776861@gmail.com"; // Email của bạn
        String host = "smtp.gmail.com"; // SMTP server của bạn

        Properties properties = System.getProperties();
        properties.setProperty("mail.smtp.host", host);
        properties.setProperty("mail.smtp.port", "587"); // Port của SMTP server
        properties.setProperty("mail.smtp.auth", "true");
        properties.setProperty("mail.smtp.starttls.enable", "true");

        Session session = Session.getDefaultInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("thang0941776861@gmail.com", "thang15122003");
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject("OTP xác nhận của bạn");
            message.setText(messageContent);

            Transport.send(message);
            System.out.println("Gửi email thành công...");
        } catch (MessagingException mex) {
            mex.printStackTrace();
        }
    }
    
    public void sendInvoice(String email, String code, Timestamp createDate, HashMap<Integer, Motorbike> list, int days, BigDecimal discount, BigDecimal rental, BigDecimal deposit, BigDecimal cost) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); 
        props.put("mail.smtp.port", "587");  
        props.put("mail.smtp.auth", "true"); 
        props.put("mail.smtp.starttls.enable", "true");

        String username = "motorbikerentalserviceportal@gmail.com";
        String password = "aaor ezuq pfju afiv";

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("motorbikerentalserviceportal@gmail.com"));
            message.setRecipients(
                    Message.RecipientType.TO, InternetAddress.parse(email));
            try {
                message.setSubject(MimeUtility.encodeText("Xác nhận đơn hàng thuê xe", "UTF-8", "B"));
            } catch (UnsupportedEncodingException ex) {
                Logger.getLogger(EmailSender.class.getName()).log(Level.SEVERE, null, ex);
            }
            String htmlContent = "<h2>Xác nhận hóa đơn</h2>"
                    + "<p><strong>Đơn hàng:</strong>" + code + "</p>"
                    + "<p><strong>Thời gian:</strong>" + createDate + "</p>"
                    + "<h3>Xe đăng ký thuê</h3>"
                    + "<table>"
                    + "<tr>"
                    + "<th>Mẫu xe</th>"
                    + "<th>Giá thuê hàng ngày</th>"
                    + "</tr>";
            for (Map.Entry<Integer, Motorbike> entry : list.entrySet()) {
                htmlContent += "<tr>"
                        + "<td>" + entry.getValue().getModel() + "</td>"
                        + "<td>" + entry.getValue().getDailyRate() + "VNĐ</td>"
                        + "</tr>";
            }
            htmlContent += "</table>"
                    + "<p><strong>Số ngày thuê:</strong>" + days + "</p>"
                    + "<p><strong>Giảm giá:</strong>-" + discount + "VND</p>"
                    + "<p><strong>Tiền thuê:</strong>" + rental + "VND</p>"
                    + "<p><strong>Tiền cọc:</strong>" + deposit + "VND</p>"
                    + "<p><strong>Tổng tiền:</strong>" + cost + "VND</p>"
                    + "<p>Cảm ơn quý khách đã sử dụng dịch vụ thuê xe của chúng tôi. Nếu có bất kỳ câu hỏi nào, vui lòng liên hệ với chúng tôi qua email hoặc số điện thoại hỗ trợ.</p>";

            MimeBodyPart mimeBodyPart = new MimeBodyPart();
            mimeBodyPart.setContent(htmlContent, "text/html; charset=UTF-8");

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(mimeBodyPart);

            message.setContent(multipart);
            
            Transport.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
    
    public void sendEmailAlert(String email, String subject, String bodyhtml) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); 
        props.put("mail.smtp.port", "587");  
        props.put("mail.smtp.auth", "true"); 
        props.put("mail.smtp.starttls.enable", "true");

        String username = "motorbikerentalserviceportal@gmail.com";
        String password = "aaor ezuq pfju afiv";

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("motorbikerentalserviceportal@gmail.com"));
            message.setRecipients(
                    Message.RecipientType.TO, InternetAddress.parse(email));
            try {
                message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));
            } catch (UnsupportedEncodingException ex) {
                Logger.getLogger(EmailSender.class.getName()).log(Level.SEVERE, null, ex);
            }

            MimeBodyPart mimeBodyPart = new MimeBodyPart();
            mimeBodyPart.setContent(bodyhtml, "text/html; charset=UTF-8");

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(mimeBodyPart);

            message.setContent(multipart);
            
            Transport.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
