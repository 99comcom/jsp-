package model;

import java.sql.Connection;
import java.sql.DriverManager;

public class Data {

	public static Connection CON;
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			CON=DriverManager.getConnection("jdbc:mysql://localhost:3306/shopdb","shop","pass");
			System.out.println("접속완료");
		}catch(Exception e) {
			System.out.println("접속애러 :" + e.toString());
		}
	}
}
