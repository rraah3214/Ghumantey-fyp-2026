<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guide Dashbord | Ghumantey</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background: #f0f4f8; font-family: 'Inter', sans-serif; color: #2d3748; }
        .nav-modern { background: #1a202c; padding: 1rem 0; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        
        .glass-card { 
            background: rgba(255, 255, 255, 0.95); 
            border-radius: 20px; 
            border: 1px solid rgba(255,255,255,0.4);
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.07);
        }

        .profile-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 20px 20px 0 0;
            height: 100px;
        }

        .profile-img {
            width: 110px; height: 110px;
            margin-top: -55px;
            border: 5px solid #fff;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .booking-item {
            background: #fff;
            border-radius: 15px;
            border-left: 6px solid #667eea;
            transition: all 0.3s ease;
            position: relative;
        }
        .booking-item.status-accepted { border-left-color: #48bb78; }
        .booking-item.status-cancelled { border-left-color: #f56565; opacity: 0.8; }
        
        .booking-item:hover { transform: translateX(5px); box-shadow: 0 5px 15px rgba(0,0,0,0.05); }

        .stat-pill { background: #f7fafc; border-radius: 12px; padding: 10px 15px; border: 1px solid #edf2f7; }
        .btn-action { border-radius: 10px; font-weight: 600; padding: 8px 20px; transition: all 0.2s; }
        
        .badge-status { font-size: 0.75rem; letter-spacing: 0.5px; }
    </style>
</head>
<body>

<nav class="nav-modern mb-5">
    <div class="container d-flex justify-content-between align-items-center">
        <a class="navbar-brand fw-bold text-white fs-4" href="#"><i class="fa-solid fa-mountain-sun me-2"></i>GHUMANTEY</a>
        <div class="d-flex align-items-center gap-3">
            <span class="text-white-50 d-none d-md-block">Welcome back, ${guide.firstname}!</span>
            <a href="/logout" class="btn btn-outline-light btn-sm rounded-pill px-4">Logout</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row g-4">
        <!-- Profile Sidebar -->
        <div class="col-lg-4">
            <div class="glass-card text-center pb-4 sticky-top" style="top: 20px;">
                <div class="profile-header"></div>
                <img src="https://ui-avatars.com/api/?name=${guide.firstname}+${guide.lastname}&background=667eea&color=fff&size=128" class="rounded-circle profile-img mb-3">
                <h4 class="fw-bold mb-0">${guide.firstname} ${guide.lastname}</h4>
                <p class="text-muted small">${guide.email}</p>
                
                <div class="px-4 mt-4 text-start">
                    <div class="d-flex align-items-center mb-3">
                        <i class="fa-solid fa-location-dot text-primary me-3" style="width: 20px;"></i>
                        <span>${guide.address}</span>
                    </div>
                    <div class="d-flex align-items-center mb-3">
                        <i class="fa-solid fa-phone text-primary me-3" style="width: 20px;"></i>
                        <span>+977 ${guide.number}</span>
                    </div>
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-tag text-primary me-3" style="width: 20px;"></i>
                        <span class="fw-bold text-success">Rs. ${guide.price} / day</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="col-lg-8">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="fw-bold m-0">Recent Bookings</h3>
                <span class="badge bg-primary rounded-pill px-3 py-2">${notifyCount} Total Requests</span>
            </div>

            <c:choose>
                <c:when test="${not empty notificationsList}">
                    <c:forEach var="booking" items="${notificationsList}">
                        <div class="booking-item p-4 mb-3 shadow-sm 
                            ${booking.status == 'ACCEPTED' ? 'status-accepted' : ''} 
                            ${booking.status == 'CANCELLED' ? 'status-cancelled' : ''}">
                            
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <div>
                                    <h5 class="fw-bold mb-1">Traveler: ${booking.user.firstname} ${booking.user.lastname}</h5>
                                    <div class="d-flex gap-2">
                                        <span class="badge rounded-pill badge-status 
                                            ${booking.status == 'PAID' ? 'bg-warning text-dark' : ''}
                                            ${booking.status == 'ACCEPTED' ? 'bg-success' : ''}
                                            ${booking.status == 'CANCELLED' ? 'bg-danger' : ''}">
                                            <i class="fa-solid ${booking.status == 'PAID' ? 'fa-clock' : (booking.status == 'ACCEPTED' ? 'fa-check' : 'fa-xmark')} me-1"></i>
                                            ${booking.status}
                                        </span>
                                        <small class="text-muted"><i class="fa-solid fa-phone-volume me-1"></i> ${booking.user.number}</small>
                                    </div>
                                </div>
                                <div class="text-end">
                                    <small class="text-muted d-block text-uppercase fw-bold" style="font-size: 0.7rem;">Tour Date</small>
                                    <span class="fw-bold text-dark"><i class="fa-regular fa-calendar-check me-1 text-primary"></i> ${booking.bookingDate}</span>
                                </div>
                            </div>

                            <div class="d-flex justify-content-between align-items-center">
                                <div class="d-flex gap-3">
                                    <div class="stat-pill">
                                        <small class="text-muted d-block">Booking ID</small>
                                        <span class="fw-bold text-dark">#GH-${booking.id}</span>
                                    </div>
                                    <div class="stat-pill">
                                        <small class="text-muted d-block">Total Paid</small>
                                        <span class="fw-bold text-success">Rs. ${booking.amount}</span>
                                    </div>
                                </div>

                                <!-- Dynamic Action Buttons -->
                                <div class="d-flex gap-2">
                                    <c:choose>
                                        <c:when test="${booking.status == 'PAID'}">
                                            <form action="/admin/guide/updateStatus" method="POST" class="m-0">
                                                <input type="hidden" name="id" value="${booking.id}">
                                                <button name="status" value="ACCEPTED" class="btn btn-primary btn-action shadow-sm">
                                                    <i class="fa-solid fa-check me-1"></i> Accept
                                                </button>
                                                <button name="status" value="CANCELLED" class="btn btn-outline-danger btn-action">
                                                    Decline
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:when test="${booking.status == 'ACCEPTED'}">
                                            <span class="text-success fw-bold p-2"><i class="fa-solid fa-circle-check"></i> Booking Confirmed</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted fw-bold p-2">Processed</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="glass-card p-5 text-center">
                        <div class="mb-4">
                            <i class="fa-solid fa-umbrella-beach fa-4x text-light"></i>
                        </div>
                        <h4 class="fw-bold">No Active Bookings</h4>
                        <p class="text-muted px-md-5">Travelers haven't sent any requests yet. Make sure your profile details and daily rate are competitive!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>