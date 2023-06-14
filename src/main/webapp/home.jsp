<%@page import="resources.MyConstants"%>
<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@page import="controller.dbconnection.DbConnection"%>
<%@page import="controller.statemanagement.SessionManage"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%!SessionManage mySession = new SessionManage();%>
<%
//setting absolute path
String mainPath = request.getContextPath();
// invoking session username
String user = (String) session.getAttribute("user");
String search = (String) session.getAttribute("search");

// Creating new database model object
DbConnection dbConn = new DbConnection();

// Deleting item on database when delete button is clicked.
if (request.getParameter("deleteId") != null) {
	String id = request.getParameter("deleteId");
	dbConn.deleteUser(MyConstants.DELETE_USER, id);
}

/* if (request.getParameter("addToCart") != null) {
	int id = Integer.parseInt(request.getParameter("addToCart"));
	dbConn.addToCart(MyConstants.ADDTOCART, id, user);
} */
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome to Reeven Store</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/home.css" />
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
	<sql:query var="allProduct" dataSource="${dbConnection}">
		SELECT product_id, product_name, price, stock, brand, category, image FROM product
	</sql:query>

	<header>
		<h1 class="logo">
			<a href="#">Reeven Store</a>
		</h1>
		<nav>
			<ul>
				<li class="selected"><a href="#">Home</a></li>
				<li><a
					href="${pageContext.request.contextPath}/pages/product.jsp">Product</a></li>
				<li><a
					href="${pageContext.request.contextPath}/pages/about.html">Contact</a></li>
				<li><a href="${pageContext.request.contextPath}/pages/user.jsp">Profile</a></li>
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

	<div class="grid">
		<c:forEach var="product" items="${allProduct.rows}">
			<div class="grid-container">
				<img src="http://localhost:8085/images/${product.image} "
					class="pic" alt="...">
				<h3>${product.product_name}</h3>
				<p class="text2">Rs. ${product.price}</p>
				<form action="${pageContext.request.contextPath}/AddCart" method="post">
					<input type="hidden" name="productName" value="${product.product_name}">
					<input type="hidden" name="price" value="${product.price}">
					<input type="hidden" name="stock" value="${product.stock}">
					<input type="hidden" name="image" value="${product.image}">
					<input type="hidden" name="productId" value="${product.product_id}">
					<input type="hidden" name="user" value="<%=user%>">
					<input type="submit" value="AddToCart" class="submit_btn">
					</form>
			</div>
		</c:forEach>
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