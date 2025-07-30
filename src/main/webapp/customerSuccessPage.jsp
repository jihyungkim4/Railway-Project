<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String username = (String) session.getAttribute("username");
	String role = (String) session.getAttribute("role");
	String message = (String) session.getAttribute("message");
	
	if (message != null) {
        out.println("<p style='color: green; font-weight: bold;'>" + message + "</p>");
        session.removeAttribute("message");
    }
	
	if (username == null) {
%>
You are not logged in<br/>
<a href="login.jsp">Please Login</a>
<%} else {
%>
Welcome <%=session.getAttribute("username")%>
<a href='logout.jsp'>Log out</a>

<p> Questions? Post in our <a href='forum.jsp'>forum</a> </p>
<%
}
%>

<h1>Search Train Schedules</h1>
    <form action="searchSchedules.jsp" method="get">
        <label for="origin">Origin:</label>
        <select id="origin" name="origin" required>
            <option value="">Select Origin</option>
            <option value="Trenton">Trenton</option>
            <option value="Hamilton">Hamilton</option>
            <option value="Princeton Junction">Princeton Junction</option>
            <option value="Jersey Avenue">Jersey Avenue</option>
            <option value="New Brunswick">New Brunswick</option>
			<option value="Edison">Edison</option>
			<option value="Metuchen">Metuchen</option>
			<option value="Metropark">Metropark</option>
			<option value="Rahway">Rahway</option>
			<option value="Linden">Linden</option>
			<option value="Elizabeth">Elizabeth</option>
			<option value="North Elizabeth">North Elizabeth</option>
			<option value="Newark Penn">Newark Penn</option>
			<option value="Secaucus Junction">Secaucus Junction</option>
			<option value="New York Penn">New York Penn</option>
        </select>
        <br><br>

        <label for="destination">Destination:</label>
        <select id="destination" name="destination" required>
            <option value="">Select Destination</option>
            <option value="Trenton">Trenton</option>
            <option value="Hamilton">Hamilton</option>
            <option value="Princeton Junction">Princeton Junction</option>
            <option value="Jersey Avenue">Jersey Avenue</option>
            <option value="New Brunswick">New Brunswick</option>
			<option value="Edison">Edison</option>
			<option value="Metuchen">Metuchen</option>
			<option value="Metropark">Metropark</option>
			<option value="Rahway">Rahway</option>
			<option value="Linden">Linden</option>
			<option value="Elizabeth">Elizabeth</option>
			<option value="North Elizabeth">North Elizabeth</option>
			<option value="Newark Penn">Newark Penn</option>
			<option value="Secaucus Junction">Secaucus Junction</option>
			<option value="New York Penn">New York Penn</option>

        </select>
        <br><br>

        <label for="date">Date of Travel:</label>
        <input type="date" id="date" name="date" required>
        <br><br>

        <button type="submit">Search</button>
    </form>
<h2>Customer Features</h2>
<ul>
    <li><a href="resPage.jsp">Reserve A Trip</a></li>
</ul>

	
</body>
</html>
