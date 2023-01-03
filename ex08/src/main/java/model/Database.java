package model;
import java.sql.*;

public class Database {
	public static Connection CON;
	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			CON=DriverManager.getConnection("jdbc:mysql://localhost:3306/webdb","web","pass");
			System.out.println("접속완료");
		}catch(Exception e) {
			System.out.println("접속애러 :" + e.toString());
		}
	}
}
