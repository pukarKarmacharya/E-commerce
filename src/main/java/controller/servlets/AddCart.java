package controller.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.dbconnection.DbConnection;
import model.Cart;
import resources.MyConstants;

/**
 * Servlet implementation class AddOrder
 */
@WebServlet("/AddCart")
public class AddCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String productName = request.getParameter("productName");
		String user = request.getParameter("user");
		String image = request.getParameter("image");
		int stock = Integer.parseInt(request.getParameter("stock"));
		int price = Integer.parseInt(request.getParameter("price"));
		int productId = Integer.parseInt(request.getParameter("productId"));
		int quantity = 1;
		int amount = price * quantity;
		Cart cartModel = new Cart(productName, price, quantity, amount, productId,stock, image, user);
		
		DbConnection con = new DbConnection();
		int result = con.addToCart(MyConstants.ADDTOCART, cartModel);
		if(result == 1) {
			request.setAttribute("addProductMessage", "Successfully Added");
			request.getRequestDispatcher("/home.jsp").forward(request, response);
		}else if(result == -1) {
			request.setAttribute("addProductMessage", "Product Already Exists");
			request.getRequestDispatcher("/home.jsp").forward(request, response);
		}else {
			System.out.println("Not working");
			System.out.println(result);
			
			request.getRequestDispatcher("/home.jsp").forward(request, response);
		}
	}
}
