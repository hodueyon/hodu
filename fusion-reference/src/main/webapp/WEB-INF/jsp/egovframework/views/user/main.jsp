<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

<title>메인페이지</title>
</head>
<body>
		<h1 style="text-align : center; margin-top : 100px; margin-bottom : 50px">메인페이지</h1>
		<%-- <div>
			<h1 style="text-align : center; margin-top : 100px; margin-bottom : 50px">메인 페이지</h1>
			<div class="d-flex justify-content-center">
				<button type="button" class="btn btn btn-info me-1"  onclick="location.href='/board/boardList.do?nowPage=1&cntPerPage=10'">게시판</button>
				<button type="button" class="btn btn-success me-1" onclick="location.href='/galary/galaryList.do?nowPage=1&cntPerPage=9'">갤러리</button>
				<button type="button" class="btn btn-success me-1" onclick="location.href='/survey/sureveyInfo.do'">설문조사</button>
				<c:if test="${empty loginId}">
					<button type="button" class="btn btn-primary me-1" onclick="location.href='/user/loginfrm.do'" class="btnss">로그인</button>
				</c:if>
				<c:if test="${not empty loginId}">
					<button type="button" class="btn btn-primary me-1" onclick="location.href='/user/logout.do'" class="btnss">로그아웃</button>
				</c:if>
				<c:if test="${empty loginId}">
				<button type="button"  class="btn btn-primary me-1" onclick="location.href='/user/applyUser.do'">회원가입</button>
				</c:if>
			</div>
		</div>		 --%>
</body>
<script>
	
</script>
</html>