<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Advanced Member Management</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f7fa;
        }
        h2 {
            color: #2c3e50;
            text-align: center;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }
        th {
            background-color: #3498db;
            color: white;
            cursor: pointer;
        }
        th:hover {
            background-color: #2980b9;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
        .action-links a {
            margin-right: 10px;
            color: #3498db;
            text-decoration: none;
        }
        .action-links a:hover {
            text-decoration: underline;
        }
        .search-form {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
        }
        .search-form input[type="text"] {
            padding: 10px;
            width: 250px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
        .search-form button, .add-button {
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        .search-form button:hover, .add-button:hover {
            background-color: #2980b9;
        }
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background: white;
            padding: 20px;
            border-radius: 8px;
            width: 400px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
        .modal-content h3 {
            margin-top: 0;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .modal-content button {
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .modal-content button:hover {
            background-color: #2980b9;
        }
        .close {
            float: right;
            font-size: 20px;
            cursor: pointer;
        }
        .error {
            color: red;
            font-size: 12px;
            display: none;
        }
    </style>
</head>
<body>
    <c:if test="${empty user}">
        <c:redirect url="login.jsp"/>
    </c:if>
    <div class="container">
        <h2>Advanced Member Management</h2>
        <p>Welcome, ${user.username} | <a href="LogoutServlet">Logout</a></p>

        <!-- Search Form -->
        <form class="search-form" onsubmit="searchMembers(event)">
            <input type="text" id="keyword" name="keyword" placeholder="Search by name or email" value="${searchKeyword}"/>
            <button type="submit">Search</button>
            <button type="button" class="add-button" onclick="openAddModal()">Add Member</button>
        </form>

        <!-- Member List Table -->
        <table id="memberTable">
            <thead>
                <tr>
                    <th onclick="sortTable('id')">ID <span id="sort-id"></span></th>
                    <th onclick="sortTable('name')">Name <span id="sort-name"></span></th>
                    <th onclick="sortTable('email')">Email <span id="sort-email"></span></th>
                    <th onclick="sortTable('createdAt')">Created At <span id="sort-createdAt"></span></th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="memberTableBody">
                <c:forEach var="member" items="${members}">
                    <tr>
                        <td>${member.id}</td>
                        <td>${member.name}</td>
                        <td>${member.email}</td>
                        <td>${member.createdAt}</td>
                        <td class="action-links">
                            <a href="#" onclick="openEditModal(${member.id}, '${member.name}', '${member.email}')">Edit</a>
                            <a href="MemberServlet?action=delete&id=${member.id}" onclick="return confirmDelete()">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty members}">
                    <tr>
                        <td colspan="5" style="text-align: center;">No members found.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <!-- Pagination -->
        <div class="pagination">
            <custom:pagination currentPage="${currentPage}" totalPages="${totalPages}" keyword="${searchKeyword}"/>
        </div>
    </div>

    <!-- Modal for Add/Edit Member -->
    <div id="memberModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h3 id="modalTitle">Add Member</h3>
            <form id="memberForm" onsubmit="submitMember(event)">
                <input type="hidden" id="memberId" name="id"/>
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" required/>
                    <span class="error" id="nameError">Name must be at least 2 characters.</span>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required/>
                    <span class="error" id="emailError">Invalid email format.</span>
                </div>
                <button type="submit">Save</button>
            </form>
        </div>
    </div>

    <script>
        // AJAX Search
        function searchMembers(event) {
            event.preventDefault();
            const keyword = document.getElementById('keyword').value;
            fetch(`MemberServlet?action=search&keyword=${encodeURIComponent(keyword)}&page=1`)
                .then(response => response.json())
                .then(data => {
                    updateTable(data.members);
                    updatePagination(data.currentPage, data.totalPages, keyword);
                })
                .catch(error => console.error('Error:', error));
        }

        // Update Table with AJAX Data
        function updateTable(members) {
            const tbody = document.getElementById('memberTableBody');
            tbody.innerHTML = '';
            if (members.length === 0) {
                tbody.innerHTML = '<tr><td colspan="5" style="text-align: center;">No members found.</td></tr>';
                return;
            }
            members.forEach(member => {
                const row = `
                    <tr>
                        <td>${member.id}</td>
                        <td>${member.name}</td>
                        <td>${member.email}</td>
                        <td>${member.createdAt}</td>
                        <td class="action-links">
                            <a href="#" onclick="openEditModal(${member.id}, '${member.name}', '${member.email}')">Edit</a>
                            <a href="MemberServlet?action=delete&id=${member.id}" onclick="return confirmDelete()">Delete</a>
                        </td>
                    </tr>`;
                tbody.innerHTML += row;
            });
        }

        // Update Pagination
        function updatePagination(currentPage, totalPages, keyword) {
            const pagination = document.querySelector('.pagination');
            pagination.innerHTML = '';
            if (currentPage > 1) {
                pagination.innerHTML += `<a href="#" onclick="loadPage(${currentPage - 1}, '${keyword}')">« Previous</a>`;
            }
            for (let i = 1; i <= totalPages; i++) {
                pagination.innerHTML += `<a href="#" class="${i === currentPage ? 'active' : ''}" onclick="loadPage(${i}, '${keyword}')">${i}</a>`;
            }
            if (currentPage < totalPages) {
                pagination.innerHTML += `<a href="#" onclick="loadPage(${currentPage + 1}, '${keyword}')">Next »</a>`;
            }
        }

        // Load Page via AJAX
        function loadPage(page, keyword) {
            fetch(`MemberServlet?action=search&keyword=${encodeURIComponent(keyword)}&page=${page}`)
                .then(response => response.json())
                .then(data => {
                    updateTable(data.members);
                    updatePagination(data.currentPage, data.totalPages, keyword);
                })
                .catch(error => console.error('Error:', error));
        }

        // Sort Table
        let currentSortColumn = '${sortColumn}';
        let currentSortOrder = '${sortOrder}';
        function sortTable(column) {
            const order = (currentSortColumn === column && currentSortOrder === 'asc') ? 'desc' : 'asc';
            currentSortColumn = column;
            currentSortOrder = order;
            const keyword = document.getElementById('keyword').value;
            fetch(`MemberServlet?action=search&keyword=${encodeURIComponent(keyword)}&page=1&sortColumn=${column}&sortOrder=${order}`)
                .then(response => response.json())
                .then(data => {
                    updateTable(data.members);
                    updatePagination(data.currentPage, data.totalPages, keyword);
                    updateSortIndicators(column, order);
                })
                .catch(error => console.error('Error:', error));
        }

        // Update Sort Indicators
        function updateSortIndicators(column, order) {
            ['id', 'name', 'email', 'createdAt'].forEach(col => {
                const indicator = document.getElementById(`sort-${col}`);
                indicator.textContent = col === column ? (order === 'asc' ? '↑' : '↓') : '';
            });
        }

        // Modal Handling
        function openAddModal() {
            document.getElementById('modalTitle').textContent = 'Add Member';
            document.getElementById('memberId').value = '';
            document.getElementById('name').value = '';
            document.getElementById('email').value = '';
            document.getElementById('memberModal').style.display = 'flex';
        }

        function openEditModal(id, name, email) {
            document.getElementById('modalTitle').textContent = 'Edit Member';
            document.getElementById('memberId').value = id;
            document.getElementById('name').value = name;
            document.getElementById('email').value = email;
            document.getElementById('memberModal').style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('memberModal').style.display = 'none';
            document.getElementById('nameError').style.display = 'none';
            document.getElementById('emailError').style.display = 'none';
        }

        // Form Submission with Validation
        function submitMember(event) {
            event.preventDefault();
            const id = document.getElementById('memberId').value;
            const name = document.getElementById('name').value;
            const email = document.getElementById('email').value;
            const nameError = document.getElementById('nameError');
            const emailError = document.getElementById('emailError');

            // Client-side Validation
            let isValid = true;
            if (name.length < 2) {
                nameError.style.display = 'block';
                isValid = false;
            } else {
                nameError.style.display = 'none';
            }
            if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                emailError.style.display = 'block';
                isValid = false;
            } else {
                emailError.style.display = 'none';
            }

            if (!isValid) return;

            // AJAX Submit
            const action = id ? 'update' : 'add';
            fetch('MemberServlet', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `action=${action}&id=${id}&name=${encodeURIComponent(name)}&email=${encodeURIComponent(email)}`
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        closeModal();
                        loadPage(1, document.getElementById('keyword').value);
                    } else {
                        alert('Error: ' + data.message);
                    }
                })
                .catch(error => console.error('Error:', error));
        }

        // Delete Confirmation
        function confirmDelete() {
            return confirm('Are you sure you want to delete this member?');
        }
    </script>
</body>
</html>