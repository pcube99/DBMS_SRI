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
<script src="loginUI/vendor/select2/select2.min.js"></script>

<script src="loginUI/vendor/daterangepicker/moment.min.js"></script>
<script src="loginUI/vendor/daterangepicker/daterangepicker.js"></script>
<script src="loginUI/vendor/countdowntime/countdowntime.js"></script>
<script src="loginUI/vendor/noui/nouislider.min.js"></script>
<script>
  var filterBar = document.getElementById('filter-bar');

  noUiSlider.create(filterBar, {
      start: [ 1500, 3900 ],
      connect: true,
      range: {
          'min': 1500,
          'max': 7500
      }
  });

  var skipValues = [
  document.getElementById('value-lower'),
  document.getElementById('value-upper')
  ];

  filterBar.noUiSlider.on('update', function( values, handle ) {
      skipValues[handle].innerHTML = Math.round(values[handle]);
      $('.contact100-form-range-value input[name="from-value"]').val($('#value-lower').html());
      $('.contact100-form-range-value input[name="to-value"]').val($('#value-upper').html());
  });
</script>
<!--===============================================================================================-->
<script src="js/main.js"></script>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
<script>
window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('js', new Date());

gtag('config', 'UA-23581568-13');
</script>

<nav class="navbar navbar-dark bg-dark">
  <div class="navbar-header ">
      <a class="navbar-brand" href="/">DBMS</a>
  </div>
  <ul class="nav nav-tabs">
    <li class="nav-item">
      <a class="nav-link" href="loginHelper.jsp" style="color :aliceblue" > <i class="fa fa-home"></i> <strong> Home</strong></a>
    </li>
    <li class="nav-item">
      <a class="nav-link active" href="ta_add.jsp" ><i class="fa fa-file"></i><strong>Add Schema</strong></a>
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
</body>
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
Statement statement = null,statement1=null,ta_statement=null;
ResultSet resultSet = null,temp=null;
String current_id;
if(null == session.getAttribute("user")){
%>
<a href="index.jsp"><img id="error" src="e.JPG"></a>
<%	
}
else{
try{
statement=c.createStatement();
statement1=c.createStatement();
ta_statement= c.createStatement();
current_id = (String)session.getAttribute("user");
String current_pass = (String)session.getAttribute("pwd");
String sql1 ="set search_path to dbms_sri"; 
String examquery ="SELECT exam_name,exam_date,exam_id FROM exam natural join answers WHERE exam_date < CURRENT_DATE and student_id="+current_id;
try{
statement1.executeQuery(sql1);
}catch(Exception ep){
}

resultSet = statement.executeQuery(sql1);
}
catch(Exception e){
}
}
%>
<div class="container-contact100">
<div class="wrap-contact100">
<iframe name="formDestination" class="hidethis"></iframe>
<form class="contact100-form validate-form" name="f5" method="post" target="formDestination" action="schema_submit.jsp">    
<span class="contact100-form-title">
 Add new Schema
</span>
<div class="wrap-input100 validate-input bg1" data-validate="Please Type Your Name">
	<span class="label-input100" style="font-size: 20px;">Schema Name *</span>
	<input class="input100" type="text" id="schemaname" name="schemaname" placeholder="Enter Schema Name">
</div>	
<div class="wrap-input100 validate-input bg0 rs1-alert-validate" data-validate = "Please Type Your Name">
	<span class="label-input100" style="font-size: 20px;">DDL Script*</span>
	<textarea class="input100" name="schemaddl" id="schemaddl" placeholder="Your message here..."></textarea>
</div>
<div class="container-contact100-form-btn">
	<button class="contact100-form-btn">
		<span>
			Submit
			<i class="fa fa-long-arrow-right m-l-7" aria-hidden="true"></i>
		</span>
	</button>
</div>
</form>
</div>
</div>
</body>
</html>