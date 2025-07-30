<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Login</title>
	</head>
	
	<body>

		<h1> Login </h1>
		 <!-- the usual HTML way -->
		<%-- <% out.println("Hello World2"); %> --%> <!-- output the same thing, but using 
	                                      jsp programming -->
							  
	<br>
		<form method="get" action="checkLoginDetails.jsp">
			<table>
				<tr>    
					<td>Username</td><td><input type="text" name="username"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="password" name="password"></td>
				</tr>
			</table>
			<input type="submit" value="Login">
		</form>
	<br>
	
	<p> Don't have an account? <a href='signup.jsp'>Sign up</a> </p>


</body>
</html>
