<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment Failed • Ghumantey</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&family=Syne:wght@700;800&display=swap" rel="stylesheet">
    <style>body { font-family: 'Plus Jakarta Sans', sans-serif; }</style>
</head>
<body class="bg-slate-50 min-h-screen flex items-center justify-center p-6">

    <div class="max-w-md w-full bg-white rounded-[2.5rem] p-10 shadow-xl border border-red-100 text-center">
        <div class="w-20 h-20 bg-red-50 rounded-full flex items-center justify-center mx-auto mb-6">
            <i data-lucide="x-circle" class="w-12 h-12 text-red-500"></i>
        </div>

        <h1 class="text-3xl font-extrabold text-slate-900 mb-2" style="font-family: 'Syne';">Payment Failed</h1>
        <p class="text-slate-500 mb-8">${errorMessage}</p>

        <div class="space-y-3">
            <a href="${pageContext.request.contextPath}/user/cart" 
               class="block w-full py-4 bg-slate-900 text-white rounded-2xl font-bold hover:bg-slate-800 transition-all active:scale-95">
                Return to Cart
            </a>
            <a href="${pageContext.request.contextPath}/user/userprofile" 
               class="block w-full py-4 bg-white text-slate-600 border border-slate-200 rounded-2xl font-bold hover:bg-slate-50 transition-all">
                Go to Dashboard
            </a>
        </div>
        
        <p class="mt-8 text-[11px] text-slate-400 font-bold uppercase tracking-widest">Transaction was not processed</p>
    </div>

    <script>lucide.createIcons();</script>
</body>
</html>