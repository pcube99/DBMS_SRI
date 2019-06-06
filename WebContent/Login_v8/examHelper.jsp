<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<style><%@include file="/WEB-INF/css/style.css"%></style>
<style><%@include file="/WEB-INF/css/b1.css"%></style>
<style><%@include file="/WEB-INF/css/b2.css"%></style>

<script><%@include file="/WEB-INF/js/j1.js"%></script>
<script><%@include file="/WEB-INF/js/j2.js"%></script>
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

	<table class="table table-bordered" border="1">
<tr>

</tr>
<tr>
<td class="tablei"><b>question_no</b></td>
<td class="tablei"><b>question_text</b></td>
<td class="tablei"><b>student_answer</b></td>
<td class="tablei"><b>correct_answer</b></td>
<td class="tablei"><b>obtained_marks</b></td>
<td class="tablei"><b>max_marks</b></td>

</tr>
<%
while(ansdetails.next()){
	%>
			<tr>
			<td><%=ansdetails.getString("question_no") %></td>
			<td><%=ansdetails.getString("question_text") %></td>
			<td><%=ansdetails.getString("student_answer") %></td>
			<td><%=ansdetails.getString("correct_answer") %></td>
			<td><%=ansdetails.getString("obtained_marks") %></td>
			<td><%=ansdetails.getString("max_marks") %></td>
			
			</tr>
			<%
		}
	
}
catch (Exception e) {
out.println(e);
}
%>
</table>
<form name="f3" method="get" action="viewQA.jsp">

<button type="submit" class="btn btn-primary">Take Exam</button>
</form>
