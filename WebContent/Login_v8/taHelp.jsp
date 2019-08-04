<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<style><%@include file="/WEB-INF/css/style.css"%></style>
<style><%@include file="/WEB-INF/css/b1.css"%></style>
<style><%@include file="/WEB-INF/css/b2.css"%></style>
<script><%@include file="/WEB-INF/js/j1.js"%></script>
<script><%@include file="/WEB-INF/js/j2.js"%></script>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"><body>
<nav class="navbar navbar-dark bg-dark"">
  <div class="navbar-header ">
      <a class="navbar-brand" href="/">DBMS</a>
  </div>
  <ul class="nav nav-tabs">
    <li class="nav-item">
      <a class="nav-link" href="loginHelper.jsp" style="color :aliceblue" > <i class="fa fa-home"></i> <strong> Home</strong></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="ta_add.jsp" style="color :aliceblue"><i class="fa fa-file"></i><strong>Add Schema</strong></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="question.jsp" style="color :aliceblue" ><i class="fa fa-file"></i><strong>Add Question</strong></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="makeExam.jsp" style="color :aliceblue"><i class="fa fa-file"></i><strong>Make Exam</strong></a>
    </li>
    <li class="nav-item">
        <a class="nav-link active" href="taHelp.jsp" ><i class="fa fa-info-circle"></i><strong> Help</strong></a>
    </li>     
    <li class="nav-item">
        <a class="nav-link" href="index.jsp" style="color :aliceblue"><i class="fa fa-sign-out"></i><strong> Logout</strong></a>
    </li>  
  </ul>
</nav>
<h1>Help</h1>
</body>


