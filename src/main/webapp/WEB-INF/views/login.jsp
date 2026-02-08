<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Ghumantey</title>
    <style>
        /* Reset & basic body styling */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Segoe UI", Tahoma, sans-serif;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(to right, #0f766e, #115e59);
            color: #333;
        }

        /* Login form container */
        .login-container {
            background-color: #ffffff;
            padding: 40px 50px;
            border-radius: 12px;
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.2);
            width: 350px;
            text-align: center;
        }

        .login-container h2 {
            margin-bottom: 25px;
            color: #115e59;
            font-size: 1.8rem;
        }

        /* Success message */
        .success-msg {
            color: #15803d;
            margin-bottom: 15px;
            font-weight: 500;
        }

        /* Form labels and inputs */
        form label {
            display: block;
            text-align: left;
            margin-bottom: 5px;
            font-weight: 500;
            color: #374151;
        }

        form input[type="text"],
        form input[type="password"] {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 20px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        form input[type="text"]:focus,
        form input[type="password"]:focus {
            border-color: #0f766e;
            outline: none;
            box-shadow: 0 0 5px rgba(15, 118, 110, 0.5);
        }

        /* Submit button */
        button[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #0f766e;
            border: none;
            border-radius: 8px;
            color: #ffffff;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        button[type="submit"]:hover {
            background-color: #115e59;
        }

        /* Signup link */
        .signup-link {
            margin-top: 15px;
            display: block;
            font-size: 0.9rem;
        }

        .signup-link a {
            color: #0f766e;
            text-decoration: none;
            font-weight: 500;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <h2>Login</h2>

        <% 
            String success = request.getParameter("signupSuccess");
            if (success != null) { 
        %>
            <p class="success-msg">Signup successful! Please login below.</p>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <label>Username:</label>
            <input type="text" name="username" required>

            <label>Password:</label>
            <input type="password" name="password" required>

            <button type="submit">Login</button>
        </form>

        <p class="signup-link">Don’t have an account? 
            <a href="${pageContext.request.contextPath}/signup">Signup here</a>
        </p>
    </div>

</body>
</html>
