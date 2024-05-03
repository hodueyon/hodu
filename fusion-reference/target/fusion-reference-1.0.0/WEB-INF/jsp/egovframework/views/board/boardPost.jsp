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
<style>

</style>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<title>퓨전 게시판(상세보기)</title>
<style>
	#inputReply{
		display : flex;
		justify-content: space-between;
		align-content: center;
	}
	#inputReply>button{
		width : 20%;
	}
	.ReReplyFrm{
		display:none;
	}
	.updateFrm{
		display : none;
	}
</style>
</head>
<body>
	<main class="mt-5 pt-5">
	<div class="container-fluid px-4">
		<h1 class="mt-4">게시글 조회</h1>
		<div class="card mb-4">
			<div class="card-body">
				<div class="mb-3">
					<label for="title" class="form-label">제목</label>
					<input type="text" class="form-control" id="title" name="title" value="${boardPost.title}" readOnly>
				</div>
				<div class="mb-3">
					<label for="content" class="form-label">내용</label>
					<textarea class="form-control" id="content" name="content" rows="8" readOnly>${boardPost.content}</textarea>
				</div>
				<div class="mb-3">
					<label for="writer" class="form-label">작성자</label>
					<input type="text" class="form-control" id="writer" name="writer" value="${boardPost.writer}" disabled>
				</div>
				<button type="button" class="btn btn-outline-secondary" onclick="goList()">목록</button>
				<c:if test="${boardPost.writer eq loginId}">
					<button class="btn btn-outline-warning" onclick="location.href='/board/boardPostModify.do?board_id=${boardPost.board_id}'">수정하기</button>
					<button class="btn btn-outline-danger" onclick="delPost()">삭제하기</button>
				</c:if>
				<c:if test="${not empty loginId}">
					<button class="btn btn-outline-info" onclick="location.href='/board/insertRePost.do?board_id=${boardPost.board_id}'">답글달기</button>
				</c:if>
			</div>
		</div>
	</div>
	<div id="inputReply"  class="container-fluid px-4">
		<c:if test="${empty loginId}">
			<input type = "text" class="form-control" placeholder ="로그인 후 댓글 작성이 가능합니다." readonly>
		</c:if>
		<c:if test="${not empty loginId}">
			<input type = "text" id="inputReplyFrm" class="form-control"  maxlength="30" required><button class="btn btn-primary" id="insReply">댓글달기</button>
		</c:if>   	
	</div>
	<table class="table table-hover" style="margin: 5px;">
	         <tbody class="replies">
	         	<c:forEach items="${replies}" var="reply">
							<tr>
								<td id="contentTd" style="padding-left: ${20 * (reply.level-1)}px;">
									<c:if test="${reply.del_yn eq 'y'}">
										삭제된 댓글입니다
									</c:if>
									<c:if test="${reply.del_yn eq 'n'}">
										${reply.content}
									</c:if>
								</td>
								<td>
									<c:if test="${reply.del_yn eq 'y'}">
										
									</c:if>
									<c:if test="${reply.del_yn eq 'n'}">
										${reply.writer}
									</c:if>	
								</td>
								<td>
									<c:if test="${reply.del_yn eq 'y'}">
										
									</c:if>
									<c:if test="${reply.del_yn eq 'n'}">
										${reply.register_dt}
									</c:if>	
								</td>
								<td>
									<c:if test="${reply.writer eq loginId && reply.del_yn eq 'n'}">
										<button class="btn btn-outline-danger delReplyBtn" value="${reply.reply_id}">삭제</button>
										<button class="btn btn-outline-primary updateBtn" >수정</button>
									</c:if>
								</td>
								<td value=${reply.reply_id} class="rereply">
									<c:if test="${reply.writer eq loginId && reply.del_yn eq 'n'}">
										<button type="button" class="btn btn-outline-success">답글</button>
									</c:if>
								</td>
							</tr>
							<tr class="ReReplyFrm" id="${reply.reply_id}">
								<td colspan="4">
									<input type="text" class="form-control"  maxlength="100" required>
								</td>
								<td><button type="button" class="btn btn-primary" onclick="inputReReply(this)">등록</button></td>
							</tr>
							<tr class="updateFrm" id="${reply.reply_id}">
								<td colspan="4">
									<input type="text" class="form-control updateInput"  maxlength="100" required>
								</td>
								<td><button type="button" class="btn btn-primary updateDoBtn" onclick="updateDo(this)">수정</button></td>
							</tr>
				</c:forEach>
	         </tbody>
	         
	    </table> 
	</main>
