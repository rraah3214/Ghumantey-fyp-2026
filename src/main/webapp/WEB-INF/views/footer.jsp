<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .ghumantey-footer {
        background: linear-gradient(135deg, #022c22, #064e3b);
        color: rgba(236, 253, 245, 0.8);
        border-top: 1px solid rgba(255,255,255,0.1);
        padding: 4rem 1.5rem;
        margin-top: auto; /* Vital for sticky behavior */
    }

    .footer-glass {
        background: rgba(255,255,255,0.05);
        border-radius: 16px;
        padding: 20px;
        backdrop-filter: blur(12px);
        border: 1px solid rgba(255,255,255,0.08);
        transition: all 0.3s ease;
    }

    .footer-glass:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 30px rgba(0,0,0,0.3);
    }

    .footer-icon {
        width: 45px;
        height: 45px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        background: rgba(255,255,255,0.08);
        transition: all 0.3s ease;
        color: white;
        text-decoration: none;
    }

    .footer-icon:hover {
        background: linear-gradient(135deg, #10b981, #059669);
        transform: translateY(-4px) scale(1.1);
        box-shadow: 0 0 15px rgba(16,185,129,0.6);
    }

    .footer-title { font-size: 24px; font-weight: bold; color: #ffffff; }
    .footer-small { font-size: 12px; opacity: 0.7; line-height: 1.6; }
</style>

<footer class="ghumantey-footer">
    <div style="max-width: 1280px; margin: 0 auto; display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 2.5rem;">

        <div class="footer-glass">
            <h3 class="footer-title mb-3">Ghumantey</h3>
            <p class="footer-small">
                Architecting the digital infrastructure for Nepal's trekking industry.
                Explore the Himalayas with intelligence and trust.
            </p>
        </div>

        <div class="footer-glass" style="text-align: center;">
            <h4 class="footer-small" style="text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 1rem;">Connect With Founder</h4>
            <div style="display: flex; justify-content: center; gap: 1rem;">
                <a href="https://wa.me/9866247698" target="_blank" class="footer-icon"><i data-lucide="phone"></i></a>
                <a href="https://www.facebook.com/rahul.parajuli.2025" target="_blank" class="footer-icon"><i class="fab fa-facebook-f"></i></a>
                <a href="https://www.linkedin.com/in/rahul-parajuli-798755274/" target="_blank" class="footer-icon"><i class="fab fa-linkedin-in"></i></a>
            </div>
            <p class="footer-small" style="margin-top: 1rem; font-family: monospace;">+977 9866247698</p>
        </div>

        <div class="footer-glass" style="text-align: right;">
            <p class="footer-small" style="text-transform: uppercase; letter-spacing: 0.1em;">Founder</p>
            <p style="color: white; font-weight: bold; font-size: 1.125rem; margin-top: 0.5rem;">Rahul Parajuli</p>
            <p class="footer-small" style="margin-top: 0.75rem; font-style: italic;">Built in Nepal • 2026</p>
        </div>
    </div>
</footer>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
<script src="https://unpkg.com/lucide@latest"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }
    });
</script>