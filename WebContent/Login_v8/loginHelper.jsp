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
Connection connection = null;
Statement statement = null,statement1=null;
Statement examstatement=null;
Statement exampath=null;
ResultSet resultSet = null,temp=null;
ResultSet examdetails=null;
String current_id;
%>

<%
try{
statement=c.createStatement();
statement1=c.createStatement();
examstatement= c.createStatement();
current_id = request.getParameter("student_id");
String current_pass = request.getParameter("student_password");
String sql ="SELECT * FROM student_profile WHERE student_id="+current_id;
String sql1 ="set search_path to dbms_sri"; 
String examquery ="SELECT exam_name,exam_date,exam_id FROM exam natural join student_profile WHERE exam_date < CURRENT_DATE and student_id="+current_id;
String correct_password="", s1="",s2="";
try{
statement1.executeQuery(sql1);
}catch(Exception ep){
}
resultSet = statement.executeQuery(sql);

while(resultSet.next()){
	String name = resultSet.getString("student_name");
	%>
	<div id="welcome">
	Welcome, <%=name %>
	</div>
	<table class="table table-bordered" border="1">
<tr>

</tr>
<tr>
<td class="tablei"><b>Exam name</b></td>
<td class="tablei"><b>Exam Date</b></td>
</tr>
	<% 
	correct_password = resultSet.getString("student_password");
	if(correct_password.equals(current_pass)){
		session.setAttribute("user",current_id);  
		try{
			examdetails = examstatement.executeQuery(examquery);
		} catch(Exception e){
			
		}
		while(examdetails.next()){
			%>
			<tr>
			<td><a href="examHelper.jsp?exam=<%=examdetails.getString("exam_id")%>&&id=<%=request.getParameter("student_id")%>"> <%=examdetails.getString("exam_name") %></a></td>
			<td><%=examdetails.getString("exam_date") %></td>
			</tr>
			<%
		}
	}
	else out.println("try again");
}


} catch (Exception e) {
out.println(e);
}
%>
</table>

<form name="f3" method="get" action="viewQA.jsp">

<button type="submit" class="btn btn-primary">Upcoming Exam</button>
</form>

