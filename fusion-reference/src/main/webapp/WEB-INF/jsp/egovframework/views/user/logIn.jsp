<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<title>로그인</title>
<!-- <style>
	div{
		border : 1px solid pink;
		border-radius: 50px;
		display : flex;
		justify-content : center;
		align-content : center;
		position: relative;
		top: 50%; 
		 left: 50%; 
	  width: 500px; 
	  height: 500px; 		
	}
</style> -->
</head>
<body>
	<div class="d-flex justify-content-center align-items-center w-100">
		<form action="/user/login.do" method="post">
			<label>아이디</label><input type="text" name="user_name" class="form-control" minlength="5" maxlength="10" required>
			<br>
			<label>비밀번호</label><input type="password" name="password" class="form-control" minlength="8" maxlength="12" required>
			<Br>
			<div class="d-flex justify-content-around align-items-center">
			<button type="submit" class="btn btn-primary me-1">로그인</button>
			<button type="button"  class="btn btn-primary me-1" onclick="location.href='/user/applyUser.do'">회원가입</button>
			<button type="button" class="btn btn-primary me-1" onclick="location.href='/user/main.do'">목록으로</button>
			</div>
		</form>
		
	</div>
	
<script>

</script>
</body>
</html>