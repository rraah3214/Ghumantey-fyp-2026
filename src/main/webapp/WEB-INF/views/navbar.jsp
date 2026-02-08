<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
    /* Navbar styling */
    .navbar {
        background-color: #1f2937;
        padding: 14px 40px;
    }

    .container-fluid {
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .navbar-brand {
        font-size: 1.4rem;
        font-weight: 600;
        color: #ffffff;
        text-decoration: none;
    }

    .navbar-nav {
        list-style: none;
        display: flex;
        gap: 28px;
        margin: 0;
        padding: 0;
    }

    .nav-item {
        display: flex;
        align-items: center;
    }

    .nav-link {
        color: #e5e7eb;
        text-decoration: none;
        font-size: 1rem;
        font-weight: 500;
        padding: 6px 12px;
        border-radius: 6px;
        transition: all 0.3s ease;
    }

    .nav-link:hover {
        background-color: #374151;
        color: #38bdf8;
    }
</style>

<nav class="navbar">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            
        </a>

        <ul class="navbar-nav">
        <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/user/home">home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/user/guide">Guides</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/user/hotel">Hotels</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/user/treck">Treck</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/user/travelpackages">Travel Packages</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/user/userprofile">Profile</a>
            </li>
           
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
            </li>
        </ul>
    </div>
</nav>
