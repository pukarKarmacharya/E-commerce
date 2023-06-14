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
	String category = (String) session.getAttribute("category");
	String brand = (String) session.getAttribute("brand");
	String filter = (String) session.getAttribute("filter");
	
	

	// Creating new database model object
	DbConnection dbConn = new DbConnection();

	// Deleting item on database when delete button is clicked.
	if (request.getParameter("deleteId") != null) {
	    String id = request.getParameter("deleteId");
	    dbConn.deleteUser(MyConstants.DELETE_USER, id);
	}
	
/* 	if (request.getParameter("addToCart") != null) {
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
	href="${pageContext.request.contextPath}/css/product.css" />
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

	<sql:query var="searchCategory" dataSource="${dbConnection}">
		SELECT product_id, product_name, price, image FROM product WHERE category=?;
		<sql:param value="${category}" />
	</sql:query>
	
	<sql:query var="searchBrand" dataSource="${dbConnection}">
		SELECT product_id, product_name, price, image FROM product WHERE brand=?;
		<sql:param value="${brand}" />
	</sql:query>
	
<%-- 	<sql:query var="allfilterPrice" dataSource="${dbConnection}">
		SELECT product_id, product_name, price, image FROM product ORDER BY price ASC;
		<sql:param value="${filter}" />
	</sql:query> --%>
	
<%-- 	<sql:query var="allfilterRating" dataSource="${dbConnection}">
		SELECT product_id, product_name, price, image FROM product ORDER BY ? ASC;
		<sql:param value="${filter}" />
	</sql:query> --%>
	
	<sql:query var="allCategory" dataSource="${dbConnection}">
		SELECT DISTINCT category FROM product;
	</sql:query>
	
	<sql:query var="allBrand" dataSource="${dbConnection}">
		SELECT DISTINCT brand FROM product;
	</sql:query>
	

	<header>
		<h1 class="logo">
			<a href="#">Reeven Store</a>
		</h1>
		<nav>
			<ul>
				<li><a href="${pageContext.request.contextPath}/home.jsp">Home</a></li>
				<li class="selected"><a href="#">Product</a></li>
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
			</ul>
		</nav>
	</header>

	<div class="box"></div>
	<h2>Search Products</h2>
	<div class="row">
		<div class="leftcolumn">
			<div class="card">
				<form action="${pageContext.request.contextPath}/SearchBy" method="post">
					<p>Search By Category</p>
					<select name="category" id="category">
						<c:forEach var="categorylist" items="${allCategory.rows}">
							<option value="${categorylist.category}">${categorylist.category}</option>
						</c:forEach>
					</select> 
					<input type="submit" name="category" value="Search" class="submit_btn">
				</form>
			</div>
			<div class="card">
				<form action="${pageContext.request.contextPath}/SearchBy" method="post">
					<p>Search By Brand</p>
					<select name="brand" id="brand">
						<c:forEach var="brandlist" items="${allBrand.rows}">
							<option value="${brandlist.brand}">${brandlist.brand}</option>
						</c:forEach>
					</select> 
					<input type="submit" name="brand" value="Search" class="submit_btn">
				</form>
			</div>
			<div class="card">
				<form action="${pageContext.request.contextPath}/SearchBy" method="post">
					<p>Filter</p>
					<select name="filter" id="filter">
							<option value="DESC">Highesh Price</option>
							<option value="price">Lowest Price</option>
							<option value="DESC">Highest Rating</option>
							<option value="rating">Lowest Rating</option>
					</select> 
					<input type="submit" name="filter" value="Filter" class="submit_btn">
				</form>
			</div>
		</div>
		
		<div class="rightcolumn">
			<div class="cardright">
				<div class="grid">
					<c:forEach var="category" items="${searchCategory.rows}">
						<div class="grid-container">
							<img src="http://localhost:8085/images/${category.image} " class="pic"
								alt="...">
							<h3>${category.product_name}</h3>
							<p class="text2">Rs. ${category.price}</p>
							<form method="post">
								<input type="hidden" name="addToCart" value="${category.product_id}" />
								<button type="submit">addToCart</button>
							</form>
						</div>
					</c:forEach>
					<c:forEach var="brand" items="${searchBrand.rows}">
						<div class="grid-container">
							<img src="http://localhost:8085/images/${brand.image} " class="pic"
								alt="...">
							<h3>${brand.product_name}</h3>
							<p class="text2">Rs. ${brand.price}</p>
							<form method="post">
								<input type="hidden" name="addToCart" value="${brand.product_id}" />
								<button type="submit">addToCart</button>
							</form>
						</div>
					</c:forEach>
			<%-- 		<c:forEach var="priceFilter" items="${allfilterPrice.rows}">
						<div class="grid-container">
							<img src="http://localhost:8085/images/${priceFilter.image} " class="pic"
								alt="...">
							<h3>${priceFilter.product_name}</h3>
							<p class="text2">Rs. ${priceFilter.price}</p>
							<form method="post">
								<input type="hidden" name="addToCart" value="${priceFilter.product_id}" />
								<button type="submit">addToCart</button>
							</form>
						</div>
					</c:forEach> --%>
					<%-- <c:forEach var="filterAsc" items="${allfilterAsc.rows}">
						<div class="grid-container">
							<img src="http://localhost:8085/images/${filterAsc.image} " class="pic"
								alt="...">
							<h3>${filterAsc.product_name}</h3>
							<p class="text2">Rs. ${filterAsc.price}</p>
							<form method="post">
								<input type="hidden" name="addToCart" value="${filterAsc.product_id}" />
								<button type="submit">addToCart</button>
							</form>
						</div>
					</c:forEach> --%>
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