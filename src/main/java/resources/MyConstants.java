package resources;

public class MyConstants {
	// Start Region: Database Configuration
	public static final String DRIVER_NAME = "com.mysql.jdbc.Driver";
	public static final String DB_URL = "jdbc:mysql://localhost:3306/lifestyle";
	public static final String DB_USER_NAME = "root"; 		
	public static final String DB_USER_PASSWORD= ""; 		
	// End Region: Database Configuration
	
	// Start Region: Query
	public static final String CHECK_LOGIN_INFO = "SELECT username, password FROM register WHERE username = ? AND password = ?";
	public static final String GET_ALL_INFO = "SELECT * FROM register";
	public static final String GET_ALL_INFO_BY_ID = "SELECT * FROM register WHERE id = ?";
	// End Region: Query
	
}
