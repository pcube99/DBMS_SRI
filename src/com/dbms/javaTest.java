package com.dbms;
import java.io.*;
public class javaTest {
	public static String scheduleCourses() throws IOException {

	    String execute = "java -jar /home/pankil/eclipse-workspace/SRI/WebContent/WEB-INF/lib/ra/ra.jar -i /home/pankil/eclipse-workspace/SRI/WebContent/WEB-INF/lib/ra/sample.ra -o /home/pankil/eclipse-workspace/SRI/WebContent/WEB-INF/lib/ra/ppp.txt";
	    Process process = Runtime.getRuntime().exec(execute);
	    BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));

	    try {
	        process.waitFor();

	    } catch (InterruptedException ex) {
	    	return "Error with import<br>" +ex;
	    }
	    return "All done";
	}
    

}
