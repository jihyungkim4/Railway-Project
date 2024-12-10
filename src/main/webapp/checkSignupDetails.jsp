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
	String first_name = request.getParameter("first_name");
	String last_name = request.getParameter("last_name");
	String email = request.getParameter("email");
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "rootroot");
	
	try {
		String query = "INSERT INTO customer (first_name, last_name, email_address, username, password) VALUES (?, ?, ?, ?, ?)";
		PreparedStatement pstmt = con.prepareStatement(query);
		pstmt.setString(1, first_name);
		pstmt.setString(2, last_name);
		pstmt.setString(3, email);
		pstmt.setString(4, username);
		pstmt.setString(5, password);
		pstmt.executeUpdate();
		session.setAttribute("username", username);
		out.println("welcome " + username);
		out.println("<a href='logout.jsp'>Log out</a>");
		response.sendRedirect("success.jsp");
	}
	
	catch (SQLIntegrityConstraintViolationException e) {
	    out.println("A user with this email already exists!<br><br>");
	    out.println("<a href='login.jsp'>Login</a><br>");
	    out.println("<a href='signup.jsp'>Back to Signup</a>");
	}

	
%>
</body>
</html>