<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logged Out - Ghumantey</title>
    <link rel="stylesheet" href="<c:url value='/css/styles.css' />">
</head>
<body>
    <header>
        <h1>Ghumantey</h1>
        <hr>
    </header>

    <section>
        <h2><c:out value="${message}" /></h2>
        <p><a href="<c:url value='/login' />">Click here to login again</a></p>
    </section>

    <footer>
        <hr>
        <p>&copy; 2026 Ghumantey. All rights reserved.</p>
    </footer>
</body>
</html>