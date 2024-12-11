<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Customer Representative</title>
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

       String checkQuery = "SELECT COUNT(*) FROM employee WHERE ssn = ?";
       PreparedStatement checkStmt = con.prepareStatement(checkQuery);
       checkStmt.setString(1, ssn);
       ResultSet rs = checkStmt.executeQuery();

       if (rs.next() && rs.getInt(1) > 0) {
           out.println("<p>Error: SSN already exists!</p>");
       } else {
           String query = "INSERT INTO employee (ssn, username, first_name, last_name, password, role) VALUES (?, ?, ?, ?, ?, 'customer_rep')";
           PreparedStatement ps = con.prepareStatement(query);
           ps.setInt(1, Integer.parseInt(ssn));
           ps.setString(2, username);
           ps.setString(3, firstName);
           ps.setString(4, lastName);
           ps.setString(5, password);

           int rows = ps.executeUpdate();

           if (rows > 0) {
               session.setAttribute("message", "Customer Representative added successfully!");
               response.sendRedirect("success.jsp");
           } else {
               session.setAttribute("message", "Failed to add Customer Representative.");
               response.sendRedirect("success.jsp");
           }

           ps.close();
       }
       con.close();
   } catch (SQLIntegrityConstraintViolationException e) {
       out.println("<p>Error: Duplicate SSN. This SSN already exists.</p>");
   } catch (SQLException e) {
       out.println("<p>SQL Error: " + e.getMessage() + "</p>");
   } catch (Exception e) {
       out.println("<p>Unexpected Error: " + e.getMessage() + "</p>");
   }
} else if (ssn == null || ssn.trim().isEmpty()) {
   out.println("<p>SSN is required!</p>");
} else if(username == null || username.trim().isEmpty() || firstName == null || firstName.trim().isEmpty() || 
         lastName == null || lastName.trim().isEmpty() || password == null || password.trim().isEmpty()) {
   out.println("<p>All fields are required!</p>");
}
%>

<h1>Add Customer Representative</h1>
<form method="post">
   SSN: <input type="number" name="ssn" required><br>
   Username: <input type="text" name="username" required><br>
   First Name: <input type="text" name="first_name" required><br>
   Last Name: <input type="text" name="last_name" required><br>
   Password: <input type="password" name="password" required><br>
   <button type="submit">Add Representative</button>
</form>

</body>
</html>