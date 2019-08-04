<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<style><%@include file="/WEB-INF/css/style.css"%></style>
<style><%@include file="/WEB-INF/css/b1.css"%></style>
<style><%@include file="/WEB-INF/css/b2.css"%></style>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"><body>

<script><%@include file="/WEB-INF/js/j1.js"%></script>
<script><%@include file="/WEB-INF/js/j2.js"%></script>
<body>
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
String schema_name = request.getParameter("schema");
String sql1 ="set search_path to dbms_sri"; 
String schemaquery ="select * from schema_details where schema_id="+schema_name;
try{
statement1.executeQuery(sql1);
}catch(Exception ep){
}%>
<%
ansdetails = ansstatement.executeQuery(schemaquery);
while(ansdetails.next()){
	%>
	<h1 style="text-align: center;"><%=ansdetails.getString("schema_name")%></h1>
	
	<div style="white-space: pre-wrap; text-align: center;">
	<%=ansdetails.getString("schema_ddl")%>
	</div>
	<%
}
}
catch (Exception e) {
out.println(e);
}
}
%>
