<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*,java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</head>
<body>
<%
String str=request.getParameter("input");
String str1 = str.replace("[","{");
String s2 = str1.replace("]","}");
String op="";
FileWriter fp = new FileWriter("/home/pankil/eclipse-workspace/SRI/WebContent/WEB-INF/lib/ra/input.ra",false);
fp.write(s2);
fp.close();

FileWriter fp1 = new FileWriter("/home/pankil/eclipse-workspace/SRI/WebContent/WEB-INF/lib/ra/output.txt",false);
fp1.write(op);
fp1.close();
Process p =Runtime.getRuntime().exec("java -jar /home/pankil/eclipse-workspace/SRI/WebContent/WEB-INF/lib/ra/ra.jar /home/pankil/eclipse-workspace/SRI/WebContent/WEB-INF/lib/ra/sample.properties -i /home/pankil/eclipse-workspace/SRI/WebContent/WEB-INF/lib/ra/input.ra -o /home/pankil/eclipse-workspace/SRI/WebContent/WEB-INF/lib/ra/output.txt");
p.waitFor();
Scanner in = new Scanner(new FileReader("/home/pankil/eclipse-workspace/SRI/WebContent/WEB-INF/lib/ra/output.txt"));
String outString;
String[] ans= new String[10000];
Integer flag=0,i=0;
while(in.hasNextLine()) {
	if(in.nextLine().compareTo("-----")==0){
	flag++;
	}
	if(flag==1){
	    ans[i]=(in.nextLine());
	    i++;
	}
}
in.close();
Scanner in2 = new Scanner(new FileReader("/home/pankil/eclipse-workspace/SRI/WebContent/WEB-INF/lib/ra/output.txt"));
StringBuilder sb = new StringBuilder();
Integer j=0;
while(in2.hasNext()) {
	sb.append(in2.next());
}
in2.close();
outString = sb.toString();
String answer1 = outString.split(":")[1];
String answer = answer1.split("-----")[0].replaceAll("int4"," ").replaceAll("varchar", " ").replaceAll("timetime","time");
answer=answer.replaceAll("datedate", "date");
String[] label = answer.split(",");
String xxx = answer.split(",")[1];
%>
<div class="wrap-input100 " style= "text-align: center">

<span style="color: red"><b>Do not refresh page</b></span>
<br>
<b>Executed Query is :</b><br> <%=s2 %>
<br><b>Answer is : </b> 
<table class="table table-bordered" border="1" style="align: left;">
<%
for(Integer jj=0;jj<label.length;jj++){
	%>
	<td><%=label[jj]%></td>
	<%
}%>
<%
Integer u=0;
String[] l;

for(Integer ii=0;ii<i;ii++){
	%>
	<tr>
	<%
String ll = ans[ii].replace('|', ' ');
l=ll.split(" ");
for(Integer e=0;e<l.length;e++){
	%>
	<td><%=l[e]%></td>
<%
}

%>
</tr>
<%
}
%>

</table>
</div>
</div>

<script type="text/javascript">
</script>
</body>
</html>