<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="db.DBManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int usernum = Integer.parseInt(request.getParameter("usernum"));
	String userpw = request.getParameter("userpw");
	
	try{
		DBManager db = DBManager.getInstance();
		Connection con = db.open();	
		
		String sql = "select usernum, userpw from offmember where usernum=? and userpw = ?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1,usernum);
		stmt.setString(2,userpw);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()){
			int dbUsernum = rs.getInt("usernum");
			String dbUserpw = rs.getString("userpw");
			if(usernum==dbUsernum && userpw.equals(dbUserpw)){
				session.setAttribute("usernum", usernum);
				%>
				<script type="text/javascript">
					alert("로그인을 성공하셨습니다.");
				</script>
				<%
				response.sendRedirect("main.jsp");
			}
			else {
				//JOptionPane.showMessageDialog(null, "로그인을 실패하셨습니다. 사원번호와 비밀번호를 확인해주세요.");
				%>
				<script type="text/javascript">
					alert("로그인을 실패하셨습니다. 사원번호와 비밀번호를 확인해주세요.");
				</script>
				<%
				response.sendRedirect("login_Form.jsp");
			}
		} else {
			out.println("조회실패");
		}
	}catch(ClassNotFoundException e){
		e.printStackTrace();
	}catch(SQLException e){
		e.printStackTrace();
	}
	
%>