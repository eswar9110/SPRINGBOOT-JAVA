<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Books &amp; Authors Join View</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap">
    <style>
        *{margin:0;padding:0;box-sizing:border-box}
        body{font-family:'Inter',sans-serif;background:linear-gradient(135deg,#0f0c29,#302b63,#24243e);min-height:100vh;color:#e0e0e0}
        .navbar{background:rgba(15,12,41,0.85);backdrop-filter:blur(20px);border-bottom:1px solid rgba(255,255,255,0.08);padding:1rem 2rem;display:flex;align-items:center;justify-content:space-between;position:sticky;top:0;z-index:100}
        .navbar-brand{font-size:1.5rem;font-weight:700;background:linear-gradient(135deg,#667eea,#764ba2);-webkit-background-clip:text;-webkit-text-fill-color:transparent;text-decoration:none}
        .nav-links{display:flex;gap:0.5rem;list-style:none}
        .nav-links a{color:#b0b0c0;text-decoration:none;padding:0.5rem 1rem;border-radius:8px;transition:all 0.3s;font-weight:500;font-size:0.9rem}
        .nav-links a:hover,.nav-links a.active{background:rgba(102,126,234,0.2);color:#667eea}
        .container{max-width:1200px;margin:2rem auto;padding:0 2rem}
        .page-header{margin-bottom:2rem}
        .page-header h1{font-size:2rem;font-weight:700;background:linear-gradient(135deg,#667eea,#764ba2);-webkit-background-clip:text;-webkit-text-fill-color:transparent}
        .page-header p{color:#888;margin-top:0.5rem;font-size:0.9rem}
        .query-badge{display:inline-block;padding:0.5rem 1rem;background:rgba(16,185,129,0.1);border:1px solid rgba(16,185,129,0.3);border-radius:10px;font-size:0.8rem;color:#34d399;margin-bottom:1.5rem;font-family:monospace}
        .table-card{background:rgba(255,255,255,0.05);backdrop-filter:blur(20px);border:1px solid rgba(255,255,255,0.08);border-radius:16px;overflow:hidden;box-shadow:0 8px 32px rgba(0,0,0,0.3)}
        table{width:100%;border-collapse:collapse}
        thead{background:rgba(102,126,234,0.1)}
        th{padding:1rem 1.5rem;text-align:left;font-weight:600;font-size:0.8rem;text-transform:uppercase;letter-spacing:0.05em;color:#a0a0c0;border-bottom:1px solid rgba(255,255,255,0.06)}
        td{padding:1rem 1.5rem;font-size:0.9rem;border-bottom:1px solid rgba(255,255,255,0.04)}
        tbody tr{transition:all 0.3s}
        tbody tr:hover{background:rgba(102,126,234,0.06)}
        tbody tr:last-child td{border-bottom:none}
        .price-cell{color:#34d399;font-weight:600}
        .author-name{color:#c084fc;font-weight:600}
        .author-email{color:#60a5fa;font-size:0.85rem}
        @media(max-width:768px){.container{padding:0 1rem}.table-card{overflow-x:auto}th,td{padding:0.75rem 1rem;font-size:0.8rem}}
    </style>
</head>
<body>
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/" class="navbar-brand">&#128218; BookAuthor Manager</a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/authors">Authors</a></li>
        <li><a href="${pageContext.request.contextPath}/books">Books</a></li>
        <li><a href="${pageContext.request.contextPath}/books/join" class="active">Join View</a></li>
    </ul>
</nav>
<div class="container">
    <div class="page-header">
        <h1>&#128279; Books &amp; Authors - Inner Join</h1>
        <p>Combined view using a custom JPQL INNER JOIN query between Book and Author entities</p>
    </div>
    <div class="query-badge">SELECT b.title, b.isbn, b.price, b.yearPublished, a.name, a.email FROM Book b INNER JOIN b.author a</div>
    <div class="table-card">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Book Title</th>
                    <th>ISBN</th>
                    <th>Price</th>
                    <th>Year</th>
                    <th>Author Name</th>
                    <th>Author Email</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ba" items="${bookAuthors}" varStatus="status">
                    <tr>
                        <td style="color:#667eea;font-weight:600">${status.index + 1}</td>
                        <td>${ba.bookTitle}</td>
                        <td>${ba.isbn}</td>
                        <td class="price-cell">$${ba.price}</td>
                        <td>${ba.yearPublished}</td>
                        <td class="author-name">${ba.authorName}</td>
                        <td class="author-email">${ba.authorEmail}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty bookAuthors}">
                    <tr><td colspan="7" style="text-align:center;padding:2rem;color:#888">No results found.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
