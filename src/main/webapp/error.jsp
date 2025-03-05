<%--
  Created by IntelliJ IDEA.
  User: kavee
  Date: 3/5/2025
  Time: 7:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .error-container {
            text-align: center;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #e74c3c;
            font-size: 2rem;
            margin-bottom: 10px;
        }
        p {
            color: #555;
            font-size: 1rem;
            margin-bottom: 20px;
        }
        a {
            text-decoration: none;
            color: #3498db;
            font-weight: bold;
        }
        a:hover {
            text-decoration: underline;
        }
        .error-message {
            color: red;
            font-size: 1rem;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="error-container">
    <h1>Oops! Something went wrong.</h1>
    <p>
            <%
    // Retrieve the error message from the request parameter or attribute
    String errorMessage = (String) request.getAttribute("message");
    if (errorMessage == null || errorMessage.isEmpty()) {
        errorMessage = "An unexpected error occurred. Please try again later.";
    }
%>

    <p class="error-message">
        <%= errorMessage %>
    </p>
    </p>
    <a href="Customer_Dashboard.jsp">Go Back to Home</a>
</div>
</body>
</html>