<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%
	MultipartRequest mReq = new MultipartRequest(request, "c:/dev", 1024 * 1024 * 5, "utf-8",
			new DefaultFileRenamePolicy());
	String userid = (String)session.getAttribute("userid");
	int boardnum = Integer.parseInt(mReq.getParameter("boardno"));
	request.setCharacterEncoding("utf-8");
	
	String header = mReq.getParameter("header");
	int headerno = 0;
	if (header.equals("고민"))
		headerno = 1;

	if (header.equals("잡담"))
		headerno = 2;

	if (header.equals("공감"))
		headerno = 3;

	String title = mReq.getParameter("title");
	String content = mReq.getParameter("content");
	String file1 = mReq.getParameter("my_file");
	String file2 = mReq.getParameter("my_file2");
	

	String originalFileName = mReq.getOriginalFileName("my_file2");

	File saveFile = mReq.getFile("my_file2");
	
	String saveFileName = "";
	if(saveFile != null) {
		saveFileName = saveFile.getName();
	}	
	
	try {
		DBManager db = DBManager.getInstance();
		Connection con = db.open();

		String sql = "update unboard set title=?, content=?,headerno=? where boardno = ?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, title);
		stmt.setString(2, content);
		stmt.setInt(3,headerno);
		stmt.setInt(4, boardnum);
		int result = stmt.executeUpdate(); // 성공 : 1이상인 정수가 나옴, 실패하면 0
		
		if(result > 0){
		%>
			<script type="text/javascript">
			alert("수정성공");
			location="view.jsp?boardno=<%=boardnum%>";		
			</script>
		<%
		}
		
		
		if(saveFile != null){
		String sql2 = "update unfile set filename=? where boardno=?";
		PreparedStatement stmt2 = con.prepareStatement(sql2);
		stmt2.setString(1,saveFileName);
		stmt2.setInt(2, boardnum);
		int result2 = stmt2.executeUpdate();
		
			if(result > 0 && result2 > 0){
				%>
					<script type="text/javascript">
					alert("수정 성공");
					location="view.jsp?boardno=<%=boardnum%>";
					</script>		
				<%
			}
			else{
				%>
				<script type="text/javascript">
				alert("수정실패");
				history.back();		
				</script>
			<%
			}
			
			
		}
	}
		catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	}
%>