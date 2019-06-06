<style><%@include file="/WEB-INF/css/style.css"%></style>
<style><%@include file="/WEB-INF/css/b1.css"%></style>
<style><%@include file="/WEB-INF/css/b2.css"%></style>

<script><%@include file="/WEB-INF/js/j1.js"%></script>
<script><%@include file="/WEB-INF/js/j2.js"%></script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="container">
<form name="f2" method="get" action="loginHelper.jsp">
	<label>StudentID : </label>
	<br>
	<input type="text" placeholder="201601xxx" name="student_id"> 
	<br>
	<label>Password : </label>
	<br>
	<input type="password" placeholder="*****" name="student_password"> 
	<br>
	<br>
	<button type="submit" class="btn btn-primary">Log in</button>
</form> 
</div>   
</body>
</html>