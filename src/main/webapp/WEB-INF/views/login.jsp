<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Ghumantey</title>
    <style>
        /* Existing Reset & Styles... (Keep your current CSS) */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: "Segoe UI", Tahoma, sans-serif; }
        body { display: flex; justify-content: center; align-items: center; min-height: 100vh; background: linear-gradient(to right, #0f766e, #115e59); color: #333; position: relative; }
        .login-container { background-color: #ffffff; padding: 35px 45px 45px 45px; border-radius: 12px; box-shadow: 0 12px 30px rgba(0, 0, 0, 0.25); width: 380px; text-align: center; }
        .login-container h2 { margin-bottom: 25px; color: #115e59; font-size: 1.8rem; font-weight: 700; }
        form label { display: block; text-align: left; margin-bottom: 6px; font-weight: 600; color: #4b5563; }
        form input[type="text"], form input[type="password"] { width: 100%; padding: 12px; margin-bottom: 18px; border: 1px solid #d1d5db; border-radius: 8px; font-size: 1rem; }

        /* NEW: Styles for the Remember Me Checkbox */
        .remember-me-container {
            display: flex;
            align-items: center;
            text-align: left;
            margin: -5px 0 20px 0;
        }
        .remember-me-container input[type="checkbox"] {
            width: 16px;
            height: 16px;
            margin-right: 8px;
            accent-color: #0f766e;
            cursor: pointer;
        }
        .remember-me-container label {
            margin-bottom: 0;
            font-size: 0.85rem;
            color: #6b7280;
            cursor: pointer;
            font-weight: 500;
        }

        button[type="submit"] { width: 100%; padding: 14px; background-color: #0f766e; border: none; border-radius: 8px; color: #ffffff; font-size: 1rem; font-weight: 700; cursor: pointer; transition: 0.3s; }
        .forgot-pass-container { text-align: right; margin-top: -10px; margin-bottom: 25px; }
        .forgot-pass-container a { color: #0f766e; text-decoration: none; font-size: 0.85rem; font-weight: 600; }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <label>Username</label>
            <input type="text" name="username" placeholder="Username" required>

            <label>Password</label>
            <input type="password" name="password" placeholder="Password" required>

            <div class="remember-me-container">
                <input type="checkbox" name="remember-me" id="rememberMe">
                <label for="rememberMe">Stay logged in for 30 days</label>
            </div>

            <div class="forgot-pass-container">
                <a href="${pageContext.request.contextPath}/forgot-password">Forgot Password?</a>
            </div>

            <button type="submit">Login</button>
        </form>

        <p style="margin-top: 25px; color: #6b7280;">Don’t have an account? 
            <a href="${pageContext.request.contextPath}/signup" style="color: #0f766e; font-weight: 700; text-decoration: none;">Signup here</a>
        </p>
    </div>
</body>
</html>