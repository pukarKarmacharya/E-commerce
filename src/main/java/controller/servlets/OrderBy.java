package controller.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

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
     * @see HttpServlet#HttpServlet()
     */
    public OrderBy() {
        super();
        // TODO Auto-generated constructor stub
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user = request.getParameter("user");
		int total = Integer.parseInt(request.getParameter("total"));
		
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		
		System.out.println(user);
		System.out.println(total);
		System.out.println(quantity);
		
		
		Order orderModel = new Order(quantity, total, user);
		
		DbConnection con = new DbConnection();
		int result = con.orderBy(MyConstants.ORDER_BY, orderModel);
		if(result == 1) {
			request.setAttribute("addProductMessage", "Successfully Added");
			request.getRequestDispatcher("/pages/home.jsp").forward(request, response);
		}else if(result == -1) {
			request.setAttribute("addProductMessage", "Product Already Exists");
			request.getRequestDispatcher("/pages/user.jsp").forward(request, response);
		}else {
			System.out.println("Not working");
			System.out.println(result);
			
			request.getRequestDispatcher("/pages/home.jsp").forward(request, response);
		}
	}

}
