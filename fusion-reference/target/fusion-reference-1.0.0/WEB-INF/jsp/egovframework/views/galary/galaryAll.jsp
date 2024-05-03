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
<%@ page import="java.util.List, java.util.ArrayList" %>

<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<title>퓨전 게시판(목록)</title>
<link href="<%=request.getContextPath()%>/css/egovframework/bootstrap.min.css" rel="stylesheet">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
	  .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }

      .b-example-divider {
        height: 3rem;
        background-color: rgba(0, 0, 0, .1);
        border: solid rgba(0, 0, 0, .15);
        border-width: 1px 0;
        box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
      }

      .b-example-vr {
        flex-shrink: 0;
        width: 1.5rem;
        height: 100vh;
      }

      .bi {
        vertical-align: -.125em;
        fill: currentColor;
      }

      .nav-scroller {
        position: relative;
        z-index: 2;
        height: 2.75rem;
        overflow-y: hidden;
      }

      .nav-scroller .nav {
        display: flex;
        flex-wrap: nowrap;
        padding-bottom: 1rem;
        margin-top: -1px;
        overflow-x: auto;
        text-align: center;
        white-space: nowrap;
        -webkit-overflow-scrolling: touch;
      }
      
      .tagStyle{
      	background-color : pink;
      	padding : 1px 1px;
      	border-radius : 10px;
      	cursor : pointer;
      }
     .centeralign{
		 justify-content: center;
	}
	img{
		cursor : pointer;
	}
	.navbar{
		background-color : beige;
		padding : 10px 0;
	}
	.navbar>ul{
		list-style : none;
		margin : 0px;
	}
	.navbar>ul>li{
		display : inline-block;
		margin-right : 100px;
	}
	#searchelse{
		margin : 5px 0;
	}
	li{
		cursor : pointer;
	}
	.bold{
		font-weight : bold;
	}
</style>
<script>
	
</script>
</head>
<body>
<%
/* 
	Integer total = Integer.parseInt(request.getAttribute("total").toString());
	Integer nowPage = Integer.parseInt(request.getAttribute("nowPage").toString());
	Integer cntperpage = Integer.parseInt(request.getAttribute("cntperpage").toString());
	
	Integer brdnum = total - ((nowPage - 1) * cntperpage);
	Integer noticenum = 5; */
	
	List<String[]> myList = new ArrayList<>();
	
%>  
<main class="mt-5 pt-5">
	<div class="container-fluid px-4">
		<div id="title" class="d-flex justify-content-between">
			<h1 class="mt-4" onclick="location.href='/galary/galaryList.do?nowPage=1&cntPerPage=9'">갤러리</h1>
			<c:if test="${empty loginId}">
				<button type="button" class="btn btn-primary" onclick="location.href='/user/loginfrm.do'" class="btnss">로그인</button>
			</c:if>
			<c:if test="${not empty loginId}">
				<button type="button" class="btn btn-primary " onclick="location.href='/user/logout.do'" class="btnss">로그아웃</button>
			</c:if>
		</div>
		<div class="card-header d-flex justify-content-between" id="searchelse">
				<div class="d-flex ">
				<select name="search_type" class="form-select" style="width:100px; margin-right : 5px" id="searchTypeSelect">
					<option value="writer">작성자</option>
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="image_name">이미지</option>
					<option value="whole">전체</option>
					<option value="tag_name">태그</option>
				</select>
				<input type="text" id="search_word" class="form-control w-50" style="margin-right : 5px" ><button type="button" id="searchBtn" class="btn btn-primary">검색</button>
				</div>
				<div class="d-flex align-items-center">
					<select name="perPage" id="perpagechoose" class="form-select" style="width:100px">
						<option value=3>3개</option>
						<option value=6>6개</option>
						<option value=9>9개</option>
					</select>
					<button type="button" id="perPageBtn" class="btn btn-outline-secondary">씩 보기</button>	
				</div>	
				<c:if test="${not empty loginId}">
					<a class="btn btn-primary float-end" href="/galary/galaryInputFrm.do" id="writebtn" >
						<i class="fas fa-edit"></i> 글 작성
					</a>
				</c:if>
				<a class="btn btn-primary float-end" href="/user/main.do" id="writebtn" >
						<i class="fas fa-edit"></i>메뉴
				</a>
			</div>	
		
	<!-- navbar -->	
	<div class="navbar">
		<ul>
			<li value="0" onclick="categoryChange()" class="categories">전체</li>
			<li value="1" onclick="categoryChange()" class="categories">동물</li>
			<li value="2" onclick="categoryChange()" class="categories">음식</li>
			<li value="3" onclick="categoryChange()" class="categories">풍경</li>
			<li value="4" onclick="categoryChange()" class="categories">캐릭터</li>
		</ul>
	</div>

