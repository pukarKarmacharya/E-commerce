<%@page import="resources.MyConstants"%>
<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@page import="controller.dbconnection.DbConnection"%>
<%@page import="controller.statemanagement.SessionManage"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%! SessionManage mySession = new SessionManage(); %>
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
	
	if (request.getParameter("addToCart") != null) {
	    int id = Integer.parseInt(request.getParameter("addToCart"));
	    dbConn.addToCart(MyConstants.ADDTOCART, id, user);
	}
	
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

	<sql:query var="allSearch" dataSource="${dbConnection}">
		SELECT product_id, product_name, price, stock, brand, image  FROM product WHERE category="search"
	</sql:query>

	<header>
		<h1 class="logo">
			<a href="#">Reeven Store</a>
		</h1>
		<nav>
			<ul>
				<li class="selected"><a href="#">Home</a></li>
				<li><a href="${pageContext.request.contextPath}/home.jsp">Product</a></li>
				<li><a
					href="${pageContext.request.contextPath}/pages/about.html">Contact</a></li>
				<li><a href="${pageContext.request.contextPath}/pages/user.jsp">Profile</a></li>
				<li>
					<form
						action="
		    				<%if(!mySession.checkUser(user)){
		    					out.print(mainPath);%>/login.jsp<%
		   					} 
		    				else {
		    					out.print(mainPath);%>/LogoutServlet<%
		   					}%>
		    				"
						method="post">
						<input type="submit"
							value="
		    			<%if(mySession.checkUser(user)){%>
				    		Logout
				   		<%}else{%>
				    		Login
				   		<%}%>
			   		" />
					</form>
				</li>
				<li>
					<form action="${pageContext.request.contextPath}/SearchBy"
						method="post">
						<input type="text" id="search" name="search"> <input
							type="submit" value="search" class="submit_btn">
					</form>
					<h2></h2>
				</li>
			</ul>
		</nav>
	</header>

	<div class="box"></div>

	<div class="grid">
		<c:forEach var="product" items="${allProduct.rows}">
			<div class="grid-container">

				<div class="card">
					<img src="http://localhost:8085/images/${product.image} "
						class="pic" alt="...">
					<div class="card-body">
						<h4 class="card-title">${product.product_name}
							${product.price}</h4>
						<h3 class="card-text">${product.product_name}</h3>
					</div>
					<form method="post">
						<input type="hidden" name="updateId"
							value="${product.product_name}" />
						<button type="submit">Update</button>
					</form>
					<form method="post">
						<input type="hidden" name="addToCart"
							value="${product.product_id}" />
						<button type="submit">addToCart</button>
					</form>
				</div>

			</div>
		</c:forEach>

		<c:forEach var="s" items="${allSearch.rows}">

			<div class="grid-container">
				<div class="card">
					<img src="http://localhost:8085/images/${s.image} " class="pic"
						alt="...">
					<div class="card-body">
						<h4 class="card-title">${s.product_name}${s.price}</h4>
						<h3 class="card-text">${s.product_name}</h3>
					</div>
					<form method="post">
						<input type="hidden" name="updateId" value="${s.product_name}" />
						<button type="submit">Update</button>
					</form>
					<form method="post">
						<input type="hidden" name="addToCart" value="${s.product_id}" />
						<button type="submit">addToCart</button>
					</form>
				</div>
				<h2><%=search %></h2>
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