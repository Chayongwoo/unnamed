<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>
<html>
<title>unnamed</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
   <%
   	String sessionId = (String)session.getAttribute("userid");
   %>
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", sans-serif}
</style>

<body class="w3-light-grey w3-content" style="max-width:1600px">

<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white w3-animate-left" style="z-index:3;width:300px;" id="mySidebar"><br>
  
  
  <div class="w3-container">
    <a href="#" onclick="w3_close()" class="w3-hide-large w3-right w3-jumbo w3-padding w3-hover-grey" title="close menu">
      <i class="fa fa-remove"></i>
    </a>
    
  </div>
  <div class="w3-bar-block">
    <br>
    <br>
    <a href="#portfolio" onclick="w3_close()" class="w3-bar-item w3-button w3-padding w3-text-teal"><i class="fa fa-th-large fa-fw w3-margin-right"></i>BOARD</a> 
    <a href="#about" onclick="w3_close()" class="w3-bar-item w3-button w3-padding"><i class="fa fa-user fa-fw w3-margin-right"></i>MESSAGE</a> 
  </div>
  <div class="w3-panel w3-large">
    <i class="fa fa-facebook-official w3-hover-opacity"></i>
    <i class="fa fa-instagram w3-hover-opacity"></i>
    <i class="fa fa-snapchat w3-hover-opacity"></i>
    <i class="fa fa-pinterest-p w3-hover-opacity"></i>
    <i class="fa fa-twitter w3-hover-opacity"></i>
    <i class="fa fa-linkedin w3-hover-opacity"></i>
  </div>
</nav>

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px">

  <!-- Header -->
  <header id="portfolio">
    <a href="#"><img src="/w3images/avatar_g2.jpg" style="width:65px;" class="w3-circle w3-right w3-margin w3-hide-large w3-hover-opacity"></a>
    <span class="w3-button w3-hide-large w3-xxlarge w3-hover-text-grey" onclick="w3_open()"><i class="fa fa-bars"></i></span>
    <div class="w3-container">
    <br>
    <h1><b>UNNAMED</b></h1>
    <div class="w3-section w3-bottombar w3-padding-16">
    	
      <button class="w3-button w3-white"><i class="fa fa-diamond w3-margin-right"></i>log-in</button>
      <button class="w3-button w3-white w3-hide-small"><i class="fa fa-photo w3-margin-right"></i>Photos</button>
      <button class="w3-button w3-white w3-hide-small"><i class="fa fa-map-pin w3-margin-right"></i>Art</button>
    </div>
    </div>
  </header>
  
  <!-- First Photo Grid-->

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
    	String sql = "SELECT a.boardno AS boardno, a.title AS title, a.content AS content, a.userid AS userid, b.header AS header FROM unboard a, unheader b WHERE a.headerno = b.headerno ORDER BY a.boardno desc LIMIT ?,3";
    	
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
    	
    	<div class="card" style="width:100%">
    	  <div class="card-body">
    	    <h4 class="card-title"><%=title%></h4>
    	    <p class="card-text"><%=content%></p>
    	    <a href="view.jsp?boardno=<%=boardno%>" class="btn btn-primary"><%=boardno%></a>
    	  </div>
    	</div>
    	<%
    	}
	%>    	
  <!-- Pagination --> 
  <div class="w3-center w3-padding-32">
    <div class="w3-bar">
    	<%
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

      <a href="#" class="w3-bar-item w3-button w3-hover-black">«</a>
      <a href="#" class="w3-bar-item w3-black w3-button">1</a>
      <a href="#" class="w3-bar-item w3-button w3-hover-black">2</a>
      <a href="#" class="w3-bar-item w3-button w3-hover-black">3</a>
      <a href="#" class="w3-bar-item w3-button w3-hover-black">4</a>
      <a href="#" class="w3-bar-item w3-button w3-hover-black">»</a>
    </div>
  </div>
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
</div>
<script>
function w3_open() {
    document.getElementById("mySidebar").style.display = "block";
    document.getElementById("myOverlay").style.display = "block";
}
 
function w3_close() {
    document.getElementById("mySidebar").style.display = "none";
    document.getElementById("myOverlay").style.display = "none";
}
</script>

</body>
</html>