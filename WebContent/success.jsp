<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.dbms.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="obj" class="com.dbms.Register"/>
<jsp:setProperty property="*" name="obj"/>
<%
	int status = RegisterDAO.registerStudent(obj);
	if(status > 0)
		out.println("Inserted Successfully");
	else
		out.println("Try again !");

%>
</body>
</html>