<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
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

<script src="tableUI/vendor/jquery/jquery-3.2.1.min.js"></script>
<script src="tableUI/vendor/bootstrap/js/popper.js"></script>
<script src="tableUI/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="tableUI/vendor/select2/select2.min.js"></script>
<script src="tableUI/js/main.js"></script>
<script><%@include file="/WEB-INF/js/j1.js"%></script>
<script><%@include file="/WEB-INF/js/j2.js"%></script>
<body>
<nav class="navbar navbar-dark bg-dark">
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
</body>
<%
Connection c= null;
try{
    Class.forName("org.postgresql.Driver");
    String url = "jdbc:postgresql://localhost:5432/dbms_sri";
    c = DriverManager.getConnection(url, "postgres", "123");
} catch(Exception e) {
    System.out.println("errpr");
}
Statement statement = null,statement1=null;
Statement ansstatement=null;
Statement anspath=null;
ResultSet resultSet = null,temp=null;
ResultSet ansdetails=null;
if(null == session.getAttribute("user")){
%>
<a href="index.jsp"><img id="error" src="e.JPG"></a>

<%	
}
else{
try{
statement1 = c.createStatement();
ansstatement= c.createStatement();
String current_id = request.getParameter("id");
String exam_id = request.getParameter("exam");
String sql1 ="set search_path to dbms_sri"; 
String ansquery ="select question_no,question_text, student_answer,correct_answer,obtained_marks,max_marks from (select * from (select question_id,student_answer,obtained_marks from answers where student_id="+current_id+" and exam_id="+exam_id+") as r1 natural join exam_questions where exam_id="+exam_id+") as r2 natural join question_bank;";
try{
statement1.executeQuery(sql1);
}catch(Exception ep){
}
ansdetails = ansstatement.executeQuery(ansquery);
%>

<div class="container-table200">
<div class="wrap-table200">
<div class="table">
<div class="row header">

<div class="cell" style="width: 30%;border: 1px solid black; text-align: left;margin: 0 auto">
<b>Question Text</b>
</div>
<div class="cell" style="width: 30%; border: 1px solid black; text-align: justify">
<b>Your Answer</b>
</div>
<div class="cell" style="width: 30%; border: 1px solid black">
<b>Correct Answer</b>
</div>
<div class="cell" style="width: 8%; border: 1px solid black">
<b>Obtained Marks</b>
</div>
<div class="cell" style="width: 5%; border: 1px solid black">
<b>Max Marks</b>
</div>
</div>
<%
while(ansdetails.next()){
	%>
<div class="row">

<div class="cell" data-title="Question Text" style="width: 30%; border: 1px solid black">
<%=ansdetails.getString("question_text") %>
</div>
<div class="cell" style="width: 30%; border: 1px solid black"" data-title="Your Answer">
<%=ansdetails.getString("student_answer") %>
</div>
<div class="cell" data-title="Correct Answer" style="width: 30%; border: 1px solid black"">
<%=ansdetails.getString("correct_answer") %>
</div>
<div class="cell" data-title="Obtained Marks" style="width: 8%;border: 1px solid black"">
<%=ansdetails.getString("obtained_marks") %>
</div>
<div class="cell" data-title="Max Marks" style="width: 5%; border: 1px solid black"">
<%=ansdetails.getString("max_marks") %>
</div>
</div>
			<%
		}
	
}
catch (Exception e) {
out.println(e);
}
}
%>
</div>
</div>
</div>
</body>
</html>