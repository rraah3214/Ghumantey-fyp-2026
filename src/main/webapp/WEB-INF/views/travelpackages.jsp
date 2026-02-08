<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Travel Packages | Ghumantey</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8fafc;
        }
        .package-card {
            transition: all 0.3s ease;
        }
        .package-card:hover {
            transform: translateY(-6px);
        }
    </style>
</head>

<body>

<!-- ================= NAV ================= -->
<nav class="bg-white/80 backdrop-blur-md sticky top-0 z-50 border-b px-6 py-4">
    <div class="max-w-7xl mx-auto flex justify-between items-center">
        <div class="flex items-center gap-3">
            <img src="${pageContext.request.contextPath}/logo.png" class="h-10">
            <span class="text-xl font-bold text-emerald-800">Ghumantey</span>
        </div>
        <%@ include file="navbar.jsp" %>
    </div>
</nav>

<!-- ================= CONTENT ================= -->
<main class="max-w-7xl mx-auto px-6 py-12">

    <h1 class="text-4xl font-bold mb-10 text-center">
        Explore Our <span class="text-emerald-600">Travel Packages</span>
    </h1>

    <div class="grid grid-cols-1 lg:grid-cols-2 gap-10">

        <!-- ================= PACKAGE CARD ================= -->
        <div class="package-card bg-white rounded-3xl shadow overflow-hidden">

            <img src="https://images.unsplash.com/photo-1500530855697-b586d89ba3ee"
                 class="h-64 w-full object-cover">

            <div class="p-6 space-y-4">

                <h3 class="text-2xl font-bold">Pokhara Adventure Package</h3>
                <p class="text-slate-500 text-sm">
                    3 Days / 2 Nights • Lakeside stay • Local guide included
                </p>

                <div class="flex items-center gap-2 text-amber-400">
                    <i data-lucide="star" class="fill-current"></i>
                    <span class="font-bold text-slate-700">4.8</span>
                </div>

                <div class="border-t pt-4 space-y-3">

                    <div class="flex justify-between">
                        <span class="font-semibold">Price per person</span>
                        <span class="font-bold">NPR <span id="price">8500</span></span>
                    </div>

                    <!-- PEOPLE SELECTOR -->
                    <div class="flex justify-between items-center">
                        <span class="font-semibold">People</span>
                        <div class="flex items-center gap-3">
                            <button onclick="changePeople(-1)"
                                    class="px-3 py-1 bg-slate-200 rounded-lg font-bold">−</button>
                            <span id="people" class="font-bold">1</span>
                            <button onclick="changePeople(1)"
                                    class="px-3 py-1 bg-slate-200 rounded-lg font-bold">+</button>
                        </div>
                    </div>

                    <div class="flex justify-between text-lg font-extrabold">
                        <span>Total</span>
                        <span>NPR <span id="total">8500</span></span>
                    </div>

                    <!-- PAYMENT -->
                    <form action="${pageContext.request.contextPath}/book-package" method="get">
                        <input type="hidden" name="price" value="8500">
                        <input type="hidden" id="peopleInput" name="people" value="1">

                        <button type="submit"
                            class="w-full mt-4 bg-emerald-600 hover:bg-emerald-700
                                   text-white py-3 rounded-xl font-bold transition">
                            Book Package
                        </button>
                    </form>

                </div>
            </div>
        </div>
        <!-- ================= END CARD ================= -->

    </div>
</main>

<script>
    lucide.createIcons();

    let people = 1;
    const price = 8500;

    function changePeople(val) {
        people += val;
        if (people < 1) people = 1;

        document.getElementById("people").innerText = people;
        document.getElementById("total").innerText = price * people;
        document.getElementById("peopleInput").value = people;
    }
</script>

</body>
</html>
