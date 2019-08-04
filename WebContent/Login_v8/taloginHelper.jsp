<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page autoFlush="true" buffer="1094kb"%>
<style><%@include file="/WEB-INF/css/style.css"%></style>
<style><%@include file="/WEB-INF/css/b1.css"%></style>
<style><%@include file="/WEB-INF/css/b2.css"%></style>
<script><%@include file="/WEB-INF/js/j1.js"%></script>
<script><%@include file="/WEB-INF/js/j2.js"%></script>
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
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<body style="background-color: blue; color: black">
<nav class="navbar navbar-dark bg-dark">
  <div class="navbar-header ">
      <a class="navbar-brand" href="/">DBMS</a>
  </div>
  <ul class="nav nav-tabs">
    <li class="nav-item">
      <a class="nav-link active" href="loginHelper.jsp" > <i class="fa fa-home"></i> <strong> Home</strong></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="ta_add.jsp" style="color :aliceblue"><i class="fa fa-file"></i><strong>Add Schema</strong></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="question.jsp" style="color :aliceblue"><i class="fa fa-file"></i><strong>Add Question</strong></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="makeExam.jsp" style="color :aliceblue"><i class="fa fa-file"></i><strong>Make Exam</strong></a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="taHelp.jsp" style="color :aliceblue"><i class="fa fa-info-circle"></i><strong> Help</strong></a>
    </li>     
    <li class="nav-item">
        <a class="nav-link" href="index.jsp" style="color :aliceblue"><i class="fa fa-sign-out"></i><strong> Logout</strong></a>
    </li>  
  </ul>
</nav>
<% 
if(session.getAttribute("user") == null)
session.setAttribute("user",request.getParameter("student_id")); 

if(session.getAttribute("pwd") == null)
session.setAttribute("pwd",request.getParameter("student_password")); 
Connection c= null;
try{
    Class.forName("org.postgresql.Driver");
    String url = "jdbc:postgresql://localhost:5432/dbms_sri";
    c = DriverManager.getConnection(url, "postgres", "123");
} catch(Exception e) {
    System.out.println("errpr");
}
Connection connection = null;
Statement statement = null,statement1=null,tastatement=null;
Statement examstatement=null;
Statement schema_statement=null;
ResultSet resultSet = null,temp=null,taresultSet=null;
ResultSet examdetails=null;
ResultSet schema_resultset=null;

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
statement=c.createStatement();
statement1=c.createStatement();
examstatement= c.createStatement();
tastatement = c.createStatement();
schema_statement= c.createStatement();

current_id = (String)session.getAttribute("user");
String current_pass = (String)session.getAttribute("pwd");
String sql ="SELECT * FROM student_profile WHERE student_id="+current_id;
String ta_sql ="SELECT * FROM ta_profile WHERE ta_id="+current_id;

String sql1 ="set search_path to dbms_sri"; 
String examquery ="SELECT exam_name,exam_date,exam_id FROM exam natural join answers WHERE exam_date < CURRENT_DATE and student_id="+current_id;
String schemquery= "select schema_id,schema_name from schema_details";
String correct_password="", s1="",s2="";
try{
statement1.executeQuery(sql1);
}catch(Exception ep){
}
resultSet = statement.executeQuery(sql);
taresultSet = tastatement.executeQuery(ta_sql);
%>

<div class="limiter">
<div class="container-table100">
<div class="wrap-table100">
<div class="table">

<%
if(!resultSet.next()){
	taresultSet = tastatement.executeQuery(ta_sql);
	while(taresultSet.next()){
		schema_resultset = schema_statement.executeQuery(schemquery);

		%>
		<div class="row header">
	<div class="cell">
		Schema name
	</div>
	</div>
	<% 
		while(schema_resultset.next()){
			%>
			<div class="row">
	<div class="cell" data-title="Schema Name">
<a href="display_schema.jsp?schema=<%=schema_resultset.getString("schema_id")%>"> <%=schema_resultset.getString("schema_name")%></a>
	</div>
	</div>
	<%
	}
	%>
	<%
}

}
}catch(Exception e){
	
}

}
%>
</div>
</div>
</div>
</div>
</body>
</html>