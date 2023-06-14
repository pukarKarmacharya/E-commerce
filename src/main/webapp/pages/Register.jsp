<%@ page import="java.sql.Connection"%>
<%@ page import="controller.dbconnection.DbConnection"%>

<%@ page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Register your account now</title>
	<link rel="stylesheet" type="text/css" 
		href="${pageContext.request.contextPath}/css/register.css"/>
</head>
<body>
	<div class="wrapper">
		<div class="registration_form">
			<div class="title">
				Registration Form
			</div>
	
			<form action="${pageContext.request.contextPath}/UserRegister" method="post" enctype="multipart/form-data">
				<div class="form_wrap">
					<div class="input_grp">
						<div class="input_wrap">
							<label for="firstName">First Name</label>
							<input type="text" id="firstName" name="firstName">
						</div>
						<div class="input_wrap">
							<label for="lastName">Last Name</label>
							<input type="text" id="lastName" name="lastName">
						</div>
					</div>
					<div class="input_wrap">
						<label for="username">UserEmail</label>
						<input type="email" id="username" name="username">
					</div>
					<div class="input_wrap">
						<label for="password">Password</label>
						<input type="password" id="password" name="password">
					</div>
					<div class="input_wrap">
						<label for="role">Role</label>
						<input type="text" id="role" name="role">
					</div>
					<div class="input_wrap">
				        <label for="image">Profile Picture</label>
				        <input type="file" id="image" name="image">
				    </div>
					<div class="input_wrap">
						<input type="submit" value="Register Now" class="submit_btn">
					</div>
   				</div>
			</form>
		</div>
	</div>
</body>
</html>