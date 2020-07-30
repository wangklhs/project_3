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
 * Servlet implementation class friends
 */
@WebServlet("/friends")
public class friends extends HttpServlet {
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
				sql ="DELETE FROM travelfriend WHERE userId = ? AND friendId = ?";
				jdbcTools.update(sql, userid, request.getParameter("del"));
			}
			
			sql = "SELECT friendId FROM travelfriend WHERE userId = ?";
			
			ArrayList<String[]> friendid = jdbcTools.query(sql,userid);
			ArrayList<String[]> result = new ArrayList<String[]>();
			
			for(int i = 0; i < friendid.size(); i ++) {
				sql = "SELECT UID, Email, UserName, DateJoined, Authority FROM traveluser WHERE UID = ?";
				ArrayList<String[]> row = jdbcTools.query(sql, friendid.get(i)[0]);
				result.add(row.get(0));
			}
			
			if (request.getParameter("start") != null) {
				sql = "UPDATE traveluser SET Authority = ? WHERE UID = ?";
				jdbcTools.update(sql, "b", userid);
			}
			
			if (request.getParameter("close") != null) {
				sql = "UPDATE traveluser SET Authority = ? WHERE UID = ?";
				jdbcTools.update(sql, "a", userid);
			}
			
			sql = "SELECT Authority FROM traveluser WHERE UID = ?";
			if (jdbcTools.query(sql, userid).get(0)[0].indexOf("a") >= 0) {
				request.setAttribute("started", 2);
			}
			else {
				request.setAttribute("started", 1);
			}
			
			System.out.print(jdbcTools.query(sql, userid).get(0)[0] + request.getAttribute("started"));
			
			jdbcTools.relese();
			
			request.setAttribute("friends", result);
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("/friends.jsp");
		rd.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getSession().getAttribute("userid") != null) {
			JdbcTools jdbcTools = new JdbcTools();
			
			String key = request.getParameter("user");
			String sql = "SELECT UID FROM traveluser WHERE UID = ? OR UserName = ?";
			ArrayList<String[]> row = jdbcTools.query(sql, key, key);
			
			if (row.isEmpty()) {
				request.setAttribute("err", 1);
			}
			else {
				String userid = (String)request.getSession().getAttribute("userid");
				sql = "SELECT * FROM travelfriend WHERE userId = ? AND friendId = ?";
				if (jdbcTools.query(sql, userid, row.get(0)[0]).isEmpty()) {
					sql = "INSERT INTO travelfriend (userId, friendId) VALUES (?, ?)";
					jdbcTools.update(sql, userid, row.get(0)[0]);
				}
				else {
					request.setAttribute("err", 2);
				}
			}
			
			jdbcTools.relese();	
		}
		
		doGet(request, response);
	}
}
