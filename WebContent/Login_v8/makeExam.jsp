<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<style><%@include file="/WEB-INF/css/style.css"%></style>
<style><%@include file="/WEB-INF/css/b1.css"%></style>
<style><%@include file="/WEB-INF/css/b2.css"%></style>
<script><%@include file="/WEB-INF/js/j1.js"%></script>
<script><%@include file="/WEB-INF/js/j2.js"%></script>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="icon" type="image/png" href="loginUI/images/icons/favicon.ico"/>
<link rel="stylesheet" type="text/css" href="loginUI/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="loginUI/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="loginUI/fonts/iconic/css/material-design-iconic-font.min.css">
<link rel="stylesheet" type="text/css" href="loginUI/vendor/animate/animate.css">
<link rel="stylesheet" type="text/css" href="loginUI/vendor/css-hamburgers/hamburgers.min.css">
<link rel="stylesheet" type="text/css" href="loginUI/vendor/animsition/css/animsition.min.css">
<link rel="stylesheet" type="text/css" href="loginUI/vendor/select2/select2.min.css">
<link rel="stylesheet" type="text/css" href="loginUI/vendor/daterangepicker/daterangepicker.css">
<link rel="stylesheet" type="text/css" href="loginUI/vendor/noui/nouislider.min.css">
<link rel="stylesheet" type="text/css" href="loginUI/css/util.css">
<link rel="stylesheet" type="text/css" href="loginUI/css/main.css">
<script src="loginUI/vendor/jquery/jquery-3.2.1.min.js"></script>
<script src="loginUI/vendor/animsition/js/animsition.min.js"></script>
<script src="loginUI/vendor/bootstrap/js/popper.js"></script>
<script src="loginUI/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="loginUI/vendor/daterangepicker/moment.min.js"></script>
<script src="loginUI/vendor/daterangepicker/daterangepicker.js"></script>
<script src="loginUI/vendor/countdowntime/countdowntime.js"></script>
<script src="loginUI/vendor/noui/nouislider.min.js"></script>
<script src="loginUI/js/main.js"></script>
<script src="loginUI/vendor/select2/select2.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
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
      <a class="nav-link" href="ta_add.jsp" style="color :aliceblue"><i class="fa fa-file"></i><strong>Add Schema</strong></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="question.jsp" style="color :aliceblue"><i class="fa fa-file"></i><strong>Add Question</strong></a>
    </li>
    <li class="nav-item">
      <a class="nav-link active" href="makeExam.jsp" ><i class="fa fa-file"></i><strong>Make Exam</strong></a>
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
Statement statement = null,statement1=null,ta_statement=null,stat=null,schem_questions_statement=null;
ResultSet resultSet = null,temp=null, schema_questions_resultset=null,resultSet2=null;
String current_id;
if(null == session.getAttribute("user")){
%>
<a href="index.jsp"><img id="error" src="e.JPG"></a>
<%	
}
else{
try{
statement=c.createStatement();
stat=c.createStatement();
schem_questions_statement= c.createStatement();
statement1=c.createStatement();
ta_statement= c.createStatement();
current_id = (String)session.getAttribute("user");
String current_pass = (String)session.getAttribute("pwd");
String sql1 ="set search_path to dbms_sri"; 
String current_schema= "select * from schema_details";
String schema_query= "select * from question_bank where schema_id=";
try{
statement1.executeQuery(sql1);
}catch(Exception ep){
}
resultSet = statement.executeQuery(current_schema);
resultSet2=stat.executeQuery(current_schema);
}
catch(Exception e){
}
}
%>
 
<div class="container-contact100">
<div class="wrap-contact100">

<form name="f5" class="contact100-form validate-form" method="post" action="add_Question_Exam.jsp">  
<span class="contact100-form-title">
 New Exam
</span>
<div class="wrap-input100 validate-input bg1" data-validate="Please Type Your Name">
	<span class="label-input100" style="font-size: 20px;">Exam Name *</span>
	<input class="input100" type="text" name="exam_name" id="exam_name" placeholder="Enter Schema Name">
</div>	
<div class="wrap-input100 validate-input bg1" data-validate="Please Type Your Name">
	<span class="label-input100" style="font-size: 20px;">Exam Date *</span>
	<input class="input100" type="text" name="exam_date" id="exam_date" placeholder="Enter Schema Name">
</div>	
<div class="wrap-input100 validate-input bg1" data-validate="Please Type Your Name">
	<span class="label-input100" style="font-size: 20px;">Exam Time *</span>
	<input class="input100" type="text" name="exam_time" id="exam_time" placeholder="Enter Schema Name">
</div>	
<div class="wrap-input100 validate-input bg1" data-validate="Please Type Your Name">
	<span class="label-input100" style="font-size: 20px;">Exam Hours *</span>
	<input class="input100" type="text" name="exam_duration" id="exam_duration" placeholder="Enter Schema Name">
</div>	
<div class="container">
<div class="row">
<div class="tab" role="tabpanel">
<ul role="tablist" class="nav nav-tabs">

<% 

while(resultSet.next()){
%>	
    <li role="presentation">
      <a class="nav-link" aria-controls="home" role="tab" data-toggle="tab" href="#<%=resultSet.getString("schema_name") %>"><%=resultSet.getString("schema_name") %></a>
    </li>
<%
}
%>
</ul>
  <div class="tab-content">

<%
try{
while(resultSet2.next()){ 
%>
    <div id="<%=resultSet2.getString("schema_name")%>" role="tabpanel" class="tab-pane">
	 <%
	 Statement x=null;
	 x=c.createStatement(); 
	 ResultSet xresultset =null;
	 xresultset = x.executeQuery("select * from question_bank where schema_id="+resultSet2.getString("schema_id"));
	 while(xresultset.next()){
		 %>
		 <div>
		 <%=xresultset.getString("question_text")%>
		 <input type="checkbox" name="que" value="<%=xresultset.getString("question_id")%> <%=resultSet2.getString("schema_id")%>" id="<%=xresultset.getString("question_id")%>">
		 <div class="wrap-input100 validate-input bg1" data-validate="Please Type Your Name">
		 <input class="input50" type="text" name="que" id="max_marks" placeholder="Enter max marks for question.">
</div>	
		 
		 </div>
    <%}%>
    </div>    
<%}
}catch(Exception e){

out.println(e);
}%>
</div>


<div class="container-contact100-form-btn">
	<button class="contact100-form-btn">
		<span>
			Submit
			<i class="fa fa-long-arrow-right m-l-7" aria-hidden="true"></i>
		</span>
	</button>
</div>
</div>
</div>
</div>
</form>

</div>
</div>


</body>
</html>