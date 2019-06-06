package com.dbms;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Connection;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import java.sql.*;

@WebServlet("/add")
public class submitServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("sss");
		System.out.println(request.getParameter("qid"));
		Connection c= null;
		try{
		    Class.forName("org.postgresql.Driver");
		    String url = "jdbc:postgresql://localhost:5432/dbms_sri";
		    c = DriverManager.getConnection(url, "postgres", "123");
		} catch(Exception e) {
		    System.out.println("error");
		}
		try {
		Statement ques_submit = null;
		Statement s = null;
		ResultSet resultSet = null,temp=null;
		ques_submit = c.createStatement();
		s=c.createStatement();
		String qid = request.getParameter("qid");
		String search_schema ="set search_path to dbms_sri";
		
		try{
		s.executeQuery(search_schema);
		}catch(Exception ep){
		}
		
		PreparedStatement stmt;
		stmt = c.prepareStatement("INSERT into answers (exam_id, student_id,question_id,student_answer,obtained_marks) values (?,?,?,?,?)");
		stmt.setInt(1, Integer.parseInt(request.getParameter("examid")));
		stmt.setInt(2, Integer.parseInt(request.getParameter("studentid")));
		stmt.setInt(3, Integer.parseInt(request.getParameter("questionid")));
		stmt.setString(4,request.getParameter("sanswer"));
		stmt.setInt(5, Integer.parseInt(request.getParameter("obtainedmark")));
		stmt.executeUpdate();
		}catch(Exception e) {
			
		}

	}
}
