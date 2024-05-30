<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exercise Log</title>
    <link rel="stylesheet" href="exerciseLog.css">
    <script src="exerciseLog.js"></script>
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
    	<h2>Exercise Log</h2>
    	<h3>Record your daily exercise activities!</h3>
        <form method="post">
        <table class="exercise-table-desktop">
            <tr>
                <td><img src="image/2548440.png" alt="Benchpress" /></td>
                <td><img src="image/runner.png" alt="Running" /></td>
                <td><img src="image/squat.png" alt="Squat" /></td>
                <td><img src="image/workout.png" alt="Armcurl" /></td>
            </tr>
            <tr class="info">
                <td>Bench Press</td>
                <td>Running</td>
                <td>Squat</td>
                <td>Armcurl</td>
            </tr>
            <tr>
                <td><input type="number" name="benchpress" class="form-control" placeholder="0 sets" required></td>
                <td><input type="number" name="running" class="form-control" placeholder="0 minutes" required></td>
                <td><input type="number" name="squat" class="form-control" placeholder="0 sets" required></td>
                <td><input type="number" name="armcurl" class="form-control" placeholder="0 sets" required></td>
            </tr>
        </table>
            <table class="exercise-table-mobile">
            <!-- Row for Bench Press -->
                <tr>
                    <td><img src="image/2548440.png" alt="Benchpress" /></td>
                    <td>
                        <div class="exercise-info">Bench Press</div>
                        <input type="number" name="benchpress" class="form-control" placeholder="0 sets" required>
                       
                    </td>
                </tr>
                <tr>
                    <td><img src="image/runner.png" alt="Running" /></td>
                    <td>
                        <div class="exercise-info">Bench Press</div>
                        <input type="number" name="running" class="form-control" placeholder="0 minutes" required>
                        
                    </td>
                </tr>
                <tr>
                    <td><img src="image/squat.png" alt="Squat" /></td>
                    <td>
                        <div class="exercise-info">Bench Press</div>
                        <input type="number" name="squat" class="form-control" placeholder="0 sets" required>
                        
                    </td>
                </tr>
                <tr>
                    <td><img src="image/workout.png" alt="Armcurl" /></td>
                    <td>
                        <div class="exercise-info">Bench Press</div>
                        <input type="number" name="armcurl" class="form-control" placeholder="0 sets" required>
                        
                    </td>
                </tr>
            
        </table>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
<%
if(request.getMethod().equals("POST")) {
	String benchpress = request.getParameter("benchpress") != null ? request.getParameter("benchpress") : request.getParameter("benchpressM");
    String running = request.getParameter("running") != null ? request.getParameter("running") : request.getParameter("runningM");
    String squat = request.getParameter("squat") != null ? request.getParameter("squat") : request.getParameter("squatM");
    String armcurl = request.getParameter("armcurl") != null ? request.getParameter("armcurl") : request.getParameter("armcurlM");
    
    String userEmail = (String) session.getAttribute("userEmail");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/website_info?user=root&password=root");

        // Fetch user ID
        PreparedStatement pst = conn.prepareStatement("SELECT idusers FROM website_info.users WHERE email = ?");
        pst.setString(1, userEmail);
        ResultSet rs = pst.executeQuery();
        if(rs.next()) {
            int userId = rs.getInt("idusers");

            // Insert or update exercise data
            String insertOrUpdateSql = "INSERT INTO website_info.exercise (benchpress, running, squat, armcurl, idusers, recordDate) VALUES (?, ?, ?, ?, ?, CURDATE()) ON DUPLICATE KEY UPDATE benchpress = VALUES(benchpress), running = VALUES(running), squat = VALUES(squat), armcurl = VALUES(armcurl)";
            pst = conn.prepareStatement(insertOrUpdateSql);
            pst.setInt(1, Integer.parseInt(benchpress));
            pst.setInt(2, Integer.parseInt(running));
            pst.setInt(3, Integer.parseInt(squat));
            pst.setInt(4, Integer.parseInt(armcurl));
            pst.setInt(5, userId);
            pst.executeUpdate();

            // Calculate burned calories
            int burnedCalories = Integer.parseInt(benchpress) * 5 + Integer.parseInt(running) * 10 + Integer.parseInt(squat) * 13 + Integer.parseInt(armcurl) * 5;

            // Check if a record exists for today
            String checkSql = "SELECT consumedCalories FROM website_info.daily_calorie_records WHERE userId = ? AND recordDate = CURDATE()";
            pst = conn.prepareStatement(checkSql);
            pst.setInt(1, userId);
            rs = pst.executeQuery();
            int consumedCalories = 0;
            if(rs.next()) {
                consumedCalories = rs.getInt("consumedCalories");
            }

            // Update or insert into daily calorie records
            String updateCalorieSql = "INSERT INTO website_info.daily_calorie_records (userId, recordDate, consumedCalories, burnedCalories, netCalories) VALUES (?, CURDATE(), ?, ?, ? - ?) ON DUPLICATE KEY UPDATE burnedCalories = VALUES(burnedCalories), netCalories = consumedCalories - VALUES(burnedCalories)";
            pst = conn.prepareStatement(updateCalorieSql);
            pst.setInt(1, userId);
            pst.setInt(2, consumedCalories);
            pst.setInt(3, burnedCalories);
            pst.setInt(4, consumedCalories);
            pst.setInt(5, burnedCalories);
            pst.executeUpdate();

           // out.println("<p>Exercise info saved successfully!</p>");
        } else {
          //  out.println("<p>User not found</p>");
        }
        conn.close();
    } catch(Exception e) {
        e.printStackTrace();
       // out.println("<p>Error: " + e.getMessage() + "</p>");
    }
}
%>

    </div>
</body>
</html>
