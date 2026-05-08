<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | Ghumantey</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #0f766e;
            --primary-light: #14b8a6;
            --bg: #f8fafc;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --success: #166534;
            --success-bg: #dcfce7;
            --warning: #854d0e;
            --warning-bg: #fef9c3;
        }

        html, body { height: 100%; margin: 0; }
        body { 
            background: var(--bg); 
            display: flex; 
            flex-direction: column; 
            color: var(--text-main);
            font-family: "Poppins", sans-serif;
        }
        
        .page-content { flex: 1 0 auto; }

        header { 
            background: radial-gradient(circle at top right, var(--primary-light), var(--primary)); 
            color: white; padding: 60px 20px 120px; position: relative; text-align: center;
        }
        header::after { 
            content: ""; position: absolute; bottom: -1px; left: 0; width: 100%; height: 80px; 
            background: var(--bg); clip-path: polygon(0 100%, 100% 100%, 100% 0); 
        }
        
        .main-wrapper { max-width: 1100px; margin: -80px auto 40px; width: 100%; padding: 0 20px; position: relative; z-index: 10; }
        
        .content-layout { display: grid; grid-template-columns: 320px 1fr; gap: 30px; }
        @media (max-width: 900px) { .content-layout { grid-template-columns: 1fr; } }

        .profile-card { background: white; border-radius: 24px; padding: 40px 30px; box-shadow: 0 20px 50px rgba(0,0,0,0.08); text-align: center; }
        .history-section { background: white; border-radius: 24px; padding: 30px; margin-bottom: 30px; border: 1px solid #f1f5f9; }

        .table-responsive { width: 100%; overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; background: #f8fafc; padding: 12px; color: var(--text-muted); font-size: 0.75rem; text-transform: uppercase; }
        td { padding: 15px; border-bottom: 1px solid #f1f5f9; font-size: 0.9rem; }

        /* Dynamic Status Badges */
        .badge { padding: 4px 10px; border-radius: 8px; font-size: 0.7rem; font-weight: 600; text-transform: uppercase; }
        .status-paid { background: var(--success-bg); color: var(--success); }
        .status-pending { background: var(--warning-bg); color: var(--warning); }
        
        .btn { display: inline-flex; align-items: center; justify-content: center; padding: 12px; border-radius: 12px; text-decoration: none; font-weight: 600; width: 100%; margin-top: 10px; }
        .btn-primary { background: var(--primary); color: white; }
    </style>
</head>
<body>

<div class="page-content">
    <jsp:include page="navbar.jsp" />

    <header>
        <h1>Namaste, <c:out value="${user.username}" />!</h1>
        <p style="opacity: 0.8;">Your Ghumantey Travel Hub</p>
    </header>

    <div class="main-wrapper">
        <div class="content-layout">
            <aside>
                <div class="profile-card">
                    <img src="${pageContext.request.contextPath}/images/profile-default.png" style="width:100px; height:100px; border-radius:50%; margin-bottom:15px;">
                    <h3><c:out value="${user.username}" /></h3>
                    <p style="font-size: 0.8rem; color: var(--text-muted); margin-bottom: 20px;">${user.email}</p>
                    <a href="<c:url value='/home' />" class="btn btn-primary">Home</a>
                </div>
            </aside>

            <main>
                <!-- Guide Bookings Section -->
                <section class="history-section">
                    <h3 style="margin-bottom: 15px;">Your Guide Trips</h3>
                    <div class="table-responsive">
                        <table>
                            <thead><tr><th>Guide</th><th>Date</th><th>Status</th></tr></thead>
                            <tbody>
                                <c:forEach var="gb" items="${guideBookings}">
                                    <tr>
                                        <td>${gb.guide.firstname}</td>
                                        <td>${gb.bookingDate}</td>
                                        <td>
                                            <%-- Use equalsIgnoreCase and trim to ensure the check is robust --%>
                                            <span class="badge ${gb.status.trim().equalsIgnoreCase('PAID') ? 'status-paid' : 'status-pending'}">
                                                <c:out value="${gb.status}" />
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty guideBookings}">
                                    <tr><td colspan="3" style="text-align:center; color:var(--text-muted);">No trips found.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </section>

                <!-- Hotel Bookings Section -->
                <section class="history-section">
                    <h3 style="margin-bottom: 15px;">Hotel Stays</h3>
                    <div class="table-responsive">
                        <table>
                            <thead><tr><th>Hotel</th><th>Check Out</th><th>Status</th></tr></thead>
                            <tbody>
                                <c:forEach var="hb" items="${hotelBookings}">
                                    <tr>
                                        <td>${hb.hotels.hotelName}</td>
                                        <td>${hb.checkOutDate}</td>
                                        <td>
                                            <!-- Status Badge Logic in Dashboard -->
                                          <span class="badge ${hb.status.trim().equalsIgnoreCase('PAID') ? 'status-paid' : 'status-pending'}">
                                              <c:out value="${hb.status}" />
                                                </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty hotelBookings}">
                                    <tr><td colspan="3" style="text-align:center; color:var(--text-muted);">No stays found.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </section>
            </main>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

</body>
</html>