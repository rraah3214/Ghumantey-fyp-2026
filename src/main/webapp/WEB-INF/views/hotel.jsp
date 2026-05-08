<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ghumantey | Find Your Perfect Basecamp</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700;800&family=Syne:wght@700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #f8fafc; }
        .card-hover { transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1); }
        .card-hover:hover { transform: translateY(-6px); box-shadow: 0 15px 30px rgba(0,0,0,0.06); }
        #hotelModal { transition: visibility 0s, opacity 0.3s linear; z-index: 100; }
        .modal-hidden { visibility: hidden; opacity: 0; pointer-events: none; }
        .modal-visible { visibility: visible; opacity: 1; pointer-events: auto; }
        .modal-content { transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1); transform: scale(0.95); }
        .modal-visible .modal-content { transform: scale(1); }
    </style>
</head>
<body class="antialiased text-slate-900 flex flex-col min-h-screen">

    <%@ include file="navbar.jsp" %>

    <main class="max-w-7xl mx-auto px-6 py-12 pt-40 flex-grow">
        <h1 class="text-4xl font-extrabold mb-8" style="font-family: 'Syne';">Find Your Perfect <span class="text-emerald-600">Basecamp.</span></h1>
        
        <form action="${pageContext.request.contextPath}/user/hotel" method="get" class="bg-white rounded-[2rem] p-2 shadow-lg mb-12 border border-slate-100 flex gap-2 max-w-2xl">
            <input type="text" name="search" placeholder="Search hotels by name or location..." class="flex-1 px-5 py-3 outline-none text-base">
            <button type="submit" class="bg-emerald-600 text-white px-8 py-3 rounded-[1.5rem] font-bold hover:bg-emerald-700 transition-colors text-sm">Search</button>
        </form>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach var="hotel" items="${hotels}">
                <div class="card-hover bg-white rounded-[2rem] overflow-hidden flex flex-col border border-slate-100 p-1.5">
                    <!-- UPDATED: Dynamic Image Source from Uploads -->
                    <div class="h-44 w-full bg-slate-200 rounded-[1.8rem] overflow-hidden">
                         <img src="${pageContext.request.contextPath}/uploads/hotels/${hotel.image}" 
                              class="w-full h-full object-cover" 
                              alt="${hotel.hotelName}"
                              onerror="this.src='https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800'">
                    </div>
                    
                    <div class="p-5 flex flex-col justify-between flex-grow">
                        <div>
                            <div class="flex justify-between items-start mb-1">
                                <h3 class="text-lg font-bold text-slate-800">${hotel.hotelName}</h3>
                                <div class="flex items-center gap-1 bg-amber-50 px-2 py-1 rounded-lg">
                                    <i data-lucide="star" class="w-3.5 h-3.5 fill-amber-400 text-amber-400"></i>
                                    <span class="text-xs font-bold text-amber-700">${hotel.ratings}.0</span>
                                </div>
                            </div>
                            
                            <p class="text-emerald-600 text-[11px] font-bold mb-1 uppercase tracking-wide flex items-center gap-1">
                                <i data-lucide="map-pin" class="w-3 h-3"></i> ${hotel.location}
                            </p>

                            <p class="text-slate-500 text-[11px] mb-3 flex items-center gap-1">
                                <i data-lucide="phone" class="w-3 h-3"></i> ${hotel.phoneNumber != null ? hotel.phoneNumber : 'N/A'}
                            </p>

                            <div class="bg-slate-50 rounded-xl p-2 flex justify-between items-center px-3 mb-4">
                                <span class="text-[9px] font-bold text-slate-400 uppercase">Per Night</span>
                                <span class="text-sm font-black text-slate-900">NPR ${hotel.price}</span>
                            </div>
                        </div>

                        <sec:authorize access="isAuthenticated()">
                            <button onclick="openHotelModal('${hotel.hotelName}', '${hotel.id}', '${hotel.price}')" 
                                    class="w-full bg-slate-900 text-white py-3 rounded-xl font-bold shadow-md hover:bg-slate-800 active:scale-95 transition-all text-sm">
                                Select Stay
                            </button>
                        </sec:authorize>
                        <sec:authorize access="isAnonymous()">
                            <a href="${pageContext.request.contextPath}/login" 
                               class="w-full bg-slate-800 text-white py-3 rounded-xl font-bold flex items-center justify-center gap-2 text-center hover:bg-slate-700 transition-all text-sm">
                                <i data-lucide="lock" class="w-4 h-4"></i>
                                Login to Book
                            </a>
                        </sec:authorize>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <!-- Empty State Handling -->
        <c:if test="${empty hotels}">
            <div class="text-center py-20">
                <i data-lucide="hotel" class="w-12 h-12 text-slate-300 mx-auto mb-4"></i>
                <h3 class="text-xl font-bold text-slate-400">No hotels found matching your search.</h3>
            </div>
        </c:if>
    </main>

    <!-- Modal Section remains the same as provided -->
    <div id="hotelModal" class="fixed inset-0 flex items-center justify-center bg-slate-900/60 backdrop-blur-sm modal-hidden p-4">
        <div class="modal-content bg-white rounded-[2.5rem] p-8 md:p-10 max-w-lg w-full shadow-2xl relative">
            <button onclick="closeModal()" class="absolute top-6 right-6 text-slate-400 hover:text-slate-600 transition-colors">
                <i data-lucide="x" class="w-6 h-6"></i>
            </button>
            <div class="text-center mb-8">
                <h2 class="text-2xl font-extrabold text-slate-900" style="font-family: 'Syne';">Journey Planning</h2>
                <p class="text-slate-500 mt-2 text-sm">Hotel: <span id="displayHotelName" class="font-bold text-emerald-600"></span></p>
            </div>
            <form action="${pageContext.request.contextPath}/user/cart/add" method="POST" class="space-y-5">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" id="modalHotelId" name="itemId">
                <input type="hidden" id="modalHotelName" name="itemName">
                <input type="hidden" name="itemType" value="HOTEL">
                <input type="hidden" id="nightlyRate" name="price">
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-[10px] font-black text-slate-400 uppercase tracking-widest mb-1.5 ml-1">Check In</label>
                        <input type="date" id="checkInDate" name="startDate" required class="w-full px-4 py-3 rounded-xl border-2 border-slate-100 focus:border-emerald-500 outline-none text-sm font-semibold">
                    </div>
                    <div>
                        <label class="block text-[10px] font-black text-slate-400 uppercase tracking-widest mb-1.5 ml-1">Check Out</label>
                        <input type="date" id="checkOutDate" name="endDate" required class="w-full px-4 py-3 rounded-xl border-2 border-slate-100 focus:border-emerald-500 outline-none text-sm font-semibold">
                    </div>
                </div>
                <div class="bg-emerald-50 p-4 rounded-2xl flex justify-between items-center border border-emerald-100">
                    <div class="flex flex-col">
                        <span class="text-[10px] font-bold text-emerald-800 uppercase tracking-wider">Estimated Nights</span>
                        <span id="nightCount" class="text-xs font-semibold text-emerald-600">0 nights</span>
                    </div>
                    <span id="totalDisplay" class="text-xl font-black text-emerald-900">NPR 0</span>
                </div>
                <div class="pt-4">
                    <button type="submit" class="w-full py-4 bg-emerald-600 text-white rounded-2xl font-bold shadow-lg hover:bg-emerald-700 transition-all flex items-center justify-center gap-3 active:scale-95 text-lg">
                        <i data-lucide="shopping-cart" class="w-5 h-5"></i> Add to Journey Cart
                    </button>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

    <script>
        lucide.createIcons();
        const checkInInput = document.getElementById('checkInDate');
        const checkOutInput = document.getElementById('checkOutDate');
        const today = new Date().toISOString().split('T')[0];
        checkInInput.setAttribute('min', today);
        checkOutInput.setAttribute('min', today);

        function openHotelModal(name, id, price) {
            document.getElementById('displayHotelName').innerText = name;
            document.getElementById('modalHotelName').value = name;
            document.getElementById('modalHotelId').value = id;
            document.getElementById('nightlyRate').value = price;
            document.getElementById('hotelModal').classList.replace('modal-hidden', 'modal-visible');
            document.body.style.overflow = 'hidden';
            calculateTotal();
        }

        function closeModal() {
            document.getElementById('hotelModal').classList.replace('modal-visible', 'modal-hidden');
            document.body.style.overflow = 'auto';
        }

        function calculateTotal() {
            const checkIn = new Date(checkInInput.value);
            const checkOut = new Date(checkOutInput.value);
            const rate = parseFloat(document.getElementById('nightlyRate').value) || 0;
            if (checkInInput.value && checkOutInput.value && checkOut > checkIn) {
                const diffTime = Math.abs(checkOut - checkIn);
                const diffNights = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                const total = diffNights * rate;
                document.getElementById('nightCount').innerText = diffNights + " night(s)";
                document.getElementById('totalDisplay').innerText = "NPR " + total;
            } else {
                document.getElementById('nightCount').innerText = "0 nights";
                document.getElementById('totalDisplay').innerText = "NPR 0";
            }
        }
        checkInInput.addEventListener('change', () => {
            checkOutInput.setAttribute('min', checkInInput.value);
            calculateTotal();
        });
        checkOutInput.addEventListener('change', calculateTotal);
        window.onclick = (e) => { if (e.target == document.getElementById('hotelModal')) closeModal(); }
    </script>
</body>
</html>