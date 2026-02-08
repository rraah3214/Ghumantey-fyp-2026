<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Find Hotels | Ghumantey</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8fafc;
        }
        .hotel-card {
            transition: all 0.3s ease;
        }
        .hotel-card:hover {
            transform: translateY(-6px);
        }
    </style>
</head>

<body class="antialiased text-slate-900">

<!-- ================= NAVBAR ================= -->
<nav class="bg-white/80 backdrop-blur-md sticky top-0 z-50 border-b px-6 py-4">
    <div class="max-w-7xl mx-auto flex justify-between items-center">
        <div class="flex items-center gap-3">
            <img src="${pageContext.request.contextPath}/logo.png" class="h-10">
            <span class="text-xl font-bold text-emerald-800">Ghumantey</span>
        </div>
        <%@ include file="navbar.jsp" %>
    </div>
</nav>

<!-- ================= PAGE ================= -->
<main class="max-w-7xl mx-auto px-6 py-12">

    <!-- SEARCH -->
    <div class="bg-white rounded-3xl p-6 shadow-sm mb-10 flex flex-wrap gap-4 items-center">
        <input type="text" placeholder="Search destination..."
               class="flex-1 px-6 py-3 bg-slate-100 rounded-xl outline-none focus:ring-2 focus:ring-emerald-400">
        <button class="bg-emerald-600 text-white px-8 py-3 rounded-xl font-bold hover:bg-emerald-700">
            Search
        </button>
    </div>

    <!-- HOTEL GRID -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">

        <!-- ================= HOTEL CARD ================= -->
        <div class="hotel-card bg-white rounded-3xl shadow-sm overflow-hidden flex flex-col md:flex-row">

            <!-- IMAGE -->
            <div class="md:w-56 h-56 md:h-auto">
                <img src="https://images.unsplash.com/photo-1566073771259-6a8506099945"
                     class="w-full h-full object-cover">
            </div>

            <!-- CONTENT -->
            <div class="flex-1 p-6 flex flex-col justify-between">

                <div>
                    <div class="flex justify-between items-start">
                        <h3 class="text-2xl font-bold">Hotel Mountain View</h3>
                        <span class="flex items-center text-amber-400 font-bold">
                            <i data-lucide="star" class="w-4 h-4 fill-current"></i> 4.5
                        </span>
                    </div>

                    <p class="text-emerald-600 text-sm font-semibold mt-1 flex items-center gap-1">
                        <i data-lucide="map-pin" class="w-4 h-4"></i> Lakeside, Pokhara
                    </p>

                    <p class="text-slate-500 text-sm mt-3">
                        Comfortable rooms with lake view, free WiFi & breakfast.
                    </p>

                    <div class="flex gap-3 mt-4 text-slate-400">
                        <i data-lucide="wifi" title="Free WiFi"></i>
                        <i data-lucide="coffee" title="Breakfast"></i>
                        <i data-lucide="car" title="Parking"></i>
                    </div>
                </div>

                <!-- BOOKING -->
                <div class="mt-6 border-t pt-5">

                    <div class="flex justify-between items-center mb-3">
                        <span class="text-xl font-extrabold">
                            NPR <span id="price">1859</span>
                        </span>
                        <span class="text-xs text-slate-400">per night</span>
                    </div>

                    <!-- Nights Selector -->
                    <div class="flex justify-between items-center mb-4">
                        <span class="text-sm font-semibold">Nights</span>
                        <div class="flex items-center gap-3">
                            <button type="button" onclick="changeNight(-1)"
                                    class="px-3 py-1 bg-slate-200 rounded-lg font-bold">−</button>
                            <span id="nights" class="font-bold">1</span>
                            <button type="button" onclick="changeNight(1)"
                                    class="px-3 py-1 bg-slate-200 rounded-lg font-bold">+</button>
                        </div>
                    </div>

                    <div class="flex justify-between items-center mb-4 text-lg font-bold">
                        <span>Total</span>
                        <span>NPR <span id="total">1859</span></span>
                    </div>

                    <!-- PAYMENT FORM -->
                    <form action="${pageContext.request.contextPath}/book-hotel" method="get">
                        <input type="hidden" id="priceInput" name="price" value="1859">
                        <input type="hidden" id="nightInput" name="nights" value="1">

                        <button type="submit"
                            class="w-full bg-slate-900 hover:bg-emerald-600
                                   text-white py-3 rounded-xl font-bold transition">
                            Book & Pay
                        </button>
                    </form>

                </div>
            </div>
        </div>
        <!-- ================= END HOTEL CARD ================= -->

    </div>
</main>

<script>
    lucide.createIcons();

    let nights = 1;
    const price = 1859;

    function changeNight(value) {
        nights += value;
        if (nights < 1) nights = 1;

        document.getElementById("nights").innerText = nights;
        document.getElementById("total").innerText = price * nights;
        document.getElementById("nightInput").value = nights;
    }
</script>

</body>
</html>
