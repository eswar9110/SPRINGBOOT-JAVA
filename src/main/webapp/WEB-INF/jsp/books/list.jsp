<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Books - BookAuthor Management</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #0f0c29, #302b63, #24243e);
            min-height: 100vh; color: #e0e0e0;
        }
        .navbar {
            background: rgba(15, 12, 41, 0.85); backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255,255,255,0.08);
            padding: 1rem 2rem; display: flex; align-items: center;
            justify-content: space-between; position: sticky; top: 0; z-index: 100;
        }
        .navbar-brand {
            font-size: 1.5rem; font-weight: 700;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            text-decoration: none;
        }
        .nav-links { display: flex; gap: 0.5rem; list-style: none; }
        .nav-links a {
            color: #b0b0c0; text-decoration: none; padding: 0.5rem 1rem;
            border-radius: 8px; transition: all 0.3s ease; font-weight: 500; font-size: 0.9rem;
        }
        .nav-links a:hover, .nav-links a.active {
            background: rgba(102, 126, 234, 0.2); color: #667eea;
        }
        .container { max-width: 1200px; margin: 2rem auto; padding: 0 2rem; }
        .page-header {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 2rem;
        }
        .page-header h1 {
            font-size: 2rem; font-weight: 700;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        }
        .btn {
            display: inline-flex; align-items: center; gap: 0.5rem;
            padding: 0.6rem 1.2rem; border: none; border-radius: 10px;
            font-family: 'Inter', sans-serif; font-weight: 600; font-size: 0.85rem;
            cursor: pointer; transition: all 0.3s ease; text-decoration: none;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2); color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }
        .btn-primary:hover {
            transform: translateY(-2px); box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
        }
        .btn-edit {
            background: rgba(59, 130, 246, 0.15); color: #60a5fa;
            border: 1px solid rgba(59, 130, 246, 0.3);
        }
        .btn-edit:hover { background: rgba(59, 130, 246, 0.25); transform: translateY(-1px); }
        .alert {
            padding: 1rem 1.5rem; border-radius: 12px; margin-bottom: 1.5rem;
            font-size: 0.9rem; animation: slideDown 0.4s ease;
        }
        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .alert-success {
            background: rgba(16, 185, 129, 0.15);
            border: 1px solid rgba(16, 185, 129, 0.3); color: #34d399;
        }
        .alert-error {
            background: rgba(239, 68, 68, 0.15);
            border: 1px solid rgba(239, 68, 68, 0.3); color: #f87171;
        }
        .table-card {
            background: rgba(255, 255, 255, 0.05); backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 16px; overflow: hidden;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        }
        table { width: 100%; border-collapse: collapse; }
        thead { background: rgba(102, 126, 234, 0.1); }
        th {
            padding: 1rem 1.5rem; text-align: left; font-weight: 600;
            font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.05em;
            color: #a0a0c0; border-bottom: 1px solid rgba(255,255,255,0.06);
        }
        td {
            padding: 1rem 1.5rem; font-size: 0.9rem;
            border-bottom: 1px solid rgba(255,255,255,0.04);
        }
        tbody tr { transition: all 0.3s ease; }
        tbody tr:hover { background: rgba(102, 126, 234, 0.06); }
        tbody tr:last-child td { border-bottom: none; }
        .id-cell { color: #667eea; font-weight: 600; }
        .price-cell { color: #34d399; font-weight: 600; }
        .author-badge {
            display: inline-block; padding: 0.25rem 0.6rem;
            background: rgba(118, 75, 162, 0.2);
            border: 1px solid rgba(118, 75, 162, 0.3);
            border-radius: 6px; font-size: 0.8rem; color: #c084fc;
        }
        @media (max-width: 768px) {
            .container { padding: 0 1rem; }
            .page-header { flex-direction: column; gap: 1rem; align-items: flex-start; }
            .table-card { overflow-x: auto; }
            th, td { padding: 0.75rem 1rem; font-size: 0.8rem; }
        }
    </style>
</head>
<body>

<nav class="navbar">
    <a href="${pageContext.request.contextPath}/" class="navbar-brand">📚 BookAuthor Manager</a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/authors">Authors</a></li>
        <li><a href="${pageContext.request.contextPath}/books" class="active">Books</a></li>
        <li><a href="${pageContext.request.contextPath}/books/join">Join View</a></li>
    </ul>
</nav>

<div class="container">
    <div class="page-header">
        <h1>📖 All Books</h1>
        <a href="${pageContext.request.contextPath}/books/add" class="btn btn-primary">+ Add Book</a>
    </div>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-error">${errorMessage}</div>
    </c:if>

    <div class="table-card">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>ISBN</th>
                    <th>Price</th>
                    <th>Year</th>
                    <th>Author</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="book" items="${books}">
                    <tr>
                        <td class="id-cell">${book.id}</td>
                        <td>${book.title}</td>
                        <td>${book.isbn}</td>
                        <td class="price-cell">$${book.price}</td>
                        <td>${book.yearPublished}</td>
                        <td><span class="author-badge">${book.author.name}</span></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/books/edit/${book.id}" class="btn btn-edit">Edit</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty books}">
                    <tr>
                        <td colspan="7" style="text-align:center; padding:2rem; color:#888;">No books found. Add one to get started!</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
