<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Ghumantey | Admin Dashbord</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root { --primary-green: #10b981; --sidebar-bg: #064e3b; --primary-blue: #3b82f6; --primary-info: #0dcaf0; --primary-warning: #f59e0b; --primary-purple: #8b5cf6; --primary-secondary: #6c757d; --primary-orange: #f97316;}
        body { background: #f8fafc; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .app-sidebar { background: var(--sidebar-bg); color: #fff; min-height: 100vh; position: fixed; width: 250px; padding: 2rem 1rem; z-index: 1000; }
        .nav-link-sidebar { color: rgba(255,255,255,.8); padding: 0.8rem; display: block; text-decoration: none; border-radius: 8px; transition: 0.3s; cursor: pointer; }
        .nav-link-sidebar:hover { background: rgba(255,255,255,0.1); color: #fff; }
        .nav-link-sidebar.active { background: var(--primary-green); color: #fff; }
        .tab-section { display: none; }
        main { margin-left: 260px; padding: 2rem; }
        .badge-approved { background-color: #10b981; color: #fff; }
        .badge-pending { background-color: #f59e0b; color: #fff; }
        .badge-rejected { background-color: #ef4444; color: #fff; }
        .badge-role { background-color: #6366f1; color: #fff; }
        .badge-paid { background-color: #10b981; color: #fff; }
        .text-truncate-custom { max-width: 150px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .img-preview-sm { width: 45px; height: 45px; object-fit: cover; border-radius: 8px; border: 1px solid #dee2e6; }
    </style>
</head>
<body>

<aside class="app-sidebar">
    <div class="text-center mb-4">
        <h4 class="fw-bold">GHUMANTEY</h4>
        <small class="opacity-50">ADMIN PORTAL</small>
    </div>
    <nav>
        <a class="nav-link-sidebar active" id="side-dash" onclick="showTab('guides')"><i class="fa fa-home me-2"></i> Dashbord</a>
        <a class="nav-link-sidebar" id="side-stats" onclick="showTab('statistics')"><i class="fa fa-chart-line me-2"></i> Statistic Data</a>
        <a class="nav-link-sidebar text-danger mt-5" href="${pageContext.request.contextPath}/logout"><i class="fa fa-power-off me-2"></i> Logout</a>
    </nav>
</aside>

<main>
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm" role="alert">
            <i class="fa fa-check-circle me-2"></i> ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm" role="alert">
            <i class="fa fa-exclamation-triangle me-2"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <section id="section-statistics" class="tab-section">
        <div class="row g-4 mb-4">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm p-4 h-100">
                    <h6 class="fw-bold text-muted mb-3"><i class="fa fa-chart-bar me-2"></i>Revenue Comparison (NPR)</h6>
                    <div style="height: 350px;"><canvas id="revenueChart"></canvas></div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm p-4 h-100">
                    <h6 class="fw-bold text-muted mb-3"><i class="fa fa-chart-pie me-2"></i>Booking Volume</h6>
                    <div style="height: 350px;"><canvas id="bookingPieChart"></canvas></div>
                </div>
            </div>
        </div>
    </section>

    <div id="btn-group-card" class="card p-3 mb-4 shadow-sm border-0">
        <div class="d-flex gap-2 flex-wrap">
            <button id="btn-guides" class="btn btn-outline-success px-4" onclick="showTab('guides')">Guides</button>
            <button id="btn-hotels" class="btn btn-outline-primary px-4" onclick="showTab('hotels')">Hotels</button>
            <button id="btn-adventures" class="btn btn-outline-purple px-4" onclick="showTab('adventures')">Adventures</button>
            <button id="btn-users" class="btn btn-outline-info px-4" onclick="showTab('users')">User Details</button>
            <button id="btn-guide-bookings" class="btn btn-outline-warning px-4" onclick="showTab('guide-bookings')">Guide Bookings</button>
            <button id="btn-hotel-bookings" class="btn btn-outline-secondary px-4" onclick="showTab('hotel-bookings')">Hotel Bookings</button>
            <button id="btn-adventure-bookings" class="btn btn-outline-orange px-4" onclick="showTab('adventure-bookings')">Adventure Bookings</button>
        </div>
    </div>

    <%-- 2. Guides Section --%>
    <section id="section-guides" class="tab-section">
        <div class="card p-4 mb-4 border-0 shadow-sm border-top border-4 border-success">
            <h5 class="fw-bold mb-4 text-success">
                <i class="fa ${empty guideToEdit ? 'fa-plus' : 'fa-edit'} me-2"></i>
                ${empty guideToEdit ? 'Add New Guide' : 'Edit Guide Details'}
            </h5>
            
            <form action="${not empty guideToEdit ? pageContext.request.contextPath.concat('/admin/guide/update') : pageContext.request.contextPath.concat('/admin/guide/add')}" 
                  method="post" enctype="multipart/form-data">
                
                <c:if test="${not empty guideToEdit}">
                    <input type="hidden" name="id" value="${guideToEdit.id}">
                    <input type="hidden" name="photo" value="${guideToEdit.photo}">
                </c:if>

                <div class="row g-3">
                    <div class="col-md-6"><label class="small fw-bold">First Name</label><input name="firstname" class="form-control" value="${guideToEdit.firstname}" required></div>
                    <div class="col-md-6"><label class="small fw-bold">Last Name</label><input name="lastname" class="form-control" value="${guideToEdit.lastname}" required></div>
                    <div class="col-md-6"><label class="small fw-bold">License Number</label><input name="licenseNo" class="form-control" value="${guideToEdit.licenseNo}" required></div>
                    <div class="col-md-6"><label class="small fw-bold">Email Address</label><input name="email" type="email" class="form-control" value="${guideToEdit.email}" required></div>
                    <div class="col-md-6"><label class="small fw-bold">Home Address</label><input name="address" class="form-control" value="${guideToEdit.address}" required></div>
                    <div class="col-md-3"><label class="small fw-bold">Price / Day (NPR)</label><input name="price" type="number" step="0.01" class="form-control" value="${guideToEdit.price}" required></div>
                    <div class="col-md-3"><label class="small fw-bold">Contact Number</label><input name="number" type="number" class="form-control" value="${guideToEdit.number}" required></div>
                    <div class="col-md-4">
                        <label class="small fw-bold">Status</label>
                        <select name="status" class="form-select" required>
                            <option value="PENDING" ${guideToEdit.status eq 'PENDING' ? 'selected' : ''}>PENDING</option>
                            <option value="APPROVED" ${guideToEdit.status eq 'APPROVED' ? 'selected' : ''}>APPROVED</option>
                            <option value="REJECTED" ${guideToEdit.status eq 'REJECTED' ? 'selected' : ''}>REJECTED</option>
                        </select>
                    </div>
                    <div class="col-md-8">
                        <label class="small fw-bold">Upload Photo</label>
                        <input type="file" name="photoFile" class="form-control" accept="image/*">
                        <c:if test="${not empty guideToEdit.photo}">
                           <div class="mt-2 d-flex align-items-center gap-2">
                               <img src="${pageContext.request.contextPath}/uploads/guides/${guideToEdit.photo}" class="img-preview-sm" style="width:30px; height:30px;">
                               <small class="text-muted">Current: ${guideToEdit.photo}</small>
                           </div>
                        </c:if>
                    </div>
                    
                    <div class="col-md-12">
                        <label class="small fw-bold text-success">Owner User ID</label>
                        <input name="user_id" type="number" class="form-control" value="${guideToEdit.userDetails.id}" placeholder="Enter ID from User Table" required ${not empty guideToEdit ? 'readonly' : ''}>
                    </div>
                </div>
                
                <div class="mt-4">
                    <button type="submit" class="btn btn-success px-4 rounded-pill">
                        ${empty guideToEdit ? 'Save Guide' : 'Update Guide'}
                    </button>
                    <c:if test="${not empty guideToEdit}">
                        <a href="${pageContext.request.contextPath}/admin/dashbord?activeTab=guides" class="btn btn-outline-secondary px-4 rounded-pill ms-2">Cancel</a>
                    </c:if>
                </div>
            </form>
        </div>

        <div class="card p-3 border-0 shadow-sm">
            <table class="table table-hover align-middle">
                <thead><tr><th>Preview</th><th>ID</th><th>Guide Name</th><th>License No</th><th>Price</th><th>Status</th><th>Action</th></tr></thead>
                <tbody>
                    <c:forEach var="g" items="${guides}">
                        <tr>
                            <td>
                                <img src="${pageContext.request.contextPath}/uploads/guides/${g.photo}" 
                                     class="img-preview-sm" 
                                     onerror="this.src='https://ui-avatars.com/api/?name=${g.firstname}+${g.lastname}&background=random'">
                            </td>
                            <td>#${g.id}</td>
                            <td>${g.firstname} ${g.lastname}</td>
                            <td><span class="badge bg-light text-dark border">${g.licenseNo}</span></td>
                            <td>NPR ${g.price}</td>
                            <td><span class="badge ${g.status eq 'APPROVED' ? 'badge-approved' : (g.status eq 'REJECTED' ? 'badge-rejected' : 'badge-pending')}">${g.status}</span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/guide/edit/${g.id}" class="btn btn-sm btn-light text-primary me-2"><i class="fa fa-edit"></i></a>
                                <a href="${pageContext.request.contextPath}/admin/guide/delete/${g.id}" class="btn btn-sm btn-light text-danger" onclick="return confirm('Delete guide?')"><i class="fa fa-trash"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>

    <%-- 3. Hotels Section --%>
    <section id="section-hotels" class="tab-section">
        <div class="card p-4 mb-4 border-0 shadow-sm border-top border-4 border-primary">
            <h5 class="fw-bold mb-4 text-primary"><i class="fa ${empty hotelToEdit ? 'fa-hotel' : 'fa-edit'} me-2"></i> ${empty hotelToEdit ? 'Add New Hotel' : 'Edit Hotel Details'}</h5>
            
            <form action="${not empty hotelToEdit ? pageContext.request.contextPath.concat('/admin/hotel/update') : pageContext.request.contextPath.concat('/admin/hotel/add')}" 
                  method="post" enctype="multipart/form-data">
                
                <c:if test="${not empty hotelToEdit}">
                    <input type="hidden" name="id" value="${hotelToEdit.id}">
                    <input type="hidden" name="image" value="${hotelToEdit.image}">
                </c:if>

                <div class="row g-3">
                    <div class="col-md-6"><label class="small fw-bold">Hotel Name</label><input name="hotelName" class="form-control" value="${hotelToEdit.hotelName}" required></div>
                    <div class="col-md-6"><label class="small fw-bold">Location</label><input name="location" class="form-control" value="${hotelToEdit.location}" required></div>
                    <div class="col-md-4"><label class="small fw-bold">Price / Night (NPR)</label><input name="price" type="number" step="0.01" class="form-control" value="${hotelToEdit.price}" required></div>
                    <div class="col-md-4"><label class="small fw-bold">Contact Number</label><input name="phoneNumber" class="form-control" value="${hotelToEdit.phoneNumber}" required></div>
                    
                    <div class="col-md-4">
                        <label class="small fw-bold">Status</label>
                        <select name="status" class="form-select" required>
                            <option value="PENDING" ${hotelToEdit.status eq 'PENDING' ? 'selected' : ''}>PENDING</option>
                            <option value="APPROVED" ${hotelToEdit.status eq 'APPROVED' ? 'selected' : ''}>APPROVED</option>
                        </select>
                    </div>

                    <div class="col-md-12">
                        <label class="small fw-bold">Hotel Photo</label>
                        <input type="file" name="imageFile" class="form-control" accept="image/*">
                        <c:if test="${not empty hotelToEdit.image}">
                           <div class="mt-2 d-flex align-items-center gap-2">
                               <img src="${pageContext.request.contextPath}/uploads/hotels/${hotelToEdit.image}" class="img-preview-sm" style="width:30px; height:30px;">
                               <small class="text-muted">Current: ${hotelToEdit.image}</small>
                           </div>
                        </c:if>
                    </div>

                    <div class="col-md-12"><label class="small fw-bold text-primary">Owner ID</label><input name="user_id" type="number" class="form-control" value="${hotelToEdit.user.id}" ${not empty hotelToEdit ? 'readonly' : ''} required></div>
                    <div class="col-md-12"><label class="small fw-bold">Description</label><textarea name="description" class="form-control" rows="3" required>${hotelToEdit.description}</textarea></div>
                </div>
                <button type="submit" class="btn btn-primary mt-4 px-4 rounded-pill">${empty hotelToEdit ? 'Save Hotel' : 'Update Hotel'}</button>
                <c:if test="${not empty hotelToEdit}">
                    <a href="${pageContext.request.contextPath}/admin/dashbord?activeTab=hotels" class="btn btn-outline-secondary mt-4 px-4 rounded-pill ms-2">Cancel</a>
                </c:if>
            </form>
        </div>
        <div class="card p-3 border-0 shadow-sm">
            <table class="table table-hover align-middle">
                <thead><tr><th>Preview</th><th>Hotel</th><th>Location</th><th>Contact</th><th>Price</th><th>Status</th><th>Action</th></tr></thead>
                <tbody>
                    <c:forEach var="h" items="${hotels}">
                        <tr>
                            <td>
                                <img src="${pageContext.request.contextPath}/uploads/hotels/${h.image}" 
                                     class="img-preview-sm" 
                                     onerror="this.src='https://placehold.co/100x100?text=Hotel'">
                            </td>
                            <td class="fw-bold">${h.hotelName}</td>
                            <td>${h.location}</td>
                            <td><small class="text-muted"><i class="fa fa-phone me-1"></i>${h.phoneNumber}</small></td>
                            <td>NPR ${h.price}</td>
                            <td><span class="badge ${h.status eq 'APPROVED' ? 'badge-approved' : 'badge-pending'}">${h.status}</span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/hotel/edit/${h.id}" class="btn btn-sm btn-light text-primary me-2"><i class="fa fa-edit"></i></a>
                                <a href="${pageContext.request.contextPath}/admin/hotel/delete/${h.id}" class="btn btn-sm btn-light text-danger" onclick="return confirm('Delete Hotel?')"><i class="fa fa-trash"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>

    <%-- 4. Adventures Section --%>
    <section id="section-adventures" class="tab-section">
        <div class="card p-4 mb-4 border-0 shadow-sm border-top border-4" style="border-top-color: var(--primary-purple) !important;">
            <h5 class="fw-bold mb-4" style="color: var(--primary-purple);"><i class="fa ${empty adventureToEdit ? 'fa-mountain-sun' : 'fa-edit'} me-2"></i> ${empty adventureToEdit ? 'Add New Adventure' : 'Edit Adventure Details'}</h5>
            <form action="${not empty adventureToEdit ? pageContext.request.contextPath.concat('/admin/adventure/update') : pageContext.request.contextPath.concat('/admin/adventure/add')}" method="post">
                <c:if test="${not empty adventureToEdit}"><input type="hidden" name="id" value="${adventureToEdit.id}"></c:if>
                <div class="row g-3">
                    <div class="col-md-6"><label class="small fw-bold">Adventure Title</label><input name="title" class="form-control" value="${adventureToEdit.title}" required></div>
                    <div class="col-md-6"><label class="small fw-bold">Category</label><input name="category" class="form-control" value="${adventureToEdit.category}" required></div>
                    <div class="col-md-6"><label class="small fw-bold">Price (NPR)</label><input name="price" type="number" step="0.01" class="form-control" value="${adventureToEdit.price}" required></div>
                    <div class="col-md-6"><label class="small fw-bold">Image URL</label><input name="imageUrl" class="form-control" value="${adventureToEdit.imageUrl}" required></div>
                    <div class="col-md-12"><label class="small fw-bold">Description</label><textarea name="description" class="form-control" rows="2" required>${adventureToEdit.description}</textarea></div>
                </div>
                <button type="submit" class="btn btn-primary mt-4 px-4 rounded-pill" style="background-color: var(--primary-purple); border:none;">Save Adventure</button>
            </form>
        </div>
        <div class="card p-3 border-0 shadow-sm">
            <table class="table table-hover align-middle">
                <thead><tr><th>Preview</th><th>Title</th><th>Category</th><th>Price</th><th>Action</th></tr></thead>
                <tbody>
                    <c:forEach var="adv" items="${adventures}">
                        <tr>
                            <td><img src="${adv.imageUrl}" class="img-preview-sm" onerror="this.src='https://placehold.co/50x40?text=No+Img'"></td>
                            <td class="fw-bold">${adv.title}</td>
                            <td><span class="badge badge-role">${adv.category}</span></td>
                            <td>NPR ${adv.price}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/dashbord?activeTab=adventures&editAdventureId=${adv.id}" class="btn btn-sm btn-light text-primary me-2"><i class="fa fa-edit"></i></a>
                                <a href="${pageContext.request.contextPath}/admin/adventure/delete/${adv.id}" class="btn btn-sm btn-light text-danger" onclick="return confirm('Delete?')"><i class="fa fa-trash"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>

    <%-- 5. User Details Section --%>
    <section id="section-users" class="tab-section">
        <div class="card p-4 mb-4 border-0 shadow-sm border-top border-4 border-info">
            <h5 class="fw-bold mb-4 text-info"><i class="fa fa-users me-2"></i> Registered Users</h5>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead><tr><th>ID</th><th>Username</th><th>Email</th><th>Role</th><th>Status</th></tr></thead>
                    <tbody>
                        <c:forEach var="u" items="${users}">
                            <tr><td>#${u.id}</td><td class="fw-bold">${u.username}</td><td>${u.email}</td><td><span class="badge badge-role">${u.userRole.role}</span></td><td><span class="badge ${u.active eq '1' ? 'badge-approved' : 'badge-rejected'}">${u.active eq '1' ? 'ACTIVE' : 'INACTIVE'}</span></td></tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </section>

    <%-- 6. Booking History Sections --%>
    <section id="section-guide-bookings" class="tab-section">
        <div class="card p-4 mb-4 border-0 shadow-sm border-top border-4 border-warning">
            <h5 class="fw-bold mb-4 text-warning"><i class="fa fa-book me-2"></i> Guide Bookings</h5>
            <table class="table table-hover align-middle">
                <thead><tr><th>ID</th><th>Customer</th><th>Guide</th><th>Amount</th><th>Status</th></tr></thead>
                <tbody>
                    <c:forEach var="gb" items="${guideBookingsHistory}">
                        <tr><td>#${gb.id}</td><td>${gb.user.username}</td><td>${gb.guide.firstname}</td><td>NPR ${gb.amount}</td><td><span class="badge badge-paid">${gb.status}</span></td></tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>

    <section id="section-hotel-bookings" class="tab-section">
        <div class="card p-4 mb-4 border-0 shadow-sm border-top border-4 border-secondary">
            <h5 class="fw-bold mb-4 text-secondary"><i class="fa fa-bed me-2"></i> Hotel Reservations</h5>
            <table class="table table-hover align-middle">
                <thead><tr><th>ID</th><th>Customer</th><th>Hotel</th><th>Amount</th><th>Status</th></tr></thead>
                <tbody>
                    <c:forEach var="hb" items="${hotelBookingsHistory}">
                        <tr><td>#${hb.id}</td><td>${hb.user.username}</td><td>${hb.hotels.hotelName}</td><td>NPR ${hb.totalAmount}</td><td><span class="badge badge-paid">${hb.status}</span></td></tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>

    <section id="section-adventure-bookings" class="tab-section">
        <div class="card p-4 mb-4 border-0 shadow-sm border-top border-4" style="border-top-color: var(--primary-orange) !important;">
            <h5 class="fw-bold mb-4" style="color: var(--primary-orange);"><i class="fa fa-bolt me-2"></i> Adventure Bookings</h5>
            <table class="table table-hover align-middle">
                <thead><tr><th>ID</th><th>Customer</th><th>Adventure</th><th>Amount</th><th>Status</th></tr></thead>
                <tbody>
                    <c:forEach var="ab" items="${adventureBookingsHistory}">
                        <tr><td>#${ab.id}</td><td>${ab.user.username}</td><td>${ab.adventure.title}</td><td>NPR ${ab.amount}</td><td><span class="badge badge-paid">${ab.status}</span></td></tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let gRev = 0, hRev = 0, aRev = 0, gCount = 0, hCount = 0, aCount = 0;
    <c:forEach var="gb" items="${guideBookingsHistory}"> gRev += (${gb.amount} || 0); gCount++; </c:forEach>
    <c:forEach var="hb" items="${hotelBookingsHistory}"> hRev += (${hb.totalAmount} || 0); hCount++; </c:forEach>
    <c:forEach var="ab" items="${adventureBookingsHistory}"> aRev += (${ab.amount} || 0); aCount++; </c:forEach>

    const revCtx = document.getElementById('revenueChart').getContext('2d');
    const pieCtx = document.getElementById('bookingPieChart').getContext('2d');

    new Chart(revCtx, { type: 'bar', data: { labels: ['Guides', 'Hotels', 'Adventures'], datasets: [{ label: 'NPR', data: [gRev, hRev, aRev], backgroundColor: ['#10b981', '#3b82f6', '#f97316'], borderRadius: 5 }]}, options: { maintainAspectRatio: false, plugins: { legend: { display: false }}}});
    new Chart(pieCtx, { type: 'doughnut', data: { labels: ['Guides', 'Hotels', 'Adventures'], datasets: [{ data: [gCount, hCount, aCount], backgroundColor: ['#10b981', '#3b82f6', '#f97316'] }]}, options: { maintainAspectRatio: false }});

    function showTab(key) {
        const sections = ['statistics', 'guides', 'hotels', 'adventures', 'users', 'guide-bookings', 'hotel-bookings', 'adventure-bookings'];
        sections.forEach(s => {
            const sec = document.getElementById('section-' + s);
            if(sec) sec.style.display = (s === key) ? 'block' : 'none';
        });

        document.getElementById('side-dash').classList.toggle('active', key !== 'statistics');
        document.getElementById('side-stats').classList.toggle('active', key === 'statistics');
        document.getElementById('btn-group-card').style.display = (key === 'statistics') ? 'none' : 'block';

        if(key !== 'statistics') {
            sections.slice(1).forEach(s => {
                const btn = document.getElementById('btn-' + s);
                if(btn) {
                    let theme = (s==='hotels'?'primary':s==='adventures'?'purple':s==='users'?'info':s==='guide-bookings'?'warning':s==='hotel-bookings'?'secondary':s==='adventure-bookings'?'orange':'success');
                    btn.className = (s === key) ? `btn btn-${theme} px-4` : `btn btn-outline-${theme} px-4`;
                }
            });
        }
    }

    showTab('${activeTab}' || 'guides');
</script>
</body>
</html>