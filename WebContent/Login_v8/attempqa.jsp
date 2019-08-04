<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.lang.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.security.*"%>
<%@page import="java.io.UnsupportedEncodingException"%>
<%@page import=" javax.crypto.Cipher"%>
<%@page import=" javax.crypto.spec.SecretKeySpec"%>
<%@page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
public void runn()throws IOException{
FileWriter fp = new FileWriter("/home/pankil/eclipse-workspace/SRI/WebContent/WEB-INF/lib/ra/inpu.ra",false);
fp.write("pnkil");
fp.close();
Runtime runtime=Runtime.getRuntime();
runtime.exec("java -jar /home/pankil/eclipse-workspace/SRI/WebContent/WEB-INF/lib/ra/ra.jar -i /home/pankil/eclipse-workspace/SRI/WebContent/WEB-INF/lib/ra/input.ra -o /home/pankil/eclipse-workspace/SRI/WebContent/WEB-INF/lib/ra/p123.txt");
}
%>

<!DOCTYPE html>
<html>
<head>

<style><%@include file="/WEB-INF/css/style.css"%></style>
<style><%@include file="/WEB-INF/css/b1.css"%></style>
<style><%@include file="/WEB-INF/css/b2.css"%></style>

<script><%@include file="/WEB-INF/js/j1.js"%></script>
<script><%@include file="/WEB-INF/js/j2.js"%></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<style><%@include file="/WEB-INF/css/style.css"%></style>
<style><%@include file="/WEB-INF/css/b1.css"%></style>
<style><%@include file="/WEB-INF/css/b2.css"%></style>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"><body>

<script><%@include file="/WEB-INF/js/j1.js"%></script>
<script><%@include file="/WEB-INF/js/j2.js"%></script>
<script>
function finishExam(){
	swal("Time's up champ !!!", "Click to see results.").then(function() {
		var Backlen=history.length;   
		history.go(-Backlen); 
		//window.location.replace(newUrl);
		var newUrl = "/SRI/Login_v8/viewScore.jsp?exam=1";
		history.replaceState(null, null, newUrl);
		window.location.reload();
		});

}
function helpExam(){
	swal("General Instructions", "You only have one attemp to complete this exam");

}
function endExam(){
swal({
	  title: "Are you sure to finish exam?",
	  icon: "warning",
	  buttons: true,
	  dangerMode: true,
	})
	.then((willDelete) => {
	  if (willDelete) {
	    swal("Yayy ! Successfully completed exam..", {
	      icon: "success",
	    }).then(function (){
	    	var Backlen=history.length;   
			history.go(-Backlen); 
			//window.location.replace(newUrl);
			var newUrl = "/SRI/Login_v8/viewScore.jsp?exam=1";
			history.replaceState(null, null, newUrl);
			window.location.reload();
	    });
		  myStopFunction();
	  } else {
	    swal("You still have time to complete exam");
	  }
	});
}
</script>
<script>
var timout=0;
function count() {
	if(sessionStorage.getItem("time") == null){
	sessionStorage.setItem("time", "00:10:30");
	}
    var sdss = sessionStorage.getItem("time");
    if(sdss != null){
 if(timout==0)
 {
var startTime = sdss;
var pieces = startTime.split(":");
var time = new Date();
time.setHours(pieces[0]);
time.setMinutes(pieces[1]);
time.setSeconds(pieces[2]);
var timedif = new Date(time.valueOf() - 1000);

var newtime = timedif.toTimeString().split(" ")[0];
var newtimearr= newtime.split(":");
document.getElementById('hms').innerHTML='Remaining Time : '+newtime;
sessionStorage.setItem("time", newtime);
if (newtime=="00:00:00") {
	clearTimeout(time_out);
	timout=1;	   
	finishExam();
}
time_out= setTimeout(count, 1000);
 }
    }
}

function myStopFunction() {
	  clearTimeout(time_out);

	}
</script>

<script type="text/javascript">
function salert(xx){
	var sicon,stitle;
	var temp =document.getElementById(xx);
	if(temp != null && temp.value === ""){
		swal({
			  icon:"warning",
			  title: "Try Again"
			});
		return false;
	}
	else{
		swal({
			  icon: "success",
			  title: "Successfully Submitted"
			});
//		window.location.reload();
		var input = document.getElementById(xx).value;
		var ip=input.split('{').join('[');
		var ipp=ip.split('}').join(']');
		var pnkil=encodeURIComponent(ipp);
		window.open("/SRI/Login_v8/interpreter.jsp?input="+pnkil);	
		//document.getElementById(xx).readOnly = true;
		return true;
	}
	
}
function salert2(xx){
	var sicon,stitle;
	var temp =document.getElementById(xx);
	if(temp != null && temp.value === ""){
		swal({
			  icon:"warning",
			  title: "Try Again"
			});
		return false;
	}
	else{
		swal({
			  icon: "success",
			  title: "Executed Successfully!"
			});
		//var urlp= window.btoa(temp.value);
		//var pn=URLEncoder.encode(temp.value);
		window.open("/SRI/Login_v8/ExecuteQuery.jsp?sql="+temp.value);
		//document.getElementById(xx).readOnly = true;
		myfunc(temp.value);
		return true;
	}
	
}

function removable(x){
	   document.getElementById(x).addAttribute('readonly');;
}

