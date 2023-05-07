<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<title>Login to your account</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>
	<% 
	String errorMessage = (String) request.getAttribute("errorMessage");
	String registerMessage = (String) request.getHeader("registerMessage");
	%>
	<% if (registerMessage != null) { %>
	<div class="register-message"><%= registerMessage %></div>
	<% } %>
	<div class="container">
		<% if (errorMessage != null) { %>
		<div class="error-message"><%= errorMessage %></div>
		<% } %>
		<div class="logo">Reeven Store</div>
		<div class="login-item">
			<form action="LoginServlet" method="post" class="form form-login">
				<div class="form-field">
					<label class="user" for="login-username"> <span
						class="hidden">Email</span>
					</label> <input id="login-username" type="text" class="form-input"
						placeholder="User@email.com" name="userName" required />
				</div>
				<div class="form-field">
					<label class="lock" for="login-password"> <span
						class="hidden">Password</span>
					</label> <input id="login-password" type="password" class="form-input"
						placeholder="Password" name="userPwd" required>
				</div>
				<div class="form-field">
					<input type="submit" value="Login" />
				</div>
				<div class="form-field">
					<a href="${pageContext.request.contextPath}/pages/register.jsp">Create
						Your New Account</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>