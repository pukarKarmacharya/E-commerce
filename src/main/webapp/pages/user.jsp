<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
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
	if (request.getParameter("firstNameId") != null) {
	    String id = request.getParameter("firstNameId");
	    dbConn.updateUser(MyConstants.UPDATE_USER_INFO, id);
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/user.css" />
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
		SELECT first_name, last_name, image, username  FROM register WHERE username=?;
	<sql:param value="${user}" />
	</sql:query>

<%-- 	<sql:query var="allAddToCart" dataSource="${dbConnection}">
		SELECT product_id, product_name, price,image FROM product WHERE product_id IN (SELECT product_id FROM addtocart)
	</sql:query> --%>

	<sql:query var="allAddToCart" dataSource="${dbConnection}">
		SELECT product_id, product_name, price, sum(quantity) AS qty, sum(amount) AS amt, image, stock FROM addtocart WHERE user_id = (SELECT user_id FROM register WHERE username = ?) GROUP BY product_id ;
	<sql:param value="${user}" />	
	</sql:query>
	
	<sql:query var="allOrder" dataSource="${dbConnection}">
		SELECT sum(quantity) AS qty, sum(amount) AS amt FROM addtocart WHERE user_id = (SELECT user_id FROM register WHERE username = ?);
	<sql:param value="${user}" />	
	</sql:query>

	<header>
		<h1 class="logo">
			<a href="#">Reeven Store</a>
		</h1>
		<nav>
			<ul>
				<li><a href="${pageContext.request.contextPath}/home.jsp">Home</a></li>
				<li><a href="${pageContext.request.contextPath}/home.jsp">Product</a></li>
				<li><a
					href="${pageContext.request.contextPath}/pages/about.html">Contact</a></li>
				<li class="selected"><a
					href="${pageContext.request.contextPath}/pages/user.jsp">Profile</a></li>
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

	<div class="row">
		<div class="leftcolumn">

			<div class="grid">
				<c:forEach var="cart" items="${allAddToCart.rows}">
					<div class="grid-container">
						<img src="http://localhost:8085/images/${cart.image} " class="pic"
							alt="...">
						<h4>${cart.product_name}</h4>
						<p class="text2">Rs. ${cart.price}</p>
						<p>Quantity:- ${cart.qty}</p>
						<p class="text2">Total Amount:- Rs. ${cart.amt}</p>
						<form action="${pageContext.request.contextPath}/OrderBy" method="post">
							<input type="hidden" name="productId" value="${cart.product_id}">
							<input type="hidden" name="quantity" value="${cart.qty}">
							<input type="hidden" name="total" value="${cart.amt}">
							<input type="hidden" name="stock" value="${cart.stock}">
							<input type="hidden" name="user" value="<%=user%>">
							<input type="submit" value="Order" class="submit_btn">
						</form>

					</div>
				</c:forEach>

			</div>
		</div>

		<div class="rightcolumn">
			<div class="card">
					<h3>Your Total Order:</h3>
					<c:forEach var="order" items="${allOrder.rows}">
					<p>Quantity:- ${order.qty }</p>
					<input type="hidden" name="quantity" value="${order.qty}">
					<p class="text2">Total Amount:- Rs. ${order.amt }</p>
					<input type="hidden" name="amount" value="${order.amt}">
					</c:forEach>
			</div>
			<div class="card">
				<h2>Your Profile</h2>
				<div class="users-info">
					<div class="users">
						<c:forEach var="user" items="${allUser.rows}">
							<div class="card">
								<img src="http://localhost:8085/images/${user.image} "
									class="card-img-top" alt="...">
								<div class="card-body">
									<h4 class="card-title">${user.first_name}
										${user.last_name}</h4>
									<h5 class="card-text">${user.username}</h5>
								</div>
								<form method="post">
									First Name:-
									<input type="text" id="firstNameId" name="firstNameId">
									<input type="hidden" name="firstNameId" value="firstNameId" />
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
				<!-- <a href="">Change Password</a> -->
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