function edit_answer(examid,studentid,qid,ans_area)
{

	var ans_text =document.getElementById(ans_area).value;
	//window.location.assign('/edit_answer.jsp');//?examid='+x+'&studentid='+student_id+'&questionid='+question_id+'&sanswer='+ans_text);
	//window.location = "/edit_answer.jsp";
	window.location.replace("/DBMS_SRI/Login_v8/edit_answer.jsp?examid="+examid+"&studentid="+studentid+"&questionid="+qid+"&sanswer="+document.getElementById(ans_area).value);
}
function sql_query(query_area)
{
	var temp =document.getElementById(xx);
	if(temp != null && temp.value === ""){
		swal({
			  icon:"warning",
			  title: "Try Again"
			});
		return false;
	}
	else{
		swal({
			  icon: "success",
			  title: "Successfully Submitted"
			});
		window.location.reload();
		//document.getElementById(xx).readOnly = true;
		return true;
	}
	
}
helpExam()
</script>
</head>
<body onClick="count()">
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
Statement statement1=null,attempqastatement=null,attempqastatementt=null;
Statement statement=null;
Statement schemaname=null;
ResultSet schemnameresult=null;
ResultSet attempqaresultset=null,qaresultset=null,attempqaresultsett=null,alreadySubmitted=null;
String exam_id;
try{
attempqastatement=c.createStatement();
attempqastatementt=c.createStatement();
statement1=c.createStatement();
statement=c.createStatement();
schemaname=c.createStatement();
exam_id = request.getParameter("examid");
String sql1 ="set search_path to dbms_sri"; 
String attempqaquery ="select schema_id,question_id,question_no,question_text,max_marks from exam_questions natural join question_bank where exam_id="+request.getParameter("examid");
String alreadysubmittedquery ="select * from answers where exam_id="+request.getParameter("examid")+"and student_id="+session.getAttribute("user")+"and question_id=";

try{
statement1.executeQuery(sql1);
}catch(Exception ep){
}
attempqaresultset = attempqastatement.executeQuery(attempqaquery);
attempqaresultsett = attempqastatementt.executeQuery(attempqaquery);
String student_id=(String)session.getAttribute("user");  
String schemaquery = "select schema_name from schema_details where schema_id=";

%>
<%
String hours = "00"; //change hours
String minutes = "03";//change minutes
String seconds = "30";//change Seconds
String clock = hours+":"+minutes+":"+seconds;
session.setAttribute("time", clock);
%>

<div id="welcome" >
  <div id='hms'>Remaining time : <% out.println(""+clock+""); %></div>
<button style="margin-left: 40%;"onClick="endExam()" class="btn btn-danger">End Exam</button>
	
</div>

  
<div class="container">
<ul class="nav nav-pills" role="tablist">
<% 
while(attempqaresultset.next()){
%>	
    <li class="nav-item">
     <a class="nav-link" data-toggle="pill" href="#<%=attempqaresultset.getString("question_no") %>">Question  <%=attempqaresultset.getString("question_no") %></a>
    </li>
<%
}
%>
</ul>
  <div class="tab-content">
<%

while(attempqaresultsett.next()){ 
	 String ansii ="ans" +attempqaresultsett.getString("question_no");
	 String qno = attempqaresultsett.getString("question_id");	
	 String sql_query="SQL";
	 schemnameresult=null;
		schemnameresult = schemaname.executeQuery(schemaquery+attempqaresultsett.getString("schema_id"));
		while(schemnameresult.next()){
%>
    <div id="<%=attempqaresultsett.getString("question_no")%>" class="container tab-pane">
    <br>
    	
     <iframe name="formDestination" class="hidethis"></iframe>
    <form name="f5" method="post" target="formDestination" action="submitanswer.jsp?examid=<%=exam_id %>&studentid=<%=student_id%>&questionid=<%=qno%>&sanswer=<%=ansii %>&obtainedmark=5  ">    
          <h4>Schema Name : <a href="display_schema.jsp?schema=<%=attempqaresultsett.getString("schema_id")%>" target="_blank"><%=schemnameresult.getString("schema_name")%></a></h4>
     
     <h3><%=attempqaresultsett.getString("question_text")%></h3>
	 <textarea rows="2" cols="50" name="<%= ansii%>" id="<%= ansii%>"></textarea>
	 <br>
	 <br> 
	 <%
		}
	 alreadySubmitted =null;
	 alreadySubmitted = statement.executeQuery(alreadysubmittedquery+attempqaresultsett.getString("question_id"));
	 if(alreadySubmitted.next()){
		 alreadySubmitted.getString("question_id");
	String qry=sql_query;
	 %>
	 <input type="submit" value="Submit Answer" onClick="return salert('<%=ansii%>'); " class="btn btn-primary">
     <input type="submit" value="Edit" onClick="return edit_answer('<%=exam_id %>','<%=student_id %>','<%=qno %>','<%=ansii%>')" class="btn btn-primary">
     
    <%
    }
else{		 %>
     <input type="submit" value="Submit Answer" onClick="return salert('<%=ansii%>');" class="btn btn-primary">
    <%} %>
    <br>
<br>
     </form>
    

<br>
    </div> 
<%

}
%>
</div>
</div>
<br>
 
<%

} catch (Exception e) {
		out.println(e + " because of me");
		}
%>

</body>
</html>



