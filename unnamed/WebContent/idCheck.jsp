<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	String id = request.getParameter("userid");

	try {
				DBManager db = DBManager.getInstance();
				Connection con = db.open();

				String sql = "select userid from unmember where userid = ?";

				PreparedStatement stmt = con.prepareStatement(sql);
				stmt.setString(1, id);
				ResultSet rs = stmt.executeQuery();
				if(rs.next()){
					out.println("아이디 중복");
				}
				
				else {
					out.println("사용 가능");
				}
				
				
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
	%>