package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO {
	Connection con;
	
	public void getCon() {
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			String url="jdbc:mariadb://localhost:3306/pro01";
			String user="root";
			String password="0910";
			
			con = DriverManager.getConnection(url, user, password);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}