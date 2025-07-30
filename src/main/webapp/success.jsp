<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
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
	<h2>Other Options</h2>
	<ul>
	    <li><a href="resPage.jsp">Reserve A Trip</a></li>
	</ul>
	<%
        // Check if the logged-in user is an admin
        if ("admin".equalsIgnoreCase(role)) {
    %>
        <h2>Admin Features</h2>
        <ul>
            <li><a href="addCustomerInfo.jsp">Add Customer Info</a></li>
            <li><a href="editCustomerInfo.jsp">Edit Customer Info</a></li>
            <li><a href="deleteCustomerInfo.jsp">Delete Customer Info</a></li>
            <li><a href="salesPerMonth.jsp">Sales Reports Per Month</a></li>
            <li><a href="listOfReservations.jsp">List Of Reservations</a></li>
            <li><a href="listingOfRevenue.jsp">Listing Of Revenue</a></li>
            <li><a href="bestCustomer.jsp">Best Customer</a></li>
            <li><a href="mostActiveTransitLines.jsp">Top 5 Most Active Transit Lines</a></li>
        </ul>
    <%
        } else if (role.equals("customer_rep")) { 
        	%>
        	        <h2>Customer Representative Features</h2>
        	        <ul>
        	            <li><a href="editTrainSchedule.jsp">Edit Train Schedules</a></li>
        	            <li><a href="deleteTrainSchedules.jsp">Delete Train Schedules</a></li>
        	            <li><a href="updateTrainSchedule.jsp">Update Train Schedules</a></li>
        	    
        	            <li><a href="browseQuestions.jsp">Browse Questions and Answers</a></li>
        	            <li><a href="searchQuestions.jsp">Search Questions by Keywords</a></li>
			            <li><a href="sendQuestion.jsp">Send a Question to Customer Service</a></li>
			            <li><a href="replyToQuestions.jsp">Reply to Customer Questions</a></li>
			            <li><a href="trainSchedulesByStation.jsp">List Train Schedules by Station</a></li>
			            <li><a href="customersByTransitLine.jsp">List Customers by Transit Line and Date</a></li>
			        </ul>
			<%
			    } else { 
			%>
			        <h2>Unauthorized Access</h2>
			        <p>You do not have access to this page.</p>
			<%
			    
        }
    %>

</body>
</html> --%>

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
    if (session.getAttribute("role") == null || "customer".equalsIgnoreCase((String) session.getAttribute("role"))) {
        response.sendRedirect("customerSuccessPage.jsp");
        return;
    }
%>

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
	<h2>Other Options</h2>
	<ul>
	    <li><a href="resPage.jsp">Reserve A Trip</a></li>
	</ul>
	<%
        // Check if the logged-in user is an admin
        if ("admin".equalsIgnoreCase(role)) {
    %>
        <h2>Admin Features</h2>
        <ul>
            <li><a href="addCustomerInfo.jsp">Add Customer Rep Info</a></li>
            <li><a href="editCustomerInfo.jsp">Edit Customer Rep Info</a></li>
            <li><a href="deleteCustomerInfo.jsp">Delete Customer Rep Info</a></li>
            <li><a href="salesPerMonth.jsp">Sales Reports Per Month</a></li>
            <li><a href="listOfReservations.jsp">List Of Reservations</a></li>
            <li><a href="listingOfRevenue.jsp">Listing Of Revenue</a></li>
            <li><a href="bestCustomer.jsp">Best Customer</a></li>
            <li><a href="mostActiveTransitLines.jsp">Top 5 Most Active Transit Lines</a></li>
        </ul>
    <%
        } else if (role.equals("customer_rep")) { 
        	%>
        	        <h2>Customer Representative Features</h2>
        	        <ul>
        	            <li><a href="editTrainSchedule.jsp">Edit Train Schedules</a></li>
        	            <li><a href="deleteTrainSchedules.jsp">Delete Train Schedules</a></li>
        	            <li><a href="updateTrainSchedule.jsp">Update Train Schedules</a></li>
        	    
        	            <li><a href="browseQuestions.jsp">Browse Questions and Answers</a></li>
        	            <li><a href="searchQuestions.jsp">Search Questions by Keywords</a></li>
			            <li><a href="forum.jsp">Reply to Customer Questions</a></li>
			            <li><a href="trainSchedulesByStation.jsp">List Train Schedules by Station</a></li>
			            <li><a href="customersByTransitLine.jsp">List Customers by Transit Line and Date</a></li>
			        </ul>
			<%
			    } else { 
			%>
			        <h2>Unauthorized Access</h2>
			        <p>You do not have access to this page.</p>
			<%
			    
        }
    %>

</body>
</html>
