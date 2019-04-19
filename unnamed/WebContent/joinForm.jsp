<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">

var isPass = false;
function idCheck(){
	
	$.ajax({
		url : 'idCheck.jsp',
		type : 'get',
		data : {"userid" : $('input[name=id]').val()},
		success : function(result){
			result = result.trim();
			if(result == '사용 가능') {
				isPass = true;
			} else {
				isPass = false;
			}
			alert(result);
			
		},
		fail: function(error) {
		   alert("오류 발생"); 
		  }
	});
}

function check(){
	
	var userid = $("input[name='userid']").val();
	
	var userpw = $("input[name='userpw']").val();
	var userpw2 = $("input[name='userpw2']").val();
	
	var nickname = $("input[name='nickname']").val();
	
	var question = $("input[name='question']").val();
	
	var answer = $("input[name='answer']").val();
	
	if(userid==""){
		alert("아이디를 입력해주세요.");	
		return false;
	}
	if(userpw==""){
		alert("비밀번호를 입력해주세요.");	
		return false;
	}
	
	if(userpw2==""){
		alert("비밀번호확인을 입력해주세요.");	
		return false;
	}
	
	if(nickname==""){
		alert("닉네임 입력해주세요.");	
		return false;
	}
	
	if(nickname.length > 5){
		alert("닉네임은 최대 5자리 입니다.");
		return false;
	}
	
	if(question==""){
		alert("질문을 입력해주세요.");
		return false;
	}
	
	if(answer==""){
		alert("대답을 입력해주세요.");	
		return false;
	}
	
	if(userpw != userpw2){
		alert("입력하신 비밀번호확인이 일치하지 않습니다.");
		return false;
	}
	
	if(!isPass) {
		alert('중복검사 필수!');
		return false;
	}
}

</script>

    <form method="post" action="join_proc.jsp" onsubmit="return check()">
    	
    	<input type="text" name="userid">
    	<input type="button" onclick="idCheck()" value="아이디중복검사"> <br>
   
              비밀번호 : <input type="password" name="userpw"> <br>
	비밀번호 확인 : <input type="password" name="userpw2"> <br>
    	  닉네임 : <input type="text" name="nickname"> <br>
    	 
    	 <label>작성하실 질문과 대답은 비밀번호 찾기에 중요합니다. 신중히 작성해주십시오.</label><br>
    	 
    	 질문 : <input type="text" name="question"><br>
    	 
    	 대답 : <input type="text" name="answer"><br>
    	 
    <input type="submit" value="Join">	
    </form>
    