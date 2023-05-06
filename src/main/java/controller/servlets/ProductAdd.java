package controller.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import controller.dbconnection.DbConnection;
import model.User;
import resources.MyConstants;

/**
 * Servlet implementation class ProductAdd
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/ProductAdd" })
public class ProductAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String productName = request.getParameter("productName");
		String price = request.getParameter("price");
		String stock = request.getParameter("stock");
		String brand = request.getParameter("brand");
		String category = request.getParameter("category");
		Part imagePart = request.getPart("image");	
		User productsModel = new User(productName, price, stock, brand, category, imagePart);
		
	    String savePath = MyConstants.IMAGE_DIR_SAVE_PATH;
	    String fileName = productsModel.getImageUrlFromPart();
	    if(!fileName.isEmpty() && fileName != null)
    		imagePart.write(savePath + fileName);
		
		DbConnection con = new DbConnection();
		int result = con.registerUser(MyConstants.ADD_PRODUCT, productsModel);
		if(result == 1) {
			request.setAttribute("addProductMessage", "Successfully Added");
			request.getRequestDispatcher("/pages/admin.jsp").forward(request, response);
		}else if(result == -1) {
			request.setAttribute("addProductMessage", "Product Already Exists");
			request.getRequestDispatcher("/pages/admin.jsp").forward(request, response);
		}else {
			System.out.println("Not working");
			System.out.println(result);
			
			request.getRequestDispatcher("/pages/admin.jsp").forward(request, response);
		}
	}

}
