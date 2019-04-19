<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 
 
 <%
 	String userid = request.getParameter("userid");
 	String userpw = request.getParameter("userpw");
 	String nickname = request.getParameter("nickname");
 	String question = request.getParameter("question");
 	String answer = request.getParameter("answer");
 	
 	 try{
     	
     	DBManager db = DBManager.getInstance();
     	Connection con = db.open();
     
     	String sql = "insert into unmember values (?,?,?,?,?)";
     	PreparedStatement stmt = con.prepareStatement(sql);
     	stmt.setString(1,userid);
     	stmt.setString(2,userpw);
     	stmt.setString(3,nickname);
     	stmt.setString(4,question);
     	stmt.setString(5,answer);
     	
     	int result = stmt.executeUpdate();
     	
     	if(result > 0)
     		
     		out.println("회원가입이 성공적으로 처리되셨습니다.");
     	
     	else
     		out.println("회원가입을 실패하셨습니다.");
     	
     } catch(ClassNotFoundException e){
     	e.printStackTrace();
     } catch(SQLException e){
     	e.printStackTrace();
     }
     
 	
 
 %>