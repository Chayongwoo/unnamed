<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	try{
	DBManager db = DBManager.getInstance();
	Connection con = db.open();
	
	String sql = "select header from unheader";	
	PreparedStatement stmt = con.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
%>	
<form method="post" action="write_proc.jsp" enctype="multipart/form-data">
<select name = "header">
<%
			while(rs.next()){
%>
				<option><%=rs.getString("header")%></option>
<%
			}
%>			</select>


제목 : <input type="text" name="title">
<br>
내용 : <textarea name="content"></textarea>
<br>
첨부파일 : <input type="file" name="my_file">
<br>
<input type="submit" value="Write">
</form>
<%
	}
	 catch (ClassNotFoundException e) {
		e.printStackTrace();
		
	} catch (SQLException e) {
		e.printStackTrace();
	}
%>