<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Account</title>
    <link rel="stylesheet" href="myaccount.css">
    <script src="myaccount.js"></script>
</head>
<body>
    <div class="container">
          <nav class="menu-bar">
           <ul>
                <li><a href="calorieCalculator.jsp">Diet Log</a></li>
                <li><a href="exerciseLog.jsp">Exercise Log</a></li>
                <li><a href="tips.jsp">Health Tips</a></li>
                <li><a href="forum.jsp">Community Forum</a></li>
                <li><a href="calorieTable.jsp">Calorie Table</a></li>
                <li><a href="myaccount.jsp">My Account</a></li>
                <li class = "logout-right"><a href="#" onclick="logoutUser()">Logout</a></li>
            </ul>
        </nav>

        <h2>My Account</h2>
        <div class="account-sections">
            <div class="account-info">
                <h3>Account Information</h3>
               <%
                String userEmail = (String) session.getAttribute("userEmail");
                if (userEmail != null) {
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/website_info?user=root&password=root");
                        PreparedStatement pst = conn.prepareStatement("SELECT * FROM website_info.users WHERE email = ?");
                        pst.setString(1, userEmail);
                        ResultSet rs = pst.executeQuery();
                        if(rs.next()) {
                            // Display user information
                            out.println("<p>Email: " + rs.getString("email") + "</p>");
                            out.println("<p>Name: " + rs.getString("firstName")+" " + rs.getString("lastName") + "</p>");
                            out.println("<p>Gender: "+rs.getString("gender")+"</p>");
                           
                        } else {
                            out.println("<p>User not found</p>");
                        }
                        conn.close();
                    } catch(Exception e) {
                        e.printStackTrace();
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    }
                } else {
                    out.println("<p>Please login to view this page.</p>");
                }

                
                %>
            </div>

            <div class="password-change">
                <h3>Change Password</h3>
                <form method="post" action="myaccount.jsp">
                    <input type="password" name="currentPassword" placeholder="Current Password" required>
                    <input type="password" name="newPassword" placeholder="New Password" required>
                    <input type="password" name="confirmNewPassword" placeholder="Confirm New Password" required>
                    <button type="submit" class="btn">Change Password</button>
                </form>
            </div>
        </div>
        </div> 
			  <%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        

        // Basic validation to ensure data is received
        if (userEmail == null || currentPassword == null || newPassword == null) {
            response.getWriter().write("All fields are required.");
        } else {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/website_info?user=root&password=root");
            PreparedStatement pst = conn.prepareStatement("SELECT password FROM website_info.users WHERE email = ?");
            pst.setString(1, userEmail);
            ResultSet rs = pst.executeQuery();

            if(rs.next() && rs.getString("password").equals(currentPassword)) {
                pst = conn.prepareStatement("UPDATE website_info.users SET password = ? WHERE email = ?");
                pst.setString(1, newPassword);
                pst.setString(2, userEmail);
                int updateCount = pst.executeUpdate();
                //logic to validate the password.
                if (updateCount > 0) {
                    response.getWriter().write("Password changed successfully.");
                } else {
                    response.getWriter().write("Failed to change password.");
                }
            } else {
                response.getWriter().write("Current password is incorrect.");
            }
            conn.close();
        }
    }
    %>
    
</body>
</html>
