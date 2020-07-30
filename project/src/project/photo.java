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
 * Servlet implementation class photo
 */
@WebServlet("/photo")
public class photo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getSession().getAttribute("userid") != null) {
			JdbcTools jdbcTools = new JdbcTools();
			
			String userid = (String)request.getSession().getAttribute("userid");
			String sql = null;
			
			if (request.getParameter("del") != null) {
				sql ="DELETE FROM travelimage WHERE ImageID = ? ";
				jdbcTools.update(sql, request.getParameter("del"));
			}
			
			sql = "SELECT ImageID, Title, Description, PATH FROM travelimage WHERE UID = ?";
			
			ArrayList<String[]> result = jdbcTools.query(sql, userid);
			
			jdbcTools.relese();
			
			request.setAttribute("imgs", result);
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("/photo.jsp");
		rd.forward(request, response);
	}

}
