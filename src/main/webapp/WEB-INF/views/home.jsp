<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home - Ghumantey</title>

    <style>
        /* ======== RESET ======== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Poppins", "Segoe UI", sans-serif;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            background: #f0fdfa;
            color: #1e293b;
            overflow-x: hidden;
        }

        /* ======== NAVBAR ======== */
        nav {
            backdrop-filter: blur(10px);
            background: rgba(15, 118, 110, 0.8);
            border-bottom: 1px solid rgba(255, 255, 255, 0.15);
            padding: 14px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 999;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.1);
        }

        .logo-section {
            display: flex;
            align-items: center;
        }

        .logo-section img {
            height: 65px;
            width: auto;
            margin-right: 10px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.3);
            transition: 0.3s;
        }

        .logo-section img:hover {
            transform: scale(1.05);
        }

        .logo-text {
            color: #ffffff;
            font-size: 1.8rem;
            font-weight: 700;
            letter-spacing: 1px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }

        .menu {
            display: flex;
            align-items: center;
        }

        .menu a {
            color: #e2e8f0;
            text-decoration: none;
            margin-left: 30px;
            font-weight: 500;
            font-size: 1rem;
            position: relative;
            transition: 0.3s ease;
        }

        .menu a:hover {
            color: #38bdf8;
        }

        .menu a::after {
            content: "";
            position: absolute;
            left: 0;
            bottom: -6px;
            width: 0%;
            height: 2px;
            background: #38bdf8;
            transition: width 0.3s ease;
        }

        .menu a:hover::after {
            width: 100%;
        }

        /* ======== HERO SECTION ======== */
        .hero {
            background: linear-gradient(to right, rgba(15, 118, 110, 0.8), rgba(13, 148, 136, 0.7)), 
                        url('https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?auto=format&fit=crop&w=1400&q=80') center/cover no-repeat;
            color: white;
            text-align: center;
            padding: 180px 20px;
            position: relative;
            overflow: hidden;
            animation: fadeIn 2s ease-in-out;
        }

        .hero::after {
            content: "";
            position: absolute;
            bottom: 0;
            width: 100%;
            height: 200px;
            background: linear-gradient(to top, #f0fdfa, transparent);
        }

        .hero h1 {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 15px;
            letter-spacing: 1px;
            text-shadow: 0 3px 8px rgba(0, 0, 0, 0.3);
            animation: slideInDown 1.2s ease;
        }

        .hero p {
            font-size: 1.3rem;
            opacity: 0.95;
            max-width: 700px;
            margin: 0 auto 35px;
            line-height: 1.6;
        }

        .hero button {
            background: linear-gradient(90deg, #38bdf8, #0ea5e9);
            border: none;
            color: white;
            font-size: 1.1rem;
            padding: 14px 36px;
            border-radius: 50px;
            cursor: pointer;
            transition: 0.4s ease;
            box-shadow: 0 6px 20px rgba(14, 165, 233, 0.4);
        }

        .hero button:hover {
            background: linear-gradient(90deg, #0ea5e9, #38bdf8);
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(56, 189, 248, 0.5);
        }

        /* ======== ABOUT SECTION ======== */
        .about {
            text-align: center;
            padding: 100px 20px;
            background: #ffffff;
            position: relative;
            z-index: 10;
        }

        .about h2 {
            font-size: 2.4rem;
            color: #0f766e;
            margin-bottom: 20px;
            font-weight: 700;
        }

        .about p {
            max-width: 850px;
            margin: 0 auto;
            color: #475569;
            font-size: 1.1rem;
            line-height: 1.8;
        }

        /* ======== FEATURE CARDS ======== */
        .features {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 25px;
            padding: 80px 20px;
            background: linear-gradient(135deg, #f0fdfa, #e0f2fe);
        }

        .feature-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border-radius: 18px;
            width: 320px;
            padding: 40px 25px;
            text-align: center;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            transition: 0.4s ease;
        }

        .feature-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 14px 35px rgba(0, 0, 0, 0.15);
        }

        .feature-card img {
            width: 80px;
            margin-bottom: 20px;
        }

        .feature-card h3 {
            color: #0f766e;
            font-size: 1.4rem;
            margin-bottom: 10px;
        }

        .feature-card p {
            color: #475569;
            font-size: 1rem;
            line-height: 1.6;
        }

        /* ======== FOOTER ======== */
        footer {
            background: #0f172a;
            color: #cbd5e1;
            text-align: center;
            padding: 30px 10px;
            font-size: 0.95rem;
        }

        footer a {
            color: #38bdf8;
            text-decoration: none;
            font-weight: 500;
        }

        footer a:hover {
            text-decoration: underline;
        }

        /* ======== ANIMATIONS ======== */
        @keyframes fadeIn {
            from { opacity: 0; transform: scale(1.05); }
            to { opacity: 1; transform: scale(1); }
        }

        @keyframes slideInDown {
            from { transform: translateY(-50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        /* ======== RESPONSIVE ======== */
        @media (max-width: 900px) {
            .features {
                flex-direction: column;
                align-items: center;
            }

            .feature-card {
                width: 85%;
            }

            .hero h1 {
                font-size: 2.2rem;
            }

            .hero p {
                font-size: 1rem;
            }

            nav {
                flex-direction: column;
                text-align: center;
            }

            .menu {
                margin-top: 10px;
            }
        }
    </style>
</head>

<body>

    <!-- Navbar -->
    <nav>
        <div class="logo-section">
            <img src="${pageContext.request.contextPath}/logo.png" alt="Ghumantey Logo">
            <div class="logo-text">Ghumantey</div>
        </div>

        <%@ include file="navbar.jsp" %>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <h1>Discover Nepal Like Never Before 🇳🇵</h1>
        <p>Embark on adventures across mountains, lakes, and culture — all with Ghumantey by your side.</p>
        <button onclick="window.location.href='${pageContext.request.contextPath}/guide/list'">Start Exploring</button>
    </section>

    <!-- About Section -->
    <section class="about">
        <h2>Why Choose Ghumantey?</h2>
        <p>We connect explorers with trusted local guides, premium hotels, and curated travel experiences across Nepal. 
        From the Himalayas to heritage towns, Ghumantey makes every trip unforgettable.</p>
    </section>

    <!-- Feature Cards -->
    <section class="features">
        <div class="feature-card">
            <img src="https://cdn-icons-png.flaticon.com/512/744/744502.png" alt="Guide Icon">
            <h3>Expert Local Guides</h3>
            <p>Our certified guides bring culture, safety, and knowledge to every step of your journey.</p>
        </div>
        <div class="feature-card">
            <img src="https://cdn-icons-png.flaticon.com/512/3069/3069172.png" alt="Hotel Icon">
            <h3>Luxury Hotels</h3>
            <p>Find handpicked hotels and lodges that combine comfort with authentic Nepali hospitality.</p>
        </div>
        <div class="feature-card">
            <img src="https://cdn-icons-png.flaticon.com/512/854/854905.png" alt="Adventure Icon">
            <h3>Trekking Adventures</h3>
            <p>From Everest to Annapurna — explore breathtaking treks with safety and passion.</p>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <p>&copy; 2026 Ghumantey | Designed with ❤️ for explorers. |
           <a href="#">Privacy Policy</a> | <a href="#">Contact Us</a>
        </p>
    </footer>

</body>
</html>
