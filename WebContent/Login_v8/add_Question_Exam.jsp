<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*,java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style><%@include file="/WEB-INF/css/style.css"%></style>
<style><%@include file="/WEB-INF/css/b1.css"%></style>
<style><%@include file="/WEB-INF/css/b2.css"%></style>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"><body>

<script><%@include file="/WEB-INF/js/j1.js"%></script>
<script><%@include file="/WEB-INF/js/j2.js"%></script>
</head>
<body>
</body>
<%
Connection c= null;
try{
    Class.forName("org.postgresql.Driver");
    String url = "jdbc:postgresql://localhost:5432/dbms_sri";
    c = DriverManager.getConnection(url, "postgres", "123");
} catch(Exception e) {
}
if(null == session.getAttribute("user")){
	%>
	<a href="index.jsp"><img id="error" src="e.JPG"></a>
	<%	
	}
else{
try {
Statement ques_submit = null;
Statement s = null;
Statement se = null;
Statement addque = null;
ResultSet resultSet = null,temp=null,seresult=null;
ResultSet addqueResult=null;
ques_submit = c.createStatement();
addque=c.createStatement();
s=c.createStatement();
se=c.createStatement();
Statement ckbox=null;
ResultSet ckboxresult=null;
ckbox= c.createStatement();
String addqueQuery = "INSERT into exam (exam_name, exam_date,exam_time,exam_duration) values ('"+request.getParameter("exam_name")+"',TO_DATE('"+request.getParameter("exam_date")+"','DD/MM/YYYY'),'"+request.getParameter("exam_time")+"','"+request.getParameter("exam_duration")+"');";
String search_schema ="set search_path to dbms_sri;";
String schemaid="select * from schema_details where schema_name=";
String latestexam = "SELECT exam_id FROM exam order by exam_id DESC limit 1;";
PreparedStatement s1;
String latestid="";
try{
	s.executeQuery(search_schema);}
	catch(Exception e){
	}
try{
s1 = c.prepareStatement(addqueQuery);
s1.executeUpdate();
}catch(Exception e){
	out.println(e);
}
try{
	seresult = se.executeQuery(latestexam);
	while(seresult.next()){
		latestid = seresult.getString("exam_id");
	}
	out.println(latestid);
}catch(Exception e){
	out.println(e);
}

try{
	//Vector v = new Vector();
	int qucount=1;
	StringBuilder prevschema = new StringBuilder();

	String[] v = request.getParameterValues("que");
	if (v != null && v.length != 0) {
	for (int i = 0; i < v.length;i++) {
		out.println(v[i] + "p");
		%>
		<br>
		<%
	}
	}
	if (v != null && v.length != 0) {
		for (int i = 0; i < v.length;i+=2) {
			String f = v[i];
			if(f.isEmpty()){
				continue;
			}
			out.println("i " + i);
			out.println(f);
			String marks = v[i+1];
			StringBuilder sid = new StringBuilder();
			StringBuilder qid = new StringBuilder();
			StringBuilder maxmarks = new StringBuilder();
			maxmarks.append(marks);
			int count=0;
			for(int j=0;j<f.length();j++){
				if(i%2 == 0){
				if(f.charAt(j) == ' '){
					count++;
					continue;
				}
				else{
					if(count == 0){
					qid.append(f.charAt(j));}
					if(count == 1){
					sid.append(f.charAt(j));}
				}
				}
			}
			if(!f.isEmpty()){
			out.println("qid " + qid);
			out.println("sid " + sid);
			out.println("maxmarks " + maxmarks);
			prevschema=sid;
			String qry = "INSERT into exam_questions (exam_id,question_id,question_no,schema_id,max_marks) values ("+latestid+","+qid+","+qucount+","+sid+","+maxmarks+")";
			qucount++;
			out.println(qry);
			%>
			<br>
			<%
			try{
			ckboxresult = ckbox.executeQuery(qry);

			}catch(Exception e){
			}
			}
		}

		}
	



}
catch(Exception ep){ 
}

%>
<%
}catch(Exception e) {
	
}
	}
%>
</html>