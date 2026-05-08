<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Success | Ghumantey</title>

    <!-- Auto-redirect to User Profile after 5 seconds -->
    <meta http-equiv="refresh" content="5;url=${pageContext.request.contextPath}/user/userprofile">

    <!-- Tailwind CSS for styling -->
    <script src="https://cdn.tailwindcss.com"></script>
    
    <style>
        @keyframes scaleIn {
            0% { transform: scale(0.9); opacity: 0; }
            100% { transform: scale(1); opacity: 1; }
        }
        .animate-scale-in { animation: scaleIn 0.4s ease-out forwards; }
    </style>
</head>

<body class="flex items-center justify-center min-h-screen bg-slate-50 p-4">

    <div class="bg-white p-8 md:p-12 rounded-[2.5rem] shadow-2xl text-center max-w-md w-full border border-green-100 animate-scale-in">

        <!-- Animated Success Checkmark -->
        <div class="w-24 h-24 bg-green-100 text-green-600 rounded-full flex items-center justify-center mx-auto mb-8 shadow-inner">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-14 w-14" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="3">
              <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" />
            </svg>
        </div>

        <h1 class="text-3xl font-extrabold text-slate-800 mb-3 tracking-tight">
            Payment Received!
        </h1>

        <p class="text-slate-500 mb-10 leading-relaxed">
            Thank you for your trust. Your booking is now confirmed and your adventure is ready.
        </p>

        <!-- Transaction Details Card -->
        <div class="bg-slate-50 p-6 rounded-3xl text-left mb-8 border border-slate-100">
            <div class="flex justify-between items-center mb-6">
                <span class="text-xs font-bold uppercase tracking-[0.15em] text-slate-400">Payment Status</span>
                <span class="bg-green-500 text-white text-[11px] px-4 py-1.5 rounded-full font-black uppercase tracking-widest shadow-lg shadow-green-200">
                    PAID
                </span>
            </div>
            
            <div class="space-y-4">
                <!-- Amount Logic: Tries model attribute first, then request parameter -->
                <div class="flex justify-between items-end border-b border-slate-200 pb-3">
                    <span class="text-slate-500 text-sm font-medium">Total Amount</span>
                    <span class="text-green-600 font-black text-2xl">
                        NPR 
                        <c:choose>
                            <c:when test="${not empty amount}">${amount}</c:when>
                            <c:when test="${not empty param.amount}">${param.amount}</c:when>
                            <c:otherwise>0.00</c:otherwise>
                        </c:choose>
                    </span>
                </div>

                <!-- Transaction ID Logic -->
                <div class="flex justify-between items-center">
                    <span class="text-slate-500 text-sm font-medium">Ref ID</span>
                    <span class="text-slate-700 text-sm font-mono font-bold bg-white px-2 py-1 rounded border border-slate-200">
                        <c:out value="${not empty transactionId ? transactionId : (not empty param.transactionId ? param.transactionId : 'GH-TXN-SUCCESS')}" />
                    </span>
                </div>
            </div>
        </div>

        <!-- Action Section -->
        <div class="flex flex-col items-center gap-5">
            <div class="flex items-center gap-2 text-xs text-slate-400">
                <span class="relative flex h-2 w-2">
                  <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-slate-300 opacity-75"></span>
                  <span class="relative inline-flex rounded-full h-2 w-2 bg-slate-400"></span>
                </span>
                Redirecting to profile in 5 seconds...
            </div>

            <a href="${pageContext.request.contextPath}/user/userprofile" class="w-full">
                <button class="w-full bg-slate-900 text-white font-bold py-4 rounded-2xl hover:bg-green-600 active:scale-[0.98] transition-all duration-300 shadow-xl shadow-slate-200">
                    Go to Dashboard Now
                </button>
            </a>
        </div>

    </div>

</body>
</html>