<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*,java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style><%@include file="/WEB-INF/css/style.css"%></style>
<style><%@include file="/WEB-INF/css/b1.css"%></style>
<style><%@include file="/WEB-INF/css/b2.css"%></style>
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
<script><%@include file="/WEB-INF/js/j1.js"%></script>
<script><%@include file="/WEB-INF/js/j2.js"%></script>
<script type="text/javascript">
function myfunc(xx) {
var urlp= <%= request.getAttribute("urlp") %>;
urlp = window.btoa(xx);
var newUrl = "/SRI/Login_v8/ExecuteQuery.jsp?sql="+urlp;
var Backlen=history.length;   
history.go(-Backlen); 
//window.location.replace(newUrl);
history.replaceState(null, null, newUrl);
document.getElementById("my").innerText = urlp;
return urlp;
}
</script>
</head>
<body onload="myfunc('<%=request.getParameter("sql")%>')">

<div class="wrap-input100 " style= "height: 60px; text-align: center">
<span style="color: red;"><b>Do not refresh page</b></span>
<br>
<b>Executed Query is :</b>  <%=request.getParameter("sql")%>

</div>
<%
Connection c= null;
try{
    Class.forName("org.postgresql.Driver");
    String url = "jdbc:postgresql://localhost:5432/dbms_sri";
    c = DriverManager.getConnection(url, "postgres", "123");
} catch(Exception e) {
    System.out.println("error");
}
if(null == session.getAttribute("user")){
	%>
	<a href="index.jsp"><img id="error" src="e.JPG"></a>	
	<%}
else{
try {
Statement conn_statement = null;
Statement sql_statement = null;
ResultSet resultSet = null,temp=null;
conn_statement=c.createStatement();
String qid = request.getParameter("qid");
String search_schema ="set search_path to dbms_sri";
String sql_query = request.getParameter("sql");
//String sql_query = "select * from exam";
sql_statement = c.createStatement();
request.setAttribute("urlp", request.getParameter("sql"));

try{
conn_statement.executeQuery(search_schema);
}catch(Exception ep){
}
try
{
	resultSet = sql_statement.executeQuery(sql_query);
}
catch(Exception e)
{
	out.println(e);
}
session.setAttribute("resultset", resultSet);
%>
<script type="text/javascript">
//window.location.replace("/SRI/Login_v8/attempqa.jsp?examid=12");
//window.history.back();
</script> 
<% 
try{
ResultSet resultSety = null;
resultSety = (ResultSet)session.getAttribute("resultset");
int no_cols = 0;
ResultSetMetaData rsmd = resultSety.getMetaData();
while(resultSety.next()){
	no_cols = rsmd.getColumnCount();
	break;
}%>
 <table class="table table-bordered" border="1">
<tr>
<%
	for(int i=1;i<=no_cols;i++)
	{
		String s = rsmd.getColumnName(i);
%>
<td class="tablei"><b><%=s %></b></td>
<%} %>
<% 
while(resultSety.next()){
	%>
<tr>
	<%for(int i=1;i<=no_cols;i++)
	{
		String s = rsmd.getColumnName(i);
%>
	
	<td><%=resultSety.getString(s) %></td>	
	<% }%>
	</tr>


<%
}
}
catch(Exception e){
	out.println("pp "+e);
}
}catch(Exception e) {
			
		}
			}
%>
</table>
</body>
</html>