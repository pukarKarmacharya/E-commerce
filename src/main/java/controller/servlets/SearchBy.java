package controller.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class SearchBy
 */
@WebServlet("/SearchBy")
public class SearchBy extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String search = request.getParameter("search");
		String category = request.getParameter("category");
		String brand = request.getParameter("brand");
		String filter = request.getParameter("filter");
		
		
		System.out.println(search);
		System.out.println(category);
		System.out.println(brand);
		System.out.println(filter);
		
				HttpSession session = request.getSession();
				session.setAttribute("search", search);
				session.setAttribute("category", category);
				session.setAttribute("brand", brand);
				session.setAttribute("filter", filter);
				
				
				//setting session to expiry in 5 mins
				session.setMaxInactiveInterval(5*60);

				/*
				 * Cookie searchBy = new Cookie("search", search); searchBy.setMaxAge(30*60);
				 * response.addCookie(searchBy);
				 */
				response.sendRedirect(request.getContextPath()+"/pages/product.jsp");
			
	}

}
