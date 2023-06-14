package controller.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.dbconnection.DbConnection;
import model.Order;
import resources.MyConstants;

/**
 * Servlet implementation class Order
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/OrderBy" })
public class OrderBy extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String user = request.getParameter("user");
		int total = Integer.parseInt(request.getParameter("total"));
		int productId = Integer.parseInt(request.getParameter("productId"));
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		int stock = Integer.parseInt(request.getParameter("stock"));
		int updatedStock = 0;

		Order orderModel = new Order(quantity, total, productId, stock, user);

		DbConnection con = new DbConnection();
		if (quantity > stock) {
			request.setAttribute("NoStockMessage", "There is not enough stock");
			request.getRequestDispatcher("/pages/user.jsp").forward(request, response);
		} else {
			updatedStock = stock - quantity;
			System.out.println("sssssssssss");
			
			  Boolean updateStock = con.updateStock(MyConstants.UPDATE_STOCK, productId, updatedStock ); 
			  Boolean deleteAddToCart = con.deleteAddToCart(MyConstants.DELETE_ADDTOCART, productId);
			 

		}
		System.out.println(user);
		System.out.println(total);
		System.out.println(productId);
		System.out.println(quantity);
		System.out.println(stock);
		System.out.println(updatedStock);

		int result = con.orderBy(MyConstants.ORDER_BY, orderModel);
		if (result == 1) {
			request.setAttribute("orderMessage", "Successfully Ordered");
			request.getRequestDispatcher("/home.jsp").forward(request, response);
		} else if (result == -1) {
			request.setAttribute("orderMessage", "Order Already Exists");
			request.getRequestDispatcher("/pages/user.jsp").forward(request, response);
		} else {
			System.out.println("Not working");
			System.out.println(result);

			request.getRequestDispatcher("/home.jsp").forward(request, response);
		}
	}

}
