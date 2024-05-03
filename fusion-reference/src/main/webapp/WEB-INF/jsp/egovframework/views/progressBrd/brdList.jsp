<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<title>진행단계</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>
	tr{
		cursor : pointer;
	}
	.centeralign{
	 justify-content: center;
	}
	#bodyDiv{
		width : 1200px;
		margin : 0 auto;	
	}
	.nav{
		width : 1200px;
		margin : 0 auto;	
	}
</style>
</head>
<body>
<% 
	Integer total = Integer.parseInt(request.getAttribute("total").toString());
	Integer nowPage = Integer.parseInt(request.getAttribute("nowPage").toString());
	Integer cntperpage = Integer.parseInt(request.getAttribute("cntperpage").toString());
	
	Integer brdnum = total - ((nowPage - 1) * cntperpage);
	
%>
	<main class="mt-5 pt-5">
	<!-- 탭 -->
	<ul class="nav nav-tabs">
		<c:forEach items="${tabs}" var="tab">
			  <li class="nav-item tabs" id="${tab.sub_id}">
			    <a class="nav-link active" aria-current="page" href="#"  id="${tab.sub_id}">${tab.sub_name}</a>
			  </li>
	 	 </c:forEach>
	</ul>
	

	<div class="container-fluid px-4 " id="bodyDiv">
		<div id="title" class="d-flex justify-content-between">
			<h1 class="mt-4" >게시판_진행단계</h1>
		</div>
		<div class="card mb-4">
			<div class="card-header d-flex justify-content-between">
				<div class="d-flex align-items-center">
					<select name="perPage" id="perpagechoose" class="form-select" style="width:100px">
						<option value=5>5개</option>
						<option value=10>10개</option>
						<option value=20>20개</option>
					</select>
					<button type="button" id="perPageBtn" class="btn btn-outline-secondary">씩 보기</button>	
				</div>	
				<c:if test="${auth >=3}">
					<a class="btn btn-primary float-end" onclick="openWrite()" id="writebtn" >
						<i class="fas fa-edit"></i> 글 작성
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
							<th>작성일</th>
							<c:if test="${auth>2 }">
								<th>관리자</th>
							</c:if>
							<c:if test="${auth<=2 }">
								<th>작성자</th>
							</c:if>
							<!-- 검토완료일 떄만  -->
							<c:if test="${progress eq 'E02' || progress eq 'E04'}">
								<th>상태</th>
							</c:if>
						</tr>
					</thead>
					<tbody>
						<c:if test = "${not empty boardList}">
							<c:forEach items="${boardList}" var="board" varStatus="num">
								<tr onclick="readPage(this)" id="${board.board_id}">
									<td><%=brdnum--%></td>
									<td>${board.title}</td>
									<td>${board.register_dt}</td>
									<c:if test="${auth>2 }">
										<td>${board.manager}</td>
									</c:if>
									<c:if test="${auth<=2 }">
										<td>${board.writer_name}</td>
									</c:if>
									<!-- 검토완료일 떄만  -->
									<c:if test="${progress eq 'E02' || progress eq 'E04'}">
										<c:if test="${board.status eq 1 }">
											<td>승인</td>
										</c:if>
										<c:if test="${board.status eq 2 }">
											<td>반려</td>
										</c:if>
									</c:if>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test = "${empty boardList}">
							<tr>
								<td colspan="6">
									글이 존재하지 않습니다.
								</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
			</div>
		</div>
		
		</div>
		
		
		<!-- 페이징 -->
		<nav aria-label="Page navigation example ">
		  <ul class="pagination centeralign">
		    <c:if test="${paging.startPage != 1 }">
				<li class="page-item">
						<a class="page-link" aria-label="Previous" href="/progress/boardList.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}&progress=${progress}&menu_id=${menu_id}">
				        <span aria-hidden="true">&laquo;</span>
				      	</a>
				    </li>
			</c:if>
			<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
		<c:choose>
				<c:when test="${p == paging.nowPage }">
				<li class="page-item">
					<a class="page-link" href="/progress/boardList.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}&progress=${progress}&menu_id=${menu_id}"><b style="color:purple;">${p}</b></a>
				</li>
				</c:when>
				<c:when test="${p != paging.nowPage }">
				<li class="page-item">
					<a class="page-link" href="/progress/boardList.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}&progress=${progress}&menu_id=${menu_id}">${p}</a>
				</li>
			</c:when>
		</c:choose>
			</c:forEach>
			    <c:if test="${paging.endPage lt paging.lastPage}">
					<li class="page-item">
						<a class="page-link" href="/progress/boardList.do?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}&progress=${progress}&menu_id=${menu_id}"aria-label="Next">
							<span aria-hidden="true">&raquo;</span>
						</a>
					</li>
				</c:if>
			</ul>
		</nav>

	
	</main>
</body>
<script>
	var nowPage = ${paging.nowPage};
	//n개씩 보기
	$('#perPageBtn').on('click',function(){
		let progress = "${progress}";
 		let cntPerPage = $('#perpagechoose').val();
 		//현재페이지도 추가
 		let menuid = ${menu_id};
 		
 		location.href="/progress/boardList.do?menu_id="+menuid+"&progress="+progress+"&cntPerPage="+cntPerPage;	
	})
	//페이징 선택값 유지
		let selected = ${paging.cntPerPage};
	$("#perpagechoose").val(selected).prop("selected", true);
	
	//선택한 탭값 표시
	let progress = "${progress}";
	$('.tabs').each(function(){
		if($(this).attr('id') == progress){
			$(this).addClass('active');
			console.log($(this));
			$(this).css({
			  'color': 'blue',
			  'font-weight': 'bold'
			});
		}
	})
	
	function openWrite(){
 		let menuid = ${menu_id};
 		let cntPerPage = $('#perpagechoose').val();
 		let progress = "${progress}";
 		
		location.href="/progress/boardRegister.do?menu_id="+menuid+"&cntPerPage="+cntPerPage+"&nowPage="+nowPage+"&progress="+progress;
	}
 	function readPage(e){
 		let menuid = ${menu_id};
 		let cntPerPage = $('#perpagechoose').val();
 		let id = e.id;
 		
 		location.href ="/progress/getPost.do?board_id="+id+"&cntPerPage="+cntPerPage+"&nowPage="+nowPage+"&menu_id="+menuid+"&progress="+progress;
 	}
 	
 	//탭이동
 	$('.tabs').on("click", function(){
 		let progress = $(this).attr('id');
 		let cntPerPage = $('#perpagechoose').val();
 		//현재페이지도 추가
 		
 		let menuid = ${menu_id};
 		location.href="/progress/boardList.do?menu_id="+menuid+"&progress="+progress+"&cntPerPage="+cntPerPage;
 	})
</script>
</html>