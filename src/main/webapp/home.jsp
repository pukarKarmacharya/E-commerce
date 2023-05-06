<%@page import="resources.MyConstants"%>
<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@page import="controller.dbconnection.DbConnection"%>
<%@page import="controller.statemanagement.SessionManage"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
    
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
	<title>Welcome to Reeven Store</title>
	<link rel="stylesheet" type="text/css" 
	href="${pageContext.request.contextPath}/css/home.css"/>
	<style type="text/css">
        body {
            background-color: lightblue;
        }
    </style>
</head>

<body>
	<sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/reeven_store" user="root" password=""/>
	
	<!-- Executing Query Using SQL Tag Library -->
	<sql:query var="allProduct" dataSource="${dbConnection}">
		SELECT product_name, price, stock, brand, category  FROM products
	</sql:query>
		
	<%-- <div class="flex-container">
	  	<h1 class="logo"><a href="#">Brand</a></h1>
	  	<ul class="navigation">
	    	<li><a href="#">Home</a></li>
	    	<li><a href="#">About</a></li>
		    <li><a href="#">Contact</a></li>
		    <li><a href="#">Profile</a></li>
		    <li>
		    	<form action="
		    				<%if(!mySession.checkUser(user)){
		    					out.print(mainPath);%>/login.jsp<%
		   					} 
		    				else {
		    					out.print(mainPath);%>/LogoutServlet<%
		   					}%>
		    			"
		    	method="post">
		  			<input type="submit" value="
		    			<%if(mySession.checkUser(user)){%>
				    		Logout
				   		<%}else{%>
				    		Login
				   		<%}%>
			   		"/>
		    	</form>
		    </li>
	  	</ul>
  	</div> --%>
  	
  	<header>
        <h1 class="logo"><a href="#">Reeven Store</a></h1>
        <nav>
            <ul>
                <li class="selected"><a href="#">Home</a></li>
                <li><a href="#">Product</a></li>
                <li><a href="${pageContext.request.contextPath}/pages/admin.jsp">Admin</a></li>
                <li><a href="#">Contact</a></li>
                <li><a href="${pageContext.request.contextPath}/pages/user.jsp">Profile</a></li>
                <li>
		    		<form action="
		    				<%if(!mySession.checkUser(user)){
		    					out.print(mainPath);%>/login.jsp<%
		   					} 
		    				else {
		    					out.print(mainPath);%>/LogoutServlet<%
		   					}%>
		    				"
		    		method="post">
		  			<input type="submit" value="
		    			<%if(mySession.checkUser(user)){%>
				    		Logout
				   		<%}else{%>
				    		Login
				   		<%}%>
			   		"/>
		    		</form>
		    	</li>
            </ul>
        </nav>
    </header>
  
  	<div class="box"></div>
  
  	<div class="grid">
        <div class="grid-container">
            <img class="pic" src="">
            <h3>Bosh Jigsaw</h3>
            <p>NRP. 100</p>
            <p><button>Add to Cart</button></p>
        </div>

        <div class="grid-container">
            <img class="pic" src="">
            <h3>Hammer</h3>
            <p>NRP. 100</p>
            <p><button>Add to Cart</button></p>
        </div>
        <div class="grid-container">
            <img class="pic" src="">
            <h3>RJ45 Clip</h3>
            <p>NRP. 100</p>
            <p><button>Add to Cart</button></p>
        </div>
        <div class="grid-container">
            <img class="pic" src="">
            <h3>Wire Stripper</h3>
            <p>NRP. 100</p>
            <p><button>Add to Cart</button></p>
        </div>
        <div class="grid-container">
            <img class="pic" src="">
            <h3>50mm Lock</h3>
            <p>NRP. 100</p>
            <p><button>Add to Cart</button></p>
        </div>
    </div>
  	
		<div class="users-info">
 	    		<div class="users">
 	    			<c:forEach var="product" items="${allProduct.rows}">
         		   <div class="card">
                <img src="http://localhost:8081/images/${product.image} " class="card-img-top" alt="...">
                <div class="card-body">
                    <h4 class="card-title">${product.product_name} ${product.price}</h4>
                    <h5 class="card-text">${product.product_name}</h5>
                </div>
           	     <form method="post">
                        <input type="hidden" name="updateId" value="${product.product_name}" />
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
  	<footer>
        <table width="100%">
            <tr>
                <th>
                    <div style="color:black;font-family:Courier New;">
                        <p>&copy; Reeven Store</p>
                    </div>
                </th>
            </tr>
        </table>
    </footer>
</body>
</html>