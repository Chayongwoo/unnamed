<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    <%
    	int boardnum = Integer.parseInt(request.getParameter("boardno"));
    
    try{
		DBManager db = DBManager.getInstance();
		Connection con = db.open();
		
		String sql2 = "SELECT header from unheader";
		PreparedStatement stmt2 = con.prepareStatement(sql2);
		ResultSet rs2 = stmt2.executeQuery();
		
		
		String sql = "SELECT a.boardno AS boardno, a.title AS title, a.content AS content, a.userid AS userid, b.header AS header, c.filename AS filename FROM unboard a, unheader b, unfile c WHERE a.headerno = b.headerno AND a.boardno = c.boardno AND  a.boardno = ?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1,boardnum);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()){
			int boardno = rs.getInt("boardno");
			String title = rs.getString("title");
			String content = rs.getString("content");
			String userid = rs.getString("userid");
			String header = rs.getString("header");
			String filename = rs.getString("filename");
		%>
    		<form method="post" action="update_proc.jsp" enctype="multipart/form-data">
    			<select name="header">
    			<% 
    				while(rs2.next()){
    			%>
    				<option><%=rs2.getString("header")%></option>
    			<%
    				}
    			
    			%>	
    			</select>
    			<input type="text" value= "<%=title%>" name="title"> <br>
    				<textarea name="content">
    				<%=content%>
    				</textarea>
    				<br>
    			<input type="hidden" name="boardno" value="<%=boardno%>">
    			<input type="hidden" name="my_file" value="<%=filename%>">
				<input type="file" name="my_file2"><br>
				<input type="submit" value="수정">
			</form>	
    		<%
		}		
	} catch (ClassNotFoundException e){
		e.printStackTrace();
	} catch(SQLException e){
		e.printStackTrace();
	}
    
    %>