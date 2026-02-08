<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hotel Dashboard</title>

<style>
    body {
        margin: 0;
        font-family: Arial, Helvetica, sans-serif;
        background: #f5f7fa;
    }

    .navbar {
        background: #1abc9c;
        padding: 15px 30px;
        color: white;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .navbar h2 {
        margin: 0;
    }

    .navbar a {
        color: white;
        text-decoration: none;
        margin-left: 20px;
        font-weight: bold;
    }

    .container {
        padding: 30px;
    }

    .cards {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-top: 20px;
    }

    .card {
        background: white;
        padding: 25px;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        transition: transform 0.3s;
    }

    .card:hover {
        transform: translateY(-5px);
    }

    .card h3 {
        margin-top: 0;
        color: #2c3e50;
    }

    .card p {
        color: #555;
    }

    .btn {
        display: inline-block;
        margin-top: 10px;
        padding: 10px 15px;
        background: #16a085;
        color: white;
        border-radius: 5px;
        text-decoration: none;
        font-size: 14px;
    }

    .btn:hover {
        background: #138d75;
    }
</style>
</head>

<body>

<div class="navbar">
    <h2>Ghumantey | Hotel Dashboard</h2>
    <div>
        <a href="${pageContext.request.contextPath}/profile">Profile</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</div>

<div class="container">
    <h1>Welcome, Hotel Partner 🏨</h1>
    <p>Manage your hotel, rooms, and bookings.</p>

    <div class="cards">

        <div class="card">
            <h3>Hotel Profile</h3>
            <p>Update hotel details, images, and description.</p>
            <a href="#" class="btn">Edit Profile</a>
        </div>

        <div class="card">
            <h3>Rooms</h3>
            <p>Add, update, or remove rooms and pricing.</p>
            <a href="#" class="btn">Manage Rooms</a>
        </div>

        <div class="card">
            <h3>Bookings</h3>
            <p>View and manage guest reservations.</p>
            <a href="#" class="btn">View Bookings</a>
        </div>

        <div class="card">
            <h3>Payments</h3>
            <p>Track payments and booking history.</p>
            <a href="#" class="btn">View Payments</a>
        </div>

    </div>
</div>

</body>
</html>
