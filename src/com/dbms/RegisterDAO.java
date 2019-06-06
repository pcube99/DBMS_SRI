package com.dbms;
import java.sql.*;
public class RegisterDAO {
	static Connection conn;
	static PreparedStatement pst;
	static PreparedStatement pst2;
	
	public static int registerStudent(Register u) {
		int status = 0;
		try {
			
			conn = ConnectionProvider.getCon();
			
			pst2 = conn.prepareStatement("set search_path to dbms_sri");
			status = pst2.executeUpdate();
			
			pst = conn.prepareStatement("insert into student_profile values(?, ?, ?)");
			pst.setInt(1,u.getStudent_id());
			pst.setString(2, u.getStudent_name());
			pst.setString(3, u.getStudent_password());
			status = pst.executeUpdate();
			conn.close();
		} catch(Exception ex){
			System.out.println(ex);
		}
		return status;
	}
}
