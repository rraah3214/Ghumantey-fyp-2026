<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Analytics</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-bg: #f4f7fe;
            --sidebar-color: #111c44;
            --accent-blue: #4318ff;
            --text-main: #2b3674;
            --card-white: #ffffff;
            --success: #05cd99;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: var(--primary-bg);
            display: flex;
            min-height: 100vh;
        }

        /* --- Sidebar --- */
        .sidebar {
            width: 260px;
            background-color: var(--sidebar-color);
            color: white;
            padding: 20px;
            transition: all 0.3s;
        }

        .sidebar h2 {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 40px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            padding-bottom: 20px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 15px;
            color: #a3aed0;
            text-decoration: none;
            border-radius: 12px;
            margin-bottom: 5px;
            transition: 0.2s;
        }

        .nav-link:hover, .nav-link.active {
            background: rgba(255,255,255,0.1);
            color: white;
        }

        .nav-link i {
            margin-right: 15px;
            font-size: 18px;
        }

        /* --- Main Content --- */
        .main-content {
            flex: 1;
            padding: 30px;
            overflow-y: auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .header h1 {
            color: var(--text-main);
            font-size: 28px;
        }

        /* --- Dashboard Grid --- */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            background: var(--card-white);
            padding: 20px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.05);
        }

        .icon-box {
            width: 56px;
            height: 56px;
            background: var(--primary-bg);
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 24px;
            color: var(--accent-blue);
            margin-right: 15px;
        }

        .card-info span {
            color: #a3aed0;
            font-size: 14px;
            font-weight: 600;
        }

        .card-info h3 {
            color: var(--text-main);
            font-size: 24px;
        }

        /* --- Table Styling --- */
        .table-container {
            background: white;
            padding: 25px;
            border-radius: 20px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.05);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th {
            text-align: left;
            color: #a3aed0;
            font-size: 14px;
            padding: 12px;
            border-bottom: 1px solid #e9edf7;
        }

        td {
            padding: 15px;
            color: var(--text-main);
            font-weight: 600;
            border-bottom: 1px solid #e9edf7;
        }

        .status {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
        }

        .status.completed { background: #e6f9f0; color: var(--success); }
        .status.pending { background: #fff8e6; color: #ffb547; }

    </style>
</head>
<body>

    <div class="sidebar">
        <h2>CORE ADMIN</h2>
        <a href="#" class="nav-link active"><i class="fa-solid fa-house"></i> Dashboard</a>
        <a href="#" class="nav-link"><i class="fa-solid fa-cart-shopping"></i> Marketplace</a>
        <a href="#" class="nav-link"><i class="fa-solid fa-chart-line"></i> Statistics</a>
        <a href="#" class="nav-link"><i class="fa-solid fa-user"></i> Profile</a>
        <a href="#" class="nav-link"><i class="fa-solid fa-lock"></i> Sign Out</a>
    </div>

    <div class="main-content">
        <div class="header">
            <h1>Main Dashboard</h1>
            <div class="search-bar">
                <p style="color: #707eae;">Welcome back, <strong>Admin</strong></p>
            </div>
        </div>

        <div class="stats-grid">
            <div class="card">
                <div class="icon-box"><i class="fa-solid fa-chart-simple"></i></div>
                <div class="card-info">
                    <span>Earnings</span>
                    <h3>$350.40</h3>
                </div>
            </div>
            <div class="card">
                <div class="icon-box"><i class="fa-solid fa-file-invoice-dollar"></i></div>
                <div class="card-info">
                    <span>Spend this month</span>
                    <h3>$642.39</h3>
                </div>
            </div>
            <div class="card">
                <div class="icon-box"><i class="fa-solid fa-users"></i></div>
                <div class="card-info">
                    <span>New Clients</span>
                    <h3>1,240</h3>
                </div>
            </div>
            <div class="card">
                <div class="icon-box"><i class="fa-solid fa-check-double"></i></div>
                <div class="card-info">
                    <span>Projects</span>
                    <h3>154</h3>
                </div>
            </div>
        </div>

        <div class="table-container">
            <h2 style="color: var(--text-main); margin-bottom: 10px;">Recent Transactions</h2>
            <table>
                <thead>
                    <tr>
                        <th>NAME</th>
                        <th>STATUS</th>
                        <th>DATE</th>
                        <th>PROGRESS</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Marketplace Design</td>
                        <td><span class="status completed">Approved</span></td>
                        <td>12 Jan 2024</td>
                        <td>75.5%</td>
                    </tr>
                    <tr>
                        <td>Mobile App Fix</td>
                        <td><span class="status pending">Pending</span></td>
                        <td>10 Jan 2024</td>
                        <td>24.2%</td>
                    </tr>
                    <tr>
                        <td>Admin Dashboard</td>
                        <td><span class="status completed">Approved</span></td>
                        <td>08 Jan 2024</td>
                        <td>100%</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>