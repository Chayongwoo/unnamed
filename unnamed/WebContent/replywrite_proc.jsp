<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    	String sessionId = (String)session.getAttribute("userid");
    	String replycontent = request.getParameter("replycontent");	
    	int boardno = Integer.parseInt(request.getParameter("boardno"));
    	request.setCharacterEncoding("utf-8"); 
	
    	try{
			DBManager db = DBManager.getInstance();
			Connection con = db.open();
	
			String sql = "insert into unreply values (null,?,?,?)";
	PreparedStatement stmt = con.prepareStatement(sql);
	stmt.setString(1,replycontent);
	stmt.setString(2,sessionId);
	stmt.setInt(3,boardno);
	int result = stmt.executeUpdate();
	
	if(result > 0){
		%>
			<script type="text/javascript">
				alert("댓글 작성에 성공하셨습니다.");
				location = "view.jsp?boardno=<%=boardno%>";
			</script>
		<% 
		
	}
	else
		out.println("댓글 작성에 실패하셨습니다.");
	
	}catch(ClassNotFoundException e){
		e.printStackTrace();
	}catch(SQLException e){
		e.printStackTrace();
	}
    %>