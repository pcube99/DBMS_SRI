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
<link rel="icon" type="image/png" href="tableUI/images/icons/favicon.ico"/>
<link rel="stylesheet" type="text/css" href="tableUI/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="tableUI/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="tableUI/vendor/animate/animate.css">
<link rel="stylesheet" type="text/css" href="tableUI/vendor/select2/select2.min.css">
<link rel="stylesheet" type="text/css" href="tableUI/vendor/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet" type="text/css" href="tableUI/css/util.css">
<link rel="stylesheet" type="text/css" href="tableUI/css/main.css">
<style><%@include file="/WEB-INF/css/style.css"%></style>
<style><%@include file="/WEB-INF/css/b1.css"%></style>
<style><%@include file="/WEB-INF/css/b2.css"%></style>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"><body>

<script><%@include file="/WEB-INF/js/j1.js"%></script>
<script><%@include file="/WEB-INF/js/j2.js"%></script>
<script src="tableUI/vendor/jquery/jquery-3.2.1.min.js"></script>
<script src="tableUI/vendor/bootstrap/js/popper.js"></script>
<script src="tableUI/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="tableUI/vendor/select2/select2.min.js"></script>
<script src="tableUI/js/main.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
function startExam(xx){
	swal({
		  title: "Are you sure to start exam?",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
		})
		.then((willDelete) => {
		  if (willDelete) {
		    swal("You'll be redirected to exam page..", {
		      icon: "success",
		    });
		    var newUrl = "/SRI/Login_v8/"+xx;
		    
		    window.open(newUrl);
		    var Backlen=history.length;   
		    history.go(-Backlen); 
		    //window.location.replace(newUrl);
		     //  window.history.pushState(null, null, newUrl);
		    //history.replaceState(null, null, newUrl);
		  } else {
		    swal("You still have one attemp left to take exam");
		  }
		});
}

</script>
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
      <a class="nav-link active" href="viewQA.jsp" ><i class="fa fa-file"></i><strong>Exam</strong></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="practise.jsp" style="color :aliceblue"><i class="fa fa-file"></i><strong>Practise</strong></a>
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
Statement statement = null,statement1=null,comingexamstatement=null;
Statement qastatement=null;
ResultSet comingexamresultset=null,qaresultset=null;
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
qastatement=c.createStatement();
comingexamstatement = c.createStatement();
statement1=c.createStatement();
current_id = request.getParameter("student_id");
String sql1 ="set search_path to dbms_sri"; 
String comingexamquery ="select * from exam where exam_date > CURRENT_DATE and ispractise =0";
try{
statement1.executeQuery(sql1);
}catch(Exception ep){
}
comingexamresultset = comingexamstatement.executeQuery(comingexamquery);
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
Exam Date	</div>
	<div class="cell">
		Exam Duration
	</div>
</div>
<% 
while(comingexamresultset.next()){
%>
<div class="row">
	<div class="cell" data-title="Exam Name">
<a href="#" onclick="startExam('attempqa.jsp?examid=<%=comingexamresultset.getString("exam_id")%>')"> <%=comingexamresultset.getString("exam_name") %></a>	</div>
	<div class="cell" data-title="Exam Date">
		<%=comingexamresultset.getString("exam_date") %>
	</div>
	<div class="cell" data-title="Exam Date">
<%=comingexamresultset.getString("exam_time") %>	</div>
	<div class="cell" data-title="Exam Duration">
<%=comingexamresultset.getString("exam_duration") %>	</div>
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