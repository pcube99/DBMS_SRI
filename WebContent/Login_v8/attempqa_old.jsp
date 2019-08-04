<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.lang.*"%>
<%@page import="java.sql.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<style><%@include file="/WEB-INF/css/style.css"%></style>
<style><%@include file="/WEB-INF/css/b1.css"%></style>
<style><%@include file="/WEB-INF/css/b2.css"%></style>

<script><%@include file="/WEB-INF/js/j1.js"%></script>
<script><%@include file="/WEB-INF/js/j2.js"%></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<style><%@include file="/WEB-INF/css/style.css"%></style>
<style><%@include file="/WEB-INF/css/b1.css"%></style>
<style><%@include file="/WEB-INF/css/b2.css"%></style>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"><body>

<script><%@include file="/WEB-INF/js/j1.js"%></script>
<script><%@include file="/WEB-INF/js/j2.js"%></script>
<script type="text/javascript">
function salert(xx){
	var sicon,stitle;
	var temp =document.getElementById(xx);
	if(temp != null && temp.value === ""){
		swal({
			  icon:"warning",
			  title: "Try Again"
			});
		return false;
	}
	else{
		swal({
			  icon: "success",
			  title: "Successfully Submitted"
			});
		return true;
	}
	
}

function removable(x){
	   document.getElementById(x).addAttribute('readonly');;
}
</script>
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
        <a class="nav-link" href="index.jsp" style="color :aliceblue"><i class="fa fa-sign-out"></i><strong> Logout</strong></a>
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
Statement statement1=null,attempqastatement=null,attempqastatementt=null;
Statement statement=null;
ResultSet attempqaresultset=null,qaresultset=null,attempqaresultsett=null,alreadySubmitted=null;
String exam_id;
try{
attempqastatement=c.createStatement();
attempqastatementt=c.createStatement();
statement1=c.createStatement();
exam_id = request.getParameter("examid");
String sql1 ="set search_path to dbms_sri"; 
String attempqaquery ="select question_id,question_no,question_text,max_marks from exam_questions natural join question_bank where exam_id="+request.getParameter("examid");
String alreadysubmittedquery ="select * from answers where exam_id="+request.getParameter("examid")+"and student_id="+session.getAttribute("user")+"and question_id=";

try{
statement1.executeQuery(sql1);
}catch(Exception ep){
}
attempqaresultset = attempqastatement.executeQuery(attempqaquery);
attempqaresultsett = attempqastatementt.executeQuery(attempqaquery);
String student_id=(String)session.getAttribute("user");  
%>
<div id="welcome">
Welcome

</div>
<div class="container">
<ul class="nav nav-pills" role="tablist">
<% 
while(attempqaresultset.next()){
%>	
    <li class="nav-item">
      <a class="nav-link" data-toggle="pill" href="#<%=attempqaresultset.getString("question_no") %>"><%=attempqaresultset.getString("question_no") %></a>
    </li>
<%
}
%>
</ul>
  <div class="tab-content">

<%
while(attempqaresultsett.next()){ 
	 String ansii ="ans" +attempqaresultsett.getString("question_no");
	 String qno = attempqaresultsett.getString("question_id");	
%>

    <div id="<%=attempqaresultsett.getString("question_no")%>" class="container tab-pane">
    <br>
     <iframe name="formDestination" class="hidethis"></iframe>
    <form name="f5" method="post" target="formDestination" action="submitanswer.jsp?examid=<%=exam_id %>&studentid=<%=student_id%>&questionid=<%=qno%>&sanswer=<%=ansii %>&obtainedmark=5  ">    
     <h3><%=attempqaresultsett.getString("question_text")%></h3>
	 <textarea rows="2" cols="50" name="<%= ansii%>" id="<%= ansii%>"></textarea>
	 <br>
	 <br> 
	 <%
	 statement=c.createStatement(); 
	 alreadySubmitted =null;
	 alreadySubmitted = statement.executeQuery(alreadysubmittedquery+attempqaresultsett.getString("question_id"));
	 if(alreadySubmitted.next()){
		 alreadySubmitted.getString("question_id");
	 %>
	  <input type="submit" value="Submit Answer" onClick="return salert('<%=ansii%>')" class="btn btn-primary">
     <input type="submit" value="Edit" onClick="return salert('<%=ansii%>')" class="btn btn-primary">
    <%}
else{		 %>
     <input type="submit" value="Submit Answer" onClick="return salert('<%=ansii%>')" class="btn btn-primary">
    <%} %>
    </form>
    </div>    
<%}%>
</div>
</div>
<%
} catch(Exception ep) {
	}
%>
</body>
</html>



