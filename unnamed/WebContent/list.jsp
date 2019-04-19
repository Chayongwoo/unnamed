<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1">

<%

	String pageStr = request.getParameter("page");
	
	int pageNum = 0;
	try{
	pageNum = Integer.parseInt(pageStr);
	}catch(NumberFormatException e){
		pageNum = 1;
	}
	int startRow = 0;
	int endRow = 0;
	endRow = pageNum * 10;
	startRow = endRow - 9;
	
	int total = 0;
	
	try{
    	String userId = request.getParameter("id");
    	String userPw = request.getParameter("pw");
    	DBManager db = DBManager.getInstance();
    	Connection con = db.open();
    	String sql2 = "select count(*) from unboard";

    	PreparedStatement stmt2 = con.prepareStatement(sql2);
    	ResultSet rs2 = stmt2.executeQuery();
    	
    	
    	if(rs2.next()){
    		total = rs2.getInt("count(*)");
    	}
    	String sql = "SELECT a.boardno AS boardno, a.title AS title, a.content AS content, a.userid AS userid, b.header AS header FROM unboard a, unheader b WHERE a.headerno = b.headerno ORDER BY a.boardno desc LIMIT ?,10";
    	
    	PreparedStatement stmt = con.prepareStatement(sql);
    	stmt.setInt(1,startRow-1);
    	ResultSet rs = stmt.executeQuery();
			
    	
    	
    	while(rs.next()){
    		String boardno = rs.getString("boardno");

    		String title = rs.getString("title");

    		String content = rs.getString("content");
    		
    		String header = rs.getString("header");
    		
    		//절대경로 http://localhost/JspBoard/view.jsp?id=1
    		//상대경로 view.jsp?id=1
			
/*     		out.println("<a href='view.jsp?id="+id+"'>" + id + "/" + title + "/" + id2 + "</a><br>"); */
    	%>
    	
    	<div class="card" style="width:400px">
    	  <div class="card-body">
    	    <h4 class="card-title"><%=title%></h4>
    	    <p class="card-text"><%=content%></p>
    	    <a href="view.jsp?boardno=<%=boardno%>" class="btn btn-primary"><%=boardno%></a>
    	  </div>
    	</div>
    	
    	<%
    	}
    	
    	int startPage = 0;
    	startPage = (pageNum-1) /10 * 10 +1;
    	
    	int endPage = 0;
    	endPage = startPage + 9;
    	
    	int totalPage = 0;
    	if(total%10 ==0){
    		totalPage = total/10;
    	} else{
    		totalPage = total /10 +1;
    	}
    	if(endPage > totalPage) endPage = totalPage;
    	
    	
    	out.println("<div class='container'>");
    	out.println("<ul class='pagination'>");
    		
    	
    	for(int i=startPage; i<=endPage; i++){
    		
    			      if (i % 10 == 1 && i > 1) {
    		  %>
    	<a class="page-link" href="list.jsp?page=<%=i - 1%>">Previous</a>
    		<%
    			}
    		%>
    		
    		 <a class="page-link" href="list.jsp?page=<%=i%>"><%=i%></a>
    		 
    		 <%
    			      if (i % 10 == 0) {
    			   %>
    			   <li class="page-item">
    			   <a class="page-link" href="list.jsp?page=<%=i + 1%>">Next</a>
    			   </li>
    			   <%
    			      } 
    	}
    	 out.println("</ul>");
    	out.println("</div>");
    	} catch(ClassNotFoundException e){
    		e.printStackTrace();
    	} catch(SQLException e){
    		e.printStackTrace();
    	}
%>