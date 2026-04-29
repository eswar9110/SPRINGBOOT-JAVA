<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Author - BookAuthor Management</title>
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
        .container { max-width: 700px; margin: 2rem auto; padding: 0 2rem; }
        .form-card {
            background: rgba(255, 255, 255, 0.05); backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 20px; padding: 2.5rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        }
        .form-card h1 {
            font-size: 1.8rem; font-weight: 700; margin-bottom: 2rem;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        }
        .form-group { margin-bottom: 1.5rem; }
        .form-group label {
            display: block; font-weight: 600; font-size: 0.85rem;
            color: #a0a0c0; margin-bottom: 0.5rem; text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        .form-group input, .form-group textarea {
            width: 100%; padding: 0.85rem 1rem;
            background: rgba(255, 255, 255, 0.06);
            border: 1px solid rgba(255, 255, 255, 0.12);
            border-radius: 10px; color: #e0e0e0;
            font-family: 'Inter', sans-serif; font-size: 0.95rem;
            transition: all 0.3s ease; outline: none;
        }
        .form-group input:focus, .form-group textarea:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
            background: rgba(255, 255, 255, 0.08);
        }
        .form-group textarea { resize: vertical; min-height: 100px; }
        .form-error { color: #f87171; font-size: 0.8rem; margin-top: 0.4rem; }
        .alert {
            padding: 1rem 1.5rem; border-radius: 12px;
            margin-bottom: 1.5rem; font-size: 0.9rem; animation: slideDown 0.4s ease;
        }
        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .alert-error {
            background: rgba(239, 68, 68, 0.15);
            border: 1px solid rgba(239, 68, 68, 0.3); color: #f87171;
        }
        .form-actions { display: flex; gap: 1rem; margin-top: 2rem; }
        .btn {
            display: inline-flex; align-items: center; gap: 0.5rem;
            padding: 0.75rem 1.5rem; border: none; border-radius: 10px;
            font-family: 'Inter', sans-serif; font-weight: 600; font-size: 0.9rem;
            cursor: pointer; transition: all 0.3s ease; text-decoration: none;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2); color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }
        .btn-primary:hover {
            transform: translateY(-2px); box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
        }
        .btn-secondary {
            background: rgba(255, 255, 255, 0.08); color: #b0b0c0;
            border: 1px solid rgba(255, 255, 255, 0.12);
        }
        .btn-secondary:hover { background: rgba(255, 255, 255, 0.12); }

        .edit-badge {
            display: inline-block; padding: 0.3rem 0.8rem;
            background: rgba(102, 126, 234, 0.15);
            border: 1px solid rgba(102, 126, 234, 0.3);
            border-radius: 20px; font-size: 0.75rem; color: #667eea;
            margin-bottom: 1rem;
        }

        @media (max-width: 768px) {
            .container { padding: 0 1rem; }
            .form-card { padding: 1.5rem; }
        }
    </style>
</head>
<body>

<nav class="navbar">
    <a href="${pageContext.request.contextPath}/" class="navbar-brand">📚 BookAuthor Manager</a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/authors" class="active">Authors</a></li>
        <li><a href="${pageContext.request.contextPath}/books">Books</a></li>
        <li><a href="${pageContext.request.contextPath}/books/join">Join View</a></li>
    </ul>
</nav>

<div class="container">
    <div class="form-card">
        <span class="edit-badge">Editing ID: ${author.id}</span>
        <h1>✏️ Edit Author</h1>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">${errorMessage}</div>
        </c:if>

        <form:form method="POST" action="${pageContext.request.contextPath}/authors/edit/${author.id}" modelAttribute="author">
            <div class="form-group">
                <label for="name">Full Name</label>
                <form:input path="name" id="name" placeholder="e.g., Jane Austen" />
                <form:errors path="name" cssClass="form-error" />
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <form:input path="email" id="email" placeholder="e.g., jane.austen@email.com" type="email" />
                <form:errors path="email" cssClass="form-error" />
            </div>

            <div class="form-group">
                <label for="bio">Biography</label>
                <form:textarea path="bio" id="bio" placeholder="A brief description about the author..." />
                <form:errors path="bio" cssClass="form-error" />
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Update Author</button>
                <a href="${pageContext.request.contextPath}/authors" class="btn btn-secondary">Cancel</a>
            </div>
        </form:form>
    </div>
</div>

</body>
</html>
