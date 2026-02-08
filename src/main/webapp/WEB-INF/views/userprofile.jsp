<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile - Ghumantey</title>

    <style>
        /* ========== RESET & BASE ========== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Poppins", "Segoe UI", sans-serif;
        }

        body {
            background: linear-gradient(135deg, #e0f2fe, #f0fdfa);
            color: #1e293b;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* ========== HEADER ========== */
        header {
            background: linear-gradient(90deg, #0f766e, #0d9488, #14b8a6);
            color: white;
            text-align: center;
            padding: 40px 20px 60px;
            position: relative;
            overflow: hidden;
        }

        header::after {
            content: "";
            position: absolute;
            bottom: -50px;
            left: 0;
            width: 100%;
            height: 100px;
            background: white;
            border-radius: 100% 100% 0 0;
        }

        header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            letter-spacing: 1px;
            text-shadow: 0 3px 10px rgba(0, 0, 0, 0.3);
        }

        /* ========== PROFILE CARD ========== */
        .profile-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: -60px;
            padding: 30px 20px;
        }

        .profile-card {
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            border-radius: 16px;
            padding: 40px 60px;
            box-shadow: 0 10px 35px rgba(0, 0, 0, 0.15);
            max-width: 500px;
            width: 100%;
            text-align: center;
            animation: slideUp 1s ease-in-out;
            transition: 0.4s ease;
        }

        .profile-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 14px 45px rgba(0, 0, 0, 0.2);
        }

        .profile-image {
            width: 110px;
            height: 110px;
            border-radius: 50%;
            margin-bottom: 20px;
            border: 3px solid #0d9488;
            object-fit: cover;
        }

        .profile-card h2 {
            color: #0f766e;
            font-size: 1.8rem;
            margin-bottom: 5px;
        }

        .profile-card p {
            font-size: 1rem;
            color: #475569;
            margin: 10px 0;
        }

        .status {
            font-weight: 600;
            padding: 5px 14px;
            border-radius: 20px;
            display: inline-block;
        }

        .active {
            background: #dcfce7;
            color: #15803d;
        }

        .inactive {
            background: #fee2e2;
            color: #b91c1c;
        }

        /* ========== NAVIGATION ========== */
        nav {
            margin-top: 30px;
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        nav a {
            background: #0f766e;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: 0.3s;
        }

        nav a:hover {
            background: #14b8a6;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(20, 184, 166, 0.4);
        }

        /* ========== FOOTER ========== */
        footer {
            margin-top: auto;
            background: #1f2937;
            color: #cbd5e1;
            text-align: center;
            padding: 18px;
            font-size: 0.95rem;
            letter-spacing: 0.5px;
        }

        /* ========== ANIMATIONS ========== */
        @keyframes slideUp {
            from { transform: translateY(30px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        /* ========== RESPONSIVE ========== */
        @media (max-width: 600px) {
            header h1 {
                font-size: 1.8rem;
            }

            .profile-card {
                padding: 30px 20px;
            }

            nav {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>

<header>
    <h1>Welcome to Your Profile 🌄</h1>
</header>

<section class="profile-container">
    <div class="profile-card">
        <!-- You can replace this image with a real user profile photo -->
        <img src="${pageContext.request.contextPath}/images/profile-default.png" alt="User" class="profile-image">

        <h2><c:out value="${user.username}" /></h2>
        <p><strong>Role:</strong> <c:out value="${user.userRole.role}" /></p>

        <p><strong>Status:</strong>
            <c:choose>
                <c:when test="${user.active == '1'}">
                    <span class="status active">Active</span>
                </c:when>
                <c:otherwise>
                    <span class="status inactive">Inactive</span>
                </c:otherwise>
            </c:choose>
        </p>

        <nav>
            <a href="<c:url value='/home' />">🏠 Home</a>
            <a href="<c:url value='/logout' />">🚪 Logout</a>
        </nav>
    </div>
</section>

<footer>
    <p>&copy; 2026 Ghumantey | Designed with ❤️ in Nepal</p>
</footer>

</body>
</html>
