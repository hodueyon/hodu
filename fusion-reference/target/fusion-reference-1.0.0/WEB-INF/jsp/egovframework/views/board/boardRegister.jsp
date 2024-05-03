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
<title>퓨전 게시판(작성)</title>
</head>
<body>
	<main class="mt-5 pt-5">
	<div class="container-fluid px-4">
		<h1 class="mt-4">게시글 작성</h1>
		<div class="card mb-4">
			<div class="card-body">
				<form onsubmit="return checkRadioBtns();" method="post" action="/board/insBoardPost.do" id="registerFrm">
					<div class="mb-3">
						<label for="category" class="form-label">분류</label>
						<input type="radio" class="flexRadioDefault" id="category" name="category" value=1>공지
						<input type="radio" class="flexRadioDefault" id="category" name="category" value=2>일반글
					</div>
					<div class="mb-3">
						<label for="title" class="form-label">제목</label>
						<input type="text" class="form-control" id="title" name="title" value="" minlength="1" maxlength="30" required>
					</div>
					<div class="mb-3">
						<label for="content" class="form-label">내용</label>
						<textarea class="form-control" id="content" name="content" value="" minlength="1" maxlength="500" required></textarea>
					</div>
					<!-- <div class="mb-3">
						<label for="writer" class="form-label">작성자</label>
						<input type="text" class="form-control" id="writer" name="writer" value="" disabled>
					</div> -->
					<button class="btn btn-outline-warning" type="button" id="submitbtn">등록하기</button>
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
		
	});
	
	/* function goList(){
		opener.document.location.href="/board/boardList.do?nowPage=1&cntPerPage=10";
		window.close();
	}
	 */
	
	function checkRadioBtns() {
	    var category = document.getElementsByName('category');
	    var checked = false;
	    for (var i = 0; i < category.length; i++) {
	        if (category[i].checked) {
	            checked = true;
	            break;
	        }
	    }
	    if (!checked) {
	        alert('카테고리을 선택해주세요.');
	        return false;
	    }
	    
	    if($("#title").val().trim() == ''){
	    	 alert('제목 입력 해주세요!');
	    	 return false;
	    }
	    
	    if($("#content").val().trim() == ''){
	    	alert("내용을 입력 해주세요!");
	    	return false;
	    }
	    return true;
	}
	
 	$("#submitbtn").click(function(){
 		$("#registerFrm").submit();

 	})
	
</script>
</html>