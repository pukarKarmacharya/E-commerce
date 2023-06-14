package resources;

import java.io.File;

public class MyConstants {
	// Start Region: Database Configuration
	public static final String DRIVER_NAME = "com.mysql.cj.jdbc.Driver";
	public static final String DB_URL = "jdbc:mysql://localhost:3306/reeven_store";
	public static final String DB_USER_NAME = "root"; 		
	public static final String DB_USER_PASSWORD= ""; 		
	// End Region: Database Configuration
	
	public static final String ADMIN = "admin";
	public static final String USER = "user";
	
	public static final String IMAGE_DIR = "Program Files\\Apache Software Foundation\\Tomcat 10.1\\webapps\\images\\";
	public static final String IMAGE_DIR_SAVE_PATH = "C:" + File.separator + IMAGE_DIR;
	// End Region: Database Configuration
	
	// Start Region: Select Query
	public static final String CHECK_LOGIN_INFO = "SELECT username, password FROM register WHERE username = ?";	
	public static final String GET_ALL_INFO = "SELECT * FROM register";
	public static final String GET_ALL_INFO_BY_ID = "SELECT * FROM register WHERE id = ?";
	public static final String IS_USER = "SELECT role FROM register WHERE username = ?";
	
	public static final String CHECK_PRODUCT_INFO = "SELECT product_name FROM product WHERE product_name = ?";	

	// Start Region: Insert Query
	public static final String USER_REGISTER = "INSERT INTO register"
			+ "(first_name, last_name, username, password, role, image)"
			+ " VALUES(?,?,?,?,?,?)";
	// End Region: Insert Query
	
	// Start Region: Insert Query
	public static final String ADD_PRODUCT = "INSERT INTO product"
			+ "(product_name, price, stock, brand, category, image, user_id)"
			+ " VALUES(?,?,?,?,?,?,(SELECT user_id FROM register WHERE username = ?))";
	// End Region: Insert Query
	
	// Start Region: Insert Query
	public static final String ORDER_BY = "INSERT INTO orderby"
			+ "(quantity, total, product_id, user_id)"
			+ " VALUES(?,?,?,(SELECT user_id FROM register WHERE username = ?))";
	// End Region: Insert Query
	
	// Start Region: Update Query
	public static final String UPDATE_USER_INFO = "UPDATE register SET first_name=?";
	// End Region: Update Query
	
	public static final String UPDATE_PRODUCT_INFO = "UPDATE product SET productName=?, "
			+ "price=?, stock=?, brand=? catagory=? WHERE productID=?";
		
	// Start Region: Delete Query
	public static final String DELETE_USER = "DELETE FROM register WHERE username=?";
	// End Region: Delete Query
	
	// Start Region: Delete Query
	public static final String DELETE_Product = "DELETE FROM register WHERE ProductID=?";
	// End Region: Delete Query

	// Start Region: Delete Query
	public static final String ADDTOCART = "INSERT INTO addtocart"
			+ "(product_name, price, quantity, amount,image, stock, product_id, user_id)"
			+ " VALUES(?,?,?,?,?,?,?,(SELECT user_id FROM register WHERE username = ?))";
	// End Region: Delete Query
	
	// Start Region: Update Query
	public static final String UPDATE_STOCK = "UPDATE product SET stock=? "
				+ "WHERE product_id=?";
	// End Region: Update Query
	
	// Start Region: Delete Query
	public static final String DELETE_ADDTOCART = "DELETE FROM addtocart WHERE product_id=?";
	// End Region: Delete Query
}
