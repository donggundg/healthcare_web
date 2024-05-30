<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Forum</title>
    <link rel="stylesheet" href="forum.css">
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

        <h2>Forum</h2>

        <!-- 게시글 작성 폼 -->
        <h3>New Post</h3>
        <form action="forum.jsp" method="post">
            <textarea id="comment" name="comment" rows="5" cols="40" required></textarea><br>
            <input type="submit" value="Post">
        </form>

        <!-- 게시글 리스트 -->
        <h3>Posts</h3>
        <table>
            <tr>
                <th>User</th>
                <th>Comment</th>
            </tr>
       <%
			String userEmail = (String) session.getAttribute("userEmail");
			if (userEmail != null) {
			    try {
			        Class.forName("com.mysql.cj.jdbc.Driver");
			        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/website_info", "root", "root");
			
			        PreparedStatement pst = conn.prepareStatement("SELECT idusers FROM website_info.users WHERE email = ?");
			        pst.setString(1, userEmail);
			        ResultSet rs = pst.executeQuery();
			        if(rs.next()) {
			            String idusers = rs.getString("idusers");
			
			            // writing the post
			            String comment = request.getParameter("comment");
			            if (comment != null) {
			                pst = conn.prepareStatement("INSERT INTO website_info.posts (idusers, comment) VALUES (?, ?)");
			                pst.setString(1, idusers);
			                pst.setString(2, comment);
			                pst.executeUpdate();
			            }
			
			            // print out the post list
			            Statement stmt = conn.createStatement();
			            rs = stmt.executeQuery("SELECT u.lastName, p.comment FROM posts p JOIN users u ON p.idusers = u.idusers ORDER BY p.idcomments DESC");
			            while(rs.next()) {
			                out.println("<tr>");
			                out.println("<td>" + rs.getString("lastName") + "</td>");
			                out.println("<td>" + rs.getString("comment") + "</td>");
			                out.println("</tr>");
			            }
			        } else {
			            //out.println("<p>User not found</p>");
			        }
			        conn.close();
			    } catch(Exception e) {
			        e.printStackTrace();
			       // out.println("<p>Error: " + e.getMessage() + "</p>");
			    }
			} else {
			    out.println("<p>Please login to view this page.</p>");
			}
			%>

        </table>
    </div>
</body>
</html>
