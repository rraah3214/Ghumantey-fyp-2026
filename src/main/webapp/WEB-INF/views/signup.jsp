<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Signup - Ghumantey</title>
    <style>
        /* Reset & body styling */
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

        /* Signup container */
        .signup-container {
            background-color: #ffffff;
            padding: 40px 50px;
            border-radius: 12px;
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.2);
            width: 400px;
            text-align: center;
        }

        .signup-container h2 {
            margin-bottom: 25px;
            color: #115e59;
            font-size: 1.8rem;
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
        form input[type="email"],
        form input[type="password"],
        form select {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 20px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        form input:focus,
        form select:focus {
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

        /* Login link */
        .login-link {
            margin-top: 15px;
            display: block;
            font-size: 0.9rem;
        }

        .login-link a {
            color: #0f766e;
            text-decoration: none;
            font-weight: 500;
        }

        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="signup-container">
        <h2>Signup Form</h2>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <label>Email:</label>
            <input type="email" name="email" required>

            <label>Username:</label>
            <input type="text" name="username" required>

            <label>Password:</label>
            <input type="password" name="password" required>

            <label>Confirm Password:</label>
            <input type="password" name="cpassword" required>

            <label>Role:</label>
            <select name="authority" required>
                <option value="ROLE_USER">User</option>
                <option value="ROLE_ADMIN">Admin</option>
                <option value="ROLE_HOTEL">Hotels</option>
                <option value="ROLE_GUIDE">Guide</option>
            </select>

            <button type="submit">Signup</button>
        </form>

        <p class="login-link">Already have an account? 
            <a href="${pageContext.request.contextPath}/login">Login here</a>
        </p>
    </div>

    <!-- Optional JavaScript alert after signup -->
    <script>
        <% if (request.getParameter("signupSuccess") != null) { %>
            alert("Signup successful! Please login now.");
            window.location.href = "<%=request.getContextPath()%>/login";
        <% } %>
    </script>

</body>
</html>
