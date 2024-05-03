<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<script>
		var msg = "${msg}"; // JSP에서 map에 있는 "msg" 키의 값 가져오기
		console.log(msg);
	   
	        alert("로그인에 실패했습니다! 다시 시도해 주세요");
	        location.href = "/user/loginfrm.do";
	

	</script>
</body>
</html>