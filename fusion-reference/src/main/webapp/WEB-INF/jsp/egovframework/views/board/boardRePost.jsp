<%
/*********************************************************
 * 업 무 명 : 게시판 컨트롤러
 * 설 명 : 게시판을 조회하는 화면에서 사용 
 * 작 성 자 : 김민규
 * 작 성 일 : 2022.10.06
 * 관련테이블 : 
 * Copyright ⓒ fusionsoft.co.kr
 *
 *********************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
</head>
<body>
	<main class="mt-5 pt-5">
	<div class="container-fluid px-4">
		<h1 class="mt-4">답글 작성</h1>
		<div class="card mb-4">
			<div class="card-body">
				<form method="post" action="/board/insBrdRePost.do" id="myfrm">
					<div class="mb-3">
						<input type="hidden" name="parent_id" value=${boardPost.board_id} id="parent">
						<input type="hidden" name="menu_id" value=${boardPost.menu_id}>
						<label for="title" class="form-label">제목</label>
						<input type="text" class="form-control" id="title" name="title" value="" minlength="1" maxlength="30" required >
					</div>
					<div class="mb-3">
						<label for="content" class="form-label">내용</label>
						<textarea class="form-control" id="content" name="content" minlength="1" maxlength="500" required></textarea>
					</div>

					<button class="btn btn-outline-warning">등록하기</button>
				</form>
			</div>
		</div>
	</div>
	</main>
</body>
<script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function() {
		let parent = $("#parent").val();
		console.log(parent);
	});
	
	document.getElementById('myfrm').addEventListener('submit', function(event) {
	  event.preventDefault(); 
	  
		var param = document.getElementById('myfrm');
		var formData = new FormData(param);
	
		console.log(formData)
	
		$.ajax({
			url: '/board/insBrdRePost.do',
			type: 'POST',
			data: formData,				
			processData : false, 
			contentType : false,			
			success: function (result) {
				opener.call();
				alert("답글 등록 완료");
				window.close();
				location.href="/board/boardList.do";
			},
			error: function (error) {
				console.log(error);
				alert('실패');
			}
		}) 

	});
	
</script>
</html>