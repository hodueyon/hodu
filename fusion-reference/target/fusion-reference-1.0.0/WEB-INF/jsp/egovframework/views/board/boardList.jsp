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
<title>퓨전 게시판(목록)</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
	#popup {
	  display: none;
	  position: absolute; /* position을 absolute로 변경 */
	  top: 10px; 
	  left: 20px; 
	  transform: translate(10px, 10px); /* transform으로 10px만큼 이동 */
	  width: 500px;
	  height: 500px;
	  background-color: beige;
	  z-index: 9999;
	  color: black;
	  border-radius : 10px;
	  padding : 3px;
	}
	
	#popup h2,#popup p {
	  color: black;
	  text-align : center;
	}
	
	
	#popup h2 {
	  margin-top: 50px;
	}
	
	#popup p {
	  margin-top: 20px;
	}
	
	#closePopup {
	  display: block;
	  position : absolute;
	  top : 0%;
	  right : 0%;
	  margin-top: 20px;
	
	}
	#title{
		display : flex;
		justify-content: space-between;
	}
	#noticetable{
		font-size : 20px;
		font-weight : bold;
	}
	.openThing{
		cursor: pointer;
	}
	h1{
		cursor : pointer;
	}
	.centeralign{
		 justify-content: center;
	}
	.btnss{
		height : 50px;
	}
	#writebtn{
		margin-right : 5px;
	}
	#updateNotice{
		display : none;
	}
	#delNotice{
		display: none;
	}
	
</style>
<script>
	function perPageChange() {
		var cntPerPage = document.getElementById('PerPage').value;
		location.href="boardList?nowPage=${paging.nowPage}&cntPerPage="+cntPerPage;
	}
</script>
</head>
<body>
<%

	Integer total = Integer.parseInt(request.getAttribute("total").toString());
	Integer nowPage = Integer.parseInt(request.getAttribute("nowPage").toString());
	Integer cntperpage = Integer.parseInt(request.getAttribute("cntperpage").toString());
	
	Integer brdnum = total - ((nowPage - 1) * cntperpage);
	Integer noticenum = 5;
