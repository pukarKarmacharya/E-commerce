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
	<title>Welcome to E-commerce</title>
	<link rel="stylesheet" type="text/css" 
	href="${pageContext.request.contextPath}/css/home.css"/>
</head>

<body>
	<sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/reeven_store" user="root" password=""/>
	
	<!-- Executing Query Using SQL Tag Library -->
	<sql:query var="allUser" dataSource="${dbConnection}">
		SELECT first_name, last_name, username, image  FROM register WHERE role="user"
	</sql:query>
		
	<div class="flex-container">
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
  	</div>
  
	<div class="users-info">
 	    <div class="users">
 	    <c:forEach var="user" items="${allUser.rows}">
            <div class="card">
                <img src="http://localhost:8080/images/${user.image} " class="card-img-top" alt="...">
                <div class="card-body">
                    <h4 class="card-title">${user.first_name} ${user.last_name}</h4>
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
  	
</body>
</html>