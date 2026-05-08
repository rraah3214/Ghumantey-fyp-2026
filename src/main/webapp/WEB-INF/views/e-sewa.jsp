<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Redirecting to eSewa...</title>

    <style>
        body {
            font-family: "Poppins", sans-serif;
            background: #f0fdf4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .loader-box {
            background: white;
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
        }

        .spinner {
            border: 5px solid #e2e8f0;
            border-top: 5px solid #16a34a;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            margin: 0 auto 20px;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        h2 { color: #065f46; }
        p { color: #64748b; font-size: 14px; }
    </style>
</head>
<body>

<div class="loader-box">
    <div class="spinner"></div>
    <h2>Redirecting to eSewa...</h2>
    <p>Please wait, do not refresh or go back.</p>
</div>

<form id="esewaForm"
      action="https://rc-epay.esewa.com.np/api/epay/main/v2/form"
      method="POST">

    <!-- REQUIRED FIELDS -->
    <input type="hidden" name="amount" value="${formattedAmount}" />
    <input type="hidden" name="tax_amount" value="0" />
    <input type="hidden" name="total_amount" value="${formattedAmount}" />
    <input type="hidden" name="transaction_uuid" value="${payment.transaction_uuid}" />
    <input type="hidden" name="product_code" value="${payment.product_code}" />

    <!-- OPTIONAL BREAKDOWN -->
    <input type="hidden" name="product_service_charge" value="0" />
    <input type="hidden" name="product_delivery_charge" value="0" />

    <!-- CALLBACK URLs -->
    <input type="hidden" name="success_url" value="${payment.success_url}" />
    <input type="hidden" name="failure_url" value="${payment.failure_url}" />

    <!-- SECURITY -->
    <input type="hidden" name="signed_field_names" value="${payment.signed_field_names}" />
    <input type="hidden" name="signature" value="${payment.signature}" />

</form>

<script>
    // Auto-submit after short delay
    setTimeout(function () {
        document.getElementById("esewaForm").submit();
    }, 1000);
</script>

</body>
</html>