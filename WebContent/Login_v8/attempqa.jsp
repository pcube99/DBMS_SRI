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

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<style><%@include file="/WEB-INF/css/style.css"%></style>
<style><%@include file="/WEB-INF/css/b1.css"%></style>
<style><%@include file="/WEB-INF/css/b2.css"%></style>

<script><%@include file="/WEB-INF/js/j1.js"%></script>
<script><%@include file="/WEB-INF/js/j2.js"%></script>
</head>
<body>
<nav class="navbar navbar-dark bg-dark">
  <div class="navbar-header ">
      <a class="navbar-brand" href="/">DBMS</a>
  </div>
  <ul class="nav nav-tabs">
    <li class="nav-item">
      <a class="nav-link active" href="#" ><i class="fas fa-home"></i><strong> Home</strong></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="" style="color :aliceblue"><i class="fas fa-info-circle"></i><strong> QA</strong></a>
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
Statement statement1=null,attempqastatement=null,attempqastatementt=null;
Statement statement=null;
ResultSet attempqaresultset=null,qaresultset=null,attempqaresultsett=null;
String exam_id;
try{
attempqastatement=c.createStatement();
attempqastatementt=c.createStatement();

statement1=c.createStatement();
exam_id = request.getParameter("examid");
String sql1 ="set search_path to dbms_sri"; 
String attempqaquery ="select question_id,question_no,question_text,max_marks from exam_questions natural join question_bank where exam_id="+request.getParameter("examid");
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
 <input TYPE="submit" VALUE="Click Here">
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



