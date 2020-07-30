package project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.mysql.cj.jdbc.result.ResultSetMetaData;

public class JdbcTools {
	
	private Connection connection;
	private String url;
	private String user;
	private String password;
	
	public JdbcTools() {
		url = "jdbc:mysql://localhost:3306/travels?serverTimezone=UTC";
		user = "root";
		password = "klhs";
		String className = "com.mysql.cj.jdbc.Driver";
		
		try {
			Class.forName(className);
			connection  = DriverManager.getConnection(url,user,password);
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
	
	public void update(String sql) {
		try {
			Statement statement = connection.createStatement();
			statement.executeUpdate(sql);
			relese(statement);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void update(String sql, Object...args) {
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			for(int i = 0; i < args.length; i ++) {
				statement.setObject(i + 1, args[i]);
			}
			statement.executeUpdate();
			relese(statement);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public ArrayList<String[]> query(String sql) {
		ArrayList<String[]> result = new ArrayList<String[]>();
		try {
			Statement statement = connection.createStatement();
			ResultSet resultSet = statement.executeQuery(sql);
			ResultSetMetaData rsmd = (ResultSetMetaData) resultSet.getMetaData();
			int columnNumber = rsmd.getColumnCount();
			while(resultSet.next()) {
				String[] row = new String[columnNumber];
				for(int i = 0; i < columnNumber; i ++) {
					row[i] = resultSet.getString(i + 1);
				}
				result.add(row);
			}
			relese(statement);
			relese(resultSet);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}
	
	public ArrayList<String[]> query(String sql, Object...args) {
		ArrayList<String[]> result = new ArrayList<String[]>();
		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			for(int i = 0; i < args.length; i ++) {
				statement.setObject(i + 1, args[i]);
			}
			ResultSet resultSet = statement.executeQuery();
			ResultSetMetaData rsmd = (ResultSetMetaData) resultSet.getMetaData();
			int columnNumber = rsmd.getColumnCount();
			while(resultSet.next()) {
				String[] row = new String[columnNumber];
				for(int i = 0; i < columnNumber; i ++) {
					row[i] = resultSet.getString(i + 1);
				}
				result.add(row);
			}
			relese(statement);
			relese(resultSet);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}
	
	public void relese() {
		if (connection != null) {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void relese(Statement statement) {
		if (statement != null) {
			try {
				statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void relese(ResultSet result) {
		if (result != null) {
			try {
				result.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
}
