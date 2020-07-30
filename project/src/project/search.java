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
 * Servlet implementation class search
 */
@WebServlet("/search")
public class search extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JdbcTools jdbcTools = new JdbcTools();
		
		String sql = "SELECT ImageID, Title, Description, PATH FROM travelimage ORDER BY ImageID DESC";
		ArrayList<String[]> result = jdbcTools.query(sql);
		
		jdbcTools.relese();
		
		request.setAttribute("imgs", result);
		RequestDispatcher rd = request.getRequestDispatcher("/search.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JdbcTools jdbcTools = new JdbcTools();
		
		String key = request.getParameter("content");
		String sql = null;
		if (request.getParameter("order") == "1") {
			sql = "SELECT ImageID, Title, Description, PATH FROM travelimage WHERE " + (Integer.parseInt(request.getParameter("way")) == 1 ? "Title" : "Content")  +" LIKE '%" + key + "%' ORDER BY ImageID DESC";
		}
		else {
			sql = "SELECT ImageID, Title, Description, PATH, Favornum FROM travelimage WHERE " + (Integer.parseInt(request.getParameter("way")) == 1 ? "Title" : "Content")  +" LIKE '%" + key + "%' ORDER BY Favornum DESC";
		}
		ArrayList<String[]> result = jdbcTools.query(sql);
		System.out.print(sql + request.getParameter("way"));
		
		jdbcTools.relese();
		
		request.setAttribute("imgs", result);
		RequestDispatcher rd = request.getRequestDispatcher("/search.jsp");
		rd.forward(request, response);
	}

}
