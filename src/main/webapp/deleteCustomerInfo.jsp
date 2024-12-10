<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Customer Info</title>
</head>
<body>
<%
    String email = request.getParameter("email_address");

    if (email != null && !email.trim().isEmpty()) {
        try {

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "rootroot");


            String query = "DELETE FROM customer WHERE email_address = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);


            int rows = ps.executeUpdate();

            if (rows > 0) {
                session.setAttribute("message", "Customer deleted successfully!");
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


<h1>Delete Customer Info</h1>
<form method="post">
    Email Address: <input type="email" name="email_address" required><br>
    <button type="submit">Delete Customer</button>
</form>

</body>
</html>