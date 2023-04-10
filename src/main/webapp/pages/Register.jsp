<%@ page import="java.sql.Connection"%>
<%@ page import="week5.DbConnection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="Student" class ="week5.Student" scope="page"/>
	<jsp:setProperty property="*" name="Student"/>
	<%
	Connection con = DbConnection.getConnection();
	String query = "Insert into register(first_name,last_name,username,password) value(?,?,?,?)";
	PreparedStatement st = con.prepareStatement(query);
	st.setString(1, Student.getName());
	st.setString(2, Student.getModule());
	st.setString(3, Student.getGender());
	st.setString(4, Student.getNumber());
	st.setShort(5, Student.getAge());

	int result = st.executeUpdate();
	if(result> 0) {
		out.print("Data inserted");
	}else {
		out.print("Data Failed");
	}
	
	
	%>
</body>
</html>