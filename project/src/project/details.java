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
 * Servlet implementation class details
 */
@WebServlet("/details")
public class details extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JdbcTools jdbcTools = new JdbcTools();
		
		String imgid = request.getParameter("id");
		String userid  = (String)request.getSession().getAttribute("userid");
		String sql = "SELECT * FROM travelimage WHERE ImageID = ?";
		ArrayList<String[]> result = jdbcTools.query(sql, imgid);
		
		if (result.get(0)[6] != null) {
			sql = "SELECT Country_RegionName FROM geocountries_regions WHERE ISO = ?";
			ArrayList<String[]> row = jdbcTools.query(sql, result.get(0)[6]);
			result.get(0)[6] = row.get(0)[0];
		}
		
		if (result.get(0)[5] != null) {
			sql = "SELECT AsciiName FROM geocities WHERE GeoNameID = ?";
			ArrayList<String[]> row = jdbcTools.query(sql, result.get(0)[5]);
			result.get(0)[5] = row.get(0)[0];
		}
		
		if (result.get(0)[7] != null) {
			sql = "SELECT UserName FROM traveluser WHERE UID = ?";
			ArrayList<String[]> row = jdbcTools.query(sql, result.get(0)[7]);
			result.get(0)[7] = row.get(0)[0];
		}
		
		request.setAttribute("row", result);
		
		if (userid != null ) {
			sql = "DELETE FROM travelfootprint WHERE userid = ? AND imageid = ?";
			jdbcTools.update(sql, userid, imgid);
			sql = "INSERT INTO travelfootprint (userid, imageid, imagetitle) VALUES (?, ?, ?)";
			jdbcTools.update(sql, userid, imgid, result.get(0)[1]);
		}
		
		if (request.getParameter("favor") != null) {
			if (userid != null) {
				sql = "INSERT INTO travelimagefavor (UID, ImageID) VALUES (?, ?)";
				jdbcTools.update(sql, userid, imgid);
				sql = "UPDATE travelimage SET Favornum = ? WHERE ImageID = ?";
				jdbcTools.update(sql, Integer.parseInt(result.get(0)[10]) + 1, imgid );
				result.get(0)[10] = "" + (Integer.parseInt(result.get(0)[10]) + 1);
			}
		}
		
		sql = "SELECT * FROM travelimagefavor WHERE UID = ? AND ImageID = ?";
		if (!jdbcTools.query(sql, userid, imgid).isEmpty()) {
			request.setAttribute("collected", 1);
		}
		
		jdbcTools.relese();
		
		if (request.getParameter("favor") != null && userid == null) {
			response.sendRedirect("/project/login.jsp");
		}
		else {
			RequestDispatcher rd = request.getRequestDispatcher("/details.jsp");
			rd.forward(request, response);
		}
	}

}
