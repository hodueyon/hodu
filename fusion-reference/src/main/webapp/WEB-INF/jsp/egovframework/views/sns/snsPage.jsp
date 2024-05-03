<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<title>sns</title>
<script src="https://cdn.ckeditor.com/4.17.1/standard/ckeditor.js"></script>
<script src="https://cdn.ckeditor.com/4.17.1/standard/lang/ko.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
   .ck.ck-editor {
    	max-width: 800px;
    	margin : 0 auto;
	}
	.ck-editor__editable {
	    min-height: 400px;
	}
  .ck-content { font-size: 12px; }
  .perSns{
  	width : 50%;
  	margin : 10px auto;
  	padding : 20px;
  }
  #updateBtn{
  	display : none;
  }
  #resetBtn{
  	display : none;
  }
  .ReplyDiv{
  	display : none;
  }
  .editTr{
  	display : none;
  }
  #replyFrm{
  	width : 50% !important;
  }
  html {
  overflow-y: scroll;
 }
	.inputReplyBtn{
		float : right;
	}
  #SnsDiv img{
  	width :100% !important;
  	height : 80% !important;
  	
  }
  
</style>
</head>
<body>
	<!-- 검색 -->
	<div class="d-flex justify-content-between" style="width:50%; margin : 10px auto;">
		<div class="d-flex">
			<select name="search_type" class="form-select" style="width:100px; margin-right : 5px" id="searchTypeSelect">
				<option value="writer" class="options">작성자</option>
				<option value="content" class="options">내용</option>
				<option value="whole" class="options" selected>전체</option>
			</select>
			<input type="text" id="search_word" class="form-control w-50" style="margin-right : 5px" >
			<button type="button" id="searchBtn" class="btn btn-primary" onclick="searchSns()">검색</button>
		</div>
		
		<div  class="d-flex">
		
		<select name="perpage" class="form-select" style="width:100px; margin-right : 5px" id="searchTypeSelect">
			<option value=5 class="per_page">5개</option>
			<option value=10 class="per_page">10개</option>
		</select>
		<button type="button" id="perPageBtn" class="btn btn-outline-secondary" onclick="nperpageList()">씩 보기</button>	
		</div>
	</div>
	
	<!-- ck editor -->
	<c:if test="${auth <4 }">
		<form action="/sns/inputSns.do" method="POST" style="width: 1000px; margin : 0 auto">
	      <textarea name="content" id="editor"></textarea>
	      <input type="hidden" value="${menuid}" name="menu_id" id="hiddenMenuid">
	   		<input type="button" id="inputSns"class="btn btn-primary mt-3 mx-2" value="작성완료" />
	   		<input type="button" id="updateBtn" class="btn btn-primary mt-3 mx-2" onclick="updateSnsInc()" value="수정" />
	   		<input type="button" id="resetBtn" class="btn btn-primary mt-3 mx-2" value="취소"  />
	    </form>
	</c:if>
	
	<!-- 게시글목록 -->
	<div id="SnsDiv">
		<c:forEach items="${SnsList}" var="sns">
			<div class="perSns">
				<div>
					<button type="button" class="editSns"  value="${sns.sns_id}">수정</button>
					<button type="button" class="delSns" value="${sns.sns_id}">삭제</button>
				</div>
				<div class="snscontent">
				${sns.content}
				</div>
				<div>
					<button type="button"  id="yesLike" class="btn btn-outline-secondary" onclick="delLike()">🤍</button>
					<button type="button"  id="noLike" class="btn btn-outline-secondary" onclick="addLike()">🤍</button>
					<button type="button" class="openReply" value="${sns.sns_id}">댓글</button>
				</div>
				<div class="ReplyDiv">
					<input type="text" id="ReplyFrm" max-length="50"><button type="button" class="inputReplyBtn">등록</button>
				</div>
			</div>
		</c:forEach>
	</div>
