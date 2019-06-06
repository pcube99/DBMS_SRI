package com.dbms;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

public class loginServlet extends HttpServlet{
public void doGet(HttpServletRequest req,HttpServletResponse res) throws IOException, ServletException
{
	PrintWriter out = res.getWriter();
String id = (req.getParameter("student_id"));
String pwd= (req.getParameter("student_password"));

out.println(id + " " + pwd);
Connection c= null;
try{
    Class.forName("org.postgresql.Driver");
    String url = "jdbc:postgresql://localhost:5432/dbms_sri";
    c = DriverManager.getConnection(url, "postgres", "123");
} catch(Exception e) {
    System.out.println("errpr");
}
Connection connection = null;
Statement statement = null,statement1=null;
ResultSet resultSet = null,temp=null;

}
}
