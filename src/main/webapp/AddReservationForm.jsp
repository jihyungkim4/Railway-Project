<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Create a New Reservation</title>
</head>
<body>
<%
    // Validate session to ensure user is logged in
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<h1>Create a New Reservation</h1>
<form action="AddReservation.jsp" method="post">
    <label for="transitline">Transit Line:</label>
    <input type="text" id="transitline" name="transitline" required><br><br>

    <label for="origin">Origin:</label>
    <input type="text" id="origin" name="origin" required><br><br>

    <label for="destination">Destination:</label>
    <input type="text" id="destination" name="destination" required><br><br>

    <label for="fare">Fare:</label>
    <input type="number" id="fare" name="fare" step="0.01" required><br><br>

    <label for="round_trip">Round Trip:</label>
    <input type="checkbox" id="round_trip" name="round_trip"><br><br>

    <label for="return_date">Return Date:</label>
    <input type="date" id="return_date" name="return_date"><br><br>

    <label for="passenger_type">Passenger Type:</label>
    <select id="passenger_type" name="passenger_type">
        <option value="adult">Adult</option>
        <option value="child">Child</option>
        <option value="senior">Senior</option>
        <option value="disabled">Disabled</option>
    </select><br><br>

    <button type="submit">Add Reservation</button>
</form>


</body>
</html>
