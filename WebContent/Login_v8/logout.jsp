<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style><%@include file="/WEB-INF/css/style.css"%></style>
<style><%@include file="/WEB-INF/css/b1.css"%></style>
<style><%@include file="/WEB-INF/css/b2.css"%></style>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"><body>

<script><%@include file="/WEB-INF/js/j1.js"%></script>
<script><%@include file="/WEB-INF/js/j2.js"%></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<nav class="navbar navbar-dark bg-dark"">
  <div class="navbar-header ">
      <a class="navbar-brand" href="/">DBMS</a>
  </div>
  <ul class="nav nav-tabs">
    <li class="nav-item">
      <a class="nav-link" href="loginHelper.jsp" style="color :aliceblue" > <i class="fa fa-home"></i> <strong> Home</strong></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="viewQA.jsp" style="color :aliceblue"><i class="fa fa-file"></i><strong>Exam</strong></a>
    </li>
    <li class="nav-item">
        <a class="nav-link active" href="marks.jsp"><i class="fa fa-list-ul"></i><strong> Marks</strong></a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="help.jsp" style="color :aliceblue"><i class="fa fa-info-circle"></i><strong> Help</strong></a>
    </li>     
    <li class="nav-item">
        <a class="nav-link" href="logout.jsp" style="color :aliceblue"><i class="fa fa-sign-out"></i><strong> Logout</strong></a>
    </li>  
  </ul>
</nav>
</body>
</html>
<%
session.invalidate(); 
if(null == session.getAttribute("user")){
%>
<a href="index.jsp"><img id="error" src="e.JPG"></a>
<%	
}
else{
	
}
out.println("ss");
%>
