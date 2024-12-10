<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Reservation</title>
</head>
<body>
<%
    // Validate session to ensure user is logged in
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Retrieve session data and form inputs
    String username = (String) session.getAttribute("username");
    String email = null; // To store the email address

    try {
        // Load JDBC Driver and establish a connection
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "rootroot");

        // Fetch email address from the database using the username
        String emailLookupQuery = "SELECT email_address FROM customer WHERE username = ?";
        PreparedStatement emailLookupPs = con.prepareStatement(emailLookupQuery);
        emailLookupPs.setString(1, username);
        ResultSet emailRs = emailLookupPs.executeQuery();
        if (emailRs.next()) {
            email = emailRs.getString("email_address");
        } else {
            out.println("<p style='color: red;'>Error: Username not found in the customer table.</p>");
            return;
        }
        emailRs.close();
        emailLookupPs.close();

        // Retrieve other form inputs
        String transitLine = request.getParameter("transitline");
        String origin = request.getParameter("origin");
        String destination = request.getParameter("destination");
        String fareStr = request.getParameter("fare");
        String returnDate = request.getParameter("return_date");
        String passengerType = request.getParameter("passenger_type");
        boolean isRoundTrip = "on".equals(request.getParameter("round_trip"));

        // Validate required fields
        if (transitLine == null || transitLine.isEmpty() || 
            origin == null || origin.isEmpty() || 
            destination == null || destination.isEmpty() || 
            fareStr == null || fareStr.isEmpty()) {
            out.println("<p style='color: red;'>Error: Missing required fields. Please try again.</p>");
            return;
        }

        // Verify email exists in customer table
        String emailCheckQuery = "SELECT COUNT(*) FROM customer WHERE email_address = ?";
        PreparedStatement emailCheckPs = con.prepareStatement(emailCheckQuery);
        emailCheckPs.setString(1, email);
        ResultSet rs = emailCheckPs.executeQuery();
        rs.next();
        int emailCount = rs.getInt(1);
        emailCheckPs.close();
        if (emailCount == 0) {
            out.println("<p style='color: red;'>Error: Email address not found in the customer table.</p>");
            return;
        }

        // Ensure email exists in reservationportfolio_transactedit
        String portfolioCheckQuery = "SELECT COUNT(*) FROM reservationportfolio_transactedit WHERE email_address = ?";
        PreparedStatement portfolioCheckPs = con.prepareStatement(portfolioCheckQuery);
        portfolioCheckPs.setString(1, email);
        ResultSet portfolioRs = portfolioCheckPs.executeQuery();
        portfolioRs.next();
        if (portfolioRs.getInt(1) == 0) {
            String insertPortfolioQuery = "INSERT INTO reservationportfolio_transactedit (email_address) VALUES (?)";
            PreparedStatement insertPortfolioPs = con.prepareStatement(insertPortfolioQuery);
            insertPortfolioPs.setString(1, email);
            insertPortfolioPs.executeUpdate();
            insertPortfolioPs.close();
        }
        portfolioCheckPs.close();

        // Parse fare and calculate total fare
        double fare = Double.parseDouble(fareStr);
        double discount = 0.0;
        if ("child".equalsIgnoreCase(passengerType) || 
            "senior".equalsIgnoreCase(passengerType) || 
            "disabled".equalsIgnoreCase(passengerType)) {
            discount = 0.15; // 15% discount for eligible passengers
        }
        double totalFare = fare * (1 - discount);

        // Generate reservation number and date
        int reservationNumber = (int) (Math.random() * 100000);
        java.sql.Date reservationDate = new java.sql.Date(System.currentTimeMillis());

        // Insert reservation into the database
        String query = "INSERT INTO reservations_for_associatedwith_contains "
                     + "(reservation_number, total_fare, reservation_date, passenger, transitline, train, origin_station, destination_station, email_address, is_round_trip, return_date, status) "
                     + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, reservationNumber);
        ps.setDouble(2, totalFare);
        ps.setDate(3, reservationDate);
        ps.setString(4, passengerType);
        ps.setString(5, transitLine);
        ps.setString(6, "DefaultTrain"); // Replace with actual train ID if necessary
        ps.setString(7, origin);
        ps.setString(8, destination);
        ps.setString(9, email);
        ps.setBoolean(10, isRoundTrip);
        ps.setDate(11, (returnDate == null || returnDate.isEmpty()) ? null : java.sql.Date.valueOf(returnDate));
        ps.setString(12, "active");
        ps.executeUpdate();

        out.println("<p style='color: green;'>Reservation added successfully! Reservation Number: " + reservationNumber + "</p>");
        ps.close();
        con.close();
    } catch (Exception e) {
        out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    }
%>

<!-- Form to collect data -->
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
    <p><a href="resPage.jsp">Reservation Portal</a></p>
    
</form>
</body>
</html>
