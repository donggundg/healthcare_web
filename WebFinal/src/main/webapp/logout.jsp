<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalidate the session
    if (session != null) {  
    session.invalidate(); 
}


    // Send a response back to AJAX
    out.println("Logged out");
%>
