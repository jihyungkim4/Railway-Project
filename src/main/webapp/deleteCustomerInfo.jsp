<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Customer Representative</title>
</head>
<body>
<%
String ssn = request.getParameter("ssn");

if (ssn != null && !ssn.trim().isEmpty()) {
   try {
       Class.forName("com.mysql.jdbc.Driver");
       Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "9142203eE!");

       String query = "DELETE FROM employee WHERE ssn = ? AND role = 'customer_rep'";
       PreparedStatement ps = con.prepareStatement(query);
       ps.setInt(1, Integer.parseInt(ssn));

       int rows = ps.executeUpdate();

       if (rows > 0) {
           session.setAttribute("message", "Customer Representative deleted successfully!");
           response.sendRedirect("success.jsp");
       } else {
           session.setAttribute("message", "No Customer Representative found with the provided SSN.");
           response.sendRedirect("success.jsp");
       }

       ps.close();
       con.close();
   } catch (SQLException e) {
       session.setAttribute("message", "SQL Error: " + e.getMessage());
       response.sendRedirect("success.jsp");
   } catch (Exception e) {
       session.setAttribute("message", "Unexpected Error: " + e.getMessage());
       response.sendRedirect("success.jsp");
   }
}
%>

<h1>Delete Customer Representative</h1>
<form method="post">
   SSN: <input type="number" name="ssn" required><br>
   <button type="submit">Delete Representative</button>
</form>

</body>
</html>
