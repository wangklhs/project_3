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
 * Servlet implementation class index
 */
@WebServlet("/index")
public class index extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JdbcTools jdbcTools = new JdbcTools();
		
		String sql = "SELECT Title, PATH, Favornum FROM travelimage ORDER BY Favornum DESC";
		ArrayList<String[]> result1 = jdbcTools.query(sql);
		
		sql = "SELECT ImageID, Title, Description, PATH, UID FROM travelimage ORDER BY ImageID DESC";
		ArrayList<String[]> result2 = jdbcTools.query(sql);
		for(int i = 0; i < result2.size(); i ++) {
			sql = "SELECT UserName FROM traveluser WHERE UID = ?";
			ArrayList<String[]> row = jdbcTools.query(sql, result2.get(i)[4]);
			result2.get(i)[4] = row.get(0)[0];
		}
		
		jdbcTools.relese();
		
		request.setAttribute("imgs1", result1);
		request.setAttribute("imgs2", result2);
		RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
		rd.forward(request, response);
	}

}
