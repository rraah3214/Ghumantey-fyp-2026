<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
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
            position: relative;
            padding: 40px 0;
        }

        /* Top Left Logo */
        .top-left-logo {
            position: absolute;
            top: 25px;
            left: 25px;
        }

        .top-left-logo img {
            height: 55px;
            width: auto;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.2));
        }

        /* Signup container */
        .signup-container {
            background-color: #ffffff;
            padding: 30px 45px 40px 45px;
            border-radius: 12px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.25);
            width: 440px;
            text-align: center;
        }

        /* Logo inside the box */
        .box-logo {
            margin-bottom: 10px;
        }

        .box-logo img {
            height: 65px;
            width: auto;
        }

        .signup-container h2 {
            margin-bottom: 25px;
            color: #115e59;
            font-size: 1.8rem;
            font-weight: 700;
        }

        /* Form labels and inputs */
        form label {
            display: block;
            text-align: left;
            margin-bottom: 5px;
            font-weight: 600;
            color: #4b5563;
        }

        form input[type="text"],
        form input[type="email"],
        form input[type="password"],
        form select {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 15px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        form input:focus,
        form select:focus {
            border-color: #0f766e;
            outline: none;
            box-shadow: 0 0 0 3px rgba(15, 118, 110, 0.2);
        }

        /* Hidden License Field Styling */
        #licenseWrapper {
            display: none;
            text-align: left;
            background: #f0fdfa;
            padding: 10px;
            border-radius: 8px;
            border-left: 4px solid #0f766e;
            margin-bottom: 15px;
            animation: slideDown 0.3s ease-out;
        }

        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
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
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        button[type="submit"]:hover {
            background-color: #115e59;
            transform: translateY(-1px);
        }

        /* Login link */
        .login-link {
            margin-top: 20px;
            display: block;
            font-size: 0.95rem;
            color: #6b7280;
        }

        .login-link a {
            color: #0f766e;
            text-decoration: none;
            font-weight: 700;
        }

        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="top-left-logo">
        <img src="${pageContext.request.contextPath}/logo.png" alt="Ghumantey Logo">
    </div>

    <div class="signup-container">
        <div class="box-logo">
            <img src="${pageContext.request.contextPath}/logo.png" alt="Ghumantey">
        </div>

        <h2>Signup Form</h2>

        <form action="${pageContext.request.contextPath}/register" method="post" id="signupForm">
            <label>Email</label>
            <input type="email" name="email" placeholder="example@mail.com" required>

            <label>Username</label>
            <input type="text" name="username" placeholder="Choose a username" required>

            <label>Password</label>
            <input type="password" name="password" id="password" placeholder="Create a password" required>

            <label>Confirm Password</label>
            <input type="password" name="cpassword" id="cpassword" placeholder="Repeat your password" required>

            <label>Role</label>
            <select name="authority" id="roleSelect" required>
                <option value="ROLE_USER">User</option>
                <option value="ROLE_ADMIN">Admin</option>
                <option value="ROLE_HOTEL">Hotels</option>
                <option value="ROLE_GUIDE">Guide</option>
            </select>

            <div id="licenseWrapper">
                <label for="licenseNo">License Number</label>
                <input type="text" name="licenseNo" id="licenseNo" placeholder="Enter Guide License ID">
            </div>

            <button type="submit">Signup</button>
        </form>

        <p class="login-link">Already have an account? 
            <a href="${pageContext.request.contextPath}/login">Login here</a>
        </p>
    </div>

<script>
    const roleSelect = document.getElementById('roleSelect');
    const licenseWrapper = document.getElementById('licenseWrapper');
    const licenseInput = document.getElementById('licenseNo');

    // Toggle license field based on role
    roleSelect.addEventListener('change', function() {
        if (this.value === 'ROLE_GUIDE') {
            licenseWrapper.style.display = 'block';
            licenseInput.setAttribute('required', 'required');
        } else {
            licenseWrapper.style.display = 'none';
            licenseInput.removeAttribute('required');
            licenseInput.value = ''; // Reset value if role is changed back
        }
    });

    // Password Match Validation
    document.getElementById('signupForm').addEventListener('submit', function(e) {
        const pass = document.getElementById('password').value;
        const cpass = document.getElementById('cpassword').value;
        
        if (pass !== cpass) {
            e.preventDefault();
            alert("Passwords do not match!");
        }
    });

    // Display Error if present
    <c:if test="${not empty error}">
        alert("${error}");
    </c:if>
</script>

</body>
</html>