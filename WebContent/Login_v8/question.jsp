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
      <a class="nav-link active" href="question.jsp" ><i class="fa fa-file"></i><strong>Add Question</strong></a>
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
<body>
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
String current_schema= "select * from schema_details";
try{
statement1.executeQuery(sql1);
}catch(Exception ep){
}
resultSet = statement.executeQuery(current_schema);
}
catch(Exception e){
}
}
%>
<div class="container-contact100">
<div class="wrap-contact100">
<iframe name="formDestination" class="hidethis"></iframe>
<form class="contact100-form validate-form" name="f5" method="post" target="formDestination" action="add_question.jsp	">    
<span class="contact100-form-title">
 Add new Questions to schema
</span>
<div class="wrap-input100 validate-input bg0 rs1-alert-validate" data-validate = "Please Type Your Name">
	<span class="label-input100" style="font-size: 20px;">Question*</span>
	<textarea class="input100" name="question" id="question" placeholder="Your message here..."></textarea>
</div>
<div class="wrap-input100 validate-input bg0 rs1-alert-validate" data-validate = "Please Type Your Name">
	<span class="label-input100" style="font-size: 20px;">Answer*</span>
	<textarea class="input100" name="answer" id="answer" placeholder="Your message here..."></textarea>
</div>
<div class="wrap-input100 input100-select bg1">
<span class="label-input100" style="font-size: 20px;">Schema *</span>
<div>
<select class="js-select2" name="select_schema">
<option>Please choose</option>
<%
while(resultSet.next()){
	%>
<option><%=resultSet.getString("schema_name") %></option>
<%
}

%>
</select>
<div class="dropDownSelect2"></div>

</div>
</div>

				<div class="w-full dis-none js-show-service">
					

					<div class="wrap-contact100-form-range">

						
					</div>
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
<script>
$(".js-select2").each(function(){
	$(this).select2({
		minimumResultsForSearch: 20,
		dropdownParent: $(this).next('.dropDownSelect2')
	});


	$(".js-select2").each(function(){
		$(this).on('select2:close', function (e){
			if($(this).val() == "Please chooses") {
				$('.js-show-select_schema').slideUp();
			}
			else {
				$('.js-show-select_schema').slideUp();
				$('.js-show-select_schema').slideDown();
			}
		});
	});
})
</script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-23581568-13');
</script>
</html>