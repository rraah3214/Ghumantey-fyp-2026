<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ghumantey | Secure Payment</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(to right, #ecfeff, #f0fdf4);
        }
    </style>
</head>

<body>

<!-- ================= NAV ================= -->
<nav class="bg-white shadow px-6 py-4">
    <div class="max-w-7xl mx-auto flex items-center gap-3">
        <img src="${pageContext.request.contextPath}/logo.png" class="h-10">
        <span class="text-xl font-extrabold text-emerald-700">Ghumantey</span>
    </div>
</nav>

<!-- ================= PAYMENT CARD ================= -->
<section class="py-20">
    <div class="max-w-3xl mx-auto bg-white rounded-3xl shadow-2xl overflow-hidden">

        <!-- HEADER -->
        <div class="bg-emerald-600 text-white px-10 py-8">
            <h2 class="text-3xl font-bold">Confirm Your Booking</h2>
            <p class="text-emerald-100 mt-1">Secure payment powered by eSewa</p>
        </div>

        <!-- BODY -->
        <div class="p-10 space-y-8">

            <!-- GUIDE SUMMARY -->
            <div class="flex items-center gap-4 bg-emerald-50 p-4 rounded-xl">
                <i data-lucide="user" class="text-emerald-600"></i>
                <div>
                    <h3 class="font-bold text-slate-800">Local Guide Booking</h3>
                    <p class="text-sm text-slate-500">Professional certified guide</p>
                </div>
            </div>

            <!-- PRICE BREAKDOWN -->
            <div class="border rounded-2xl p-6 space-y-4">
                <h4 class="font-bold text-lg text-slate-800">Payment Details</h4>

                <div class="flex justify-between text-slate-600">
                    <span>Guide Charge</span>
                    <span>NPR <span id="amount">${payment.amount}</span></span>
                </div>

                <div class="flex justify-between text-slate-600">
                    <span>Tax</span>
                    <span>NPR <span id="tax">${payment.tax_amount}</span></span>
                </div>

                <div class="flex justify-between text-slate-600">
                    <span>Service Charge</span>
                    <span>NPR <span id="psc">${payment.psc}</span></span>
                </div>

                <div class="flex justify-between text-slate-600">
                    <span>Delivery Charge</span>
                    <span>NPR <span id="pdc">${payment.pdc}</span></span>
                </div>

                <hr>

                <div class="flex justify-between text-xl font-extrabold text-slate-900">
                    <span>Total Payable</span>
                    <span>NPR <span id="total">${payment.total_amount}</span></span>
                </div>
            </div>

            <!-- PAY BUTTON -->
            <form action="https://rc-epay.esewa.com.np/api/epay/main/v2/form" method="POST">

                <!-- Hidden eSewa fields -->
                <input type="hidden" name="amount" value="${payment.amount}">
                <input type="hidden" name="tax_amount" value="${payment.tax_amount}">
                <input type="hidden" name="total_amount" value="${payment.total_amount}">
                <input type="hidden" name="transaction_uuid" value="${payment.transaction_uuid}">
                <input type="hidden" name="product_code" value="${payment.product_code}">
                <input type="hidden" name="product_service_charge" value="${payment.psc}">
                <input type="hidden" name="product_delivery_charge" value="${payment.pdc}">
                <input type="hidden" name="success_url" value="${payment.success_url}">
                <input type="hidden" name="failure_url" value="${payment.failure_url}">
                <input type="hidden" name="signed_field_names" value="${payment.signed_field_names}">
                <input type="hidden" name="signature" value="${payment.signature}">

                <button type="submit"
                        class="w-full mt-6 bg-emerald-600 hover:bg-emerald-700
                               text-white py-4 rounded-2xl font-bold text-lg
                               transition-all flex items-center justify-center gap-2">
                    <i data-lucide="lock"></i>
                    Pay Securely with eSewa
                </button>
            </form>

            <!-- TRUST -->
            <p class="text-xs text-center text-slate-400">
                🔒 Your payment is secure & encrypted
            </p>
        </div>
    </div>
</section>

<script>
    lucide.createIcons();
</script>

</body>
</html>
