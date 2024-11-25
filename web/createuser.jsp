<%-- 
    Document   : createuser
    Created on : Sep 26, 2024, 12:19:55 AM
    Author     : hungv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Danh sách Người dùng</h1>

        <table border="1">
            <thead>
                <tr>
                    <th>Tên người dùng</th>
                    <th>Email</th>
                    <th>Họ tên</th>
                    <th>Số điện thoại</th>
                    <th>Ngày sinh</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Users> users = (List<Users>) request.getAttribute("users");
                    for (Users user : users) {
                %>
                <tr>
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getFull_name() %></td>
                    <td><%= user.getPhone_number() %></td>
                    <td><%= user.getDate_of_birth() %></td>
                    <td>
                        <form action="CRUDUserServlet" method="post">
                            <input type="hidden" name="username" value="<%= user.getUsername() %>"/>
                            <input type="submit" name="action" value="delete" onclick="return confirm('Bạn có chắc chắn muốn xóa không?');"/>
                        </form>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <h2>Thêm Người dùng mới</h2>
        <form action="CRUDUserServlet" method="post">
            <input type="hidden" name="action" value="add"/>
            Tên người dùng: <input type="text" name="username" required/><br/>
            Mật khẩu: <input type="password" name="password" required/><br/>
            Email: <input type="email" name="email" required/><br/>
            Họ tên: <input type="text" name="full_name" required/><br/>
            Số điện thoại: <input type="text" name="phone_number" required/><br/>
            Ngày sinh: <input type="date" name="date_of_birth" required/><br/>
            Loại người dùng: <input type="text" name="user_type" required/><br/>
            Hình đại diện: <input type="text" name="profile_picture"/><br/>
            Địa chỉ: <input type="text" name="address"/><br/>
            Vai trò: <input type="text" name="role" required/><br/>
            <input type="submit" value="Thêm"/>
        </form>
    </body>
</html>
