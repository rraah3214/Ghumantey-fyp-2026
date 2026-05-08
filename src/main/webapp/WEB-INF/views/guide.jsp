<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ghumantey • Find Your Expert Local Guide</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700;800&family=Syne:wght@700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #fbfcfd; }
        .guide-card { transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275); }
        .guide-card:hover { transform: translateY(-8px); box-shadow: 0 20px 40px -12px rgba(0, 0, 0, 0.08); }
        #bookingModal { transition: visibility 0s, opacity 0.3s linear; z-index: 100; }
        .modal-hidden { visibility: hidden; opacity: 0; pointer-events: none; }
        .modal-visible { visibility: visible; opacity: 1; pointer-events: auto; }
        .modal-content { transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1); transform: scale(0.9); }
        .modal-visible .modal-content { transform: scale(1); }
    </style>
</head>
<body class="antialiased text-slate-900 flex flex-col min-h-screen">

    <%@ include file="navbar.jsp" %>

    <main class="max-w-7xl mx-auto px-6 pt-40 pb-24 flex-grow">
        
        <!-- Header Section -->
        <div class="max-w-3xl mb-12">
            <h1 class="text-4xl font-extrabold text-slate-900 mb-6 leading-tight" style="font-family: 'Syne';">
                Professional <span class="text-emerald-600">Local Experts</span>
            </h1>
            
            <!-- Search Form -->
            <form action="${pageContext.request.contextPath}/search" method="get" class="relative group mb-8">
                <input type="text" name="search" value="${param.search}" placeholder="Search by name, location, or license..." 
                       class="w-full pl-12 pr-32 py-4 rounded-2xl border border-slate-200 focus:border-emerald-500 outline-none shadow-sm transition-all text-base">
                <i data-lucide="search" class="absolute left-5 top-1/2 -translate-y-1/2 text-slate-400 w-4 h-4"></i>
                <button type="submit" class="absolute right-2 top-2 bottom-2 px-5 bg-emerald-600 text-white rounded-xl font-bold hover:bg-emerald-700 transition-colors text-sm">Search</button>
            </form>

            <!-- Guide Upload Section -->
            <sec:authorize access="hasAnyAuthority('GUIDE', 'ROLE_GUIDE')">
                <div class="bg-white p-6 rounded-[2rem] border border-emerald-100 shadow-sm mb-12">
                    <div class="flex items-center gap-3 mb-4">
                        <div class="p-2 bg-emerald-50 rounded-lg">
                            <i data-lucide="camera" class="w-5 h-5 text-emerald-600"></i>
                        </div>
                        <h2 class="text-lg font-bold text-slate-800">Update Profile Photo</h2>
                    </div>
                    <form action="${pageContext.request.contextPath}/guide/upload-profile" method="post" enctype="multipart/form-data" class="flex flex-col sm:flex-row gap-4">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <input type="file" name="photoFile" accept="image/png, image/jpeg" required 
                               class="block w-full text-sm text-slate-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-emerald-50 file:text-emerald-700 hover:file:bg-emerald-100 cursor-pointer border border-slate-100 rounded-xl p-2">
                        <button type="submit" class="bg-slate-900 text-white px-6 py-2 rounded-xl font-bold hover:bg-slate-800 transition-all text-sm whitespace-nowrap">
                            Upload Now
                        </button>
                    </form>
                    <p class="text-[10px] text-slate-400 mt-2 ml-2 uppercase font-bold tracking-wider italic">Recommended: Square JPG or PNG, max 5MB</p>
                </div>
            </sec:authorize>
        </div>

        <!-- Guides Grid -->
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
            <c:choose>
                <c:when test="${not empty guides}">
                    <c:forEach var="g" items="${guides}">
                        <div class="guide-card bg-white rounded-[1.8rem] p-1.5 border border-slate-100 shadow-sm flex flex-col h-full">
                            
                            <!-- Profile Image -->
                            <div class="relative overflow-hidden rounded-[1.5rem] h-52 mb-4 group">
                                <c:choose>
                                    <c:when test="${not empty g.photo}">
                                        <img src="${pageContext.request.contextPath}/uploads/guides/${g.photo}" 
                                             class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110" 
                                             alt="${g.firstname}"
                                             onerror="this.onerror=null; this.src='https://ui-avatars.com/api/?name=${g.firstname}+${g.lastname}&background=064e3b&color=fff&size=512'">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://ui-avatars.com/api/?name=${g.firstname}+${g.lastname}&background=064e3b&color=fff&size=512" class="w-full h-full object-cover" alt="Guide Avatar">
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${not empty g.licenseNo}">
                                    <div class="absolute top-3 right-3 bg-white/90 backdrop-blur-md px-2 py-1 rounded-lg shadow-sm flex items-center gap-1.5 border border-emerald-100">
                                        <i data-lucide="shield-check" class="w-3.5 h-3.5 text-emerald-600"></i>
                                        <span class="text-[9px] font-black text-slate-700 uppercase tracking-tighter">Verified</span>
                                    </div>
                                </c:if>
                            </div>

                            <div class="px-4 pb-1 text-center flex-grow">
                                <h3 class="text-lg font-bold text-slate-800">${g.firstname} ${g.lastname}</h3>
                                <p class="text-[10px] text-slate-400 font-bold tracking-widest uppercase mb-1">
                                    <c:out value="${not empty g.licenseNo ? g.licenseNo : 'Certified Guide'}" />
                                </p>
                                
                                <!-- Location -->
                                <c:choose>
                                    <c:when test="${not empty g.address}">
                                        <p class="text-emerald-600 text-[11px] font-bold mb-2 uppercase tracking-wide"> ${g.address}</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-slate-400 text-[11px] font-medium italic mb-2">Location Independent</p>
                                    </c:otherwise>
                                </c:choose>

                                <!-- Contact Information -->
                                <div class="flex flex-col gap-1 mb-4 items-center border-t border-slate-50 pt-3">
                                    <c:if test="${not empty g.number}">
                                        <div class="flex items-center gap-2 text-slate-600">
                                            <i data-lucide="phone" class="w-3 h-3 text-emerald-500"></i>
                                            <span class="text-[11px] font-medium">${g.number}</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty g.email}">
                                        <div class="flex items-center gap-2 text-slate-600">
                                            <i data-lucide="mail" class="w-3 h-3 text-emerald-500"></i>
                                            <span class="text-[11px] font-medium truncate max-w-[160px]">${g.email}</span>
                                        </div>
                                    </c:if>
                                </div>

                                <!-- Daily Rate -->
                                <div class="bg-slate-50 rounded-xl p-2 mb-4 flex justify-between items-center px-3">
                                    <span class="text-[9px] font-bold text-slate-400 uppercase">Daily Rate</span>
                                    <span class="text-sm font-black text-slate-900">NPR ${g.price}</span>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="px-4 pb-5">
                                <sec:authorize access="isAuthenticated()">
                                    <button onclick="openBookingModal('${g.firstname} ${g.lastname}', '${g.id}', '${g.price}')" 
                                            class="w-full py-3 bg-emerald-600 text-white rounded-xl font-bold shadow-md hover:bg-emerald-700 active:scale-95 transition-all text-sm">
                                        Select Guide
                                    </button>
                                </sec:authorize>
                                <sec:authorize access="isAnonymous()">
                                    <a href="${pageContext.request.contextPath}/login" 
                                       class="w-full py-3 bg-slate-800 text-white rounded-xl font-bold flex items-center justify-center gap-2 hover:bg-slate-700 transition-all text-sm">
                                        <i data-lucide="lock" class="w-4 h-4"></i>
                                        Login to Book
                                    </a>
                                </sec:authorize>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-span-full py-20 text-center">
                        <i data-lucide="search-x" class="w-16 h-16 text-slate-300 mx-auto mb-4"></i>
                        <p class="text-xl font-bold text-slate-400">No guides found for "${param.search}"</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <!-- Booking Modal -->
    <div id="bookingModal" class="fixed inset-0 flex items-center justify-center bg-slate-900/60 backdrop-blur-sm modal-hidden p-4">
        <div class="modal-content bg-white rounded-[2.5rem] p-8 md:p-10 max-w-lg w-full shadow-2xl relative">
            <button onclick="closeModal()" class="absolute top-6 right-6 text-slate-400 hover:text-slate-600 transition-colors">
                <i data-lucide="x" class="w-6 h-6"></i>
            </button>
            <div class="text-center mb-6">
                <h2 class="text-2xl font-extrabold text-slate-900" style="font-family: 'Syne';">Trip Planning</h2>
                <p class="text-slate-500 mt-2 text-sm">Booking with: <span id="displayGuideName" class="font-bold text-emerald-600"></span></p>
            </div>
            <form action="${pageContext.request.contextPath}/user/cart/add" method="post" class="space-y-4">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" id="modalGuideId" name="itemId">
                <input type="hidden" id="modalGuideName" name="itemName">
                <input type="hidden" name="itemType" value="GUIDE">
                <input type="hidden" id="dailyRate" name="price">
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-[10px] font-black text-slate-400 uppercase tracking-widest mb-1 ml-1">Start Date</label>
                        <input type="date" id="startDate" name="startDate" required class="w-full px-4 py-3 rounded-xl border-2 border-slate-100 focus:border-emerald-500 outline-none text-sm font-semibold">
                    </div>
                    <div>
                        <label class="block text-[10px] font-black text-slate-400 uppercase tracking-widest mb-1 ml-1">End Date</label>
                        <input type="date" id="endDate" name="endDate" required class="w-full px-4 py-3 rounded-xl border-2 border-slate-100 focus:border-emerald-500 outline-none text-sm font-semibold">
                    </div>
                </div>
                <div>
                    <label class="block text-[10px] font-black text-slate-400 uppercase tracking-widest mb-1 ml-1">Meeting Time (Optional)</label>
                    <input type="time" name="meetingTime" class="w-full px-4 py-3 rounded-xl border-2 border-slate-100 focus:border-emerald-500 outline-none text-sm font-semibold">
                </div>
                <div class="bg-emerald-50 p-4 rounded-2xl flex justify-between items-center border border-emerald-100">
                    <span class="text-xs font-bold text-emerald-800 uppercase">Estimated Total</span>
                    <span id="totalDisplay" class="text-xl font-black text-emerald-900">NPR 0</span>
                </div>
                <div class="pt-4">
                    <button type="submit" class="w-full py-4 bg-emerald-600 text-white rounded-2xl font-bold shadow-lg hover:bg-emerald-700 transition-all flex items-center justify-center gap-3 active:scale-95 text-lg">
                        <i data-lucide="shopping-cart" class="w-6 h-6"></i> Add to Journey Cart
                    </button>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

    <script>
        lucide.createIcons();
        const startDateInput = document.getElementById('startDate');
        const endDateInput = document.getElementById('endDate');
        const today = new Date().toISOString().split('T')[0];
        startDateInput.setAttribute('min', today);
        endDateInput.setAttribute('min', today);

        function openBookingModal(guideName, guideId, price) {
            document.getElementById('displayGuideName').innerText = guideName;
            document.getElementById('modalGuideName').value = guideName;
            document.getElementById('modalGuideId').value = guideId;
            document.getElementById('dailyRate').value = price;
            document.getElementById('bookingModal').classList.remove('modal-hidden');
            document.getElementById('bookingModal').classList.add('modal-visible');
            document.body.style.overflow = 'hidden';
            calculateTotal();
        }

        function closeModal() {
            document.getElementById('bookingModal').classList.remove('modal-visible');
            document.getElementById('bookingModal').classList.add('modal-hidden');
            document.body.style.overflow = 'auto';
        }

        function calculateTotal() {
            const start = new Date(startDateInput.value);
            const end = new Date(endDateInput.value);
            const rate = parseFloat(document.getElementById('dailyRate').value) || 0;
            if (startDateInput.value && endDateInput.value && end >= start) {
                const diffTime = Math.abs(end - start);
                const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1; 
                const total = diffDays * rate;
                document.getElementById('totalDisplay').innerText = "NPR " + total;
            } else {
                document.getElementById('totalDisplay').innerText = "NPR 0";
            }
        }

        startDateInput.addEventListener('change', () => {
            endDateInput.setAttribute('min', startDateInput.value);
            calculateTotal();
        });
        endDateInput.addEventListener('change', calculateTotal);
        window.onclick = (e) => { if (e.target == document.getElementById('bookingModal')) closeModal(); }
    </script>
</body>
</html>