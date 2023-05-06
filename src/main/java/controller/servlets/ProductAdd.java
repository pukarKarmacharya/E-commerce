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
import model.Product;

import resources.MyConstants;

/**
 * Servlet implementation class ProductAdd
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/ProductAdd" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50)
public class ProductAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String productName = request.getParameter("productName");
		System.out.print("P-");
		
		System.out.println(productName);
		System.out.println(request.getParameter("price"));
		System.out.println(request.getParameter("stock"));
		
		int price = Integer.parseInt(request.getParameter("price"));
		int stock = Integer.parseInt(request.getParameter("stock"));
		System.out.println(price);
		System.out.println(stock);
		String brand = request.getParameter("brand");
		String category = request.getParameter("category");
		Part imagePart = request.getPart("image");	
		Product productModel = new Product(productName, price, stock, brand, category, imagePart);
		
	    String savePath = MyConstants.IMAGE_DIR_SAVE_PATH;
	    String fileName = productModel.getImageUrlFromPart();
	    if(!fileName.isEmpty() && fileName != null)
    		imagePart.write(savePath + fileName);
		
		DbConnection con = new DbConnection();
		int result = con.addProduct(MyConstants.ADD_PRODUCT, productModel);
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
