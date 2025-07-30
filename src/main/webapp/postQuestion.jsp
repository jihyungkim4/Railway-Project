<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    String email_address = request.getParameter("email_address");
    String question = request.getParameter("question");


    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "9142203eE!");

        String query = "INSERT INTO questions (email_address, body) VALUES (?, ?)";
        PreparedStatement pstmt = con.prepareStatement(query);

        pstmt.setString(1, email_address);
        pstmt.setString(2, question);

        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            out.println("Your question has been submitted successfully! <a href='forum.jsp'>View forum</a>");
        } else {
            out.println("An error occurred while submitting your question. Please try again.");
        }

        pstmt.close();
        con.close();
    } catch (SQLIntegrityConstraintViolationException e) {
    	out.println(e);
        out.println("An account with this email does not exist <a href='signup.jsp'>Sign up</a>");
    } 
    
%>
</body>
</html>
