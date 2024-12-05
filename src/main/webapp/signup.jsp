<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Signup</title>
</head>
<body>
<h1>Sign up</h1>
	<form method="get" action="checkSignupDetails.jsp">
		<table>
			<tr>    
				<td>First name</td><td><input type="text" name="first_name"></td>
			</tr>
			<tr>    
				<td>Last name</td><td><input type="text" name="last_name"></td>
			</tr>
			<tr>    
				<td>Email</td><td><input type="text" name="email"></td>
			</tr>
			<tr>    
				<td>Username</td><td><input type="text" name="username"></td>
			</tr>
			<tr>
				<td>Password</td><td><input type="password" name="password"></td>
			</tr>
		</table>
		<input type="submit" value="Sign up">
	</form>
	
	<br>
	<p> Already have an account? <a href='login.jsp'>Log in</a> </p>
</body>
</html>