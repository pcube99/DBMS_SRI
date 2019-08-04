<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*"%>
<style><%@include file="/WEB-INF/css/style.css"%></style>
<style><%@include file="/WEB-INF/css/b1.css"%></style>
<style><%@include file="/WEB-INF/css/b2.css"%></style>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"><body>

<script><%@include file="/WEB-INF/js/j1.js"%></script>
<script><%@include file="/WEB-INF/js/j2.js"%></script>
<body>
<nav class="navbar navbar-dark bg-dark"">
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
        <a class="nav-link" href="marks.jsp" style="color :aliceblue"><i class="fa fa-list-ul"></i><strong> Marks</strong></a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="help.jsp" style="color :aliceblue"><i class="fa fa-info-circle"></i><strong> Help</strong></a>
    </li>     
    <li class="nav-item">
        <a class="nav-link" href="logout.jsp" style="color :aliceblue"><i class="fa fa-sign-out"></i><strong> Logout</strong></a>
    </li>  
  </ul>
</nav>
	<form name="f4" method="get" action="questionta.jsp">
Question:<br>
<textarea rows="4" cols="50" name="question_text" required placeholder="Insert Question"></textarea>
<br>
Answer:
<br>
<textarea rows="4" cols="50" name="answer_text" required placeholder="Insert Answer"></textarea>
<br>
<button type="submit" class="btn btn-info">Submit</button></form>
</body>
<%
Connection c= null;
try{
    Class.forName("org.postgresql.Driver");
    String url = "jdbc:postgresql://localhost:5432/dbms_sri";
    c = DriverManager.getConnection(url, "postgres", "123");
} catch(Exception e) {
    System.out.println("error");
}

Statement ques_submit = null;
Statement s = null;
ResultSet resultSet = null,temp=null;
%>
<%
if(null == session.getAttribute("user")){
%>
<a href="index.jsp"><img id="error" src="e.JPG"></a>

<%	
}
else{
ques_submit = c.createStatement();
s=c.createStatement();
String question_text = request.getParameter("question_text");
String answer_text = request.getParameter("answer_text");
out.println(question_text);
String search_schema ="set search_path to dbms_sri";
try
{
s.executeQuery(search_schema);
}
catch(Exception ep)
{
}
PreparedStatement stmt;
stmt = c.prepareStatement("INSERT into question_bank (question_id, question_text, schema_id,correct_answer) values (?,?,?,?)");
stmt.setInt(1, 33);
stmt.setString(2,request.getParameter("question_text"));
stmt.setInt(3, 1);
stmt.setString(4,request.getParameter("answer_text"));

int status =stmt.executeUpdate();
}

%>

