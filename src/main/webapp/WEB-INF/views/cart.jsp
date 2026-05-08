<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ghumantey • Your Journey Cart</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;700;800&family=Syne:wght@700;800&display=swap" rel="stylesheet">
    <style> 
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #fbfcfd; } 
        .cart-item:hover .remove-btn { opacity: 1; transform: translateX(0); }
    </style>
</head>
<body class="antialiased text-slate-900 flex flex-col min-h-screen">

    <%@ include file="navbar.jsp" %>

    <main class="max-w-7xl mx-auto px-6 pt-40 pb-24 flex-grow w-full">
        <div class="flex items-center gap-4 mb-10">
            <h1 class="text-4xl font-extrabold" style="font-family: 'Syne';">My <span class="text-emerald-600">Journey Cart</span></h1>
        </div>

        <div class="grid lg:grid-cols-3 gap-10">
            <div class="lg:col-span-2 space-y-4">
                <c:choose>
                    <c:when test="${not empty cartItems}">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="cart-item bg-white p-6 rounded-[2rem] border border-slate-100 shadow-sm flex items-center justify-between transition-all hover:border-emerald-200 hover:shadow-md">
                                <div class="flex items-center gap-6">
                                    <div class="w-16 h-16 bg-emerald-50 rounded-2xl flex items-center justify-center text-emerald-600">
                                        <c:if test="${item.itemType == 'GUIDE'}"><i data-lucide="user-check"></i></c:if>
                                        <c:if test="${item.itemType == 'HOTEL'}"><i data-lucide="hotel"></i></c:if>
                                        <c:if test="${item.itemType == 'ADVENTURE'}"><i data-lucide="mountain"></i></c:if>
                                    </div>
                                    <div>
                                        <h3 class="font-bold text-lg text-slate-800">${item.itemName}</h3>
                                        <p class="text-xs font-bold text-slate-400 uppercase tracking-wider">${item.startDate} — ${item.endDate}</p>
                                    </div>
                                </div>

                                <div class="flex items-center gap-8">
                                    <p class="font-black text-emerald-700">NPR ${item.totalAmount}</p>
                                    
                                    <form action="${pageContext.request.contextPath}/user/cart/remove" method="POST" 
                                          onsubmit="return confirm('Remove ${item.itemName} from your cart?')">
                                        <input type="hidden" name="itemId" value="${item.id}">
                                        <button type="submit" class="p-3 text-slate-300 hover:text-red-500 hover:bg-red-50 rounded-xl transition-all duration-300 flex items-center justify-center">
                                            <i data-lucide="trash-2" class="w-5 h-5"></i>
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="py-24 text-center bg-white rounded-[3rem] border border-dashed border-slate-200">
                            <div class="w-20 h-20 bg-slate-50 rounded-full flex items-center justify-center mx-auto mb-4 text-slate-300">
                                <i data-lucide="shopping-cart" class="w-10 h-10"></i>
                            </div>
                            <p class="text-slate-500 font-medium">Your cart is currently empty.</p>
                            <a href="${pageContext.request.contextPath}/destinations" class="text-emerald-600 font-bold mt-2 inline-block hover:underline">Start exploring Nepal</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="lg:col-span-1">
                <div class="bg-emerald-900 text-white p-8 rounded-[2.5rem] sticky top-32 shadow-xl shadow-emerald-900/20">
                    <h2 class="text-2xl font-bold mb-6" style="font-family: 'Syne';">Summary</h2>
                    
                    <div class="space-y-4 mb-8">
                        <div class="flex justify-between text-emerald-100/60 text-sm font-bold uppercase tracking-widest">
                            <span>Service Fee</span>
                            <span>Included</span>
                        </div>
                    </div>

                    <div class="flex justify-between items-end border-t border-white/10 pt-6">
                        <span class="font-bold text-emerald-100">Grand Total</span>
                        <div class="text-right">
                            <span class="block text-3xl font-black text-yellow-400">NPR ${grandTotal}</span>
                        </div>
                    </div>

                    <button onclick="payWithEsewa()" class="w-full mt-8 py-4 bg-white text-emerald-900 rounded-2xl font-extrabold hover:bg-yellow-400 hover:scale-[1.02] active:scale-95 transition-all shadow-lg">
                        Checkout with eSewa
                    </button>
                    
                    <p class="text-center text-[10px] text-emerald-100/40 mt-6 font-bold uppercase tracking-widest">
                        Securely processed in Nepal
                    </p>
                </div>
            </div>
        </div>
    </main>

    <%@ include file="footer.jsp" %>

    <script>
        // Initialize Lucide Icons
        lucide.createIcons();

        function payWithEsewa() {
            const total = "${grandTotal}";
            if (!total || parseFloat(total) <= 0) {
                alert("Please add items to your cart before checking out.");
                return;
            }
            // Proceed to payment controller
            window.location.href = "${pageContext.request.contextPath}/user/payment/checkoutCart?totalAmount=" + total;
        }
    </script>
</body>
</html>