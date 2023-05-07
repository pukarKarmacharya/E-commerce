<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page import="resources.MyConstants"%>
<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@page import="controller.dbconnection.DbConnection"%>
<%@page import="controller.statemanagement.SessionManage"%>
    
    <%! SessionManage mySession = new SessionManage(); %>
<% 
	//setting absolute path
	String mainPath = request.getContextPath();
	// invoking session username
	String user = (String) session.getAttribute("user");

	// Creating new database model object
	DbConnection dbConn = new DbConnection();

	// Deleting item on database when delete button is clicked.
	if (request.getParameter("deleteId") != null) {
	    String id = request.getParameter("deleteId");
	    dbConn.deleteUser(MyConstants.DELETE_USER, id);
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/admin.css" />
<style type="text/css">
body {
	background-color: lightblue;
}
</style>
</head>
<body>
	<sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://localhost:3306/reeven_store" user="root" password="" />

	<!-- Executing Query Using SQL Tag Library -->
	<sql:query var="allUser" dataSource="${dbConnection}">
		SELECT first_name, last_name, username, image  FROM register WHERE role="user"
	</sql:query>

	<!-- Executing Query Using SQL Tag Library -->
	<sql:query var="allProduct" dataSource="${dbConnection}">
		SELECT product_name, price, stock, brand,image category  FROM product
	</sql:query>

	<header>
		<h1 class="logo">
			<a href="#">Reeven Store</a>
		</h1>
		<nav>
			<ul>
				<li><a href="${pageContext.request.contextPath}/home.jsp">Home</a></li>
				<li class="selected"><a
					href="${pageContext.request.contextPath}/pages/admin.jsp">Admin</a></li>
				<li><a
					href="${pageContext.request.contextPath}/pages/about.html">Contact</a></li>
				<li>
					<form
						action="
		    				<%if (!mySession.checkUser(user)) {
	out.print(mainPath);%>/login.jsp<%} else {
								out.print(mainPath);%>/LogoutServlet<%}%>
		    				"
						method="post">
						<input type="submit"
							value="
		    			<%if (mySession.checkUser(user)) {%>
				    		Logout
				   		<%} else {%>
				    		Login
				   		<%}%>
			   		" />
					</form>
				</li>
			</ul>
		</nav>
	</header>

	<div class="box"></div>

	<div class="row">
		<div class="leftcolumn">
			<div class="card">
				<h2>Add Product</h2>
				<form action="${pageContext.request.contextPath}/ProductAdd"
					method="post" enctype="multipart/form-data">
					<div>
						<div>
							<div>
								<label for="productName"><h3>Product Name</h3></label> <input
									type="text" id="productName" name="productName">
							</div>
							<div>
								<label for="price"><p>Price</p></label> <input type="text"
									id="price" name="price">
							</div>
						</div>
						<div>
							<label for="stock">Stock</label> <input type="text" id="stock"
								name="stock">
						</div>
						<div>
							<label for="brand">Brand</label> <input type="text" id="brand"
								name="brand">
						</div>
						<div>
							<label for="category">Category</label> <input type="text"
								id="category" name="category">
						</div>
						<div>
							<label for="image">Product Image</label> <input type="file"
								id="image" name="image">
						</div>
						<input type="hidden" name="user" value="<%=user%>">
						<div>
							<br> <input type="submit" value="Add Product"
								class="submit_btn">
						</div>
					</div>
				</form>
			</div>
			<div class="card">
				<div class="grid">
					
					<c:forEach var="product" items="${allProduct.rows}">
						<div class="grid-container">
							<img src="http://localhost:8085/images/${product.image} "
								class="pic" alt="...">

							<h4 class="card-title">${product.product_name}
								${product.price}</h4>
							<h5 class="card-text">${product.product_name}</h5>
							<form method="post">
								<input type="hidden" name="updateId"
									value="${product.product_name}" />
								<button type="submit">Update</button>
							</form>
							<form method="post">
								<input type="hidden" name="deleteId" value="${product.username}" />
								<button type="submit">Delete</button>
							</form>
						</div>
					</c:forEach>

				</div>
			</div>
		</div>
	

		<div class="rightcolumn">
			<div class="card">
				<h2>Users</h2>
				<div class="users-info">
					<div class="users">
						<c:forEach var="user" items="${allUser.rows}">
							<div class="card">
								<img src="http://localhost:8085/images/${user.image} "
									class="card-img-top" alt="...">
								<div class="card-body">
									<h4 class="card-title">${user.first_name}${user.last_name}</h4>
									<h5 class="card-text">${user.username}</h5>
								</div>
								<form method="post">
									<input type="hidden" name="updateId" value="${user.username}" />
									<button type="submit">Update</button>
								</form>
								
								<form method="post">
									<input type="hidden" name="deleteId" value="${user.username}" />
									<button type="submit">Delete</button>
								</form>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="card">
				<h2>Follow Us</h2>
				<p>
					<a href="https://www.facebook.com/">@Facebook</a>
				</p>
				<p>
					<a href="https://www.instagram.com/">@instagram</a>
				</p>
			</div>
		</div>
	</div>	
	</div>

	<footer>
		<table width="100%">
			<tr>
				<th>
					<div style="color: black; font-family: Courier New;">
						<p>&copy; Reeven Store</p>
					</div>
				</th>
			</tr>
		</table>
	</footer>
</body>
</html>