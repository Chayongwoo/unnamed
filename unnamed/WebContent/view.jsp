<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>


<%
	String boardno = request.getParameter("boardno");
	String pageStr = request.getParameter("page");
	
	int pageNum = 0;
	try {
		pageNum = Integer.parseInt(pageStr);
	} catch (NumberFormatException e) {
		pageNum = 1;
	}
	int startRow = 0;
	int endRow = 0;
	endRow = pageNum * 10;
	startRow = endRow - 9;
	
	int total = 0;

	try {
		DBManager db = DBManager.getInstance();
		Connection con = db.open();

		String sql = "SELECT a.boardno AS boardno, a.title AS title, a.content AS content, a.userid AS userid, b.header AS header, c.filename AS filename FROM unboard a, unheader b, unfile c WHERE a.headerno = b.headerno AND a.boardno = c.boardno AND  a.boardno = ?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, boardno);

		ResultSet rs = stmt.executeQuery();
%>
<table border="1">
	<%
		if (rs.next()) {
			int boardnum = rs.getInt("boardno");
			String title = rs.getString("title");
			String content = rs.getString("content");
			String userid = rs.getString("userid");
			String header = rs.getString("header");
			String filename = rs.getString("filename");
	%>
	<tr>
		<td>글번호</td>
		<td><%=boardno%></td>
		<td>말머리</td>
		<td><%=header%></td>
		<td>작성자</td>
		<td><%=userid%></td>
		<td>파일명</td>
		<td><%=filename%></td>
	</tr>
	<tr>
		<td colspan="2">제목</td>
		<td colspan="6"><%=title%></td>
	</tr>
	<tr>
		<td colspan="8"><%=content%></td>
	</tr>



	<%



				String sql2 = "select count(*) from unreply where boardno = ?";

				PreparedStatement stmt2 = con.prepareStatement(sql2);
				stmt2.setInt(1, boardnum);
				ResultSet rs2 = stmt2.executeQuery();
				if (rs2.next()) {
					total = rs2.getInt("count(*)");
				}

				String sql3 = "select * from unreply where boardno = ? ORDER BY repno desc LIMIT ?,10";

				PreparedStatement stmt3 = con.prepareStatement(sql3);
				stmt3.setInt(1,boardnum);
				stmt3.setInt(2, startRow - 1);
				ResultSet rs3 = stmt3.executeQuery();
		%>
	<%
				while (rs3.next()) {
					String repno = rs3.getString("repno");

					String repcontent = rs3.getString("repcontent");

					String repuserid = rs3.getString("userid");

			%>
	<tr>
		<td><%=repno%></td>
		<td><%=repcontent%></td>
		<td><%=repuserid%></td>
	</tr>
	<tr>
	<%
				}
	
				int startPage = 0;
				startPage = (pageNum - 1) / 10 * 10 + 1;

				int endPage = 0;
				endPage = startPage + 9;

				int totalPage = 0;
				if (total % 10 == 0) {
					totalPage = total / 10;
				} else {
					totalPage = total / 10 + 1;
				}
				if (endPage > totalPage) {
					endPage = totalPage;
				}

				for (int i = startPage; i <= endPage; i++) {
					if (i % 10 == 1 && i > 1) {
		%>
		<td>
	<a href="view.jsp?page=<%=i - 1%>&boardno=<%=boardno%>">Previous</a>
	</td>
	<%
					}
		%>
	<td>
	<a href="view.jsp?page=<%=i%>&boardno=<%=boardno%>"><%=i%></a>
	</td>
	<%
					if (i % 10 == 0) {
		%>
	<td>
	<a href="view.jsp?page=<%=i + 1%>&boardno=<%=boardno%>">Next</a>
	</td>
	<%
					}
				}


		%>
	</tr>
	
		<tr>
		<td colspan="8">
		<form method="post" action="replywrite_proc.jsp">
			<input type="hidden" name="boardno" value="<%=boardno%>">
			<input type="text" name="replycontent">
			<input type="submit" value="댓글작성">
		</form>
		</td>
		</tr>
	<tr>
		<td colspan="8">
			<button onclick="location='update.jsp?boardno=<%=boardno%>'">수정</button>
			<button onclick="del()">삭제</button>

		</td>
	</tr>
	<%
		}
	} catch(ClassNotFoundException e) {
		e.printStackTrace();
	} catch(SQLException e) {
		e.printStackTrace();
	}
	%>
</table>


<script type="text/javascript">
   	function del () {
   		var isOk = confirm("게시물을 삭제 하시겠습니까?"); // 네 아니오 로 물어보고 isOk는 네를 누르면 true 아니오 를 누르면 false
   		if(isOk){
   			location = 'delete_proc.jsp?boardno=<%=boardno%>';
		}
	}
</script>
