<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String boardno = request.getParameter("boardno");
	try{
		DBManager db = DBManager.getInstance();
		Connection con = db.open();
		
		
		String sql = "delete from unfile where boardno=?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1,boardno);
		int result = stmt.executeUpdate();
		
		sql = "delete from unreply where boardno = ?";
		PreparedStatement stmt2 = con.prepareStatement(sql);
		stmt2.setString(1,boardno);
		result = stmt2.executeUpdate();
		
		sql = "delete from unboard where boardno = ?";
		PreparedStatement stmt3 = con.prepareStatement(sql);
		stmt3.setString(1,boardno);
		result = stmt3.executeUpdate();
		
		
		
		if(result > 0){
			%>
				<script>
				alert("게시글 삭제가 완료되었습니다.");
				location = "list.jsp";
				</script>
			<%
		}
		else{
			%>
			<script>
				alert("게시글 삭제가 실패하셨습니다.");
				location = "view.jsp?boardno=<%=boardno%>";
			</script>
			<%
				
		}
		
	}catch(ClassNotFoundException e){
		e.printStackTrace();
	}


%>    
    