%> 
	<main class="mt-5 pt-5">
	<div class="container-fluid px-4">
		<div id="title" class="d-flex justify-content-between">
			<h1 class="mt-4" onclick="location.href='/board/boardList.do?nowPage=1&cntPerPage=10'">게시판</h1>
			<c:if test="${empty loginId}">
				<button type="button" class="btn btn-primary" onclick="location.href='/user/loginfrm.do'" class="btnss">로그인</button>
			</c:if>
			<c:if test="${not empty loginId}">
				<button type="button" class="btn btn-primary " onclick="location.href='/user/logout.do'" class="btnss">로그아웃</button>
			</c:if>
		</div>
		<div class="card mb-4">
			<div class="card-header d-flex justify-content-between">
				<div class="d-flex ">
				<select name="search_type" class="form-select" style="width:100px; margin-right : 5px" id="searchTypeSelect">
					<option value="writer">작성자</option>
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="whole">전체</option>
				</select>
				<input type="text" id="search_word" class="form-control w-50" style="margin-right : 5px" ><button type="button" id="searchBtn" class="btn btn-primary">검색</button>
				</div>
				<div class="d-flex align-items-center">
					<select name="perPage" id="perpagechoose" class="form-select" style="width:100px">
						<option value=10>10개</option>
						<option value=30>30개</option>
						<option value=50>50개</option>
					</select>
					<button type="button" id="perPageBtn" class="btn btn-outline-secondary">씩 보기</button>	
				</div>	
				<c:if test="${not empty loginId}">
					<a class="btn btn-primary float-end" onclick="openWrite()" id="writebtn" >
						<i class="fas fa-edit"></i> 글 작성
					</a>
				</c:if>
				<a class="btn btn-primary float-end" href="/user/main.do" id="writebtn" >
						<i class="fas fa-edit"></i>메뉴
				</a>
				<c:if test="${not empty loginId}">
					<a class="btn btn-outline-secondary float-end" onclick="delChecked()" style="margin-right : 0.5%">
						<i class="fas fa-edit"></i> 선택 삭제
					</a>
				</c:if>
			</div>
			
			<div class="card mb-4">
			<div class="card-body">
				<table class="table table-hover table-striped" >
					<thead>
						<tr>
							<th>글번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>조회수</th>
							<th>작성일</th>
							<th>선택</th>
						</tr>
					</thead>
					<tbody>
						<c:if test = "${not empty boardList}">
						<c:forEach items="${boardList}" var="board">
							<tr id="${board.del_yn}"  style="background-color: ${board.category == 1 ? '#F8E0E0' : 'inherit'};">
								<td id="${board.category}"><%=brdnum--%></td>
								<td class="openThing" onclick="openBrd(this)" id="${board.board_id}"  style="padding-left: ${20 * (board.level-1)}px;">
									<c:if test="${board.del_yn eq 'y' && board.level == 1}">
										삭제된 글 입니다
									</c:if>

									<c:if test="${board.del_yn eq 'y' && board.level >1}">
										⮩ 삭제된 글 입니다
									</c:if>
									<c:if test="${board.del_yn eq 'n' && board.level == 1}">
										${board.title}
									</c:if>
									<c:if test="${board.del_yn eq 'n' && board.level >1}">
										⮩ ${board.title}
									</c:if>
								
								</td>
								<td>
									<c:if test="${board.del_yn eq 'n'}">
										${board.writer}
									</c:if>
									<c:if test="${board.del_yn eq 'y'}">
										
									</c:if>
								</td>
								<td>
									<c:if test="${board.del_yn eq 'n'}">
										${board.cnt}
									</c:if>
									<c:if test="${board.del_yn eq 'y'}">
										
									</c:if>
								</td>
								<td>
									<c:if test="${board.del_yn eq 'n'}">
										${board.register_dt}
									</c:if>
									<c:if test="${board.del_yn eq 'y'}">
										
									</c:if>	
								</td>
								<td>
									<c:if test="${board.writer eq loginId && board.del_yn eq 'n'}">
										<input type="checkbox" name="chkBox" value=${board.board_id}>
									</c:if>
								</td>
							</tr>
							
						</c:forEach>
						</c:if>
						<c:if test = "${empty boardList}">
							<tr>
								<td colspan="5" style="text-align:center;">검색 결과가 없습니다</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
			</div>
		</div>
		
		</div>
		
		<!-- 페이징 -->
		<nav aria-label="Page navigation example">
		  <ul class="pagination centeralign">
		    <c:if test="${paging.startPage != 1 }">
				<li class="page-item">
						<a class="page-link" aria-label="Previous" href="/board/boardList.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}&search_type=${searchType}&search_word=${searchWord}">
				        <span aria-hidden="true">&laquo;</span>
				      	</a>
				    </li>
			</c:if>
			<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
		<c:choose>
				<c:when test="${p == paging.nowPage }">
				<li class="page-item">
					<a class="page-link" href="/board/boardList.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}&search_type=${searchType}&search_word=${searchWord}"><b style="color:purple;">${p}</b></a>
				</li>
				</c:when>
				<c:when test="${p != paging.nowPage }">
				<li class="page-item">
					<a class="page-link" href="/board/boardList.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}&search_type=${searchType}&search_word=${searchWord}">${p}</a>
				</li>
			</c:when>
		</c:choose>
			</c:forEach>
			    <c:if test="${paging.endPage lt paging.lastPage}">
					<li class="page-item">
						<a class="page-link" href="/board/boardList.do?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}&search_type=${searchType}&search_word=${searchWord}"aria-label="Next">
							<span aria-hidden="true">&raquo;</span>
						</a>
					</li>
				</c:if>
			</ul>
		</nav>

	
	</main>
	
	<!-- 처음 오픈시 모달 -->
	<div id="popup">
	<h2>🚨최신 공지🚨</h2><button type="button" class="btn-close" aria-label="Close" id="closePopup" style="block"></button>
			 
	    		<div class="mb-3">
					<label for="title" class="form-label">제목</label>
					<input type="text" class="form-control" id="content" name="content" value = "${recentNotice.title}" readOnly>
					<input type="hidden" id="modalbrdid" value="${recentNotice.board_id}">
				</div>
				<div class="mb-3">
					<label for="content" class="form-label">내용</label>
					<textarea class="form-control" id="content" name="content"  rows="7" readOnly>${recentNotice.content}</textarea>
				</div>
			
	  		
	    <input type="checkbox" id="todaynot"><span>오늘 그만보기</span>
 	</div>
	
	<!-- 모달! -->
	<div class="modal" tabindex="-1">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">${boardPost.title}</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <p>Modal body text goes here.</p>
	      </div>
	      <div class="modal-footer">
	         	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="updateNotice">수정</button>
	          	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="delNotice">삭제</button>
	           	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
 
