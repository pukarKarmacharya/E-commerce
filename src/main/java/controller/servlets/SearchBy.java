package controller.servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.dbconnection.DbConnection;
import resources.MyConstants;

/**
 * Servlet implementation class SearchBy
 */
@WebServlet("/SearchBy")
public class SearchBy extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String search = request.getParameter("search");
		System.out.println(search);
				HttpSession session = request.getSession();
				session.setAttribute("search", search);
				//setting session to expiry in 30 mins
				session.setMaxInactiveInterval(30*60);

				Cookie searchBy = new Cookie("search", search);
				searchBy.setMaxAge(30*60);
				response.addCookie(searchBy);
				
				response.sendRedirect(request.getContextPath()+"/home.jsp");
			
	}

}
