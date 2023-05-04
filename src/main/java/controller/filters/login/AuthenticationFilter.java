package controller.filters.login;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/authenticationfilter")
public class AuthenticationFilter implements Filter {
private ServletContext context;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		this.context = filterConfig.getServletContext();
		this.context.log("AuthenticationFilter initialized");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
	
        // Check if the request is a login or logout request
        String uri = req.getRequestURI();
		boolean isLoginJsp = uri.toLowerCase().endsWith("login.jsp");
		boolean isLoginServlet = uri.endsWith("LoginServlet");
		boolean isLogoutServlet = uri.endsWith("LogoutServlet");
		boolean isRegisterJsp = uri.endsWith("register.jsp");
		boolean isUserRegisterServlet = uri.endsWith("UserRegister");

		HttpSession session = req.getSession(false);
        boolean loggedIn = session != null && session.getAttribute("user") != null;

        if(!loggedIn && !(isLoginJsp || isUserRegisterServlet || isLoginServlet || isRegisterJsp) && !uri.contains("css")){
            res.sendRedirect(req.getContextPath()+"/login.jsp");
        }else if (loggedIn && (isRegisterJsp)) {
		    res.sendRedirect(req.getContextPath() + "/home.jsp");
	    }else if(loggedIn && !(!isLoginJsp || isLogoutServlet)) {
			res.sendRedirect(req.getContextPath()+"/home.jsp");
		}else{
			chain.doFilter(request, response);
		}		
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
	}

}
