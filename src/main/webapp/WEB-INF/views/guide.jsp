<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ghumantey | Local Guides</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f0f9ff;
        }
        .guide-card {
            transition: all 0.3s ease;
        }
        .guide-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 25px 50px -12px rgba(16, 185, 129, 0.2);
        }
    </style>
</head>

<body>

<!-- ================= NAVBAR ================= -->
<nav class="bg-white shadow sticky top-0 z-50 px-6 py-4">
    <div class="max-w-7xl mx-auto flex justify-between items-center">
        <div class="flex items-center gap-3">
            <img src="${pageContext.request.contextPath}/logo.png" class="h-10">
            <span class="text-xl font-bold text-emerald-700">Ghumantey</span>
        </div>
        <%@ include file="navbar.jsp" %>
    </div>
</nav>

<!-- ================= HERO ================= -->
<section class="py-16 bg-white border-b">
    <div class="max-w-4xl mx-auto text-center">
        <h1 class="text-4xl font-bold text-slate-900 mb-4">
            Explore Nepal with <span class="text-emerald-600">Local Guides</span>
        </h1>
        <input type="text" id="searchInput" onkeyup="searchGuide()"
               placeholder="Search guide, city, trek..."
               class="w-full max-w-xl px-6 py-4 border rounded-xl shadow-inner">
    </div>
</section>

<!-- ================= GUIDE LIST ================= -->
<main class="max-w-7xl mx-auto px-6 py-16">
    <div id="guideGrid" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-10">

        <!-- ================= GUIDE CARD ================= -->
        <div class="guide-card bg-white rounded-3xl overflow-hidden border">
            <img src="https://images.unsplash.com/photo-1590001158193-79cd7c703f89"
                 class="h-60 w-full object-cover">

            <div class="p-6">
                <span class="text-sm text-emerald-600 font-semibold">Pokhara, Nepal</span>
                <h3 class="text-2xl font-bold mt-2">Tenzing Sherpa</h3>
                <p class="text-slate-600 mt-2 text-sm">
                    ABC Trek specialist & cultural guide.
                </p>

                <div class="mt-4 flex gap-2">
                    <span class="bg-emerald-100 text-emerald-700 px-3 py-1 rounded-lg text-xs font-bold">
                        TREKKING
                    </span>
                    <span class="bg-emerald-100 text-emerald-700 px-3 py-1 rounded-lg text-xs font-bold">
                        ENG / HINDI
                    </span>
                </div>

                <div class="mt-6 flex justify-between items-center">
                    <span class="text-lg font-bold text-slate-800">NPR 1500 / Day</span>

                    <!-- BOOK BUTTON -->
                    <form action="${pageContext.request.contextPath}/book-guide" method="get">
                        <input type="hidden" name="guideId" value="1">
                        <input type="hidden" name="price" value="1500">
                        <button type="submit"
                            class="bg-slate-900 text-white px-5 py-2 rounded-xl font-bold hover:bg-emerald-600">
                            Book Guide
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <!-- ================= END CARD ================= -->

    </div>
</main>

<!-- ================= JS ================= -->
<script>
    lucide.createIcons();

    function searchGuide() {
        let input = document.getElementById("searchInput").value.toLowerCase();
        let cards = document.getElementsByClassName("guide-card");

        for (let card of cards) {
            let text = card.innerText.toLowerCase();
            card.style.display = text.includes(input) ? "block" : "none";
        }
    }
</script>

</body>
</html>
