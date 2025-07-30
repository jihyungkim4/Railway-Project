<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forum</title>
</head>
<body>
    <h1>Forum</h1>
    <%
	String role = (String) session.getAttribute("role");
	if (role == null) {
	   out.println("<a href='newQuestion.jsp'>Write a new question</a>");
	}
	%>

    <form method="GET" action="">
        <input type="text" name="keyword" placeholder="Search questions..." 
               value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>">
        <input type="submit" value="Search">
    </form>

    <%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "9142203eE!");

        String keyword = request.getParameter("keyword");
        String query = "SELECT q.question_id, q.email_address, q.body AS question_body, " +
                      "a.body AS answer_body, a.email_address AS answerer_email " +
                      "FROM questions q " +
                      "LEFT JOIN answers a ON q.question_id = a.question_id ";

        if (keyword != null && !keyword.trim().isEmpty()) {
            query += "WHERE q.body LIKE ? ";
        }
        
        query += "ORDER BY q.question_id, a.answer_id";

        PreparedStatement pstmt = con.prepareStatement(query);
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            pstmt.setString(1, "%" + keyword.trim() + "%");
        }

        ResultSet rs = pstmt.executeQuery();

        out.println("<br>");

        while (rs.next()) {
            int questionId = rs.getInt("question_id");
            String emailAddress = rs.getString("email_address");
            String questionBody = rs.getString("question_body");
            String answerBody = rs.getString("answer_body");
            String answererEmail = rs.getString("answerer_email");

            out.println("<div class='question-container'>");
            out.println("<p><i>Asked by: " + emailAddress + "</i></p>");
            out.println("<p><strong>Question:</strong> " + questionBody + "</p>");

            if (answerBody != null) {
                out.println("<p><strong>Answer:</strong> " + answerBody + "</p>");
            } else {
                if ("customer_rep".equals(role)) {
                    %>
                    <form action="submitAnswer.jsp" method="POST" onsubmit="return confirm('Are you sure you want to submit this answer?');">
					    <input type="hidden" name="question_id" value="<%= questionId %>">
					    <textarea name="answer_body" rows="4" cols="50" required></textarea><br>
					    <input type="submit" value="Submit Answer">
					</form>
                    <%
                } else {
                    out.println("<p>No answers yet</p>");
                }
            }

            out.println("<hr>");
            out.println("</div>");
        }

        rs.close();
        pstmt.close();
        con.close();
    } catch (Exception e) {
        out.println("An error occurred: " + e.getMessage());
    }
    %>

</body>
</html>
