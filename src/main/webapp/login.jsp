<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
	<title>Login to your account</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>
	<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
	
	<div class="container">
		<% if (errorMessage != null) { %>
		    <div class="error-message"><%= errorMessage %></div>
		<% } %>
		<div class="logo">My-ECommerce</div>
    	<div class="login-item">
			<form action="LoginServlet" method="post" class="form form-login">
		        <div class="form-field">
			        <label class="user" for="login-username">
			        	<span class="hidden">Username</span>
		        	</label>
					<input id="login-username" type="text" class="form-input" 
							placeholder="Username" name="userName" required/>
				</div>
				<div class="form-field">
					<label class="lock" for="login-password">
						<span class="hidden">Password</span>
					</label>
		          <input id="login-password" type="password" class="form-input" 
		          		placeholder="Password" name="userPwd" required>
				</div>
				<div class="form-field">
					<input type="submit" value="Login"/>
				</div>
			</form>
		</div>
	</div>
</body>
</html>