<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>New question</h1>
	<form method="get" action="postQuestion.jsp">
		<table>
			<tr>    
				<td>Email address</td><td><input type="text" name="email_address"></td>
			</tr>
			<tr>    
				<td>Question</td><td><input type="text" name="question"></td>
			</tr>
			
		</table>
		<input type="submit" value="Post">
	</form>
	
	<br>
	<a href='forum.jsp'>Back to forum</a>
</body>
</html>