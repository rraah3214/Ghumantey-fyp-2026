<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Rahul Parajuli • Founder of Ghumantey</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700;800&family=Syne:wght@700;800&display=swap" rel="stylesheet">
    
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; scroll-behavior: smooth; }
        .font-syne { font-family: 'Syne', sans-serif; }
        .glass { background: rgba(255, 255, 255, 0.7); backdrop-filter: blur(10px); }
        
        .animated-bg {
            background: linear-gradient(-45deg, #f0fdf4, #ffffff, #ecfdf5, #f8fafc);
            background-size: 400% 400%;
            animation: gradient 15s ease infinite;
        }
        
        @keyframes gradient { 
            0% { background-position: 0% 50%; } 
            50% { background-position: 100% 50%; } 
            100% { background-position: 0% 50%; } 
        }

        .reveal { opacity: 0; transform: translateY(20px); transition: 0.6s all ease-out; }
        .reveal.active { opacity: 1; transform: translateY(0); }
    </style>
</head>
<body class="animated-bg text-slate-900 antialiased flex flex-col min-h-screen">

    <%@ include file="navbar.jsp" %>

    <main class="max-w-6xl mx-auto pt-44 pb-20 px-6 flex-grow">
        <div class="grid lg:grid-cols-12 gap-12 items-center mb-32">
            <div class="lg:col-span-5 reveal">
                <div class="relative group">
                    <div class="absolute -inset-4 bg-emerald-500/10 rounded-[3rem] -rotate-3 group-hover:rotate-0 transition-transform duration-500"></div>
                    <div class="relative w-full aspect-[4/5] rounded-[2.5rem] overflow-hidden shadow-2xl border-8 border-white">
                        <img src="/rahul.jpg" alt="Rahul Parajuli" class="w-full h-full object-cover grayscale hover:grayscale-0 transition duration-700">
                    </div>
                    <div class="absolute -bottom-6 -right-6 glass p-6 rounded-3xl shadow-xl border border-white/50 hidden md:block">
                        <p class="text-xs font-black uppercase text-emerald-600 mb-1">Current Role</p>
                        <p class="font-bold text-slate-800">Founder of Ghumantey</p>
                    </div>
                </div>
            </div>

            <div class="lg:col-span-7 reveal">
                <h2 class="text-emerald-600 font-bold tracking-widest text-sm mb-4 uppercase">Architecting the Himalayas</h2>
                <h1 class="text-6xl md:text-7xl font-syne font-extrabold text-slate-900 mb-8 leading-tight">
                    Namaste, I'm <span class="text-transparent bg-clip-text bg-gradient-to-r from-emerald-600 to-teal-500">Rahul Parajuli.</span>
                </h1>
                <p class="text-xl text-slate-600 leading-relaxed mb-8">
                    Founder of Ghumantey and Java Backend Specialist with a heart for high altitudes. By day, I build robust enterprise solutions; by night, I am scaling the digital infrastructure for Nepal's trekking industry through <b>Ghumantey</b>.
                </p>
                <div class="flex flex-wrap gap-4">
                    <button class="bg-emerald-600 text-white px-8 py-4 rounded-2xl font-bold shadow-lg shadow-emerald-200 hover:bg-emerald-700 hover:-translate-y-1 transition">Get in Touch</button>
                    <div class="flex items-center gap-4 px-6">
                        <a href="https://github.com/rraah3214" target="_blank" class="text-slate-400 hover:text-emerald-600 transition"><i data-lucide="github"></i></a>
                        <a href="https://www.linkedin.com/in/rahul-parajuli-798755274/" target="_blank" class="text-slate-400 hover:text-emerald-600 transition"><i data-lucide="linkedin"></i></a>
                        <a href="https://www.facebook.com/rahul.parajuli.2025" target="_blank" class="text-slate-400 hover:text-emerald-600 transition"><i data-lucide="facebook"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <%@ include file="footer.jsp" %>

    <script>
        // Initialize Icons and Scroll Reveal
        lucide.createIcons();
        
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => { 
                if (entry.isIntersecting) entry.target.classList.add('active'); 
            });
        }, { threshold: 0.1 });

        document.querySelectorAll('.reveal').forEach(el => observer.observe(el));
    </script>
</body>
</html>