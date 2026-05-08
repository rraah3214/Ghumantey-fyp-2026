<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Verify OTP - Ghumantey</title>
    <style>
        .otp-card { max-width: 400px; margin: 100px auto; padding: 30px; border: 1px solid #ddd; border-radius: 8px; text-align: center; font-family: sans-serif; }
        .otp-input { width: 100%; padding: 12px; margin: 20px 0; border: 1px solid #ccc; border-radius: 4px; font-size: 1.2rem; text-align: center; letter-spacing: 5px; }
        .btn-verify { background: #10b981; color: white; border: none; padding: 12px 25px; border-radius: 4px; cursor: pointer; width: 100%; }
        .error { color: red; margin-top: 10px; }
    </style>
</head>
<body>
    <div class="otp-card">
        <h2>Two-Step Verification</h2>
        <p>Please enter the 6-digit code sent to your email.</p>
        
        <form action="${pageContext.request.contextPath}/verify-otp" method="post">
            <input type="text" name="otp" maxlength="6" class="otp-input" placeholder="000000" required autofocus />
            <button type="submit" class="btn-verify">Verify Now</button>
        </form>

        <c:if test="${param.error == 'true'}">
            <div class="error">Invalid OTP. Please try again.</div>
        </c:if>
    </div>
</body>
</html>