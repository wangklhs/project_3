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
 * Servlet implementation class favor
 */
@WebServlet("/favor")
public class favor extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getSession().getAttribute("userid") != null) {
			JdbcTools jdbcTools = new JdbcTools();
			
			String userid = null;
			if (request.getParameter("friendid") == null) {
				userid = (String)request.getSession().getAttribute("userid");
			}
			else {
				userid = request.getParameter("friendid");
			}
			
			String sql = null;
			
			if (request.getParameter("del") != null) {
				sql ="DELETE FROM travelimagefavor WHERE UID = ? AND ImageID = ?";
				jdbcTools.update(sql, userid, request.getParameter("del"));
			}
			
			sql = "SELECT ImageID FROM travelimagefavor WHERE UID = ?";		
			
			ArrayList<String[]> ids = jdbcTools.query(sql, userid);
			ArrayList<String[]> result = new ArrayList<String[]>();
			
			for (int i = 0; i < ids.size(); i ++) {
				sql = "SELECT ImageID, Title, Description, PATH FROM travelimage WHERE ImageID = ?";
				ArrayList<String[]> row = jdbcTools.query(sql, ids.get(i)[0]);
				result.add(row.get(0));
			}
			
			if(request.getParameter("friendid") == null) {
				sql = "SELECT id, imageid, imagetitle FROM travelfootprint WHERE userid = ? ORDER BY id DESC";
				ArrayList<String[]> footprint = jdbcTools.query(sql, userid);
				if (footprint.size() > 10) {
					footprint = (ArrayList<String[]>) footprint.subList(0, 11);
				}
				request.setAttribute("footprint", footprint);
			}
			else {
				sql = "SELECT UserName FROM traveluser WHERE UID = ?";
				ArrayList<String[]> row = jdbcTools.query(sql, userid);
				request.setAttribute("friendname", row.get(0)[0]);
			}

			jdbcTools.relese();
			
			request.setAttribute("imgs", result);
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("/favor.jsp");
		rd.forward(request, response);
		
	}

}
