<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login and Sign Up Form</title>
  <link rel="stylesheet" href="signup.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="signup.js"></script>
</head>
<body>
  <div class="container">   
  
  <div class="welcome-message">
      Welcome to Body Mate!
    </div>
    
    <div class="login-container">
      <!-- Tabs for Login and Sign Up -->
      <div class="tabs">
        <button id="loginTab" class="tab active">Login</button>
        <button id="signupTab" class="tab">Sign Up</button>
      </div>

      <!-- Login Form -->
      <div id="loginForm">
        <h2>Login</h2>
        <p class="loginState">Enter your email and password:</p>
        <form>
          <div class="input-group"> 
            <label for="loginEmail">Email</label>
            <input type="email" id="loginEmail" name="loginEmail" required>
          </div>
          <div class="input-group">
            <label for="loginPassword">Password</label>
            <input type="password" id="loginPassword" name="loginPassword" required>
          </div>
          <button type="submit" class="login-button">Login</button>
        </form>
      </div>

      <!-- Sign Up Form -->
      <div id="signupForm" class="signup-container" style="display: none;">
        <h2>Sign Up</h2>
        <p>Fill in the form:</p>
        <form>
          <div class="input-group">
              <label for="signupName">First name</label>
              <input id="signupName" type="text" name="firstName" required>
          </div>
          <div class="input-group">
              <label for="signupLast">Last name</label>
              <input type="text" id="signupLast" name="lastName" required>
          </div>
          <div class="input-group radio-group">
              <input type="radio" id="signupMale" name="gender" value="Male" required>
              <label for="signupMale">Male</label>
              <input type="radio" id="signupFemale" name="gender" value="Female" required>
              <label for="signupFemale">Female</label>
          </div>
          <div class="input-group">
              <label for="signupEmail">Email</label>
              <input type="email" id="signupEmail" name="email" required>
          </div>
          <div class="input-group">
              <label for="signupPassword">Password</label>
              <input type="password" id="signupPassword" name="password" required>
          </div>
          <div class="input-group">
              <label for="signupConfirm">Confirm password</label>
              <input type="password" id="signupConfirm" name="signupConfirm" required>
          </div>
          <button type="submit" class="signup-button">Sign Up</button>
      </form>
      
      </div>
    </div>
  </div>
  
  <%
 
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String gender = request.getParameter("gender");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("signupConfirm");
    String loginEmail = request.getParameter("loginEmail");
    String loginPassword = request.getParameter("loginPassword");
   


    StringBuilder alertMessage = new StringBuilder();

    
    if (loginEmail != null && loginPassword != null) {
        
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/website_info?user=root&password=root");
            PreparedStatement pst = conn.prepareStatement("SELECT * FROM website_info.users WHERE email = ? AND password = ?");
            pst.setString(1, loginEmail);
            pst.setString(2, loginPassword);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                // login success
                session.setAttribute("userEmail", loginEmail);
                response.sendRedirect("menu.jsp"); 
            } else {
                // login fail
                out.println("<script>alert('Invalid email or password.'); window.location.href='signup.jsp';</script>");
            }
            conn.close();
        
        
    }
    
    // Password criteria validation
    if (password != null && !password.matches("^(?=.*[!@&]).{7,}$")) {
        alertMessage.append("Password should be at least 7 characters including special characters like !, @, &.\\n");
    }

    // Confirm password match
    if (password != null && confirmPassword != null && !password.equals(confirmPassword)) {
        alertMessage.append("Passwords do not match!\\n");
    }

    // Email existence check
    if (email != null) {
        
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/website_info?user=root&password=root");

            PreparedStatement checkEmail = conn.prepareStatement("SELECT email FROM website_info.users WHERE email = ?");
            checkEmail.setString(1, email);
            ResultSet emailResult = checkEmail.executeQuery();

            if (emailResult.next()) {
                alertMessage.append("The email already exists!\\n");
            }
        
    }

    // Display the alert if there are any errors
    if (alertMessage.length() > 0) {
        out.println("<script>alert('" + alertMessage.toString() + "');</script>");
    }
    
    else{
    	try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/website_info?user=root&password=root");

            // store the users info into the database
            PreparedStatement insertStmt = conn.prepareStatement("INSERT INTO website_info.users (firstName, lastName, gender, email, password) VALUES (?, ?, ?, ?, ?)");
            insertStmt.setString(1, firstName);
            insertStmt.setString(2, lastName);
            insertStmt.setString(3, gender);
            insertStmt.setString(4, email);
            insertStmt.setString(5, password);

            int result = insertStmt.executeUpdate();
            if (result > 0) {
                out.println("<script>alert('Registration successful!'); window.location.href='signup.jsp';</script>");
            } else {
                out.println("<script>alert('Registration failed. Please try again.');</script>"); 
            }
            conn.close();
        } catch (SQLIntegrityConstraintViolationException e) {
            
        }
    }
    %>
</body>
</html>