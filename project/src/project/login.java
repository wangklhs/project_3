package project;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class login
 */
@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameter("location") != null) {
			request.getSession().setAttribute("location", request.getParameter("location"));
		}
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String sql = "SELECT UID, UserName FROM traveluser WHERE UserName = ? AND Pass = ?";
		
		JdbcTools jdbcTools = new JdbcTools();
		ArrayList<String[]> result = jdbcTools.query(sql, username, password);
		String location = request.getSession().getAttribute("location") != null ? (String) request.getSession().getAttribute("location") : "index";
		if (result.isEmpty()) {
			sql = "SELECT UID, UserName FROM traveluser WHERE Email = ? AND Pass = ?";
			result = jdbcTools.query(sql, username, password);
			if (result.isEmpty()) {
				request.setAttribute("err", 1);
				jdbcTools.relese();
				RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
				rd.forward(request, response);
			}
			else {
				request.getSession().setAttribute("username", result.get(0)[1]);
				request.getSession().setAttribute("userid", result.get(0)[0]);
				jdbcTools.relese();
				response.sendRedirect("/project/" + location );
			}
		}
		else {
			request.getSession().setAttribute("username", result.get(0)[1]);
			request.getSession().setAttribute("userid", result.get(0)[0]);
			jdbcTools.relese();
			response.sendRedirect("/project/" + location );
		}
	}

}
