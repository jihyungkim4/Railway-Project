<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Train Schedule</title>
</head>
<body>
<%
    // Validate session and role
    if (session.getAttribute("username") == null || !"customer_rep".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Retrieve parameters
    String transitLine = request.getParameter("transitline");
    String train = request.getParameter("train");

    if (transitLine == null || transitLine.isEmpty()) {
        response.sendRedirect("editTrainSchedule.jsp?error=missing_params");
        return;
    }

    try {
        // Database connection
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project", "root", "9142203eE!");

        // Adjust the SQL query to account for NULL values in the train column
        String deleteQuery;
        if (train == null || train.isEmpty()) {
            deleteQuery = "DELETE FROM train_schedules_has WHERE transitline = ? AND train IS NULL";
        } else {
            deleteQuery = "DELETE FROM train_schedules_has WHERE transitline = ? AND train = ?";
        }

        PreparedStatement pstmt = con.prepareStatement(deleteQuery);
        pstmt.setString(1, transitLine);

        // Set the second parameter only if train is not null
        if (train != null && !train.isEmpty()) {
            pstmt.setString(2, train);
        }

        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            response.sendRedirect("editTrainSchedule.jsp?success=deleted");
        } else {
            response.sendRedirect("editTrainSchedule.jsp?error=delete_failed");
        }

        pstmt.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("editTrainSchedule.jsp?error=exception");
    }
%>
</body>
</html>
