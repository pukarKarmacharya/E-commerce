package controller.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import controller.dbconnection.DbConnection;
import model.User;
import resources.MyConstants;


@WebServlet(asyncSupported = true, urlPatterns = { "/UserRegister" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
	maxFileSize = 1024 * 1024 * 10, // 10MB
	maxRequestSize = 1024 * 1024 * 50)
public class UserRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String  username = request.getParameter("username");
		String  password = request.getParameter("password");
		String  role = request.getParameter("role");
		Part imagePart = request.getPart("image");	
		User userModel = new User(firstName, lastName, username, password, role, imagePart);
		
	    String savePath = MyConstants.IMAGE_DIR_SAVE_PATH;
	    String fileName = userModel.getImageUrlFromPart();
	    if(!fileName.isEmpty() && fileName != null)
    		imagePart.write(savePath + fileName);
		
		DbConnection con = new DbConnection();
		int result = con.registerUser(MyConstants.USER_REGISTER, userModel);
		if(result == 1) {
			request.setAttribute("registerMessage", "Successfully Registered");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}else if(result == -1) {
			request.setAttribute("registerMessage", "User Already Exists");
			request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
		}else {
			System.out.println("Not working");
			System.out.println(result);
			
			request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
		}
		
	}

}
