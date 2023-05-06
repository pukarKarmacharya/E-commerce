package controller.dbconnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.PasswordEncryptionWithAes;
import model.User;
import model.Product;

import resources.MyConstants;

public class DbConnection {
	public Connection getConnection(){
		try {
			Class.forName(MyConstants.DRIVER_NAME);
			Connection connection = DriverManager.getConnection(
					MyConstants.DB_URL,
					MyConstants.DB_USER_NAME,
					MyConstants.DB_USER_PASSWORD);
			return connection;
		}catch(SQLException | ClassNotFoundException ex) {
			ex.printStackTrace();
			return null;
		}
	}
	
	//	Start region Read operation
	public List<User> getAllData(String query) {
        List<User> dataList = new ArrayList();
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
	            Statement stmt = dbConnection.createStatement();
	            ResultSet rs = stmt.executeQuery(query);
	            while (rs.next()) {
	            	User data = new User();
	                data.setFirstName(rs.getString("first_name"));
	                data.setLastName(rs.getString("last_name"));
	                data.setUsername(rs.getString("username"));
	                data.setRole(rs.getString("role"));
	                dataList.add(data);
	            }
	            rs.close();
	            stmt.close();
	            dbConnection.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
		}
        return dataList;
	}
	
	public ResultSet selectWhereQuery(String query, String id) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, id);
				ResultSet result = statement.executeQuery();
				return result;
			} catch (SQLException e) {
				return null;
			}
		}else {
			return null;
		}
	}

	public Boolean isUserAlreadyRegistered(String username) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(MyConstants.CHECK_LOGIN_INFO);
				statement.setString(1, username);
				ResultSet result = statement.executeQuery();
				if(result.next()) {
					return true;		
				}else return false;
			} catch (SQLException e) { return null; }
		}else { return null; }
						
	}
	
	public Boolean isProductAlreadyAdded(String productName) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(MyConstants.CHECK_PRODUCT_INFO);
				statement.setString(1, productName);
				ResultSet result = statement.executeQuery();
				if(result.next()) {
					return true;		
				}else return false;
			} catch (SQLException e) { return null; }
		}else { return null; }
						
	}
	
	public Boolean isUserRegistered(String query, String username, String password) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, username);
				ResultSet result = statement.executeQuery();
				if(result.next()) {
					String userDb = result.getString("username");
					String passwordDb  = result.getString("password");
					String decryptedPwd = PasswordEncryptionWithAes.decrypt(passwordDb, username);
					if(decryptedPwd!=null && userDb.equals(username) && decryptedPwd.equals(password)) return true;
					else return false;
				}else return false;
			} catch (SQLException e) { return null; }
		}else { return null; }
	}
	
	public Boolean isproductRegistered(String query, String productName) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, productName);
				ResultSet result = statement.executeQuery();
				if(result.next()) {
					String productDb = result.getString("productName");
					if(productDb.equals(productName) ) return true;
					else return false;
				}else return false;
			} catch (SQLException e) { return null; }
		}else { return null; }
	}
		
	public int isAdmin(String username) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(MyConstants.IS_USER);
				statement.setString(1, username);
				ResultSet result = statement.executeQuery();
				if(result.next()) {
					String role = result.getString("role");
					if(role.equalsIgnoreCase(MyConstants.ADMIN)) {
						System.out.print("1-");
						System.out.println(role);
						return 1;
					}
					else {
						System.out.print("0-");
						System.out.println(role);
						System.out.print("Constants-");
						System.out.println(MyConstants.ADMIN);
						
						return 0;
					}
				}
				else return -1;
			} catch (SQLException e) { return -2; }
		}else { return -3; }
	}
	//	End region Read operation

	//	Start region Create operation
	public int registerUser(String query, User userModel) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				if(isUserAlreadyRegistered(userModel.getUsername())) return -1;
				
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, userModel.getFirstName());
				statement.setString(2, userModel.getLastName());
				statement.setString(3, userModel.getUsername());
				statement.setString(4, PasswordEncryptionWithAes.encrypt(
						userModel.getUsername(), userModel.getPassword()));
				statement.setString(5, userModel.getRole());
				statement.setString(6, userModel.getImageUrlFromPart());

				int result = statement.executeUpdate();
				if(result>=0) return 1;
				else return 0;
			} catch (Exception e) {
				System.out.println(e);
				return -2; 
				}
		}else { return -3; }
	}
	//	End region Create operation
	
	//	Start region Update operation
	public Boolean updateUser(String query, String username) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, username);
				int result = statement.executeUpdate();
				if(result>=0)return true;
				else return false;
			} catch (SQLException e) { return null; }
		}else { return null; }
	}
	//	End region Update operation
	
	//	Start region Delete operation
	public Boolean deleteUser(String query, String username) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, username);
				int result = statement.executeUpdate();
				if(result>=0)return true;
				else return false;
			} catch (SQLException e) { return null; }
		}else { return null; }
	}
	//	End region Delete operation
	
//	Start region Create operation
	public int addProduct(String query, Product productModel) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				//if(isProductAlreadyAdded(productModel.getProductName())) return -1;
				
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, productModel.getProductName());
				statement.setInt(2, productModel.getPrice());
				statement.setInt(3, productModel.getStock());
				statement.setString(4, productModel.getBrand());
				statement.setString(5, productModel.getCategory());
				statement.setString(6, productModel.getImageUrlFromPart());

				int result = statement.executeUpdate();
				if(result>=0) return 1;
				else return 0;
			} catch (Exception e) {
				System.out.print("add-");
				System.out.println(e);
				return -2; 
				}
		}else { return -3; }
	}
	//	End region Create operation
	
	//	Start region Update operation
	public Boolean updateProduct(String query, String productName) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, productName);
				int result = statement.executeUpdate();
				if(result>=0)return true;
				else return false;
			} catch (SQLException e) { return null; }
		}else { return null; }
	}
	//	End region Update operation
	
	//	Start region Delete operation
	public Boolean deleteProduct(String query, String productName) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, productName);
				int result = statement.executeUpdate();
				if(result>=0)return true;
				else return false;
			} catch (SQLException e) { return null; }
		}else { return null; }
	}
	//	End region Delete operation
	
	
}