</body>
<script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript">
	window.onload = function() {
	//쿠키 소환
	
		var cookiedata = document.cookie; 
		var brdId = "${recentNotice.board_id}"
		
		console.log(brdId);
		 if(cookiedata.indexOf("closeCookie=" + brdId)<0){
			 $("#popup").show(); 
		 }else{
			 $("#popup").hide(); 
		 }

	};
	//쿠키만들기
	// 쿠키 생성
	function setCookie( name, value, expiredays ) {  // 쿠키저장
		var todayDate = new Date();  //date객체 생성 후 변수에 저장
		todayDate.setDate( todayDate.getDate() + (expiredays*24*60*60*1000) ); 
		
	   	 // 시간지정(현재시간 + 지정시간)
		document.cookie = name + "=" + value + "; path=/; expires=" + todayDate.toUTCString() + ";"
		//위 정보를 쿠키넣고 생성하기~!
	} 
	
	
	//공지수정
	$("#updateNotice").on("click", function(){
		var popupWidth = 600;
		var popupHeight = 500;
		let brdId = $("#modalbrdid").val();
		var url = '/board/boardPostModify.do?board_id='+brdId;
		var popupX = Math.ceil(( window.screen.width - popupWidth )/2);
		var popupY = Math.ceil(( window.screen.height - popupHeight )/2); 
		

		window.open(url, 'window_name', 'width=' + popupWidth + ',height=' + popupHeight + ',left='+ popupX + ', top='+ popupY);
	})
	
	
	//공지삭제
	$("#delNotice").on("click", function(){
		if(confirm("정말 삭제하시겠습니까.")){
			let brdId = $("#modalbrdid").val();
			location.href='/board/delBoardPost.do?board_id='+brdId;
			
			$('.modal').modal("hide");
			location.reload();
		  }
	})
	
	
	//cntperpage로 selection option값 바꾸기
	let selected = ${paging.cntPerPage};
	$("#perpagechoose").val(selected).prop("selected", true);

	//검색어 유지
	let searchType = "${searchType}";
	let searchWord = "${searchWord}";
	if(searchType != ""){
		$("#searchTypeSelect").val(searchType).prop("selected", true);	
	}
	$("#search_word").val(searchWord);
	
	//처음모달 닫기
	document.getElementById('closePopup').addEventListener('click', function() {
		//오늘 그만 보기 했을떄 
		let brdId = $("#modalbrdid").val();
		console.log(brdId);
		
	 	if($('input:checkbox#todaynot:checked').length > 0){
			 setCookie("closeCookie",brdId,1);
			
		}else{
			console.log("false"); 
		}  
		
	 	document.getElementById('popup').style.display = 'none';
	
	});
	
	var myModal = document.getElementById('myModal')
	var myInput = document.getElementById('myInput')
	
	//새로고침!
	function call(){
		location.reload();
	}
	
	$(document).ready(function() {
		//검색
		$("#searchBtn").on("click", function(){
			 let search_type = $("select[name='search_type'] option:selected").val();
				console.log(search_type);
				let search_word = $("#search_word").val();
				console.log(search_word);
				let cntPerPage = "${cntPerPage}";
			location.href="/board/boardList.do?search_type="+search_type+"&search_word="+search_word+"&cntPerPage="+cntPerPage;
		})
		
		//검색창에서 엔터 누르면 바로 검색 
		 $("#search_word").on("keyup",function(key){
	        if(key.keyCode==13) {
	        	//검색버튼 활성화
	        	$("#searchBtn").click();
	        }
	    });
		
		//몇개씩 보기
		$("#perPageBtn").on("click", function(){
			 let perPage = $("select[name='perPage'] option:selected").val();
			 console.log(perPage);
			 

			 let searchType= "${searchType}";
			 let searchWord = "${searchWord}"
			 let nowPage = $("#nowpage").text();
			 location.href="/board/boardList.do?cntPerPage="+perPage+"&nowPage="+1+"&search_type="+searchType+"&search_word="+searchWord;
		})
	});
	
	//공지 열기 - 모달창 오픈
	function openModal(e){
		$('.modal').modal("show");
		
		let brdId = e;
		let data = {};
		let loginId = "${loginId}";
		console.log(loginId);
		data.board_id = e;
		 $.ajax({
				type: "POST",
				url : "/board/boardNotice.do?board_id="+brdId,
				data : JSON.stringify(data),
				contentType : 'application/json', 
				success : function(result){
					$(".modal-title").text(result.boardPost.title);
					$(".modal-body>p").text(result.boardPost.content);
					$("#modalbrdid").val(result.boardPost.board_id);
					let aaa = $("#modalbrdid").val();
					console.log(aaa);
					let writer = result.boardPost.writer;
					if(loginId == writer){
						$("#updateNotice").css("display", "block");
						$("#delNotice").css("display", "block");
					}
					console.log(result);
					
				},
				error : function(error){
					console.log(error);
				}
				
			}) 
			
	}
	//글읽기
	function openBrd(e){
		let btn = e;
		let tr = btn.parentElement.id;
		let brdId = e.id;

		let thdthdtdh = $(this);
		console.log(e);
		let cateogy =  btn.previousSibling.previousSibling.id;
		
		console.log(thdthdtdh);

		/* console.log(cateogy);
		if(cateogy == 1){
			openModal(brdId);
		}else{ */
			var popupWidth = 600;
			var popupHeight = 500;
			let url = "/board/boardPost.do?board_id="+brdId;
			var popupX = Math.ceil(( window.screen.width - popupWidth )/2);
			var popupY = Math.ceil(( window.screen.height - popupHeight )/2); 
			
			if(tr == 'n'){
				window.open(url, 'window_name', 'width=' + popupWidth + ',height=' + popupHeight + ',left='+ popupX + ', top='+ popupY);	
			}else{
				alert("삭제된 글입니다!");	
	/* 	} */
		
		console.log(tr);
		console.log(brdId);
		
		}
			
	
 		
	}
	
	function openWrite(){
		var popupWidth = 600;
		var popupHeight = 500;
		
		var popupX = Math.ceil(( window.screen.width - popupWidth )/2);
		var popupY = Math.ceil(( window.screen.height - popupHeight )/2); 
		

		window.open('/board/boardRegister.do', 'window_name', 'width=' + popupWidth + ',height=' + popupHeight + ',left='+ popupX + ', top='+ popupY);

	}
	function delChecked(){
		var chkArr= [];
		  $("input:checkbox[name='chkBox']:checked").each(function() {
			  chkArr.push($(this).val());   
			  console.log(chkArr);
			})
			let data = {};
		  data.numArr = chkArr;
		
		  if(confirm("정말 삭제하시겠습니까.")){
			  $.ajax({
					type: "POST",
					url : "/board/delChkBoardPost.do",
					data : JSON.stringify(data),
					contentType : 'application/json', 
					success : function(result){
						document.location.reload();
					},
					error : function(error){
						console.log(error);
					}	
				})   
		  }
		 
	}	
	
	
</script>
</html>