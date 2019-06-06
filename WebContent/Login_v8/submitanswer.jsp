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
System.out.println("sss");
		Connection c= null;
		try{
		    Class.forName("org.postgresql.Driver");
		    String url = "jdbc:postgresql://localhost:5432/dbms_sri";
		    c = DriverManager.getConnection(url, "postgres", "123");
		} catch(Exception e) {
		    System.out.println("error");
		}
		try {
		Statement ques_submit = null;
		Statement s = null;
		ResultSet resultSet = null,temp=null;
		ques_submit = c.createStatement();
		s=c.createStatement();
		String qid = request.getParameter("qid");
		String search_schema ="set search_path to dbms_sri";
		
		try{
		s.executeQuery(search_schema);
		}catch(Exception ep){
		}
		
		PreparedStatement stmt;
		stmt = c.prepareStatement("INSERT into answers (exam_id, student_id,question_id,student_answer,obtained_marks) values (?,?,?,?,?)");
		stmt.setInt(1, Integer.parseInt(request.getParameter("examid")));
		stmt.setInt(2, Integer.parseInt(request.getParameter("studentid")));
		stmt.setInt(3, Integer.parseInt(request.getParameter("questionid")));
		stmt.setString(4,request.getParameter(request.getParameter("sanswer")));
		stmt.setInt(5, Integer.parseInt(request.getParameter("obtainedmark")));
		stmt.executeUpdate();
    	String redirectURL = "http://localhost:8080/SRI/Login_v8/attempqa.jsp?examid="+request.getParameter("examid");
    	out.println(redirectURL);
%>
 <input type="submit" id="myCheck" onclick="myFunction()">
<a href="http://localhost:8080/SRI/Login_v8/attempqa.jsp?examid= <%= request.getParameter("examid")%>">click me </a>
<h1>asdas</h1>
<%
		}catch(Exception e) {
			
		}
%>
</body>
</html>