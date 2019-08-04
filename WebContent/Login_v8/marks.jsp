<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style><%@include file="/WEB-INF/css/style.css"%></style>
<style><%@include file="/WEB-INF/css/b1.css"%></style>
<style><%@include file="/WEB-INF/css/b2.css"%></style>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="icon" type="image/png" href="tableUI/images/icons/favicon.ico"/>
<link rel="stylesheet" type="text/css" href="tableUI/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="tableUI/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="tableUI/vendor/animate/animate.css">
<link rel="stylesheet" type="text/css" href="tableUI/vendor/select2/select2.min.css">
<link rel="stylesheet" type="text/css" href="tableUI/vendor/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet" type="text/css" href="tableUI/css/util.css">
<link rel="stylesheet" type="text/css" href="tableUI/css/main.css">
<script><%@include file="/WEB-INF/js/j1.js"%></script>
<script><%@include file="/WEB-INF/js/j2.js"%></script>
<script src="tableUI/vendor/jquery/jquery-3.2.1.min.js"></script>
<script src="tableUI/vendor/bootstrap/js/popper.js"></script>
<script src="tableUI/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="tableUI/vendor/select2/select2.min.js"></script>
<script src="tableUI/js/main.js"></script>

<title>Insert title here</title>
</head>
<body>
<nav class="navbar navbar-dark bg-dark">
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
        <a class="nav-link" href="help.jsp" style="color :aliceblue"><i class="fa fa-sign-out"></i><strong> Logout</strong></a>
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
Statement statement1=null,marksstatement=null;
ResultSet marksresultset=null,qaresultset=null;
String current_id;
%>
<%
if(null == session.getAttribute("user")){
%>
<a href="index.jsp"><img id="error" src="e.JPG"></a>

<%	
}
else{
try{
marksstatement = c.createStatement();
statement1=c.createStatement();
current_id = (String)session.getAttribute("user");
String sql1 ="set search_path to dbms_sri"; 
String marksquery ="select * from (select exam_id,exam_name,exam_date, sum from (select sum(obtained_marks),exam_id from answers where student_id="+session.getAttribute("user")+" group by exam_id ) as r1 natural join exam) as r2 join (select sum(max_marks) as total,exam_id from exam_questions group by exam_id) as r3 on r2.exam_id =r3.exam_id";
try{
statement1.executeQuery(sql1);
}catch(Exception ep){
}
marksresultset = marksstatement.executeQuery(marksquery);
%>
<div class="limiter">
<div class="container-table100">
<div class="wrap-table100">
<div class="table">
<div class="row header">
	<div class="cell">
		Exam name
	</div>
	<div class="cell">
Exam Date	</div>
	<div class="cell">
Obtained Marks	</div>
	<div class="cell">
Total Marks	</div>
</div>
<% 
while(marksresultset.next()){
%>
	<div class="row">
	<div class="cell" data-title="Exam Name">
<a href="attempqa.jsp?examid=<%=marksresultset.getString("exam_id")%>"> <%=marksresultset.getString("exam_name") %></a>
	</div>
	<div class="cell" data-title="Exam Date">
<%=marksresultset.getString("exam_date") %>	</div>
	<div class="cell" data-title="Obtained Marks">
<%=marksresultset.getString("sum") %>	</div>
	<div class="cell" data-title="Total Marks">
<%=marksresultset.getString("total") %>	</div>
</div>
<%
}
} catch (Exception e) {
		out.println(e);
		}
}
%>
</div>
</div>
</div>
</div>
</body>
</html>