</body>
<script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
	});
	//이동!
	function goList(){
		opener.call();
		location.href ="/board/boardList.do";
		window.close();
	}
	//게시글삭제
	function delPost(){
		
		let brdId = "${boardPost.board_id}";
		
		console.log(brdId);
		location.href='/board/delBoardPost.do?board_id='+brdId;
		
		window.close();
		opener.call();
	}
	//댓글 수정
	function updateDo(e){
		console.log(e);
		let reply_id = e.parentNode.parentNode.id;
		let content = e.parentNode.previousElementSibling.firstElementChild.value;
		console.log(content);
		console.log(reply_id);
		
		if(content == null || content == ""){
			alert("내용을 입력해주세요!");
			return;
		}
		let data = {};
	 	data.reply_id = reply_id;
	 	data.content = content;
			 $.ajax({
	    		url : "/board/updateReply.do",
	    		method : 'POST',
	    		contentType: 'application/json',
			    data: JSON.stringify(data),
			    success:function(result){
			    	alert(result);
			    	location.reload();
			    },
			    error : function(error){
			    	console.log(error);
			    } 
	    	})	 
	}
	
	//댓글 수정 폼 오픈
	 $(".updateBtn").click(function() {
		 let thisis = $(this);
		 let update = thisis.parent().parent().next().next();
		 let input = thisis.parent().parent().next().next().find("input:first").text();
		 let content = thisis.parent().parent().find("#contentTd").text();
		 console.log(content)
		 console.log(input);
		 //input = content;
		 update.show();	        
	 }); 

	
	//댓글 삭제
	$(".delReplyBtn").click(function() {
		 let thisis = $(this).val();
		 	console.log(thisis);
		 	let data = {};
		 	data.reply_id = thisis;
		 	
		 	$.ajax({
	    		url : "/board/delReply.do",
	    		method : 'POST',
	    		contentType: 'application/json',
			    data: JSON.stringify(data),
			    success:function(result){
			    	alert(result);
			    	location.reload();
			    },
			    error : function(error){
			    	console.log(error);
			    } 
	    	})		 
		
	    });
	
	//대댓글등록
	function inputReReply(e){
		console.log(e);
		let parent_id = e.parentNode.parentNode.id;
		let content = e.parentNode.previousElementSibling.firstElementChild.value;
		let board_id = ${boardPost.board_id};
		console.log(board_id);
		let data = {};
		data.parent_id = parent_id;
		data.content = content;
		data.board_id = board_id;
		if(content == null || content == ""){
			alert("내용을 입력해주세요!");
			return;
		}
		
		
		$.ajax({
    		url : "/board/inputReply.do",
    		method : 'POST',
    		contentType: 'application/json',
		    data: JSON.stringify(data),
		    success:function(result){
		    	location.reload();
		    },
		    error : function(error){
		    	console.log(error);
		    } 
    	})		 
		
	}
	//대댓글 작성폼 열기
	 $(".rereply").click(function() {
		 let thisis = $(this);
		 	console.log(thisis);
		 let reply = thisis.parent().next();
		 console.log(reply);
		 reply.show();	        
	    });
	
	let insReplyBtn = document.getElementById("insReply");
	
	 //댓글 등록
	insReplyBtn.addEventListener("click", function(){
		let content = document.getElementById("inputReplyFrm").value;
		let board_id = ${boardPost.board_id};
		console.log(content);
		console.log(board_id);
		let data = {};
		data.content = content;
		data.board_id = board_id;
		if(content == null || content == ""){
			alert("내용을 입력해주세요!");
			return;
		}
	
	 	$.ajax({
    		url : "/board/inputReply.do",
    		method : 'POST',
    		contentType: 'application/json',
		    data: JSON.stringify(data),
		    success:function(result){
		    	location.reload();
		    },
		    error : function(error){
		    	console.log(error);
		    } 
    		
    	})		
	}) 
</script>
</html>