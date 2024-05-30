<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calorie Table</title>
    <link rel="stylesheet" href="calorieTable.css">
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
                <li class="logout-right"><a href="#" onclick="logoutUser()">Logout</a></li>
            </ul>
        </nav>

        <h2>Calorie Table</h2>

          <%
        String userEmail = (String) session.getAttribute("userEmail");
        if (userEmail != null) {
            try {
            	//data base connecting
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/website_info", "root", "root");

                //query for user id
                PreparedStatement pst = conn.prepareStatement("SELECT idusers FROM website_info.users WHERE email = ?");
                pst.setString(1, userEmail);
                ResultSet rs = pst.executeQuery();
                if(rs.next()) {
                    int userId = rs.getInt("idusers");
					
                    //query for user calorie record
                    String query = "SELECT * FROM website_info.daily_calorie_records WHERE userId = ? ORDER BY recordDate DESC";
                    pst = conn.prepareStatement(query);
                    pst.setInt(1, userId);
                    rs = pst.executeQuery();
					
                    //printing out the calorie table
                    out.println("<table border='1'><tr><th>Date</th><th>Consumed Calories</th><th>Burned Calories</th><th>Net Calories</th></tr>");
                    while(rs.next()) {
                        int netCalories = rs.getInt("consumedCalories") - rs.getInt("burnedCalories");
                        out.println("<tr><td>" + rs.getDate("recordDate") + "</td><td>" + rs.getInt("consumedCalories") + "</td><td>" + rs.getInt("burnedCalories") + "</td><td>" + netCalories + "</td></tr>");
                    }
                    out.println("</table>");
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
</body>
</html>