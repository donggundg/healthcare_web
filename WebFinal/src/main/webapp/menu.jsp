<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu</title>
    <link rel="stylesheet" href="menu.css">
    <script src="logout.js"></script>
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
    	<div class="welcome-message">
        <%
        //for browsing the database to the menu.jsp to get the last name of the user
            String userEmail = (String) session.getAttribute("userEmail");
            String lastName = "";

            if (userEmail != null) {
                
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/website_info?user=root&password=root");

                    PreparedStatement pst = conn.prepareStatement("SELECT lastName FROM website_info.users WHERE email = ?");
                    pst.setString(1, userEmail);

                    ResultSet rs = pst.executeQuery();
                    if(rs.next()) {
                        lastName = rs.getString("lastName");
                    }
                 
                
            }

            if (!lastName.isEmpty()) {
                out.println("<p>Welcome to Body Mate, " + lastName + "!</p>");
            }
            else{
            	out.println("<p>Siu</p]>");
            }
        %>
         </div>
        <div class="service-message">
            <p>We hope that this service will help you create a healthier body.<br>
            Please select a service that you want in the menu bar.</p>
        </div>
    </div>
</body>
</html>