<!-- 사진 -->
 <div class="album py-5 bg-light">
 	
    <div class="container">
      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
      
      <!-- 갤러리 반복문 -->
      <c:forEach items="${galarylist}" var="galary">
        <div class="col firstdiv"  >
          <div class="card shadow-sm">
            <img class="bd-placeholder-img card-img-top" width="100%" height="225" src="/resize/${galary.file_route}" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false"
            onclick="gopost()" id="${galary.galary_id}"></img>

            <div class="card-body" >
              <p class="card-text" onclick="gopost()" id="${galary.galary_id}">${galary.title}</p>
              <div class="d-flex justify-content-between align-items-center">
               
                <div>
                	<span class="text-muted">❤️ </span><span> ${galary.likescnt}</span>
              	</div>
              	<div>
                	<span class="text-muted">조회수 : </span><span>${galary.cnt}</span><span> 회</span>
              	</div>
              </div>
            <div class="d-flex align-items-center">
              		<c:forEach items="${galary.tagArr}" var="tag">
              		  	 <c:if test="${tag ne 'null'}">
						        <div class="tagStyle me-2" id="${tag}">
						            <span># ${tag}</span>
						        </div>
						  </c:if>
						  <c:if test="${tag eq 'null'}">
						        <div class=" me-2">
						            <br>
						        </div>
						  </c:if>              		 
					</c:forEach>
              </div>
            </div>
          </div>
        </div>
        </c:forEach>

        
      </div>
    </div>
  </div>

		
	</div>
		
	<!-- 페이징 -->
	 <nav aria-label="Page navigation example">
	  <ul class="pagination centeralign">
	    <c:if test="${paging.startPage != 1 }">
			<li class="page-item">
					<a class="page-link" aria-label="Previous" href="/galary/galaryList.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}&search_type=${searchType}&search_word=${searchWord}">
			        <span aria-hidden="true">&laquo;</span>
			      	</a>
			    </li>
		</c:if>
		<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
	<c:choose>
			<c:when test="${p == paging.nowPage }">
			<li class="page-item">
				<a class="page-link" href="/galary/galaryList.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}&search_type=${searchType}&search_word=${searchWord}"><b style="color:purple;">${p}</b></a>
			</li>
			</c:when>
			<c:when test="${p != paging.nowPage }">
			<li class="page-item">
				<a class="page-link" href="/galary/galaryList.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}&search_type=${searchType}&search_word=${searchWord}">${p}</a>
			</li>
		</c:when>
	</c:choose>
		</c:forEach>
		    <c:if test="${paging.endPage lt paging.lastPage}">
				<li class="page-item">
					<a class="page-link" href="/galary/galaryList.do?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}&search_type=${searchType}&search_word=${searchWord}"aria-label="Next">
						<span aria-hidden="true">&raquo;</span>
					</a>
				</li>
			</c:if>
		</ul>
	</nav> 

	
	</main>
	
	
</body>
<script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript">
	var category = "${category}";
	
	//post가기
	function gopost(){
		let galId =  event.target.id;
		console.log(galId);
		let cntperpage = "${cntPerPage}";
		let nowpage = "${paging.nowPage}";
		console.log(nowpage);
		let search_word = "${searchWord}";
		let search_type = "${searchType}";
		let category = "${category}";
		
		location.href="/galary/galaryPost.do?galary_id="+galId+"&category="+category+"&cntPerPage="+cntperpage+"&nowPage="+nowpage+"&search_type="+search_type+"&search_word="+search_word;
	}
	//category체인지
	function categoryChange(){
		let category = event.target;
		categoryval = category.value;
		
		let cntPerPage = "${cntPerPage}";
		 let searchType= "${searchType}";
		 let searchWord = "${searchWord}"
		 let nowPage = $("#nowpage").text();
		 
		console.log(categoryval);
		if(categoryval == 0){
			location.href="/galary/galaryList.do?cntPerPage="+cntPerPage+"&nowPage="+1;	
		}else{
			location.href="/galary/galaryList.do?cntPerPage="+cntPerPage+"&nowPage="+1+"&category="+categoryval;			
		}
		
	}
	
	
	//카테고리유지
	var Categories = document.getElementsByClassName('categories');
	
	if(category == null || category == 0 ){
		$('.categories[value="0"]').addClass('bold');
	}else{
		for (let i = 0; i < Categories.length; i++) {
		  if (Categories[i].getAttribute('value') === category) {
			  Categories[i].classList.add('bold');
		  }
		}
	}
	//cntperpage유지
	let selected = ${paging.cntPerPage};
	console.log(selected);
	$("#perpagechoose").val(selected).prop("selected", true);
	
	//글삭
	$(".delbtn").on("click", function(){
		console.log(this);
		console.log(this.value);
		let galid = this.value;
		
		location.href="/galary/delGalaryPost.do?galary_id="+galid;
	});
	//몇개씩 보기
	$("#perPageBtn").on("click", function(){
		 let perPage = $("select[name='perPage'] option:selected").val();
		 console.log(perPage);
		 
	
		 let searchType= "${searchType}";
		 let searchWord = "${searchWord}"
		 let nowPage = $("#nowpage").text();
		 location.href="/galary/galaryList.do?cntPerPage="+perPage+"&nowPage="+1+"&search_type="+searchType+"&search_word="+searchWord+"&category="+category;
	})

	//검색어 유지
	let searchType = "${searchType}";
	let searchWord = "${searchWord}";
	if(searchType != ""){
		$("#searchTypeSelect").val(searchType).prop("selected", true);	
	}
	$("#search_word").val(searchWord);

	//검색창 검색
	$("#searchBtn").on("click", function(){
			 let search_type = $("select[name='search_type'] option:selected").val();
				console.log(search_type);
				let search_word = $("#search_word").val();
				console.log(search_word);
				let cntPerPage = "${cntPerPage}";
			location.href="/galary/galaryList.do?search_type="+search_type+"&search_word="+search_word+"&cntPerPage="+cntPerPage+"&category="+category;
		})

	//태그 검색 ㅎㅎ
	$('.tagStyle').on("click", function(){
		console.log(this);
		let tagName = this.id;
		console.log(tagName);
		let search_type= "tag_name";
		let search_word = tagName;
		let cntPerPage = "${cntPerPage}";
		
		
		location.href="/galary/galaryList.do?search_type="+search_type+"&search_word="+search_word+"&cntPerPage="+cntPerPage+"&category="+category;
		
	})
	
	
</script>
</html>