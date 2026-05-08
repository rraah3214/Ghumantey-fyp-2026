<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trekking Destinations | Ghumantey</title>
<script src="https://unpkg.com/lucide@latest"></script>

<style>
    body {
        font-family: "Segoe UI", sans-serif;
        background: linear-gradient(to right, #eef2f3, #ffffff);
        margin: 0;
        padding: 0;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    /* --- Fixed & Stable Navbar Styling --- */
    nav {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: #ffffff;
        padding: 0 40px; /* Vertical padding handled by height */
        height: 70px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        position: sticky;
        top: 0;
        z-index: 1000;
        width: 100%;
        box-sizing: border-box;
    }

    .logo-section {
        display: flex;
        align-items: center;
        gap: 12px;
        flex-shrink: 0; /* Prevents logo from squishing */
    }

    .logo-section img {
        height: 45px;
        width: auto;
    }

    .logo-text {
        font-size: 22px;
        font-weight: 800;
        color: #27ae60;
        letter-spacing: -0.5px;
    }

    /* This wrapper ensures the included navbar content stays aligned */
    .nav-links-wrapper {
        display: flex;
        align-items: center;
    }

    .main-content {
        flex: 1;
    }

    h1 {
        text-align: center;
        margin: 50px 0 40px;
        font-size: 32px;
        color: #2c3e50;
    }

    .trek-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 30px;
        max-width: 1200px;
        margin: auto;
        padding: 0 30px 60px;
    }

    .trek-card {
        background: #fff;
        border-radius: 14px;
        overflow: hidden;
        box-shadow: 0 10px 25px rgba(0,0,0,0.08);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        height: 100%;
    }

    .trek-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 18px 35px rgba(0,0,0,0.12);
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
        font-size: 1.2rem;
    }

    .trek-content p {
        font-size: 14px;
        color: #666;
        line-height: 1.5;
        margin-bottom: 20px;
    }

    .trek-btn {
        display: inline-block;
        padding: 10px 24px;
        background: #2ecc71;
        color: #fff;
        text-decoration: none;
        border-radius: 25px;
        font-size: 13px;
        font-weight: 600;
        transition: 0.3s;
    }

    .trek-btn:hover {
        background: #27ae60;
        transform: scale(1.05);
    }

    /* Footer Layout Fixes */
    .max-w-7xl { max-width: 1200px; margin: 0 auto; }
    .grid { display: grid; }
    @media (min-width: 768px) { .md\:grid-cols-3 { grid-template-columns: repeat(3, 1fr); } }
    
    footer.ghumantey-footer { font-size: 0.8rem !important; }
    footer.ghumantey-footer h3 { font-size: 1.1rem !important; }
    .dev-name { font-size: 0.9rem !important; }
</style>

</head>
<body>

    <nav>
        <div class="logo-section">
            <img src="${pageContext.request.contextPath}/logo.png" alt="Ghumantey Logo">
            <div class="logo-text">Ghumantey</div>
        </div>

        <div class="nav-links-wrapper">
            <%@ include file="navbar.jsp" %>
        </div>
    </nav>

    <div class="main-content">
        <h1>Explore Popular Treks of Nepal</h1>

        <div class="trek-container">
            <div class="trek-card">
                <img src="/manang.jpg" alt="Manang Trek">
                <div class="trek-content">
                    <h3>Manang Trek</h3>
                    <p>A high-altitude trek offering stunning Himalayan views and rich Tibetan culture.</p>
                    <a href="#" class="trek-btn">View Description</a>
                </div>
            </div>

            <div class="trek-card">
                <img src="/mustang.jpg" alt="Upper Mustang">
                <div class="trek-content">
                    <h3>Upper Mustang Trek</h3>
                    <p>Explore the forbidden kingdom with desert landscapes and cave monasteries.</p>
                    <a href="#" class="trek-btn">View Description</a>
                </div>
            </div>

            <div class="trek-card">
                <img src="/mardi.jpeg" alt="Mardi Himal">
                <div class="trek-content">
                    <h3>Mardi Himal Trek</h3>
                    <p>A short and scenic trek with breathtaking views of the Annapurna range.</p>
                    <a href="#" class="trek-btn">View Description</a>
                </div>
            </div>

            <div class="trek-card">
                <img src="/manasalu.jpg" alt="Manaslu Circuit">
                <div class="trek-content">
                    <h3>Manaslu Circuit Trek</h3>
                    <p>A remote and adventurous trek circling Mt. Manaslu, perfect for experts.</p>
                    <a href="#" class="trek-btn">View Description</a>
                </div>
            </div>

            <div class="trek-card">
                <img src="/Pokhara.jpg" alt="Pokhara">
                <div class="trek-content">
                    <h3>Pokhara Region</h3>
                    <p>Gateway to Annapurna treks, famous for lakes and relaxed routes.</p>
                    <a href="#" class="trek-btn">View Description</a>
                </div>
            </div>

            <div class="trek-card">
                <img src="/Chitwan.jpg" alt="Chitwan">
                <div class="trek-content">
                    <h3>Chitwan Area</h3>
                    <p>A mix of jungle walks and cultural tours, ideal for wildlife lovers.</p>
                    <a href="#" class="trek-btn">View Description</a>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

    <script>
        lucide.createIcons();
    </script>
</body>
</html>