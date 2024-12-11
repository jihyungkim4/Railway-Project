<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Customer Representative</title>
</head>
<body>
<%
String ssn = request.getParameter("ssn");
String username = request.getParameter("username");
String firstName = request.getParameter("first_name");
String lastName = request.getParameter("last_name");
String password = request.getParameter("password");

if (ssn != null && username != null && firstName != null && lastName != null && password != null) {
   try {
       Class.forName("com.mysql.jdbc.Driver");
       Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "rootroot");

       String query = "UPDATE employee SET username = ?, first_name = ?, last_name = ?, password = ? WHERE ssn = ? AND role = 'customer_rep'";
       PreparedStatement ps = con.prepareStatement(query);
       ps.setString(1, username);
       ps.setString(2, firstName);
       ps.setString(3, lastName);
       ps.setString(4, password);
       ps.setInt(5, Integer.parseInt(ssn));

       int rows = ps.executeUpdate();

       if (rows > 0) {
           session.setAttribute("message", "Customer Representative updated successfully!");
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

<h1>Edit Customer Representative</h1>
<form method="post">
   SSN: <input type="number" name="ssn" required><br>
   New Username: <input type="text" name="username" required><br>
   New First Name: <input type="text" name="first_name" required><br>
   New Last Name: <input type="text" name="last_name" required><br>
   New Password: <input type="password" name="password" required><br>
   <button type="submit">Update Representative</button>
</form>

</body>
</html>