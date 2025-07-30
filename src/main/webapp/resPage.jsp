<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
    <title>Reservation Page</title>
</head>
<body>
<%
    // Validate session to ensure user is logged in
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<h1>Welcome to the Reservation Page</h1>
<a href="ResTable_Customer.jsp">View My Reservations</a><br>
<a href="HandleResTable_Customer.jsp">Manage My Reservations</a><br>
<a href="AddReservation.jsp">Create a New Reservation</a>
</body>
</html>
 --%>
 
 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
    <title>Reservation Page</title>
</head>
<body>
<%
    // Validate session to ensure user is logged in
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<h1>Welcome to the Reservation Page</h1>
<a href="HandleResTable_Customer.jsp">View My Reservations</a><br>
<a href="HandleResTable_Customer.jsp">Manage My Reservations</a><br>
<a href="AddReservationForm.jsp">Create a New Reservation</a> <!-- Changed to new form -->
<p><a href="success.jsp">Home</a></p>

</body>
</html>
 
