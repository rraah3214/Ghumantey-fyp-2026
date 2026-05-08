<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%
    String currentUri = request.getRequestURI();
%>

<style>
.navbar {
    position: fixed;
    top: 0; left: 0; width: 100%;
    background: rgba(6, 78, 59, 0.85);
    backdrop-filter: blur(12px);
    z-index: 9999;
}

.nav-inner {
    max-width: 1200px;
    margin: auto;
    padding: 10px 16px;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

/* LOGO */
.logo {
    height: 55px;
}

/* LINKS */
.nav-links {
    display: flex;
    align-items: center;
    gap: 14px;
}

.nav-btn {
    color: rgba(255,255,255,0.85);
    font-size: 17px;
    font-weight: 600;
    padding: 6px 12px;
    border-radius: 8px;
    transition: 0.25s;
    text-decoration: none;
    display: inline-block;
}

.nav-btn:hover {
    background: rgba(255,255,255,0.1);
}

.nav-active {
    color: #fbbf24 !important;
}

/* BUTTONS */
.login-link {
    color: white !important;
}

.signup-btn {
    background: #fbbf24;
    color: #064e3b !important;
}

.signup-btn:hover {
    background: #f59e0b; /* Slightly darker gold on hover */
}

.logout-btn {
    background: rgba(239,68,68,0.2);
    color: #fca5a5 !important;
    border: none;
    cursor: pointer;
}

.logout-btn:hover {
    background: rgba(239,68,68,0.3);
}

/* CART */
.cart-btn {
    display: flex;
    align-items: center;
    gap: 4px;
}

/* MOBILE */
.menu-btn {
    display: none;
    color: white;
    cursor: pointer;
}

.mobile-menu {
    display: none;
    flex-direction: column;
    gap: 10px;
    padding: 12px 16px;
    background: rgba(6,78,59,0.95);
}

/* RESPONSIVE */
@media(max-width: 768px){
    .nav-links {
        display: none;
    }
    .menu-btn {
        display: block;
    }
    .mobile-menu.active {
        display: flex;
    }
}
</style>

<div class="navbar">
    <div class="nav-inner">

        <a href="${pageContext.request.contextPath}/user/home">
            <img src="${pageContext.request.contextPath}/logo.png" class="logo" alt="Logo">
        </a>

        <div class="nav-links">

            <a class="nav-btn <%= currentUri.contains("home") ? "nav-active" : "" %>" href="${pageContext.request.contextPath}/user/home">Home</a>
            <a class="nav-btn <%= currentUri.contains("about") ? "nav-active" : "" %>" href="${pageContext.request.contextPath}/user/about">About</a>
            <a class="nav-btn <%= currentUri.contains("guide") ? "nav-active" : "" %>" href="${pageContext.request.contextPath}/user/guide">Guides</a>
            <a class="nav-btn <%= currentUri.contains("hotel") ? "nav-active" : "" %>" href="${pageContext.request.contextPath}/user/hotel">Hotels</a>
            <a class="nav-btn <%= currentUri.contains("adventure") ? "nav-active" : "" %>" href="${pageContext.request.contextPath}/user/adventure">Adventure</a>

            <sec:authorize access="isAuthenticated()">
                <a class="nav-btn cart-btn <%= currentUri.contains("cart") ? "nav-active" : "" %>"
                   href="${pageContext.request.contextPath}/user/cart/view">
                    <i data-lucide="shopping-cart" style="width:16px;"></i>
                </a>
                <a class="nav-btn <%= currentUri.contains("userprofile") ? "nav-active" : "" %>"
                   href="${pageContext.request.contextPath}/user/userprofile">Profile</a>

                <form action="${pageContext.request.contextPath}/logout" method="post" style="display:inline;">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="nav-btn logout-btn">Logout</button>
                </form>
            </sec:authorize>

            <sec:authorize access="!isAuthenticated()">
                <a class="nav-btn login-link" href="${pageContext.request.contextPath}/login">Login</a>
                <a class="nav-btn signup-btn" href="${pageContext.request.contextPath}/signup">Sign Up</a>
            </sec:authorize>

        </div>

        <div class="menu-btn" onclick="toggleMenu()">
            <i data-lucide="menu"></i>
        </div>

    </div>

    <div id="mobileMenu" class="mobile-menu">

        <a class="nav-btn" href="${pageContext.request.contextPath}/user/home">Home</a>
        <a class="nav-btn" href="${pageContext.request.contextPath}/user/about">About</a>
        <a class="nav-btn" href="${pageContext.request.contextPath}/user/guide">Guides</a>
        <a class="nav-btn" href="${pageContext.request.contextPath}/user/hotel">Hotels</a>
        <a class="nav-btn" href="${pageContext.request.contextPath}/user/adventure">Adventure</a>

        <sec:authorize access="!isAuthenticated()">
            <hr style="border: 0.5px solid rgba(255,255,255,0.1); width: 100%;">
            <a class="nav-btn login-link" href="${pageContext.request.contextPath}/login">Login</a>
            <a class="nav-btn signup-btn" href="${pageContext.request.contextPath}/signup" style="text-align: center;">Sign Up</a>
        </sec:authorize>

        <sec:authorize access="isAuthenticated()">
            <a class="nav-btn" href="${pageContext.request.contextPath}/user/userprofile">Profile</a>
            <form action="${pageContext.request.contextPath}/logout" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button type="submit" class="nav-btn logout-btn" style="width: 100%; text-align: left;">Logout</button>
            </form>
        </sec:authorize>

    </div>
</div>

<script>
function toggleMenu(){
    document.getElementById("mobileMenu").classList.toggle("active");
}
</script>s