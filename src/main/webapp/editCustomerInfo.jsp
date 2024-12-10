<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Customer Info</title>
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
            
            String query = "UPDATE customer SET username = ?, first_name = ?, last_name = ?, password = ? WHERE email_address = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, firstName);
            ps.setString(3, lastName);
            ps.setString(4, password);
            ps.setString(5, email);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                session.setAttribute("message", "Customer updated successfully!");
                response.sendRedirect("success.jsp");
            } else {
                session.setAttribute("message", "No customer found with the provided email address.");
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

<h1>Edit Customer Info</h1>
<form method="post">
    Email Address: <input type="email" name="email_address" required><br>
    New Username: <input type="text" name="username" required><br>
    New First Name: <input type="text" name="first_name" required><br>
    New Last Name: <input type="text" name="last_name" required><br>
    New Password: <input type="password" name="password" required><br>
    <button type="submit">Update Customer</button>
</form>

</body>
</html>