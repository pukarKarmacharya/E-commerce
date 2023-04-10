<%@page import="controller.statemanagement.SessionManage"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%! SessionManage mySession = new SessionManage(); %>
<% String mainPath = request.getContextPath(); %>
<% String user = (String) session.getAttribute("user");%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Welcome to E-commerce</title>
	<link rel="stylesheet" type="text/css" 
	href="${pageContext.request.contextPath}/css/home.css"/>
</head>

<body>
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
</body>
</html>