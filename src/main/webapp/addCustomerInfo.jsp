<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Customer Info</title>
</head>
<body>
<%
    String email = request.getParameter("email_address");
    String username = request.getParameter("username");
    String firstName = request.getParameter("first_name");
    String lastName = request.getParameter("last_name");
    String password = request.getParameter("password");

    if (email != null && username != null && firstName != null && lastName != null && password != null) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "rootroot");
            
            String checkQuery = "SELECT COUNT(*) FROM customer WHERE email_address = ?";
            PreparedStatement checkStmt = con.prepareStatement(checkQuery);
            checkStmt.setString(1, email);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                out.println("<p>Error: Email Address already exists!</p>");
            } else{

            String query = "INSERT INTO customer (email_address, username, first_name, last_name, password) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, username);
            ps.setString(3, firstName);
            ps.setString(4, lastName);
            ps.setString(5, password);

            int rows = ps.executeUpdate();

            if (rows > 0) {
            	session.setAttribute("message", "Customer added successfully!");
                response.sendRedirect("success.jsp");
            } else {
            	session.setAttribute("message", "Failed to add Customer Info.");
                response.sendRedirect("success.jsp");
            }

            ps.close();
            }
           	con.close();
        } catch (SQLIntegrityConstraintViolationException e) {
            out.println("<p>Error: Duplicate email address. This email already exists.</p>");
        } catch (SQLException e) {
            out.println("<p>SQL Error: " + e.getMessage() + "</p>");
        } catch (Exception e) {
            out.println("<p>Unexpected Error: " + e.getMessage() + "</p>");
        }
    } else if (email == null || email.trim().isEmpty()) {
        out.println("<p>Email Address is required!</p>");
    } else if(username == null || username.trim().isEmpty() || firstName == null || firstName.trim().isEmpty() || lastName == null || lastName.trim().isEmpty() || password == null || password.trim().isEmpty()) {
        out.println("<p>All fields are required!</p>");
    }
%>


<h1>Add Customer Representative</h1>
<form method="post">
    Email Address: <input type="email" name="email_address" required><br>
    Username: <input type="text" name="username" required><br>
    First Name: <input type="text" name="first_name" required><br>
    Last Name: <input type="text" name="last_name" required><br>
    Password: <input type="password" name="password" required><br>
    <button type="submit">Add Representative</button>
</form>

</body>
</html>