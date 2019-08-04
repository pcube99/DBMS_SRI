<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*,java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style><%@include file="/WEB-INF/css/style.css"%></style>
<style><%@include file="/WEB-INF/css/b1.css"%></style>
<style><%@include file="/WEB-INF/css/b2.css"%></style>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"><body>

<script><%@include file="/WEB-INF/js/j1.js"%></script>
<script><%@include file="/WEB-INF/js/j2.js"%></script>
</head>
<body>
<nav class="navbar navbar-dark bg-dark"">
  <div class="navbar-header ">
      <a class="navbar-brand" href="/">DBMS</a>
  </div>
  <ul class="nav nav-tabs">
    <li class="nav-item">
      <a class="nav-link active" href="loginHelper.jsp" > <i class="fa fa-home"></i> <strong> Home</strong></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="viewQA.jsp" style="color :aliceblue"><i class="fa fa-file"></i><strong>Exam</strong></a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="marks.jsp" style="color :aliceblue"><i class="fa fa-list-ul"></i><strong> Marks</strong></a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="help.jsp" style="color :aliceblue"><i class="fa fa-info-circle"></i><strong> Help</strong></a>
    </li>     
    <li class="nav-item">
        <a class="nav-link" href="logout.jsp" style="color :aliceblue"><i class="fa fa-sign-out"></i><strong> Logout</strong></a>
    </li>  
  </ul>
</nav>
<%
Connection c= null;
try{
    Class.forName("org.postgresql.Driver");
    String url = "jdbc:postgresql://localhost:5432/dbms_sri";
    c = DriverManager.getConnection(url, "postgres", "123");
} catch(Exception e) {
    System.out.println("error");
}
if(null == session.getAttribute("user")){
	%>
	<a href="index.jsp"><img id="error" src="e.JPG"></a>
	<%	
	}
else{
try {
Statement ques_submit = null;
Statement s = null;
ResultSet resultSet = null,temp=null;
ques_submit = c.createStatement();
s=c.createStatement();
String search_schema ="set search_path to dbms_sri";
String schemaid="select * from schema_details where schema_name=";
try{
s.executeQuery(search_schema);
}catch(Exception ep){
}
resultSet = ques_submit.executeQuery(schemaid+"'"+request.getParameter("select_schema")+"'");
PreparedStatement stmt;
while(resultSet.next()){
stmt = c.prepareStatement("INSERT into question_bank (question_text, schema_id,correct_answer) values (?,?,?)");
stmt.setString(1, request.getParameter("question"));
stmt.setInt(2, Integer.parseInt(resultSet.getString("schema_id")));
stmt.setString(3, request.getParameter("answer"));
stmt.executeUpdate();
}
%>

<%
		}catch(Exception e) {
			
		}
			}
%>
</body>
</html>