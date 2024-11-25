package controller;

import dal.CartDAO;
import dal.UserDAO;
import model.GoogleAccount;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import logingoogle.LoginGoogle;

public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        if (code != null && !code.isEmpty()) {
            handleGoogleLogin(code, request, response);
            return;
        }
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        if (code != null && !code.isEmpty()) {
            handleGoogleLogin(code, request, response);
            return;
        }

        String username = request.getParameter("txtUsername");
        String password = request.getParameter("txtPassword");
        String remember = request.getParameter("remember");

        Cookie cookieU = new Cookie("cUser", username);
        Cookie cookieP = new Cookie("cPass", password);
        Cookie cookieR = new Cookie("cRem", remember);

        int maxAge = (remember != null) ? 60 * 60 * 24 : 0;
        cookieU.setMaxAge(maxAge);
        cookieP.setMaxAge(maxAge);
        cookieR.setMaxAge(maxAge);

        response.addCookie(cookieU);
        response.addCookie(cookieP);
        response.addCookie(cookieR);

        // Process standard login
        UserDAO u = new UserDAO();
        Users users = u.setDataUser(username, password);

        if (users != null) { 
            if (!users.isIsActive()) {              
                Date bannedUntil = users.getBannedUntil();
                String banMessage = bannedUntil != null
                        ? "Your account has been banned. Reason: " + users.getBannedReason()
                        + ". You will be unbanned on: " + bannedUntil.toString()
                        : "Your account has been banned. Reason: " + users.getBannedReason()
                        + ". Unban date is not available.";
                request.setAttribute("error", banMessage);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            HttpSession session = request.getSession();
            CartDAO cdb = new CartDAO();
            int quantity = cdb.getQuantity(users.getUserId());
            session.setAttribute("quantity", quantity);

            session.setAttribute("user", users);
            session.setAttribute("fullName", users.getFullName());
            session.setAttribute("user_id", u.setDataUid(username, password));
            String role = users.getRole(); // Get role from users object
            session.setAttribute("role", role);      
            response.sendRedirect("home?uid=" + session.getAttribute("user_id"));
        } else {
            // Handle failed login case
            request.setAttribute("error", "Username or Password incorrect!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void handleGoogleLogin(String code, HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        UserDAO userDAO = new UserDAO();
        HttpSession session = request.getSession();

        try {
           
            String accessToken = LoginGoogle.getToken(code);
            GoogleAccount googleAccount = LoginGoogle.getUserInfo(accessToken);
            Users user = userDAO.getUserByEmail(googleAccount.getEmail());
            if (user == null) {
                userDAO.saveUserToDatabase(googleAccount);
                user = userDAO.getUserByEmail(googleAccount.getEmail()); 
            }
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(60 * 60 * 24);
            response.sendRedirect(request.getContextPath() + "/home");
        } catch (Exception e) {
            e.printStackTrace();
            // Optionally, handle error during Google login
            request.setAttribute("error", "Google login failed, please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