<script>
	var methodNum;
	var content;
	var replacecon;
	var length;
	let menuid = ${menuid};
	var data = {};
	var nowPage = 1;
	var auth = ${auth};
	var sessionauth = '<%= session.getAttribute("auth") %>';
	if(sessionauth === 'null'){
		sessionauth = 4;
	}
	console.log(sessionauth);
	var loginid = "${loginId}";
	var cntperpage = "${cntPerPage}";
	var scrollTop;
	  var windowHeight;
	  var innerheight;
	var totalHeight;

		//맨처음 로딩
		getSnsList();
		setTimeout(heightCheck, 500);
		
		$(window).on("scroll", function() {
			  heightCheck();
		});
		
		 //높이체크
		 function heightCheck(){
			 //내용영역 높이 + 스크롤수직위치  >= 문체전체 높이(스크롤에 가려진 부분 포함)
			 if (window.innerHeight + window.scrollY + 10 >= document.body.scrollHeight) {
					 nowPage++;
					 setTimeout(getSnsList(), 500);
					
				 }
			 }

		if(auth <4){
			CKEDITOR.replace('editor', {
				filebrowserUploadUrl : '/sns/imageUpload.do?',
				language: 'ko',
				on: {
					change: function() {
						content = this.getData();
						length = this.getData().trim().length;
						replacecon = this.getData().replaceAll('<p>', '').replaceAll('</p>', '')
										.replaceAll('&nbsp;', '').replaceAll('<strong>', '')
										.replaceAll('</strong>','').replaceAll('<s>', '')
										.replaceAll('<em>', '').replaceAll('</s>','')
										.replaceAll('</em>', '').trim().length;
	
	
						//글자수 제한
						console.log(length);
						if(length >4000){
							alert("작성 범위를 초과했습니다.");
						}
	
					}
				}
			});
		}
		
		//권한체크
		function ckAuth(){
			
			data.menu_id = menuid;
			data.methodNum = methodNum;
			$.ajax({
				type : "GET",
				url : "/sns/getsnsList.do",
				data: data,
	            contentType : 'application/json',
	            success: function(result) {
	            	console.log(result);
	            },
	            error: function(xhr, status, error) {
	                console.log(error);
	            }
			})
			
		}
		//search
		function searchSns(){
			let search_type = $('.options:selected').val();
			let search_word = $('#search_word').val();

		
			data.search_type = search_type;
			data.nowPage =1;
			console.log(search_word);
			
				data.search_word = $('#search_word').val().trim();

			if( cntperpage != ''){
				data.cntperpage = cntperpage;
			}else{
				data.cntperpage = 5;
			}
			
			 $.ajax({
					type : "GET",
					url : "/sns/getsnsList.do",
					data: data,
		            contentType : 'application/json',
		            success: function(result) {	
		            	console.log(result.SnsList);
		            	
		            	search_word = '';
		            	$('#SnsDiv').empty();
		            		
		            		if(result.SnsList.length <=0){
		            			let perdiv = $('<div class="perSns card"/>');
			            	    perdiv.append('<div style="text-align : center"><p>'+ '검색 결과가 존재하지 않습니다!' +'</p></div>');	
			            	    $('#SnsDiv').append(perdiv);
		            		}
		            		
		            		for(let i = 0; i < result.SnsList.length; i++) {
		            	    let perdiv = $('<div class="perSns card"/>');
		            	    if(result.SnsList[i].writer == loginid || auth <= 1){
			            	    perdiv.append('<div class="d-flex justify-content-between"><div>' + result.SnsList[i].user_name + '</div><div><button type="button" class="editSns btn btn-primary mt-3 mx-2" value="'+ result.SnsList[i].sns_id+'">수정</button> <button type="button" class="delSns  btn btn-danger mt-3 mx-2" value="'+ result.SnsList[i].sns_id+'">삭제</button></div></div>');	
		            	    }else{
		            	    	perdiv.append('<div class="d-flex justify-content-start">' + result.SnsList[i].user_name +'</div>');	
		            	    }
		            	    perdiv.append('<div class="snscontent">' + result.SnsList[i].content + '</div>');
		            	    
		            	    if(result.SnsList[i].likeyn == 0 || result.SnsList[i].likeyn == null){
		            	    	 perdiv.append('<div class="d-flex justify-content-between"><button type="button" class="like_y  btn btn-outline-secondary" value="'+ result.SnsList[i].sns_id+' ">🤍('+result.SnsList[i].likecnt+')</button> <button type="button" class="openReply btn btn-outline-secondary" value="'+ result.SnsList[i].sns_id+'">댓글</button></div>');	
		            	    }
		            	    if(result.SnsList[i].likeyn >0){
		            	    	 perdiv.append('<div class="d-flex justify-content-between"><button type="button" class="like_n btn btn-outline-secondary" value="'+ result.SnsList[i].sns_id+'">❤️('+result.SnsList[i].likecnt+')</button> <button type="button" class="openReply btn btn-outline-secondary" value="'+ result.SnsList[i].sns_id+'">댓글</button></div>');	
		            	    }
		            	   
		            	    if(auth < 4){
		            	    	perdiv.append('<div class="ReplyDiv" value="'+ result.SnsList[i].sns_id+'"><input type="text" class="form-control" id="ReplyFrm" maxlength = "50"><button type="button" class="inputReplyBtn btn btn-primary">등록</button><div class="replytb"></div></div>');
		            	    }else{
		            	    	perdiv.append('<div class="ReplyDiv" value="'+ result.SnsList[i].sns_id+'"><input type="text" class="form-control" id="ReplyFrm" placeholder="비로그인 유저는 댓글을 작성하실 수 없습니다." readonly><div class="replytb"></div></div>');	
		            	    }	            	    
		            	    // 삭제
		            	    perdiv.find('.delSns').on('click', delSnsInc);
		            	    // 수정
		            	    perdiv.find('.editSns').on('click', updateSns);
		            	    
		            	    //댓글폼열기
		            	    perdiv.find('.openReply').on('click', openReplyFrm);
		            	    $('#SnsDiv').append(perdiv);
		            	    //댓글등록
		            	    perdiv.find('.inputReplyBtn').on("click", inputReplyInc);
		            	    
		            	    //좋아요
		            	    perdiv.find('.like_y').on('click', addLike);
		            	    //좋아요해제
		            	    perdiv.find('.like_n').on('click', delLike);
		            	  }
		            },
		            error: function(xhr, status, error) {
		                console.log(error);
		            }
				}) 
			
		}
		
		//n개씩 보기
		function nperpageList(){
			let ppage = $('.per_page:selected').val();
			let search_type = $('.options:selected').val();
			let search_word = $('#search_word').val();
			data.nowPage =1;
			
			data.cntPerPage = ppage;
			data.menu_id = menuid;

			if(search_type != 'nothing'){
				data.search_type = search_type;	
			}
			if($('#search_word').val().trim().length > 0 ){
				data.search_word = $('#search_word').val();
			}
			
			 $.ajax({
					type : "GET",
					url : "/sns/getsnsList.do",
					data: data,
		            contentType : 'application/json',
		            success: function(result) {
		            	console.log(result);
		            	nowPage = 1;
		            	$('#SnsDiv').empty();
		            	for(let i = 0; i < result.SnsList.length; i++) {
		            	    let perdiv = $('<div class="perSns card"/>');
		            	    if(result.SnsList[i].writer == loginid || auth <= 1){
			            	    perdiv.append('<div class="d-flex justify-content-between"><div>' + result.SnsList[i].user_name + '</div><div><button type="button" class="editSns btn btn-primary mt-3 mx-2" value="'+ result.SnsList[i].sns_id+'">수정</button> <button type="button" class="delSns  btn btn-danger mt-3 mx-2" value="'+ result.SnsList[i].sns_id+'">삭제</button></div></div>');	
		            	    }else{
		            	    	perdiv.append('<div class="d-flex justify-content-start">' + result.SnsList[i].user_name +'</div>');	
		            	    }
		            	    perdiv.append('<div class="snscontent">' + result.SnsList[i].content + '</div>');
		            	    
		            	    if(result.SnsList[i].likeyn == 0 || result.SnsList[i].likeyn == null){
		            	    	 perdiv.append('<div class="d-flex justify-content-between"><button type="button" class="like_y  btn btn-outline-secondary" value="'+ result.SnsList[i].sns_id+' ">🤍('+result.SnsList[i].likecnt+')</button> <button type="button" class="openReply btn btn-outline-secondary" value="'+ result.SnsList[i].sns_id+'">댓글</button></div>');	
		            	    }
		            	    if(result.SnsList[i].likeyn >0){
		            	    	 perdiv.append('<div class="d-flex justify-content-between"><button type="button" class="like_n btn btn-outline-secondary" value="'+ result.SnsList[i].sns_id+'">❤️('+result.SnsList[i].likecnt+')</button> <button type="button" class="openReply btn btn-outline-secondary" value="'+ result.SnsList[i].sns_id+'">댓글</button></div>');	
		            	    }
		            	   
		            	    if(auth < 4){
		            	    	perdiv.append('<div class="ReplyDiv" value="'+ result.SnsList[i].sns_id+'"><input type="text" class="form-control" id="ReplyFrm" maxlength = "50"><button type="button" class="inputReplyBtn btn btn-primary">등록</button><div class="replytb"></div></div>');
		            	    }else{
		            	    	perdiv.append('<div class="ReplyDiv" value="'+ result.SnsList[i].sns_id+'"><input type="text" class="form-control" id="ReplyFrm" placeholder="비로그인 유저는 댓글을 작성하실 수 없습니다." readonly><div class="replytb"></div></div>');	
		            	    }	            	    
		            	    // 삭제
		            	    perdiv.find('.delSns').on('click', delSnsInc);
		            	    // 수정
		            	    perdiv.find('.editSns').on('click', updateSns);
		            	    
		            	    //댓글폼열기
		            	    perdiv.find('.openReply').on('click', openReplyFrm);
		            	    $('#SnsDiv').append(perdiv);
		            	    //댓글등록
		            	    perdiv.find('.inputReplyBtn').on("click", inputReplyInc);
		            	    
		            	    //좋아요
		            	    perdiv.find('.like_y').on('click', addLike);
		            	    //좋아요해제
		            	    perdiv.find('.like_n').on('click', delLike);
		            	  }
		            },
		            error: function(xhr, status, error) {
		                console.log(error);
		            }
				}) 
			
		}
		
		//무한스크롤
		function getSnsList(){
			data.nowPage = nowPage;
			data.menu_id = menuid;
			data.cntPerPage = $('.per_page:selected').val();
			if( $('.options:selected').val() != 'nothing'){
				data.search_type = $('.options:selected').val();	
			}
			if($('#search_word').val().trim().length > 0 ){
				data.search_word = $('#search_word').val();
			}
			
			data.nowPage = nowPage;

			 $.ajax({
				type : "GET",
				url : "/sns/getsnsList.do",
				data: data,
	            contentType : 'application/json',
	            success: function(result) {
	            	console.log(result);
	            	for(let i = 0; i < result.SnsList.length; i++) {
	            	    let perdiv = $('<div class="perSns card"/>');
	            	    if(result.SnsList[i].writer == loginid || auth <= 1){
		            	    perdiv.append('<div class="d-flex justify-content-between"><div>' + result.SnsList[i].user_name + '</div><div><button type="button" class="editSns btn btn-primary mt-3 mx-2" value="'+ result.SnsList[i].sns_id+'">수정</button> <button type="button" class="delSns  btn btn-danger mt-3 mx-2" value="'+ result.SnsList[i].sns_id+'">삭제</button></div></div>');	
	            	    }else{
	            	    	perdiv.append('<div class="d-flex justify-content-start">' + result.SnsList[i].user_name +'</div>');	
	            	    }
	            	    perdiv.append('<div class="snscontent">' + result.SnsList[i].content + '</div>');
	            	    
	            	    if(result.SnsList[i].likeyn == 0 || result.SnsList[i].likeyn == null){
	            	    	 perdiv.append('<div class="d-flex justify-content-between"><button type="button" class="like_y  btn btn-outline-secondary" value="'+ result.SnsList[i].sns_id+' ">🤍('+result.SnsList[i].likecnt+')</button> <button type="button" class="openReply btn btn-outline-secondary" value="'+ result.SnsList[i].sns_id+'">댓글</button></div>');	
	            	    }
	            	    if(result.SnsList[i].likeyn >0){
	            	    	 perdiv.append('<div class="d-flex justify-content-between"><button type="button" class="like_n btn btn-outline-secondary" value="'+ result.SnsList[i].sns_id+'">❤️('+result.SnsList[i].likecnt+')</button> <button type="button" class="openReply btn btn-outline-secondary" value="'+ result.SnsList[i].sns_id+'">댓글</button></div>');	
	            	    }
	            	   
	            	    if(auth < 4){
	            	    	perdiv.append('<div class="ReplyDiv" value="'+ result.SnsList[i].sns_id+'"><input type="text" class="form-control" id="ReplyFrm" maxlength = "50"><button type="button" class="inputReplyBtn btn btn-primary">등록</button><div class="replytb"></div></div>');
	            	    }else{
	            	    	perdiv.append('<div class="ReplyDiv" value="'+ result.SnsList[i].sns_id+'"><input type="text" class="form-control" id="ReplyFrm" placeholder="비로그인 유저는 댓글을 작성하실 수 없습니다." readonly><div class="replytb"></div></div>');	
	            	    }	            	    
	            	    // 삭제
	            	    perdiv.find('.delSns').on('click', delSnsInc);
	            	    // 수정
	            	    perdiv.find('.editSns').on('click', updateSns);
	            	    
	            	    //댓글폼열기
	            	    perdiv.find('.openReply').on('click', openReplyFrm);
	            	    $('#SnsDiv').append(perdiv);
	            	    //댓글등록
	            	    perdiv.find('.inputReplyBtn').on("click", inputReplyInc);
	            	    
	            	    //좋아요
	            	    perdiv.find('.like_y').on('click', addLike);
	            	    //좋아요해제
	            	    perdiv.find('.like_n').on('click', delLike);
	
	            	  }
	            },
	            error: function(xhr, status, error) {
	                console.log(error);
	            }
			}) 
			
		}
		//sns등록
		  $('#inputSns').click(inputSns);
		
		function inputSns(){
		  data.content = CKEDITOR.instances.editor.getData();
		  data.start = 1;
		  let snscontent = CKEDITOR.instances.editor.getData().trim();
		  methodNum = 1;

		  data.menu_id = menuid;
		  
		  let ppage = $('.per_page:selected').val();
			data.cntPerPage = ppage;
		  
			if(snscontent.length <= 0 || replacecon <=0){
				alert("내용을 입력하세요");
				return false;
			}
			
			if(content.length >4000){
				alert("작성 범위를 초과했습니다.");
				return false;
			}
			
			
			   $.ajax({
		            type: 'POST',
		            url: '/sns/inputSns.do',
		            data: JSON.stringify(data),
		            dataType : "json",
		            contentType : 'application/json',
		            success: function(result) {
		                console.log(result);
		                // CKEditor 작성 칸 비우기
		                CKEDITOR.instances.editor.setData('');
		                
		                $('#SnsDiv').empty();
		                for(let i =0; i<result.length; i++){
		                	  let perdiv = $('<div class="perSns card"/>');
		                	  	if(result[i].writer == loginid || auth <= 1){
				            	    perdiv.append('<div class="d-flex justify-content-between"><div>' + result[i].user_name + '</div><div><button type="button" class="editSns btn btn-primary mt-3 mx-2" value="'+ result[i].sns_id+'">수정</button> <button type="button" class="delSns  btn btn-danger mt-3 mx-2" value="'+ result[i].sns_id+'">삭제</button></div></div>');	
			            	    }else{
			            	    	perdiv.append('<div class="d-flex justify-content-start">' + result[i].user_name +'</div>');	
			            	    }
			            	    perdiv.append('<div class="snscontent">' + result[i].content + '</div>');
			            	    
			            	    if(result[i].likeyn == 0 || result[i].likeyn == null){
			            	    	 perdiv.append('<div class="d-flex justify-content-between"><button type="button" class="like_y  btn btn-outline-secondary" value="'+ result[i].sns_id+' ">🤍('+result[i].likecnt+')</button> <button type="button" class="openReply btn btn-outline-secondary" value="'+ result[i].sns_id+'">댓글</button></div>');	
			            	    }
			            	    if(result[i].likeyn >0){
			            	    	 perdiv.append('<div class="d-flex justify-content-between"><button type="button" class="like_n btn btn-outline-secondary" value="'+ result[i].sns_id+'">❤️('+result[i].likecnt+')</button> <button type="button" class="openReply btn btn-outline-secondary" value="'+ result[i].sns_id+'">댓글</button></div>');	
			            	    }
			            	   
			            	    if(auth < 4){
			            	    	perdiv.append('<div class="ReplyDiv" value="'+ result[i].sns_id+'"><input type="text" class="form-control" id="ReplyFrm" max-length="50"><button type="button" class="inputReplyBtn btn btn-primary">등록</button><div class="replytb"></div></div>');
			            	    }else{
			            	    	perdiv.append('<div class="ReplyDiv" value="'+ result[i].sns_id+'"><input type="text" class="form-control" id="ReplyFrm" placeholder="비로그인 유저는 댓글을 작성하실 수 없습니다." readonly><div class="replytb"></div></div>');	
			            	    }		            	    
			            	    // 삭제
			            	    perdiv.find('.delSns').on('click', delSnsInc);
			            	    // 수정
			            	    perdiv.find('.editSns').on('click', updateSns);
			            	    
			            	    //댓글폼열기
			            	    perdiv.find('.openReply').on('click', openReplyFrm);
			            	    $('#SnsDiv').append(perdiv);
			            	    //댓글등록
			            	    perdiv.find('.inputReplyBtn').on("click", inputReplyInc);
			            	    
			            	    //좋아요
			            	    perdiv.find('.like_y').on('click', addLike);
			            	    //좋아요해제
			            	    perdiv.find('.like_n').on('click', delLike);
		                	 
		                }
		            },
		            error: function(xhr, status, error) {
		                console.log(error);
		            }
		        });	
		
	     
			    
		}

		
		//sns삭제
		var delSns = document.querySelectorAll(".delSns");
		
		delSns.forEach(function(e) {
			  e.addEventListener("click", delSnsInc);
		});
		
		function delSnsInc(e){
			let search_word = $('#search_word').val();
			
			 let id = e.target.value;
			 data.start = 1;
			  let ppage = $('.per_page:selected').val();
				data.cntPerPage = ppage;	
				data.menu_id = menuid;
				data.sns_id = id;
				//data.search_word = $('#search_word').val().trim();
				
		    $.ajax({
		        url : '/sns/delSns.do',
		        type : 'POST',
		        data: JSON.stringify(data),
		        dataType : "json",
		        contentType : 'application/json',
		        success: function(result) {
		        	alert("삭제완료!");
		        	$('#SnsDiv').empty();
		        	nowPage = 1;
	                for(let i =0; i<result.length; i++){
	                	  let perdiv = $('<div class="perSns card"/>');
	                	  if(result[i].writer == loginid || auth <= 1){
			            	    perdiv.append('<div class="d-flex justify-content-between"><div>' + result[i].user_name + '</div><div><button type="button" class="editSns btn btn-primary mt-3 mx-2" value="'+ result[i].sns_id+'">수정</button> <button type="button" class="delSns  btn btn-danger mt-3 mx-2" value="'+ result[i].sns_id+'">삭제</button></div></div>');	
		            	    }else{
		            	    	perdiv.append('<div class="d-flex justify-content-start">' + result[i].user_name +'</div>');	
		            	    }
		            	    perdiv.append('<div class="snscontent">' + result[i].content + '</div>');
		            	    
		            	    if(result[i].likeyn == 0 || result[i].likeyn == null){
		            	    	 perdiv.append('<div class="d-flex justify-content-between"><button type="button" class="like_y  btn btn-outline-secondary" value="'+ result[i].sns_id+' ">🤍('+result[i].likecnt+')</button> <button type="button" class="openReply btn btn-outline-secondary" value="'+ result[i].sns_id+'">댓글</button></div>');	
		            	    }
		            	    if(result[i].likeyn >0){
		            	    	 perdiv.append('<div class="d-flex justify-content-between"><button type="button" class="like_n btn btn-outline-secondary" value="'+ result[i].sns_id+'">❤️('+result[i].likecnt+')</button> <button type="button" class="openReply btn btn-outline-secondary" value="'+ result[i].sns_id+'">댓글</button></div>');	
		            	    }
		            	   
		            	    if(auth < 4){
		            	    	perdiv.append('<div class="ReplyDiv" value="'+ result[i].sns_id+'"><input type="text" class="form-control" id="ReplyFrm" max-length="50"><button type="button" class="inputReplyBtn btn btn-primary">등록</button><div class="replytb"></div></div>');
		            	    }else{
		            	    	perdiv.append('<div class="ReplyDiv" value="'+ result[i].sns_id+'"><input type="text" class="form-control" id="ReplyFrm" placeholder="비로그인 유저는 댓글을 작성하실 수 없습니다." readonly><div class="replytb"></div></div>');	
		            	    }		            	    
		            	    // 삭제
		            	    perdiv.find('.delSns').on('click', delSnsInc);
		            	    // 수정
		            	    perdiv.find('.editSns').on('click', updateSns);
		            	    
		            	    //댓글폼열기
		            	    perdiv.find('.openReply').on('click', openReplyFrm);
		            	    $('#SnsDiv').append(perdiv);
		            	    //댓글등록
		            	    perdiv.find('.inputReplyBtn').on("click", inputReplyInc);
		            	    
		            	    //좋아요
		            	    perdiv.find('.like_y').on('click', addLike);
		            	    //좋아요해제
		            	    perdiv.find('.like_n').on('click', delLike);
	                	 
	                }
		        },
		        error: function(xhr, status, error) {
		            console.log(error);
		        }
		    })
		}
		
		var editSns = document.querySelectorAll(".editSns");
		
		editSns.forEach(function(e) {
			  e.addEventListener("click", updateSns);
		});
		
		
		//sns수정오픈 !
		function updateSns(e){
			let id = e.target.value;
			let thismom = e.target.parentNode.parentNode;
			let content = e.target.parentNode.parentNode.parentNode.querySelector('.snscontent').innerHTML;
			$('#hiddenMenuid').val(id);
			console.log(content);
			 CKEDITOR.instances.editor.setData(content);
				
			 $('#updateBtn').css("display", "block");
			 $('#inputSns').css("display", "none");
			$('#resetBtn').css("display", "block");
			
			 window.scrollTo({
			    top: 0,
			    behavior: 'auto'
			  });
			
		};
		
		//sns수정 아작스
		function updateSnsInc(e){
			let content = CKEDITOR.instances.editor.getData();
			let sns_id = $('#hiddenMenuid').val();
			let ppage = $('.per_page:selected').val();
			
			  data.content = content;
			  data.sns_id = sns_id;
			  data.menu_id = menuid;
			  data.start = 1;	 
			data.cntPerPage = ppage;
			
			let snscontent = CKEDITOR.instances.editor.getData().trim();

			
			if(snscontent.length <= 0 || replacecon <=0){
				alert("내용을 입력하세요");
				return false;
			}
			
			if(content.length >4000){
				alert("작성 범위를 초과했습니다.");
				return false;
			}
			
			
			
		  $.ajax({
		            type: 'POST',
		            url: '/sns/updateSns.do',
		            data: JSON.stringify(data),
		            dataType : "json",
		            contentType : 'application/json',
		            success: function(result) {
		            	nowPage = 1;
		                // CKEditor 작성 칸 비우기
		                CKEDITOR.instances.editor.setData('');
		                //버튼들 원래대로
		                $('#resetBtn').css("display", "none");
						$('#updateBtn').css("display", "none");
						$('#inputSns').css("display", "block");
				
		                $('#SnsDiv').empty();
		                for(let i =0; i<result.length; i++){
		                	  let perdiv = $('<div class="perSns card"/>');
		                	  if(result[i].writer == loginid || auth <= 1){
				            	    perdiv.append('<div class="d-flex justify-content-between"><div>' + result[i].user_name + '</div><div><button type="button" class="editSns btn btn-primary mt-3 mx-2" value="'+ result[i].sns_id+'">수정</button> <button type="button" class="delSns  btn btn-danger mt-3 mx-2" value="'+ result[i].sns_id+'">삭제</button></div></div>');	
			            	    }else{
			            	    	perdiv.append('<div class="d-flex justify-content-start">' + result[i].user_name +'</div>');	
			            	    }
		                	  
			            	    perdiv.append('<div class="snscontent">' + result[i].content + '</div>');
			            	    
			            	    if(result[i].likeyn == 0 || result[i].likeyn == null){
			            	    	 perdiv.append('<div class="d-flex justify-content-between"><button type="button" class="like_y  btn btn-outline-secondary" value="'+ result[i].sns_id+' ">🤍('+result[i].likecnt+')</button> <button type="button" class="openReply btn btn-outline-secondary" value="'+ result[i].sns_id+'">댓글</button></div>');	
			            	    }
			            	    if(result[i].likeyn >0){
			            	    	 perdiv.append('<div class="d-flex justify-content-between"><button type="button" class="like_n btn btn-outline-secondary" value="'+ result[i].sns_id+'">❤️('+result[i].likecnt+')</button> <button type="button" class="openReply btn btn-outline-secondary" value="'+ result[i].sns_id+'">댓글</button></div>');	
			            	    }
			            	    if(auth < 4){
			            	    	perdiv.append('<div class="ReplyDiv" value="'+ result[i].sns_id+'"><input type="text" class="form-control" id="ReplyFrm" max-length="50"><button type="button" class="inputReplyBtn btn btn-primary">등록</button><div class="replytb"></div></div>');
			            	    }else{
			            	    	perdiv.append('<div class="ReplyDiv" value="'+ result[i].sns_id+'"><input type="text" class="form-control" id="ReplyFrm" placeholder="비로그인 유저는 댓글을 작성하실 수 없습니다." readonly><div class="replytb"></div></div>');	
			            	    }
			            	    // 삭제
			            	    perdiv.find('.delSns').on('click', delSnsInc);
			            	    // 수정
			            	    perdiv.find('.editSns').on('click', updateSns);
			            	    
			            	    //댓글폼열기
			            	    perdiv.find('.openReply').on('click', openReplyFrm);
			            	    $('#SnsDiv').append(perdiv);
			            	    //댓글등록
			            	    perdiv.find('.inputReplyBtn').on("click", inputReplyInc);
			            	    
			            	    //좋아요
			            	    perdiv.find('.like_y').on('click', addLike);
			            	    //좋아요해제
			            	    perdiv.find('.like_n').on('click', delLike);
		                	 
		                }
		            },
		            error: function(xhr, status, error) {
		                console.log(error);
		            }
		        }); 
		}
		
		//댓글 div 오픈겸 댓글불러오기
		var openReply = document.querySelectorAll(".openReply");
		
		openReply.forEach(function(e) {
			  e.addEventListener("click", openReplyFrm);
		});
		
		function openReplyFrm(e){
			let id = e.target.value;
			let target = $(this).parent().next().find('#ReplyFrm');
			console.log(target);
			let dd = e.target;
			let replyDiv = dd.parentNode.nextElementSibling;
			if (replyDiv.style.display === "block") {
		        replyDiv.style.display = "none";
		        target.val(" ");
		    } else {
		        replyDiv.style.display = "block";
		    }
			let zzzz= $(this).parent().next();
			let tb = zzzz.find('.replytb');

			data.brd_id = id;
			
		 	 $.ajax({
				url : '/sns/replyList.do',
				type: 'POST',
				data : JSON.stringify(data),
				contentType : 'application/json',
	            success: function(result) {
	            	 var table = $('<table class="table">');
	            	 
	            	 $.each(result, function(index, item) {
	                     var row = $('<tr class="replyTr">');
	                     var userNameCell = $('<td>').text(item.user_name);
	                     var contentCell = $('<td>').text(item.content);
	                     var registerDtCell = $('<td>').text(item.register_dt)
	                     row.append(userNameCell, contentCell, registerDtCell);
	                     
	                     let editrow = $('<tr class="editTr">');
	                     editrow.append($('<td colspan="5">').append(
	                    		    $('<input>', {
	                    		        type: 'text',
	                    		        id: 'editReplyFrm',
	                    		        value: item.content,
	                    		        style: 'width: 800px;',
	                    		        maxlength: 50

	                    		    }),
	                    		    $('<button>', {
	                    		        type: 'button',
	                    		        class: 'editReplyIncBtn',
	                    		        text: '수정'
	                    		    }).on('click', editReplyInc),
	                    		    $('<button>', {
	                    		        type: 'button',
	                    		        class: 'resetEditReply',
	                    		        text: '취소'
	                    		    }).on('click', resetEditReplyInc)
	                    		));
	                     
 
	                     if (item.writer == loginid || auth == 1) {
	                            let delBtn = $('<button>', {
	                                type: 'button',
	                                class: 'delReply',
	                                value : item.reply_id,
	                                text: '❌'
	                            });
	                            delBtn.on('click', delReplyInc);
	                            row.append($('<td>').append(delBtn));

	                            let editBtn = $('<button>', {
	                                type: 'button',
	                                class: 'editReply',
	                                value : item.reply_id,
	                                text: '수정'
	                            });
	                            editBtn.on('click', editReplyFrm); 
	                            row.append($('<td>').append(editBtn));
	                        }
	                     
	                     table.append(row);
	                     table.append(editrow);
	                 });

	                 // 표 HTML을 reply div에 삽입
	                 tb.empty().append(table);
	                zzzz.append(tb);
	            	 
	            },
	            error: function(xhr, status, error) {
	                console.log(error);
	            }
			})  
		}
		
		//댓글등록
		function inputReplyInc(e){
			
			
			  let id = e.target.parentNode.getAttribute('value');
			  let content = e.target.previousElementSibling.value;
			  let replydiv = e.target.parentNode;
				let input = $(this).prev();
			  let zzzz = $(this).parent();
			  let tb = zzzz.find('.replytb');
			 
			data.menu_id = menuid;
			data.brd_id = id;
			data.content = content;
			if(content.trim().length <= 0){
				alert("댓글을 작성해주세요");
				return false;
			}
			
			 let replytable = $('<table class="table">');
			//댓글등록
			 $.ajax({
	            type: 'POST',
				url : "/sns/inputReply.do",
				data : JSON.stringify(data),
				contentType : 'application/json',
	            success: function(result) {
	            	console.log(result);
	            	input.val(" ");
	            	
 					var table = $('<table class="table">'); 
	            	 $.each(result, function(index, item) {
	                     var row = $('<tr class="replyTr">');
	                     var userNameCell = $('<td>').text(item.user_name);
	                     var contentCell = $('<td>').text(item.content);
	                     var registerDtCell = $('<td>').text(item.register_dt)
	                     row.append(userNameCell, contentCell, registerDtCell);
	                     
	                     let editrow = $('<tr class="editTr">');
	                     editrow.append($('<td colspan="5">').append(
	                    		    $('<input>', {
	                    		        type: 'text',
	                    		        id: 'editReplyFrm',
	                    		        value: item.content,
	                    		        style: 'width: 800px;',
	                    		        maxlength: 50
	                    		    }),
	                    		    $('<button>', {
	                    		        type: 'button',
	                    		        class: 'editReplyIncBtn',
	                    		        text: '수정'
	                    		    }).on('click', editReplyInc),
	                    		    $('<button>', {
	                    		        type: 'button',
	                    		        class: 'resetEditReply',
	                    		        text: '취소'
	                    		    }).on('click', resetEditReplyInc)
	                    		));
	                     
 
	                     if (item.writer == loginid || auth == 1) {
	                            let delBtn = $('<button>', {
	                                type: 'button',
	                                class: 'delReply',
	                                value : item.reply_id,
	                                text: '❌'
	                            });
	                            delBtn.on('click', delReplyInc);
	                            row.append($('<td>').append(delBtn));

	                            let editBtn = $('<button>', {
	                                type: 'button',
	                                class: 'editReply',
	                                value : item.reply_id,
	                                text: '수정'
	                            });
	                            editBtn.on('click', editReplyFrm); 
	                            row.append($('<td>').append(editBtn));
	                        }
	                     
	                     table.append(row);
	                     table.append(editrow);
	                 });

	                 // 표 HTML을 reply div에 삽입
	                 tb.empty().append(table);
	                zzzz.append(tb);
	            },
	            error: function(xhr, status, error) {
	                console.log(error);
	            }
			}) 
		}
		
		//댓글삭제
		function delReplyInc(){
			let target = $(this);
			let reply_id = target.val();
			let brd_id = target.closest('.ReplyDiv').attr('value');
			
			let tb = target.closest('.replytb');
			let ddd = target.closest('.ReplyDiv');
			console.log(target);
			data.reply_id = reply_id;
			data.brd_id = brd_id;
			
			let replytable = $('<table class="table">');
			
		 	if(!confirm('정말 삭제하시겠습니까')){
				return false;
			}
			else{
				$.ajax({
					url :'/sns/delReply.do',
					type : 'POST',
					data : JSON.stringify(data),
					dataType : "json",
			        contentType : 'application/json',
			        success: function(result) {
			        		console.log(result);
			        	target.closest('.Replytb').empty();
			        	var table = $('<table class="table">');
		            	 
		            	 $.each(result, function(index, item) {
		                     var row = $('<tr class="replyTr">');
		                     var userNameCell = $('<td>').text(item.user_name);
		                     var contentCell = $('<td>').text(item.content);
		                     var registerDtCell = $('<td>').text(item.register_dt)
		                     row.append(userNameCell, contentCell, registerDtCell);
		                     
		                     let editrow = $('<tr class="editTr">');
		                     editrow.append($('<td colspan="5">').append(
		                    		    $('<input>', {
		                    		        type: 'text',
		                    		        id: 'editReplyFrm',
		                    		        value: item.content,
		                    		        style: 'width: 800px;',
		                    		        maxlength: 50
		                    		    }),
		                    		    $('<button>', {
		                    		        type: 'button',
		                    		        class: 'editReplyIncBtn',
		                    		        text: '수정'
		                    		    }).on('click', editReplyInc),
		                    		    $('<button>', {
		                    		        type: 'button',
		                    		        class: 'resetEditReply',
		                    		        text: '취소'
		                    		    }).on('click', resetEditReplyInc)
		                    		));
		                     
	 
		                     if (item.writer == loginid || auth == 1) {
		                            let delBtn = $('<button>', {
		                                type: 'button',
		                                class: 'delReply',
		                                value : item.reply_id,
		                                text: '❌'
		                            });
		                            delBtn.on('click', delReplyInc);
		                            row.append($('<td>').append(delBtn));

		                            let editBtn = $('<button>', {
		                                type: 'button',
		                                class: 'editReply',
		                                value : item.reply_id,
		                                text: '수정'
		                            });
		                            editBtn.on('click', editReplyFrm); 
		                            row.append($('<td>').append(editBtn));
		                        }
		                     
		                     table.append(row);
		                     table.append(editrow);
		                 });

		                 // 표 HTML을 reply div에 삽입
		                 tb.empty().append(table);
		                 ddd.append(tb);
		            },
		            error: function(xhr, status, error) {
		                console.log(error);
		            }
				})
			} 

			
			
		}
		
		//댓글수정 폼 오픈
		function editReplyFrm(){
			let target = $(this);

			let replytr = target.closest('.replyTr');
			let editfrm = replytr.next('.editTr');
			editfrm.css("display", 'table-row');
			replytr.css("display", 'none');
		}
		
		//댓글수정 취소
		function resetEditReplyInc(){
			let target = $(this);
			let edittr= target.closest('.editTr');
			let replytr = edittr.prev('.replyTr');
			edittr.css("display", "none");
			replytr.css("display", 'table-row');
		}
		
		//댓글수정
		function editReplyInc(){
			let btn = $(this);
			let content = btn.prev().val();
			let replyid = btn.closest('.editTr').prev().find('.editReply').val();
			let brdid = btn.closest('.ReplyDiv').attr('value');
			
			let zzzz= $(this).closest('.ReplyDiv');
			let tb = $(this).closest('.replytb');
			
			data.content = content;
			data.reply_id = replyid;
			data.brd_id = brdid;
			
			if(content.trim().length <= 0 ){
				alert("수정할 내용을 입력해 주세요");
				return false;
			}
			
			  $.ajax({
				url : '/sns/updateReply.do',
				type : 'POST',
				data : JSON.stringify(data),
				contentType : 'application/json',
	            success: function(result) {
	            	alert('수정완료');
	            	 var table = $('<table class="table">');
	            	 
	            	 $.each(result, function(index, item) {
	                     var row = $('<tr class="replyTr">');
	                     var userNameCell = $('<td>').text(item.user_name);
	                     var contentCell = $('<td>').text(item.content);
	                     var registerDtCell = $('<td>').text(item.register_dt)
	                     row.append(userNameCell, contentCell, registerDtCell);
	                     
	                     let editrow = $('<tr class="editTr">');
	                     editrow.append($('<td colspan="5">').append(
	                    		    $('<input>', {
	                    		        type: 'text',
	                    		        id: 'editReplyFrm',
	                    		        value: item.content,
	                    		        style: 'width: 800px;',
	                    		        maxlength: 50
	                    		    }),
	                    		    $('<button>', {
	                    		        type: 'button',
	                    		        class: 'editReplyIncBtn',
	                    		        text: '수정'
	                    		    }).on('click', editReplyInc),
	                    		    $('<button>', {
	                    		        type: 'button',
	                    		        class: 'resetEditReply',
	                    		        text: '취소'
	                    		    }).on('click', resetEditReplyInc)
	                    		));
	                     
 
	                     if (item.writer == loginid || auth == 1) {
	                            let delBtn = $('<button>', {
	                                type: 'button',
	                                class: 'delReply',
	                                value : item.reply_id,
	                                text: '❌'
	                            });
	                            delBtn.on('click', delReplyInc);
	                            row.append($('<td>').append(delBtn));

	                            let editBtn = $('<button>', {
	                                type: 'button',
	                                class: 'editReply',
	                                value : item.reply_id,
	                                text: '수정'
	                            });
	                            editBtn.on('click', editReplyFrm); 
	                            row.append($('<td>').append(editBtn));
	                        }
	                     
	                     table.append(row);
	                     table.append(editrow);
	                 });

	                 // 표 HTML을 reply div에 삽입
	                 tb.empty().append(table);
	                zzzz.append(tb);
	            	 
	            },
	            error: function(xhr, status, error) {
	                console.log(error);
	            } 
			})  
		}
		
		//좋아요
		function addLike(){
			let brdid = $(this).val();
			if(auth >=4){
				alert("로그인 후에 좋아요 기능을 이용하실 수 있습니다.");
				return false;
			}
			
			if(cntperpage == null || cntperpage == ''){
				data.cntPerPage = 5;
			}else{
				data.cntPerPage = cntperpage;
			}
			data.menu_id = menuid;
			data.sns_id = brdid;
			data.user_id = loginid;
			
			$.ajax({
				url : "/sns/addLike.do",
				type : 'POST',
				data : JSON.stringify(data),
				contentType : 'application/json',
				success: function(result){
	            	console.log(result);
	            	$('#SnsDiv').empty();
	            	nowPage = 1;
	            	for(let i = 0; i < result.length; i++) {
	            	    let perdiv = $('<div class="perSns card"/>');
	            	    if(result[i].writer == loginid || auth <= 1){
		            	    perdiv.append('<div class="d-flex justify-content-between"><div>' + result[i].user_name + '</div><div><button type="button" class="editSns btn btn-primary mt-3 mx-2" value="'+ result[i].sns_id+'">수정</button> <button type="button" class="delSns  btn btn-danger mt-3 mx-2" value="'+ result[i].sns_id+'">삭제</button></div></div>');	
	            	    }else{
	            	    	perdiv.append('<div class="d-flex justify-content-start">' + result[i].user_name +'</div>');	
	            	    }
	            	    perdiv.append('<div class="snscontent">' + result[i].content + '</div>');
	            	    
	            	    if(result[i].likeyn == 0 || result[i].likeyn == null){
	            	    	 perdiv.append('<div class="d-flex justify-content-between"><button type="button" class="like_y  btn btn-outline-secondary" value="'+ result[i].sns_id+' ">🤍('+result[i].likecnt+')</button> <button type="button" class="openReply btn btn-outline-secondary" value="'+ result[i].sns_id+'">댓글</button></div>');	
	            	    }
	            	    if(result[i].likeyn >0){
	            	    	 perdiv.append('<div class="d-flex justify-content-between"><button type="button" class="like_n btn btn-outline-secondary" value="'+ result[i].sns_id+'">❤️('+result[i].likecnt+')</button> <button type="button" class="openReply btn btn-outline-secondary" value="'+ result[i].sns_id+'">댓글</button></div>');	
	            	    }
	            	   
	            	    if(auth < 4){
	            	    	perdiv.append('<div class="ReplyDiv" value="'+ result[i].sns_id+'"><input type="text" class="form-control" id="ReplyFrm" max-length="50"><button type="button" class="inputReplyBtn btn btn-primary">등록</button><div class="replytb"></div></div>');
	            	    }else{
	            	    	perdiv.append('<div class="ReplyDiv" value="'+ result[i].sns_id+'"><input type="text" class="form-control" id="ReplyFrm" placeholder="비로그인 유저는 댓글을 작성하실 수 없습니다." readonly><div class="replytb"></div></div>');	
	            	    }	            	    
	            	    // 삭제
	            	    perdiv.find('.delSns').on('click', delSnsInc);
	            	    // 수정
	            	    perdiv.find('.editSns').on('click', updateSns);
	            	    
	            	    //댓글폼열기
	            	    perdiv.find('.openReply').on('click', openReplyFrm);
	            	    $('#SnsDiv').append(perdiv);
	            	    //댓글등록
	            	    perdiv.find('.inputReplyBtn').on("click", inputReplyInc);
	            	    
	            	    //좋아요
	            	    perdiv.find('.like_y').on('click', addLike);
	            	    //좋아요해제
	            	    perdiv.find('.like_n').on('click', delLike);
	            	  }
	            },
	            error: function(xhr, status, error) {
	                console.log(error);
	            }
			})
			
		}
		
		//좋아요해제
		function delLike(){
			let brdid = $(this).val();

			if(cntperpage == null || cntperpage == ''){
				data.cntPerPage = 5;
			}else{
				data.cntPerPage = cntperpage;
			}
			data.menu_id = menuid;
			data.sns_id = brdid;
			data.user_id = loginid;
			
			$.ajax({
				url : "/sns/delLike.do",
				type : 'POST',
				data : JSON.stringify(data),
				contentType : 'application/json',
				success: function(result) {
	            	console.log(result);
	            	$('#SnsDiv').empty();
	            	nowPage = 1;
	            	for(let i = 0; i < result.length; i++) {
	            	    let perdiv = $('<div class="perSns card"/>');
	            	    if(result[i].writer == loginid || auth <= 1){
		            	    perdiv.append('<div class="d-flex justify-content-between"><div>' + result[i].user_name + '</div><div><button type="button" class="editSns btn btn-primary mt-3 mx-2" value="'+ result[i].sns_id+'">수정</button> <button type="button" class="delSns  btn btn-danger mt-3 mx-2" value="'+ result[i].sns_id+'">삭제</button></div></div>');	
	            	    }else{
	            	    	perdiv.append('<div class="d-flex justify-content-start">' + result[i].user_name +'</div>');	
	            	    }
	            	    perdiv.append('<div class="snscontent">' + result[i].content + '</div>');
	            	    
	            	    if(result[i].likeyn == 0 || result[i].likeyn == null){
	            	    	 perdiv.append('<div class="d-flex justify-content-between"><button type="button" class="like_y  btn btn-outline-secondary" value="'+ result[i].sns_id+' ">🤍('+result[i].likecnt+')</button> <button type="button" class="openReply btn btn-outline-secondary" value="'+ result[i].sns_id+'">댓글</button></div>');	
	            	    }
	            	    if(result[i].likeyn >0){
	            	    	 perdiv.append('<div class="d-flex justify-content-between"><button type="button" class="like_n btn btn-outline-secondary" value="'+ result[i].sns_id+'">❤️('+result[i].likecnt+')</button> <button type="button" class="openReply btn btn-outline-secondary" value="'+ result[i].sns_id+'">댓글</button></div>');	
	            	    }
	            	   
	            	    if(auth < 4){
	            	    	perdiv.append('<div class="ReplyDiv" value="'+ result[i].sns_id+'"><input type="text" class="form-control" id="ReplyFrm"><button type="button" class="inputReplyBtn btn btn-primary">등록</button><div class="replytb"></div></div>');
	            	    }else{
	            	    	perdiv.append('<div class="ReplyDiv" value="'+ result[i].sns_id+'"><input type="text" class="form-control" id="ReplyFrm" placeholder="비로그인 유저는 댓글을 작성하실 수 없습니다." readonly><div class="replytb"></div></div>');	
	            	    }	            	    
	            	    // 삭제
	            	    perdiv.find('.delSns').on('click', delSnsInc);
	            	    // 수정
	            	    perdiv.find('.editSns').on('click', updateSns);
	            	    
	            	    //댓글폼열기
	            	    perdiv.find('.openReply').on('click', openReplyFrm);
	            	    $('#SnsDiv').append(perdiv);
	            	    //댓글등록
	            	    perdiv.find('.inputReplyBtn').on("click", inputReplyInc);
	            	    
	            	    //좋아요
	            	    perdiv.find('.like_y').on('click', addLike);
	            	    //좋아요해제
	            	    perdiv.find('.like_n').on('click', delLike);
	            	  }
	            },
	            error: function(xhr, status, error) {
	                console.log(error);
	            }
			})	
		}
		
		//수정취소시 
		$('#resetBtn').on("click", function(){
			if(! confirm("수정을 취소하시겠습니까")){
				return false;
			}else{
				$('#resetBtn').css("display", "none");
				$('#updateBtn').css("display", "none");
				$('#inputSns').css("display", "block");
			    // CKEditor 작성 칸 비우기
                CKEDITOR.instances.editor.setData('');
			}
		})
		
</script>
	
</body>
</html>
