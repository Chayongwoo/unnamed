<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>


<%
	MultipartRequest mReq = new MultipartRequest(request, "c:/dev", 1024 * 1024 * 5, "utf-8",
			new DefaultFileRenamePolicy());

	String sessionId = (String) session.getAttribute("userId");

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

	String originalFileName = mReq.getOriginalFileName("my_file");

	File saveFile = mReq.getFile("my_file");

	String saveFileName = saveFile.getName();

	if (sessionId == null) {
%>
		<script type="text/javascript">
			alert("로그인을 하셔야 글을 작성하실 수 있습니다.");
			history.back();
 		</script>
<%
	}

	try {
		DBManager db = DBManager.getInstance();
		Connection con = db.open();


		String sql1 = "insert into unboard values (null,?,?,?,?)";

		PreparedStatement stmt1 = con.prepareStatement(sql1);
		stmt1.setString(1, title);
		stmt1.setString(2, content);
		stmt1.setString(3, sessionId);
		stmt1.setInt(4, headerno);

		int result1 = stmt1.executeUpdate();

		if (result1 <= 0)
			out.println("게시물작성 실패");

		String sql2 = "select max(boardno) as boardno from unboard";
		PreparedStatement stmt2 = con.prepareStatement(sql2);

		ResultSet rs = stmt2.executeQuery();
		int boardno2 = 0;
		if (rs.next()) {
			boardno2 = rs.getInt("boardno");
		
		}
		
		String sql3 = "insert into unfile values (null,?,?)";
		PreparedStatement stmt3 = con.prepareStatement(sql3);
		stmt3.setString(1, saveFileName);
		stmt3.setInt(2, boardno2);

		int result2 = stmt3.executeUpdate();
		
		if(result2 > 0){
			out.println("ㅎㅇㅎㅇ");
			%>
				<script type="text/javascript">
					alert("게시물 작성에 성공하셨습니다.");
					location = 'list.jsp';
				</script>
			<%
		}
		else {
			%>
			<script type="text/javascript">
				alert("게시물 작성에 실패하셨습니다.");
				history.back();
			</script>
		<%
		}
		
	
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	}
%>