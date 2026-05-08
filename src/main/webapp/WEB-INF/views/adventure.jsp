<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Adventures | Ghumantey</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;800&family=Syne:wght@800&display=swap" rel="stylesheet">

    <style>
        :root { --primary-green: #10b981; }
        body {
            background-color: #f8fafc;
            font-family: 'Plus Jakarta Sans', sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .main-content { flex: 1; }
        .adventure-card {
            border: none;
            border-radius: 24px;
            transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            overflow: hidden;
            background: #fff;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
        }
        .adventure-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 25px -5px rgba(0,0,0,0.1);
        }
        .img-container { height: 220px; position: relative; }
        .card-img-top { height: 100%; width: 100%; object-fit: cover; }
        .price-badge {
            position: absolute;
            bottom: 15px;
            right: 15px;
            background: rgba(255,255,255,0.95);
            padding: 6px 16px;
            border-radius: 50px;
            font-weight: 800;
            color: #064e3b;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .btn-cart {
            background-color: var(--primary-green);
            color: white;
            border-radius: 14px;
            padding: 12px;
            font-weight: 700;
            border: none;
            transition: all 0.3s ease;
        }
        .btn-cart:hover { background-color: #059669; transform: scale(1.02); color: white; }
    </style>
</head>

<body>
<div class="main-content">
    <jsp:include page="navbar.jsp"/>

    <div class="container py-5" style="margin-top: 80px;">
        <div class="d-flex justify-content-between align-items-end mb-5">
            <div>
                <span class="text-success fw-bold text-uppercase small tracking-widest">Explore Nepal</span>
                <h2 class="fw-bold m-0">Adventure Experiences</h2>
            </div>
        </div>

        <div class="row g-4">
            <c:forEach var="adv" items="${adventures}">
                <div class="col-lg-4 col-md-6">
                    <div class="card adventure-card h-100">
                        <div class="img-container">
                            <img src="${adv.imageUrl}" class="card-img-top" onerror="this.src='https://placehold.co/600x400?text=Adventure'">
                            <div class="price-badge">NPR ${adv.price}</div>
                        </div>
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-2">${adv.title}</h5>
                            <p class="text-muted small mb-4">${adv.description}</p>

                            <form action="${pageContext.request.contextPath}/user/cart/add" method="POST">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <input type="hidden" name="itemId" value="${adv.id}">
                                
                                <div class="mb-3">
                                    <label class="form-label text-muted small fw-bold">START DATE</label>
                                    <input type="date" name="startDate" required class="form-control form-control-sm rounded-3">
                                </div>

                                <button class="btn btn-cart w-100 d-flex align-items-center justify-content-center gap-2">
                                    <i data-lucide="shopping-cart" style="width:18px;"></i> Add to Cart
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Logic for date validation
    document.querySelectorAll('input[type="date"]').forEach(input => {
        input.min = new Date().toISOString().split('T')[0];
    });
</script>
</body>
</html>