<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Authors - BookAuthor Management</title>
    <style>
        /* ==================== GLOBAL STYLES ==================== */
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #0f0c29, #302b63, #24243e);
            min-height: 100vh;
            color: #e0e0e0;
        }

        /* ==================== NAVIGATION ==================== */
        .navbar {
            background: rgba(15, 12, 41, 0.85);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255,255,255,0.08);
            padding: 1rem 2rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            gap: 0.5rem;
            list-style: none;
        }

        .nav-links a {
            color: #b0b0c0;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s ease;
            font-weight: 500;
            font-size: 0.9rem;
        }

        .nav-links a:hover, .nav-links a.active {
            background: rgba(102, 126, 234, 0.2);
            color: #667eea;
        }

        /* ==================== CONTAINER ==================== */
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .page-header h1 {
            font-size: 2rem;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* ==================== BUTTONS ==================== */
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.6rem 1.2rem;
            border: none;
            border-radius: 10px;
            font-family: 'Inter', sans-serif;
            font-weight: 600;
            font-size: 0.85rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
        }

        .btn-edit {
            background: rgba(59, 130, 246, 0.15);
            color: #60a5fa;
            border: 1px solid rgba(59, 130, 246, 0.3);
        }

        .btn-edit:hover {
            background: rgba(59, 130, 246, 0.25);
            transform: translateY(-1px);
        }

        /* ==================== ALERTS ==================== */
        .alert {
            padding: 1rem 1.5rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            animation: slideDown 0.4s ease;
        }

        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.15);
            border: 1px solid rgba(16, 185, 129, 0.3);
            color: #34d399;
        }

        .alert-error {
            background: rgba(239, 68, 68, 0.15);
            border: 1px solid rgba(239, 68, 68, 0.3);
            color: #f87171;
        }

        /* ==================== TABLE ==================== */
        .table-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: rgba(102, 126, 234, 0.1);
        }

        th {
            padding: 1rem 1.5rem;
            text-align: left;
            font-weight: 600;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: #a0a0c0;
            border-bottom: 1px solid rgba(255,255,255,0.06);
        }

        td {
            padding: 1rem 1.5rem;
            font-size: 0.9rem;
            border-bottom: 1px solid rgba(255,255,255,0.04);
        }

        tbody tr {
            transition: all 0.3s ease;
        }

        tbody tr:hover {
            background: rgba(102, 126, 234, 0.06);
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .bio-cell {
            max-width: 300px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .id-cell {
            color: #667eea;
            font-weight: 600;
        }

        /* ==================== RESPONSIVE ==================== */
        @media (max-width: 768px) {
            .container { padding: 0 1rem; }
            .page-header { flex-direction: column; gap: 1rem; align-items: flex-start; }
            .table-card { overflow-x: auto; }
            th, td { padding: 0.75rem 1rem; font-size: 0.8rem; }
            .nav-links { gap: 0.25rem; }
            .nav-links a { padding: 0.4rem 0.6rem; font-size: 0.8rem; }
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/" class="navbar-brand">📚 BookAuthor Manager</a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/authors" class="active">Authors</a></li>
        <li><a href="${pageContext.request.contextPath}/books">Books</a></li>
        <li><a href="${pageContext.request.contextPath}/books/join">Join View</a></li>
    </ul>
</nav>

<div class="container">
    <!-- Page Header -->
    <div class="page-header">
        <h1>📝 All Authors</h1>
        <a href="${pageContext.request.contextPath}/authors/add" class="btn btn-primary">+ Add Author</a>
    </div>

    <!-- Flash Messages -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-error">${errorMessage}</div>
    </c:if>

    <!-- Authors Table -->
    <div class="table-card">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Bio</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="author" items="${authors}">
                    <tr>
                        <td class="id-cell">${author.id}</td>
                        <td>${author.name}</td>
                        <td>${author.email}</td>
                        <td class="bio-cell">${author.bio}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/authors/edit/${author.id}" class="btn btn-edit">Edit</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty authors}">
                    <tr>
                        <td colspan="5" style="text-align:center; padding:2rem; color:#888;">No authors found. Add one to get started!</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
