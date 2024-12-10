<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forum</title>
</head>
<body>
<h1>Forum</h1>
<a href='newQuestion.jsp'>Write a new question</a>


<%
	try {
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "rootroot");
	
	    String query = "SELECT q.question_id, q.email_address, q.body AS question_body, " +
	                   "a.body AS answer_body " +
	                   "FROM questions q " +
	                   "LEFT JOIN answers a ON q.question_id = a.question_id " +
	                   "ORDER BY q.question_id, a.answer_id";
	
	    Statement stmt = con.createStatement();
	    ResultSet rs = stmt.executeQuery(query);
	
	
	    out.println("<br>");
	    
	    while (rs.next()) {
	        String emailAddress = rs.getString("email_address");
	        String questionBody = rs.getString("question_body");
	        String answerBody = rs.getString("answer_body");
	
	        out.println("</ul>");
	
            out.println("<p><i> " + emailAddress + "</i></p>");
            out.println("<p><strong>Question:</strong> " + questionBody + "</p>");
            
            
            if (answerBody != null) {
            	out.println("<p>" + answerBody + "</p>");
            }
            else {
            	out.println(session.getAttribute("type"));
            	if (session.getAttribute("type") == "ADMIN") {
            		out.println("<a>Reply</a>");
            	}
            	else {
            		out.println("<p>No answers yet</p>");
            	}
            	
            }
            
            out.println("<hr></hr>");
            out.println("<ul>");
	        
	
	    }

        out.println("</ul>");
        
	
	    rs.close();
	    stmt.close();
	    con.close();
	} catch (Exception e) {
	    out.println("An error occurred: " + e.getMessage());
	}
%>
	
	
</body>
</html>