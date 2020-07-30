package project;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class register
 */
@WebServlet("/register")
public class register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String repass = request.getParameter("repass");
		
		if (username.length() > 15 || username.length() < 4) {
			request.setAttribute("err1", 1);
			RequestDispatcher rd = request.getRequestDispatcher("/register.jsp");
			rd.forward(request, response);
		}
		else {
			if (password.length() > 12 || password.length() < 6){
				request.setAttribute("err2", 1);
				RequestDispatcher rd = request.getRequestDispatcher("/register.jsp");
				rd.forward(request, response);
			}
			else {
				if (!repass.equals(password)) {
					request.setAttribute("err3", 1);
					RequestDispatcher rd = request.getRequestDispatcher("/register.jsp");
					rd.forward(request, response);
				}
				else {
					JdbcTools jdbcTools = new JdbcTools();
					
					String sql = "SELECT UID FROM traveluser WHERE UserName = ?";
					if (jdbcTools.query(sql, username).isEmpty()) {
						Date date = new Date(new java.util.Date().getTime());
						sql = "INSERT INTO traveluser (Email, UserName, Pass, DateJoined) VALUES (?, ?, ?, ?)";
						jdbcTools.update(sql, email, username, password, date);
						
						jdbcTools.relese();
						
						RequestDispatcher rd = request.getRequestDispatcher("/login");
						rd.forward(request, response);
					}
					else {
						request.setAttribute("err1", 2);
						
						jdbcTools.relese();
						
						RequestDispatcher rd = request.getRequestDispatcher("/register.jsp");
						rd.forward(request, response);
					}
				}
			}
		}
	}

}
