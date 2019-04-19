<%@page import="java.util.ArrayList"%>
<%@page import="db.DBManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
   function check() {
      var id = $("input[name='userid']").val();
      var pw = $("input[name='userpw']").val();
      if (id == "" || pw == "") {
         alert("아이디와 비밀번호를 확인하세요.");
         return false;
      } else {
         return true;
      }
   }
</script>
<form name="login" method="post" action="login_proc.jsp" onsubmit="return check()">
   <input type="text" name="userid" placeholder="userid"> <input type="password" name="userpw"placeholder="userpw">
   <input type="submit" value="Login">
   <button type="button" onclick="location = 'inputid.jsp'">비밀번호 찾기</button>
</form>