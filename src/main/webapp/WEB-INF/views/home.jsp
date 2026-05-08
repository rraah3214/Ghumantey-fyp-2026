<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ghumantey • Elevate Your Himalayan Journey</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>

    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans&family=Syne:wght@700;800&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; scroll-behavior: smooth; }
        .hero-mesh {
            background: linear-gradient(135deg,#064e3b,#059669);
        }
        .glass-card {
            background: rgba(255,255,255,0.8);
            backdrop-filter: blur(15px);
        }
        /* Custom Scrollbar for Chat */
        #chatBody::-webkit-scrollbar { width: 4px; }
        #chatBody::-webkit-scrollbar-thumb { background: #10b981; border-radius: 10px; }
        .no-scrollbar::-webkit-scrollbar { display: none; }
        .no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
    </style>
</head>

<body class="flex flex-col min-h-screen bg-white">

<%@ include file="navbar.jsp" %>

<main class="flex-grow">

    <section class="hero-mesh text-white pt-32 pb-40 px-6 text-center lg:text-left">
        <div class="max-w-7xl mx-auto grid lg:grid-cols-2 gap-10 items-center">
            <div>
                <h1 class="text-4xl md:text-6xl font-bold" style="font-family: 'Syne';">
                    The Trek of a <br/>
                    <span class="text-yellow-400">Lifetime</span>
                </h1>
                <p class="mt-4 text-lg text-emerald-100">
                    Explore Nepal with verified guides and smart AI assistance.
                </p>
                <a href="${pageContext.request.contextPath}/explore-treks"
                   class="inline-block mt-6 bg-yellow-400 hover:bg-yellow-500 text-black px-8 py-3 rounded-xl font-bold transition-all transform hover:scale-105">
                    Explore Now
                </a>
            </div>
            <div class="hidden lg:block">
                <img src="https://images.unsplash.com/photo-1544735716-392fe2489ffa"
                     class="rounded-3xl shadow-2xl border-4 border-emerald-400/20" alt="Nepal Mountains">
            </div>
        </div>
    </section>

    <div class="max-w-5xl mx-auto px-6 -mt-16 relative z-10">
        <div class="glass-card p-6 rounded-2xl shadow-2xl border border-white/50">
            <form action="${pageContext.request.contextPath}/search" class="grid md:grid-cols-4 gap-4">
                <input name="search" placeholder="Destination (e.g. Pokhara)"
                       class="p-3 rounded-xl bg-gray-50 border border-gray-200 outline-none focus:ring-2 focus:ring-emerald-500">
                <select class="p-3 rounded-xl bg-gray-50 border border-gray-200 outline-none focus:ring-2 focus:ring-emerald-500">
                    <option>Guide</option>
                    <option>Expert</option>
                    <option>Local</option>
                </select>
                <input placeholder="Budget (NPR)" class="p-3 rounded-xl bg-gray-50 border border-gray-200 outline-none focus:ring-2 focus:ring-emerald-500">
                <button class="bg-emerald-600 hover:bg-emerald-700 text-white rounded-xl font-bold py-3 transition-colors">
                    Search
                </button>
            </form>
        </div>
    </div>

    <section class="py-24 text-center">
        <h2 class="text-3xl font-bold mb-12">Why Ghumantey?</h2>
        <div class="grid md:grid-cols-3 gap-8 max-w-6xl mx-auto px-6">
            <div class="p-8 bg-white border border-gray-100 shadow-sm hover:shadow-md rounded-2xl transition-all">
                <i data-lucide="shield-check" class="mx-auto text-emerald-600 mb-4 w-10 h-10"></i>
                <h3 class="font-bold text-lg">Verified Guides</h3>
                <p class="text-sm text-gray-500 mt-2">Background checked professionals for your safety.</p>
            </div>
            <div class="p-8 bg-white border border-gray-100 shadow-sm hover:shadow-md rounded-2xl transition-all">
                <i data-lucide="map" class="mx-auto text-emerald-600 mb-4 w-10 h-10"></i>
                <h3 class="font-bold text-lg">Real Adventures</h3>
                <p class="text-sm text-gray-500 mt-2">Off-the-beaten-path routes across the Himalayas.</p>
            </div>
            <div class="p-8 bg-white border border-gray-100 shadow-sm hover:shadow-md rounded-2xl transition-all">
                <i data-lucide="bot" class="mx-auto text-emerald-600 mb-4 w-10 h-10"></i>
                <h3 class="font-bold text-lg">AI Assistant</h3>
                <p class="text-sm text-gray-500 mt-2">24/7 smart travel planning and trekking tips.</p>
            </div>
        </div>
    </section>

    <section class="py-20 bg-gray-50">
        <div class="max-w-6xl mx-auto px-6">
            <h2 class="text-3xl font-bold mb-12 text-center">Popular Destinations</h2>
            <div class="grid md:grid-cols-3 gap-8">
                <div class="group relative rounded-2xl overflow-hidden shadow-lg cursor-pointer">
                    <img src="https://images.unsplash.com/photo-1501785888041-af3ef285b470" class="w-full h-64 object-cover transition-transform duration-500 group-hover:scale-110">
                    <div class="absolute inset-0 bg-gradient-to-t from-black/70 to-transparent flex items-end p-6">
                        <span class="text-white font-bold text-xl">Everest Base Camp</span>
                    </div>
                </div>
                <div class="group relative rounded-2xl overflow-hidden shadow-lg cursor-pointer">
                    <img src="https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1" class="w-full h-64 object-cover transition-transform duration-500 group-hover:scale-110">
                    <div class="absolute inset-0 bg-gradient-to-t from-black/70 to-transparent flex items-end p-6">
                        <span class="text-white font-bold text-xl">Annapurna Circuit</span>
                    </div>
                </div>
                <div class="group relative rounded-2xl overflow-hidden shadow-lg cursor-pointer">
                    <img src="https://images.unsplash.com/photo-1519681393784-d120267933ba" class="w-full h-64 object-cover transition-transform duration-500 group-hover:scale-110">
                    <div class="absolute inset-0 bg-gradient-to-t from-black/70 to-transparent flex items-end p-6">
                        <span class="text-white font-bold text-xl">Langtang Valley</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

</main>

<div class="fixed bottom-6 right-6 z-50">
    <button onclick="toggleChat()" class="w-16 h-16 bg-emerald-600 hover:bg-emerald-700 text-white rounded-full shadow-2xl flex items-center justify-center transition-transform active:scale-95">
        <i data-lucide="message-circle" id="chatIcon"></i>
    </button>

    <div id="chatWindow" class="hidden absolute bottom-20 right-0 w-80 md:w-96 h-[500px] bg-white shadow-2xl rounded-2xl border border-gray-100 flex flex-col overflow-hidden">
        <div class="bg-emerald-600 p-4 text-white flex justify-between items-center">
            <div class="flex items-center gap-2">
                <div class="w-2 h-2 bg-yellow-400 rounded-full animate-pulse"></div>
                <span class="font-bold">Ghumantey AI</span>
            </div>
            <button onclick="toggleChat()" class="hover:bg-emerald-500 rounded p-1">
                <i data-lucide="x" class="w-4 h-4"></i>
            </button>
        </div>
        
        <div id="chatBody" class="flex-grow p-4 overflow-y-auto space-y-4 bg-gray-50">
            <div class="flex justify-start">
                <div class="bg-white border border-gray-200 text-gray-800 p-3 rounded-2xl rounded-tl-none text-sm shadow-sm">
                    Namaste! I'm your Himalayan guide. How can I help you today?
                </div>
            </div>
        </div>

        <div class="px-4 pb-2 flex gap-2 overflow-x-auto whitespace-nowrap no-scrollbar bg-white">
            <button onclick="sendQuick('Tell me about EBC')" class="text-[10px] bg-emerald-50 text-emerald-700 px-3 py-1 rounded-full border border-emerald-100 hover:bg-emerald-100">Everest Info</button>
            <button onclick="sendQuick('Are your guides verified?')" class="text-[10px] bg-emerald-50 text-emerald-700 px-3 py-1 rounded-full border border-emerald-100 hover:bg-emerald-100">Safety</button>
            <button onclick="sendQuick('List approved hotels')" class="text-[10px] bg-emerald-50 text-emerald-700 px-3 py-1 rounded-full border border-emerald-100 hover:bg-emerald-100">Stays</button>
            <button onclick="sendQuick('Find guides')" class="text-[10px] bg-emerald-50 text-emerald-700 px-3 py-1 rounded-full border border-emerald-100 hover:bg-emerald-100">Guides</button>
        </div>

        <div class="p-4 border-t bg-white flex gap-2">
            <input id="chatInput" 
                   type="text" 
                   placeholder="Ask about treks or guides..." 
                   class="flex-grow border border-gray-200 rounded-xl px-4 py-2 text-sm outline-none focus:border-emerald-500"
                   onkeypress="if(event.key === 'Enter') processMessage()">
            <button onclick="processMessage()" class="bg-emerald-600 text-white p-2 rounded-xl hover:bg-emerald-700 transition-colors">
                <i data-lucide="send" class="w-5 h-5"></i>
            </button>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script>
    lucide.createIcons();

    function toggleChat() {
        const chatWin = document.getElementById("chatWindow");
        chatWin.classList.toggle("hidden");
        if (!chatWin.classList.contains("hidden")) {
            document.getElementById("chatInput").focus();
        }
    }

    function sendQuick(text) {
        document.getElementById("chatInput").value = text;
        processMessage();
    }

    async function processMessage() {
        const input = document.getElementById("chatInput");
        const msg = input.value.trim();
        if (!msg) return;

        const body = document.getElementById("chatBody");

        // USER MESSAGE UI
        const userMsgHtml = `
            <div class="flex justify-end">
                <div class="bg-emerald-600 text-white p-3 rounded-2xl rounded-tr-none text-sm shadow-md max-w-[80%]">
                    \${msg}
                </div>
            </div>`;
        body.insertAdjacentHTML('beforeend', userMsgHtml);

        input.value = "";
        body.scrollTop = body.scrollHeight;

        // Security Tokens
        const token = document.querySelector('meta[name="_csrf"]')?.content;
        const header = document.querySelector('meta[name="_csrf_header"]')?.content;

        // THINKING PLACEHOLDER
        const thinkingId = "thinking-" + Date.now();
        const thinkingHtml = `
            <div class="flex justify-start" id="\${thinkingId}">
                <div class="bg-white border border-gray-200 text-gray-400 p-3 rounded-2xl rounded-tl-none text-xs italic">
                    AI is thinking...
                </div>
            </div>`;
        body.insertAdjacentHTML('beforeend', thinkingHtml);
        body.scrollTop = body.scrollHeight;

        try {
            // API Endpoint Setup
            const apiUrl = window.location.origin + "${pageContext.request.contextPath}/api/chat";

            const res = await fetch(apiUrl, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    ...(header && token ? { [header]: token } : {})
                },
                body: JSON.stringify({ message: msg })
            });

            const data = await res.json();
            
            // REMOVE THINKING INDICATOR
            const thinkingElem = document.getElementById(thinkingId);
            if (thinkingElem) thinkingElem.remove();

            // EXTRACT RESPONSE (Fixed to look at .message field)
            const botText = data.message || "Namaste! I'm here to help you explore Nepal.";

            // RENDER GUIDES IF PRESENT
            let guideContent = "";
            if (data.guides && Array.isArray(data.guides) && data.guides.length > 0) {
                guideContent = `<div class="mt-3 space-y-2 border-t pt-2">` +
                    data.guides.map(g => `
                        <div class="bg-emerald-50 p-2 rounded-lg border border-emerald-100 text-[11px] flex justify-between items-center">
                            <span class="font-medium text-emerald-900">• \${g.firstname} \${g.lastname}</span>
                            <span class="bg-emerald-600 text-white px-2 py-0.5 rounded text-[9px]">Rs. \${g.price}</span>
                        </div>
                    `).join('') + `</div>`;
            }

            // RENDER HOTELS IF PRESENT
            let hotelContent = "";
            if (data.hotels && Array.isArray(data.hotels) && data.hotels.length > 0) {
                hotelContent = `<div class="mt-3 space-y-2 border-t pt-2">` +
                    data.hotels.map(h => `
                        <div class="bg-blue-50 p-2 rounded-lg border border-blue-100 text-[11px]">
                            <div class="font-bold text-blue-900">\${h.hotelName}</div>
                            <div class="text-blue-700 opacity-70">\${h.location} - Rs. \${h.price}</div>
                        </div>
                    `).join('') + `</div>`;
            }

            // BOT MESSAGE UI
            const botMsgHtml = `
                <div class="flex justify-start animate-in fade-in duration-300">
                    <div class="bg-white border border-gray-200 text-gray-800 p-3 rounded-2xl rounded-tl-none text-sm shadow-sm max-w-[85%]">
                        <div>\${botText}</div>
                        \${guideContent}
                        \${hotelContent}
                    </div>
                </div>`;
            
            body.insertAdjacentHTML('beforeend', botMsgHtml);
            body.scrollTop = body.scrollHeight;

        } catch (error) {
            console.error("ERROR:", error);
            const thinkingElem = document.getElementById(thinkingId);
            if (thinkingElem) {
                thinkingElem.innerHTML = `
                    <div class="bg-red-50 text-red-600 p-3 rounded-2xl rounded-tl-none text-xs border border-red-100">
                        ⚠️ Error: Connection failed. Please try again.
                    </div>`;
            }
        }
    }
</script>

</body>
</html>