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
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "pass");
	Statement st = con.createStatement();
	
	ResultSet rs = null;
	boolean isAuthenticated = false;
	
	rs = st.executeQuery("SELECT * FROM customer WHERE username='" + username + "' AND password='" + password + "'");
	if (rs.next()) {
	    session.setAttribute("username", username);
	    isAuthenticated = true;
	} else {
	    rs = st.executeQuery("SELECT * FROM employee WHERE username='" + username + "' AND password='" + password + "'");
	    if (rs.next()) {
	        session.setAttribute("username", username);
	        if (rs.getString("type") != null) {
	            session.setAttribute("type", rs.getString("type"));
	        }
	        isAuthenticated = true;
	    }
	}
	
	if (rs != null) rs.close();
	if (st != null) st.close();
	if (con != null) con.close();
	
	if (isAuthenticated) {
	    out.println("Welcome " + username);
	    out.println("<a href='logout.jsp'>Log out</a>");
	    response.sendRedirect("success.jsp");
	} else {
	    out.println("Invalid username or password. <a href='login.jsp'>Try again</a>");
	}
%>
</body>
</html>