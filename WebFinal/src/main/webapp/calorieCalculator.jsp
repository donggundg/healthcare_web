<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu</title>
    <link rel="stylesheet" href="calorieCalculator.css">
    <script src="calorieCalculator.js"></script>
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
    	<h2>How much did you eat?</h2>
    	<h3>Write down how much calories you gained per meal!</h3>
        <form method="post">
            <table class="calorie-table-desktop">
            <tr>
                <td><img src="image/salad.png" alt="Breakfast" /></td>
                <td><img src="image/burger.png" alt="Lunch" /></td>
                <td><img src="image/christmas-dinner.png" alt="Dinner" /></td>
                <td><img src="image/snack.png" alt="Snack" /></td>
            </tr>
            <tr class="info">
                <td>Breakfast</td>
                <td>Lunch</td>
                <td>Dinner</td>
                <td>Snack</td>
            </tr>
            <tr>
                <td><input type="number" name="breakfast" class="form-control" placeholder="0kcal" required></td>
                <td><input type="number" name="lunch" class="form-control" placeholder="0kcal" required></td>
                <td><input type="number" name="dinner" class="form-control" placeholder="0kcal" required></td>
                <td><input type="number" name="snack" class="form-control" placeholder="0kcal" required></td>
            </tr>
        </table>
        </table>
            <table class="calorie-table-mobile">
                <tr>
                    <td><img src="image/salad.png" alt="Breakfast" /></td>
                    <td>
                        <div class="calorie-info">Breakfast</div>
                        <input type="number" name="breakfast" class="form-control" placeholder="0kcal" required>
                       
                    </td>
                </tr>
                <tr>
                    <td><img src="image/burger.png" alt="Lunch" /></td>
                    <td>
                        <div class="calorie-info">Lunch</div>
                        <input type="number" name="lunch" class="form-control" placeholder="0kcal" required>
                        
                    </td>
                </tr>
                <tr>
                    <td><img src="image/christmas-dinner.png" alt="Dinner" /></td>
                    <td>
                        <div class="calorie-info">Dinner</div>
                        <input type="number" name="dinner" class="form-control" placeholder="0kcal" required>
                        
                    </td>
                </tr>
                <tr>
                    <td><img src="image/snack.png" alt="Snack" /></td>
                    <td>
                        <div class="calorie-info">Snack</div>
                       <input type="number" name="snack" class="form-control" placeholder="0kcal" required>
                        
                    </td>
                </tr>
            
        </table>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
       <%
       //
if(request.getMethod().equals("POST")) {
    String breakfast = request.getParameter("breakfast");
    String lunch = request.getParameter("lunch");
    String dinner = request.getParameter("dinner");
    String snack = request.getParameter("snack");
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

            // Insert meal data
            String insertMealSql = "INSERT INTO website_info.meal (breakfast, lunch, dinner, snack, idusers, recordDate) VALUES (?, ?, ?, ?, ?, CURDATE()) ON DUPLICATE KEY UPDATE breakfast = VALUES(breakfast), lunch = VALUES(lunch), dinner = VALUES(dinner), snack = VALUES(snack)";
            pst = conn.prepareStatement(insertMealSql);
            pst.setInt(1, Integer.parseInt(breakfast));
            pst.setInt(2, Integer.parseInt(lunch));
            pst.setInt(3, Integer.parseInt(dinner));
            pst.setInt(4, Integer.parseInt(snack));
            pst.setInt(5, userId);
            pst.executeUpdate();

            // Calculate consumed calories
            int consumedCalories = Integer.parseInt(breakfast) + Integer.parseInt(lunch) + Integer.parseInt(dinner) + Integer.parseInt(snack);

            // Check if a record exists for today
            String checkSql = "SELECT burnedCalories FROM website_info.daily_calorie_records WHERE userId = ? AND recordDate = CURDATE()";
            pst = conn.prepareStatement(checkSql);
            pst.setInt(1, userId);
            rs = pst.executeQuery();
            int burnedCalories = 0;
            if(rs.next()) {
                burnedCalories = rs.getInt("burnedCalories");
            }

            // Update or insert into daily calorie records
            String updateCalorieSql = "INSERT INTO website_info.daily_calorie_records (userId, recordDate, consumedCalories, burnedCalories, netCalories) VALUES (?, CURDATE(), ?, ?, ? - ?) ON DUPLICATE KEY UPDATE consumedCalories = VALUES(consumedCalories), netCalories = VALUES(consumedCalories) - burnedCalories";
            pst = conn.prepareStatement(updateCalorieSql);
            pst.setInt(1, userId);
            pst.setInt(2, consumedCalories);
            pst.setInt(3, burnedCalories);
            pst.setInt(4, consumedCalories);
            pst.setInt(5, burnedCalories);
            pst.executeUpdate();

        } else {
           // out.println("<p>User not found</p>");
        }
    } catch(Exception e) {
        e.printStackTrace();
        //out.println("<p>Error: " + e.getMessage() + "</p>");
    }
}
%>

    </div>
</body>
</html>