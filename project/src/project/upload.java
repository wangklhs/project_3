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
 * Servlet implementation class upload
 */
@WebServlet("/upload")
public class upload extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JdbcTools jdbcTools = new JdbcTools();
		
		String id = request.getParameter("id");
		String iso = request.getParameter("country");
		String sql = "SELECT ISO, Country_RegionName FROM geocountries_regions";
		ArrayList<String[]> countries = jdbcTools.query(sql);
		
		request.setAttribute("countries", countries);
		
		if (id != null) {
			sql = "SELECT * FROM travelimage WHERE ImageID = ?";
			ArrayList<String[]> result = jdbcTools.query(sql, id);
			request.setAttribute("img", result);
			if (iso == null) {
				iso = result.get(0)[6];
			}
		}
		
		if (iso != null) {
			sql = "SELECT GeoNameID, AsciiName FROM geocities WHERE Country_RegionCodeISO = ?";
			request.setAttribute("cities", jdbcTools.query(sql, iso));
		}
		
		jdbcTools.relese();
		
		RequestDispatcher rd = request.getRequestDispatcher("/upload.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String des = request.getParameter("des");
		String iso = request.getParameter("iso");
		String city = request.getParameter("city");
		String path = request.getParameter("path"); 			
		String content = request.getParameter("content");
		String userid = (String)request.getSession().getAttribute("userid");
		
		JdbcTools jdbcTools = new JdbcTools();
		String sql = null;
		if (request.getParameter("id") != null) {
			sql = "UPDATE travelimage SET Title = ?, Description = ?, CityCode = ?, Country_RegionCodeISO = ?, Content = ? WHERE ImageID = ?";
			jdbcTools.update(sql, title, des, city, iso, content, request.getParameter("id"));
		}
		else {
			sql = "INSERT INTO travelimage (Title,Description,CityCode,Country_RegionCodeISO,UID,PATH,Content) VALUES (?,?,?,?,?,?,?)";
			jdbcTools.update(sql, title, des, city, iso, userid, path, content);
		}
		
		jdbcTools.relese();
		
		response.sendRedirect("/project/photo");
	}

}
