<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
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
<nav class="navbar navbar-dark bg-dark"">
  <div class="navbar-header ">
      <a class="navbar-brand" href="/">DBMS</a>
  </div>
  <ul class="nav nav-tabs">
    <li class="nav-item">
      <a class="nav-link active" href="#" ><i class="fas fa-home"></i><strong> Home</strong></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="" style="color :aliceblue"><i class="fas fa-info-circle"></i><strong> Q & A</strong></a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="" style="color :aliceblue"><i class="fas fa-sign-out-alt"></i><strong> Marks</strong></a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="help" style="color :aliceblue"><i class="fas fa-question-circle"></i><strong> Help</strong></a>
    </li>     
    <li class="nav-item">
        <a class="nav-link" href="help" style="color :aliceblue"><i class="fas fa-sign-out-alt"></i><strong> Logout</strong></a>
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
Statement statement = null,statement1=null,comingexamstatement=null;
Statement qastatement=null;
ResultSet comingexamresultset=null,qaresultset=null;
String current_id;
%>
<%
try{
qastatement=c.createStatement();
comingexamstatement = c.createStatement();
statement1=c.createStatement();
current_id = request.getParameter("student_id");
String sql1 ="set search_path to dbms_sri"; 
String comingexamquery ="select * from exam where exam_date > CURRENT_DATE";
try{
statement1.executeQuery(sql1);
}catch(Exception ep){
}
comingexamresultset = comingexamstatement.executeQuery(comingexamquery);
%>
<div id="welcome">
Welcome
</div>
<table class="table table-bordered" border="1">
<tr>
<td class="tablei"><b>Exam name</b></td>
<td class="tablei"><b>Exam Date</b></td>
<td class="tablei"><b>Exam time</b></td>
<td class="tablei"><b>Exam Duration</b></td>
</tr>
<% 
while(comingexamresultset.next()){
%>
	<tr>
	<td><a href="attempqa.jsp?examid=<%=comingexamresultset.getString("exam_id")%>"> <%=comingexamresultset.getString("exam_name") %></a></td>
	<td><%=comingexamresultset.getString("exam_date") %></td>
	<td><%=comingexamresultset.getString("exam_time") %></td>
	<td><%=comingexamresultset.getString("exam_duration") %></td>
	</tr>
<%
}
} catch (Exception e) {
		out.println(e);
		}
%>
</table>
</body>
</html>