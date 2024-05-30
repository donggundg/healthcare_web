<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Health Tips</title>
<link rel="stylesheet" href="tips.css">
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
<div class="health-tips-container">
    <h2>Health Tips</h2>
    <ul>
        <li>
            <h3>Regular Exercise</h3>
            <p>Engage in at least 150 minutes of moderate-intensity or 75 minutes of vigorous-intensity physical activity per week.<br>
             Include strength training exercises 2 or more days a week.</p>
        </li>
        <li>
            <h3>Balanced Diet</h3>
            <p>Consume a variety of foods in the right amount. Prioritize fruits, vegetables, whole grains, protein foods, and healthy fats.</p>
        </li>
        <li>
            <h3>Stay Hydrated</h3>
            <p>Drink at least 8 cups of water daily. Increase intake during physical activity and hot weather.</p>
        </li>
        <li>
            <h3>Regular Health Check-ups</h3>
            <p>Regular health check-ups help in recognizing health status and early detection of any abnormalities.</p>
        </li>
        <li>
            <h3>Manage Stress</h3>
            <p>Stress can lead to various health problems. Manage stress through proper rest, exercise, meditation, etc.</p>
        </li>
        <li>
            <h3>Avoid Smoking and Limit Alcohol</h3>
            <p>Smoking can cause various diseases, and excessive alcohol is also harmful to health.</p>
        </li>
        <li>
            <h3>Get Enough Sleep</h3>
            <p>Adequate sleep is essential for physical and mental health. Most adults need 7-9 hours of sleep per day.</p>
        </li>
        <li>
        	<h3>Customized Tips</h3>
        	<%
    String userEmail = (String) session.getAttribute("userEmail");

    if (userEmail != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/website_info?user=root&password=root");

            // Get user ID from the database
            PreparedStatement pst = conn.prepareStatement("SELECT idusers FROM website_info.users WHERE email = ?");
            pst.setString(1, userEmail);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                int userId = rs.getInt("idusers");

                // bring up the current date data base
                java.sql.Date today = new java.sql.Date(new java.util.Date().getTime());
                pst = conn.prepareStatement("SELECT benchpress, running, squat, armcurl FROM website_info.exercise WHERE idusers = ? AND recordDate = ?");
                pst.setInt(1, userId);
                pst.setDate(2, today);
                rs = pst.executeQuery();

                if (rs.next()) {
                    int benchpress = rs.getInt("benchpress");
                    int running = rs.getInt("running");
                    int squat = rs.getInt("squat");
                    int armcurl = rs.getInt("armcurl");

                    // give you personilzed tips
                    if (benchpress < 12) {
                        out.println("<p>Average bench press is 12 sets. Try to do more!</p>");
                    }
                    if (running < 30) {
                        out.println("<p>Average running time is 30 minutes per day. Try to run longer!</p>");
                    }
                    if (squat < 12) {
                        out.println("<p>Average squat is 12 sets. Try to do more!</p>");
                    }
                    if (armcurl < 12) {
                        out.println("<p>Average armcurl is 12 sets. Try to do more!</p>");
                    }
                    if(benchpress >= 12 && running >= 30 && squat >= 12 && armcurl >= armcurl){
                    	out.println("<p>You are doing great!</p>");
                    }
                } else {
                    out.println("<p>No exercise records found for today.</p>");
                }
                
            } else {
                out.println("<p>User not found. Please log in.</p>");
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p>Please log in to view personalized tips.</p>");
    }
%>
        </li>
    </ul>
</div>
 
    
</div>

</body>
</html>