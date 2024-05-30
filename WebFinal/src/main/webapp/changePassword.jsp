<%@ page import="java.sql.*" %>
<%@ page contentType="text/plain; charset=UTF-8" language="java" session="true" %>

<%
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmNewPassword = request.getParameter("confirmNewPassword");
    String userEmail = (String) session.getAttribute("userEmail");

    // Ensure all fields are provided
    if (userEmail == null || currentPassword == null || newPassword == null || confirmNewPassword == null) {
        out.print("All fields are required.");
        return;
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/website_info?user=root&password=root");

        // Verify current password
        PreparedStatement pst = conn.prepareStatement("SELECT * FROM website_info.users WHERE email = ? AND password = ?");
        pst.setString(1, userEmail);
        pst.setString(2, currentPassword);
        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            if (!newPassword.equals(confirmNewPassword)) {
                out.print("New password and confirm password should be same!");
            } else if (newPassword.equals(currentPassword)) {
                out.print("New password should not match current password!");
            } else {
                // Update the password
                pst = conn.prepareStatement("UPDATE website_info.users SET password = ? WHERE email = ?");
                pst.setString(1, newPassword);
                pst.setString(2, userEmail);
                int updated = pst.executeUpdate();

                if (updated > 0) {
                    out.print("Successfully changed!");
                } else {
                    out.print("Password change failed.");
                }
            }
        } else {
            out.print("Current Password doesn't match!");
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.print("Error: " + e.getMessage());
    }
%>
