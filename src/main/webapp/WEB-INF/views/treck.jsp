<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trekking Destinations</title>

<style>
    body {
        font-family: "Segoe UI", sans-serif;
        background: linear-gradient(to right, #eef2f3, #ffffff);
        margin: 0;
        padding: 0; /* Changed to 0 to allow navbar to touch edges */
    }

    /* --- Logo and Navbar Styling --- */
    nav {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: #ffffff;
        padding: 10px 40px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        position: sticky;
        top: 0;
        z-index: 1000;
    }

    .logo-section {
        display: flex;
        align-items: center;
        gap: 12px; /* Space between logo and text */
    }

    .logo-section img {
        height: 50px; /* Adjust height as needed */
        width: auto;
    }

    .logo-text {
        font-size: 24px;
        font-weight: 800;
        color: #27ae60; /* Ghumantey Green */
        letter-spacing: -1px;
    }
    /* ------------------------------ */

    h1 {
        text-align: center;
        margin-top: 50px;
        margin-bottom: 40px;
        font-size: 32px;
        color: #2c3e50;
    }

    .trek-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 30px;
        max-width: 1200px;
        margin: auto;
        padding: 0 30px 50px 30px; /* Added padding for bottom spacing */
    }

    .trek-card {
        background: #fff;
        border-radius: 14px;
        overflow: hidden;
        box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .trek-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 18px 35px rgba(0,0,0,0.15);
    }

    .trek-card img {
        width: 100%;
        height: 200px;
        object-fit: cover;
    }

    .trek-content {
        padding: 20px;
        text-align: center;
    }

    .trek-content h3 {
        margin-bottom: 10px;
        color: #34495e;
    }

    .trek-content p {
        font-size: 14px;
        color: #666;
        line-height: 1.6;
        margin-bottom: 18px;
    }

    .trek-btn {
        display: inline-block;
        padding: 10px 22px;
        background: #2ecc71;
        color: #fff;
        text-decoration: none;
        border-radius: 25px;
        font-size: 14px;
        transition: background 0.3s ease;
    }

    .trek-btn:hover {
        background: #27ae60;
    }
</style>

</head>
<body>

<nav>
        <div class="logo-section">
            <img src="${pageContext.request.contextPath}/logo.png" alt="Ghumantey Logo">
            <div class="logo-text">Ghumantey</div>
        </div>

        <%@ include file="navbar.jsp" %>
    </nav>

<h1>Explore Popular Treks of Nepal</h1>

<div class="trek-container">

    <div class="trek-card">
        <img src="/manang.jpg" alt="Manang Trek">
        <div class="trek-content">
            <h3>Manang Trek</h3>
            <p>
                A high-altitude trek offering stunning Himalayan views,
                ancient monasteries, and rich Tibetan culture.
            </p>
            <a href="#" class="trek-btn">View Description</a>
        </div>
    </div>

    <div class="trek-card">
        <img src="/mustang.jpg" alt="Upper Mustang">
        <div class="trek-content">
            <h3>Upper Mustang Trek</h3>
            <p>
                Explore the forbidden kingdom with desert landscapes,
                cave monasteries, and unique Himalayan culture.
            </p>
            <a href="#" class="trek-btn">View Description</a>
        </div>
    </div>

    <div class="trek-card">
        <img src="/mardi.jpeg" alt="Mardi Himal">
        <div class="trek-content">
            <h3>Mardi Himal Trek</h3>
            <p>
                A short and scenic trek with breathtaking views of
                Machhapuchhre and Annapurna range.
            </p>
            <a href="#" class="trek-btn">View Description</a>
        </div>
    </div>

    <div class="trek-card">
        <img src="/manasalu.jpg" alt="Manaslu Circuit">
        <div class="trek-content">
            <h3>Manaslu Circuit Trek</h3>
            <p>
                A remote and adventurous trek circling Mt. Manaslu,
                perfect for experienced trekkers.
            </p>
            <a href="#" class="trek-btn">View Description</a>
        </div>
    </div>

    <div class="trek-card">
        <img src="/Pokhara.jpg" alt="Pokhara">
        <div class="trek-content">
            <h3>Pokhara Region</h3>
            <p>
                Gateway to Annapurna treks, famous for lakes,
                mountain views, and relaxed trekking routes.
            </p>
            <a href="#" class="trek-btn">View Description</a>
        </div>
    </div>

    <div class="trek-card">
        <img src="/Chitwan.jpg" alt="Chitwan">
        <div class="trek-content">
            <h3>Chitwan Area</h3>
            <p>
                A mix of jungle walks and cultural tours,
                ideal for nature and wildlife lovers.
            </p>
            <a href="#" class="trek-btn">View Description</a>
        </div>
    </div>

</div>

</body>
</html>