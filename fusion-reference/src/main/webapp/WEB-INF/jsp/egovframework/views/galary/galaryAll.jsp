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
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.anychart.com/releases/v8/js/anychart-base.min.js"></script>
<script src="https://cdn.anychart.com/releases/v8/js/anychart-tag-cloud.min.js"></script>
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
	#rank{
		width :500px;
		padding : 48px 20px;
	}
	.album{
		flex-grow : 1;
		
	}
	.tagranks{
		padding : 1px;
		background-color : rgb(238, 238, 238);
		cursor : pointer;
	}
	#cloudDiv{
		flex-grow : 1;
	}
	#exampleModal .form-select{
		width : 25%;
	}
	.thisNav{
		font-weight : bold;
	}
	.RankingDivTitle{
		font-size : 20px;
	}
	.rankTr{
		cursor : pointer;
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
<%-- 			<c:if test="${empty loginId}">
				<button type="button" class="btn btn-primary" onclick="location.href='/user/loginfrm.do'" class="btnss">로그인</button>
			</c:if>
			<c:if test="${not empty loginId}">
				<button type="button" class="btn btn-primary " onclick="location.href='/user/logout.do'" class="btnss">로그아웃</button>
			</c:if> --%>
		</div>
		<div class="card-header d-flex justify-content-between" id="searchelse">
				<div class="d-flex ">
				<select name="search_type" class="form-select" style="width:100px; margin-right : 5px" id="searchTypeSelect2">
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
					<a class="btn btn-primary float-end" href="/galary/galaryInputFrm.do?menu_id=${menu_id}" id="writebtn" >
						<i class="fas fa-edit"></i> 글 작성
					</a>
				</c:if>
		<!-- 		<a class="btn btn-primary float-end" href="/user/main.do" id="writebtn" >
						<i class="fas fa-edit"></i>메뉴
				</a> -->
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

<!--갤러리 반띵 나누기 -->
<div class="d-flex">
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
           	 <div class="d-flex justify-content-between  align-items-center">
              	<p class="card-text" onclick="gopost()" id="${galary.galary_id}" style="margin : 0">${galary.title}</p>
                
                <c:if test="${auth <= 2 }">
	         		<button type="button" class="btn btn-outline-secondary manageBtn" data-bs-toggle="modal" data-bs-target="#exampleModal"  data-galid = "${galary.galary_id}">
					통계</button>
				</c:if>
              </div>
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
  
  <!-- 클라우드 -->
  <div class="chart-area" id="cloudDiv">
		<div id="container" style="width:80%; height:100%;"></div>
	</div>

	<!-- 인기글 div 두기 -->
	<input type="hidden" id="secretRankType">
	<div id="rank" class="bg-light">
		<div class="mb-2 RankingDivTitle">
			✔️ Ranking
		</div>
		<!-- 일간 주간 월간 -->
		<select class="form-control mb-2" id="rankWord">
			<option value="cnt">조회수</option>
			<option value="like">좋아요</option>
			<option value="down">다운로드 수</option>
		</select>
		<!-- 탭 -->
		<ul class="nav nav-tabs">
			  <li class="nav-item tabs" id="${tab.sub_id}">
			    <a class="nav-link active" aria-current="page" href="#" data-word="day">일간 랭킹</a>
			  </li>
			    <li class="nav-item tabs" id="${tab.sub_id}">
			    <a class="nav-link active" aria-current="page" href="#" data-word="week">주간 랭킹</a>
			  </li>
			    <li class="nav-item tabs" id="${tab.sub_id}">
			    <a class="nav-link active" aria-current="page" href="#"  data-word="month">월간 랭킹</a>
			  </li>
		</ul>
		
		<!-- 결과 -->
		<table class="table" id="ranktb">
			<c:if test="${not empty Ranks }">
			<c:forEach items="${Ranks}" var="r" varStatus="ranknum">
				<tr class="rankTr" id="${r.galary_id}">
					<td>${ranknum.count}</td>
					<td>${r.title}</td>
					<td>${r.cnt}</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${empty Ranks }">
				<tr>
					<td>조회된 게시글이 없습니다.</td>
				</tr>
			</c:if>
		</table>
		
		<!-- 태그 -->
		<div class="d-flex justify-content-between mb-2 align-items-center">
			<div class="RankingDivTitle">
				✔️ Tag
			</div>
			<select id="tagselect" class="form-select" style="width:150px">
				<option value="day">일간 랭킹</option>
				<option value="week">주간 랭킹</option>
				<option value="month">월간 랭킹</option>
			</select>
		</div>
		
		
		<!-- 태그랭킹 -->
		<div class="card" >
			<div class="card-body d-flex" id="tagdiv">
				<c:forEach items="${tagRank}" var="tr">
						<span class="me-2 tagranks" id="${tr.tag_name}">
							${tr.tag_name}
						</span>	
				</c:forEach>
				<c:if test="${empty tagRank }">
					<span>클릭된 태그가 없습니다.</span>
				</c:if>	
			</div>
		</div>
		
		<div class="d-flex justify-content-end mt-2">
			<button type="button" onclick="goTagCloud()" class="btn btn-outline-secondary">태그더보기</button>	
		</div>

	</div>
	
	
	
</div>
<!-- 갤러리 반띵 나누기 끝  -->			
</div>
		
	<!-- 페이징 -->
	 <nav aria-label="Page navigation example" id="pagingnav">
	  <ul class="pagination centeralign">
	    <c:if test="${paging.startPage != 1 }">
			<li class="page-item">
					<a class="page-link" aria-label="Previous" href="/galary/galaryList.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}&search_type=${searchType}&search_word=${searchWord}&menu_id=${menu_id}">
			        <span aria-hidden="true">&laquo;</span>
			      	</a>
			    </li>
		</c:if>
		<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
			<c:choose>
					<c:when test="${p == paging.nowPage }">
					<li class="page-item">
						<a class="page-link" href="/galary/galaryList.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}&search_type=${searchType}&search_word=${searchWord}&menu_id=${menu_id}"><b style="color:purple;">${p}</b></a>
					</li>
					</c:when>
					<c:when test="${p != paging.nowPage }">
					<li class="page-item">
						<a class="page-link" href="/galary/galaryList.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}&search_type=${searchType}&search_word=${searchWord}&menu_id=${menu_id}">${p}</a>
					</li>
				</c:when>
			</c:choose>
		</c:forEach>
		    <c:if test="${paging.endPage lt paging.lastPage}">
				<li class="page-item">
					<a class="page-link" href="/galary/galaryList.do?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}&search_type=${searchType}&search_word=${searchWord}&menu_id=${menu_id}"aria-label="Next">
						<span aria-hidden="true">&raquo;</span>
					</a>
				</li>
			</c:if>
		</ul>
	</nav> 

	
	</main>
	
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">게시글 통계</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      		<div class="card widthclass">
					<div class="card-body">
						<div class="d-flex justify-content-center gap-1">
							<select id="tagSelect"  class="typeSelect form-select">
								<option value="day">일</option>
								<option value="week">주</option>
								<option value="month">월</option>
							</select>
							<select id="tagyearselect"  class="form-select">
								<option>2021</option>
								<option>2022</option>
								<option>2023</option>	
							</select>
							<select id="tagmonthselect" class="monthSelect form-select">
								<option class="timedayop" value="0">ALL</option>
								<c:forEach var="i" begin="1" end="12" step="1">
									<option  class="timedayop" value="${i}">${i}월</option>
								</c:forEach>	
							</select>
							<button type="button" class="btn btn-outline-secondary" id="btn4">조회</button>
						</div>
						<input type="hidden" id="secretgalId">
			  			<canvas id="cntchart"></canvas>
			  			<canvas id="likechart"></canvas>
					</div>
				</div>	
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	
</body>
<script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript">
	var category = "${category}";
	var menuid= ${menu_id}
	
	$('#cloudDiv').hide();
	$('#secretRankType').val("day");
	$('.nav-link:first').addClass('thisNav');

	
    function createDataset(data, label, color) {
        return {
          label: label,
          data: data,
          backgroundColor: color,
          borderColor: color,
          borderWidth: 1,
          fill: false,
          type: 'line'
        };
      }
    
	//빈차트 만들기
	
  	var dataset = createDataset(null, 'Data', 'rgba(54, 162, 235, 0.8)');


      // 차트 설정
      var chartOptions = {
        responsive: true,
        scales: {
          x: {
            grid: {
              display: false
            }
          },
          y: {
            beginAtZero: true,
            grid: {
              drawBorder: false
            },
            ticks: {
              stepSize: 5
            }
          }
        },
        plugins: {
            title: {
              display: true,
              text: '', // 차트 제목 설정
              font: {
                size: 16
              }
            }
          }
      };

      const cntchart = document.getElementById('cntchart');
      // 차트 생성
      const cntchart1 = new Chart(cntchart, {
        type: 'line',
        data: {
        	labels: [],
        	datasets: [{
        	label: '',
        	data: [],
        	borderWidth: 1
        	}]
       	},
        options: chartOptions
      });
      const likechart = document.getElementById('likechart');
      // 차트 생성
      const likechart1 = new Chart(likechart, {
        type: 'line',
        data: {
        	labels: [],
        	datasets: [{
        	label: '',
        	data: [],
        	borderWidth: 1
        	}]
       	},
        options: chartOptions
      });
	      
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
		
		location.href="/galary/galaryPost.do?galary_id="+galId+"&category="+category+"&cntPerPage="+cntperpage+"&nowPage="+nowpage+"&search_type="+search_type+"&search_word="+search_word+"&menu_id="+menuid;
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
			location.href="/galary/galaryList.do?cntPerPage="+cntPerPage+"&nowPage="+1+"&menu_id="+menuid;	
		}else{
			location.href="/galary/galaryList.do?cntPerPage="+cntPerPage+"&nowPage="+1+"&category="+categoryval+"&menu_id="+menuid;			
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
		 location.href="/galary/galaryList.do?cntPerPage="+perPage+"&nowPage="+1+"&search_type="+searchType+"&search_word="+searchWord+"&category="+category+"&menu_id="+menuid;
	})

	//검색어 유지
	let searchType = "${searchType}";
	let searchWord = "${searchWord}";
	
	if(searchType !== ""){
		console.log(searchType);
		$("#searchTypeSelect2").val(searchType).prop("selected", true);	
	}
	
	$("#search_word").val(searchWord);

	//검색창 검색
	$("#searchBtn").on("click", function(){
			 let search_type = $('#searchTypeSelect2').val();
				 //$("select[name='search_type'] option:selected").val();
				console.log(search_type);
				let search_word = $("#search_word").val();
				console.log(search_word);
				let cntPerPage = "${cntPerPage}";
			location.href="/galary/galaryList.do?search_type="+search_type+"&search_word="+search_word+"&cntPerPage="+cntPerPage+"&category="+category+"&menu_id="+menuid;
		})

	//태그 검색 ㅎㅎ
	$('.tagStyle').on("click", function(){
		let data = {};
		console.log(this);
		let tagName = this.id;
		console.log(tagName);
		let search_type= "tag_name";
		let search_word = tagName;
		let cntPerPage = "${cntPerPage}";
		
		data.tag_name = tagName;
		
		//태그 클릭 기록 넣기
		$.ajax({
		url : '/galary/insTagsClickRcd.do',
		method : 'POST',
		data : JSON.stringify(data),
		contentType : 'application/json',
  		success: function(result) {
  			location.href="/galary/galaryList.do?search_type="+search_type+"&search_word="+search_word+"&cntPerPage="+cntPerPage+"&category="+category+"&menu_id="+menuid;

           },
           error: function(xhr, status, error) {
               console.log(error);
           }
		})
		
	})
	
	//랭킹페이지이동
	$('.rankTr').on('click', function(){
		let cntperpage = "${cntPerPage}";
		let nowpage = "${paging.nowPage}";
		let search_word = "${searchWord}";
		let search_type = "${searchType}";
		let category = "${category}";
		let galId = $(this).attr('id');
		
		location.href="/galary/galaryPost.do?galary_id="+galId+"&category="+category+"&cntPerPage="+cntperpage+"&nowPage="+nowpage+"&search_type="+search_type+"&search_word="+search_word+"&menu_id="+menuid;
	})
	
	//랭킹 변경
	$('.nav-link').on('click', function(){
		let data ={};
		let rankType = $(this).data('word');
		let rankword = $('#rankWord').val();
		data.menu_id = menuid;
		data.rankType = rankType;
		data.rankword = rankword;
		if(category != 0){
			data.category = category;
		}
		
		$.ajax({
			url : '/galary/getRankData.do',
			method : 'POST',
			data : JSON.stringify(data),
			contentType : 'application/json',
	  		success: function(result) {
				console.log(result);
				$('#ranktb tr').remove();
				

				
			for (let i = 0; i < result.length; i++) {
				  let galaryId = result[i].galary_id;
				  let column1Value = (i+1);
				  let title = result[i].title;
				  let cnt = result[i].cnt;

				  const tr = $('<tr>', {
				    class: 'rankTr',
				    id: galaryId
				  });

				  let td1 = $('<td>').text(column1Value);
				  let td2 = $('<td>').text(title);
				  let td3 = $('<td>').text(cnt);

				  tr.append(td1, td2, td3);

				  $('#ranktb').append(tr);
				  
				}
			
				if(result.length <=0){
					const tr = $('<tr>')
				  let td1 = $('<td>').text(rankword+"의 기록이 없습니다.");
				  tr.append(td1);

				  $('#ranktb').append(tr);
				}
				
				$('.rankTr').on('click', function(){
					let cntperpage = "${cntPerPage}";
					let nowpage = "${paging.nowPage}";
					let search_word = "${searchWord}";
					let search_type = "${searchType}";
					let category = "${category}";
					let galId = $(this).attr('id');
					
					location.href="/galary/galaryPost.do?galary_id="+galId+"&category="+category+"&cntPerPage="+cntperpage+"&nowPage="+nowpage+"&search_type="+search_type+"&search_word="+search_word+"&menu_id="+menuid;
				})
				
				
				$('.nav-link').each(function(){

					if($(this).data('word') == rankType){
  						$(this).addClass('thisNav');
  					}else{
  						$(this).removeClass('thisNav')
  					}
  				})
  				
  				$('#secretRankType').val(rankType);
				console.log($('#secretRankType').val());

			
            },
            error: function(xhr, status, error) {
                console.log(error);
            }
		})
	})
	
		//select창으로 랭킹바꾸기
	$('#rankWord').on('change', function(){
		let data ={};
		let rankType = $('#secretRankType').val();
		let rankword = $('#rankWord').val();
		data.menu_id = menuid;
		data.rankType = rankType;
		data.rankword = rankword;
		if(category != 0){
			data.category = category;
		}
		
		$.ajax({
			url : '/galary/getRankData.do',
			method : 'POST',
			data : JSON.stringify(data),
			contentType : 'application/json',
	  		success: function(result) {
				console.log(result);
				$('#ranktb tr').remove();
				

				
			for (let i = 0; i < result.length; i++) {
				  let galaryId = result[i].galary_id;
				  let column1Value = (i+1);
				  let title = result[i].title;
				  let cnt = result[i].cnt;

				  const tr = $('<tr>', {
				    class: 'rankTr',
				    id: galaryId
				  });

				  let td1 = $('<td>').text(column1Value);
				  let td2 = $('<td>').text(title);
				  let td3 = $('<td>').text(cnt);

				  tr.append(td1, td2, td3);

				  $('#ranktb').append(tr);
				  
				}
			
				if(result.length <=0){
					const tr = $('<tr>')
				  let td1 = $('<td>').text(rankword+"의 기록이 없습니다.");
				  tr.append(td1);

				  $('#ranktb').append(tr);
				}
				
				$('.rankTr').on('click', function(){
					let cntperpage = "${cntPerPage}";
					let nowpage = "${paging.nowPage}";
					let search_word = "${searchWord}";
					let search_type = "${searchType}";
					let category = "${category}";
					let galId = $(this).attr('id');
					
					location.href="/galary/galaryPost.do?galary_id="+galId+"&category="+category+"&cntPerPage="+cntperpage+"&nowPage="+nowpage+"&search_type="+search_type+"&search_word="+search_word+"&menu_id="+menuid;
				})
				
				
				$('.nav-link').each(function(){

					if($(this).data('word') == rankType){
  						$(this).addClass('thisNav');
  					}else{
  						$(this).removeClass('thisNav')
  					}
  				})
  				
  				$('#secretRankType').val(rankType);
				console.log($('#secretRankType').val());

			
            },
            error: function(xhr, status, error) {
                console.log(error);
            }
		})
		
	})
	
	
	//태그 랭킹, 태그 검색
	$('.tagranks').on('click', function(){
		
		let tagName = $(this).attr('id');
		let search_type= "tag_name";
		let search_word = tagName;
		let cntPerPage = "${cntPerPage}";
		
		location.href="/galary/galaryList.do?search_type="+search_type+"&search_word="+search_word+"&cntPerPage="+cntPerPage+"&category="+category+"&menu_id="+menuid;

	})
	
	//태그 랭킹바꾸기
	$('#tagselect').on('change', function(){
		let rankType = $(this).val();
		console.log(rankType);
		let data = {};
		data.rankType = rankType;
		$.ajax({
			url : '/galary/chageTagRank.do',
			type : 'POST',
			data : JSON.stringify(data),
			contentType : 'application/json',
			success: function(result){
				var tagdiv = $('#tagdiv');
				
				tagdiv.empty();
				
		        for (var i = 0; i < result.length; i++) {
		            var tag = result[i].tag_name;
		            var tagSpan = $('<span></span>')
		                .addClass('me-2 tagranks')
		                .attr('id', tag)
		                .text(tag);

	            tagdiv.append(tagSpan);
		        }
		        
		        $('.tagranks').on('click', function(){
		    		let tagName = $(this).attr('id');
		    		let search_type= "tag_name";
		    		let search_word = tagName;
		    		let cntPerPage = "${cntPerPage}";
		    		
		    		location.href="/galary/galaryList.do?search_type="+search_type+"&search_word="+search_word+"&cntPerPage="+cntPerPage+"&category="+category+"&menu_id="+menuid;

		    	})

		        $('#tagselect').val(rankType);
			},
			error: function(xhr, status, error) {
                console.log(error);
            }
		})
		
	})
	

	//태그 클라우드
	function goTagCloud(){
		//location.href="/galary/goTagCloud.do";
		 let cloudShow = $("#cloudDiv").is(":visible");

		 if(cloudShow){
			 $('#cloudDiv').hide();
				$('.album').show();
				$('#pagingnav').show();	
		 }else{
			 $('#cloudDiv').show();
				$('.album').hide();
				$('#pagingnav').hide();	
		 }
		
	}
	
	//태그 클라우드
	anychart.onDocumentReady(function () {
	    var data = [];
	    $.ajax({
	        url: '/galary/getTagCloudData.do',
	        type: 'GET',
	        contentType: 'application/json',
	        success: function(result) {
	            data = result;
	
	            // 태그 클라우드 차트 생성
	            var chart = anychart.tagCloud(data);
	            chart.angles([0]);
	            chart.container("container");
	

	            chart.normal().fontSize([10, 40]);


	            chart.mode("rectangular");
	
	            chart.colorRange().enabled(false);
	
	            chart.draw();
				
	            chart.listen("pointClick", function(e) {
	              var clickedWord = e.point.get("x");
	              handleWordClick(clickedWord);
	            });

	            // 클릭한 단어 처리 함수
	            function handleWordClick(word) {
	            	let search_type= "tag_name";
	        		let search_word = word;
	        		let cntPerPage = "${cntPerPage}";

	        		location.href="/galary/galaryList.do?search_type="+search_type+"&search_word="+search_word+"&cntPerPage="+cntPerPage+"&category="+category+"&menu_id="+menuid;

	            }
	        },
	        error: function(xhr, status, error) {
	            console.log(error);
	        }
	    });
	});
	
	//modal
	$('.manageBtn').click(function(e) {

	    e.preventDefault();
	    
	    let obj = {};

	   let galid = $(this).data('galid');
		obj.galary_id = galid;
	    obj.menu_id = menuid;

	    $.ajax({
	        url: "/galary/modalStats.do",
	        data: JSON.stringify(obj),
	        type: 'POST',
	        contentType: 'application/json',
	        success: function(result) {
	        	let cntarr = result.cnt;
              	let likearr = result.like;

              	let cntdata = [];
              	let cntlabel = [];
              	let likedata = [];
              	let likelabel = [];

              	for(let i=0; i<cntarr.length; i++){
              		cntdata.push(cntarr[i].cnt);
              		let label = cntarr[i].month + "월"
              		cntlabel.push(label);
              	}
              	
              	let title1 = cntarr[0].year + '년 조회수 추이';
              	
              	cntchart1.data.labels = cntlabel; 
              	cntchart1.data.datasets[0].data = cntdata;
              	cntchart1.options.plugins.title.text = title1;
              	cntchart1.data.datasets[0].label = "조회수";

              	cntchart1.update();
                  
                 for(let i=0; i<likearr.length; i++){
                  	likedata.push(likearr[i].cnt);
              		let label = likearr[i].month + "월"
              		likelabel.push(label);
              	}
                 
               let title2 = likearr[0].year + '년 좋아요 수 추이';
     		  	likechart1.data.labels = likelabel; 
	     		likechart1.data.datasets[0].data = likedata;
	     		likechart1.options.plugins.title.text = title2;
	     		likechart1.data.datasets[0].label = "좋아요 수";
	     		likechart1.update();
	     		
	     		//셀렉틑박스 값 고정
	     		let resultmonth = result.month;
	     		let resultyear = result.year;
	     		let resulttype = result.type;
	     		$('#tagSelect').val(resulttype);
	     		$('#tagyearselect').val(resultyear);
	     		$('#tagmonthselect').prop('disabled',true);
	     		$('#secretgalId').val(galid);
	     		//$('#tagmonthselect').val(resultyear);
	     		
	        },
	        error: function(xhr, status, error) {
	            console.log(error);
	        }
	    });
	    $('#exampleModal').modal("show");
	    
	});

	
    //select 비활성화 시키기
    $('.typeSelect').on('change', function(){
    	let val = $(this).val();
    	if(val == 'month'){
    		$(this).parent().find('.monthSelect').prop('disabled',true);
    		$('#tagmonthselect').find('option').each(function(){
    			if($(this).val() == 0){
    				$(this).show();
    			}
    		})
    		$('#tagmonthselect').val(0);

    	}
    	else{
    		$('#tagmonthselect').find('option').each(function(){
    			if($(this).val() == 0){
    				$(this).hide();
    			}
    		})
    		$('#tagmonthselect').val(1);
    		$(this).parent().find('.monthSelect').prop('disabled',false);
    	}
    	
    })
    
    
    //모달창 통계 바꾸기
    $('#btn4').on('click', function(){
    	 
	    let obj = {};

	   let galid = $('#secretgalId').val();
		obj.galary_id = galid;
	    obj.menu_id = menuid;
	    
	    let start_date;
    	let end_date;
		let year = $('#tagyearselect').val();
		let month = $('#tagmonthselect').val();
    	let chartype = $('#tagSelect').val();
    	
    	obj.chartype= chartype;
    	console.log(chartype);
    	if(chartype != 'month'){
    		start = new Date(year, month-1,1 );
    		let dayval = new Date(year, month-1, 0).getDate();
			end = new Date(year, month-1,dayval );   
	    	end_date = end.getFullYear() + '-' + ('0' + (end.getMonth() + 1)).slice(-2) + '-' + ('0' + end.getDate()).slice(-2);
	    	start_date = start.getFullYear() + '-' + ('0' + (start.getMonth()+ 1)).slice(-2) + '-' + ('0' + start.getDate()).slice(-2);
    	}else{
    		console.log("월");
    		start = new Date(year, 1,1 );
    		end = new Date(year, 11, 31);
    		end_date = end.getFullYear() + '-' + ('0' + (end.getMonth() + 1)).slice(-2) + '-' + ('0' + end.getDate()).slice(-2);
    		start_date = start.getFullYear() + '-' + ('0' + (start.getMonth())).slice(-2) + '-' + ('0' + start.getDate()).slice(-2);
    	}


    	console.log(start_date);
    	console.log(end_date);
    	obj.start_date = start_date;
    	obj.end_date = end_date;

	    $.ajax({
	        url: "/galary/modalStats.do",
	        data: JSON.stringify(obj),
	        type: 'POST',
	        contentType: 'application/json',
	        success: function(result) {
	     		//셀렉틑박스 값 고정
	     		let resultmonth = result.month;
	     		let resultyear = result.year;
	     		let resulttype = result.type;
	     		$('#tagSelect').val(resulttype);
	     		$('#tagyearselect').val(resultyear);
	     		
	     		$('#secretgalId').val(galid);
	     		
	     		
	        	let cntarr = result.cnt;
              	let likearr = result.like;
				let title;
              	let cntdata = [];
              	let cntlabel = [];
              	let likedata = [];
              	let likelabel = [];

            	if(chartype =='day'){
              		for(let i=0; i<cntarr.length; i++){
                  		cntdata.push(cntarr[i].cnt);
                  		let label = cntarr[i].month + "월" + cntarr[i].day + "일"
                  		cntlabel.push(label);
                  	}
                  	title = year + '년' + month + '월 일 별 조회수 추이';
                     
              	}
				
              	if(chartype =='week'){
              		for(let i=0; i<cntarr.length; i++){
                  		cntdata.push(cntarr[i].cnt);
                  		let label = month + "월" + (i+1) + "주"
                  		cntlabel.push(label);
                  	}
                  	title = year + '년'+month+ '월 주 별 조회수 추이';
              	}
              	
              	if(chartype =='month'){
              		for(let i=0; i<cntarr.length; i++){
                  		cntdata.push(cntarr[i].cnt);
                  		let label = cntarr[i].month + "월"
                  		cntlabel.push(label);
                  		$('#tagmonthselect').val(0);
                  		$('#tagmonthselect').prop('disabled',true);
                  	}
                  	title = cntarr[0].year + '년 월 별 조회수 추이';
              	}

              	cntchart1.data.labels = cntlabel; 
              	cntchart1.data.datasets[0].data = cntdata;
              	cntchart1.options.plugins.title.text = title;
              	cntchart1.data.datasets[0].label = "조회수";

              	cntchart1.update();
                  

                
               	if(result.type == 'day'){
              		for(let i=0; i<likearr.length; i++){
              			likedata.push(likearr[i].cnt);
                  		let label = likearr[i].month + "월" + likearr[i].day + "일"
                  		likelabel.push(label);
                  	}
              		$('#tagmonthselect').val(resultmonth);
                  	title = year + '년 ' + month + '월 일 별 좋아요수 추이';	
              	}
              	if(result.type =='week'){
              		for(let i=0; i<likearr.length; i++){
              			likedata.push(likearr[i].cnt);
                  		let label = month + "월" + (i+1) + "주"
                  		likelabel.push(label);
                  	}
              		$('#tagmonthselect').val(resultmonth);
                  	title = year + '년'+month+ '월 주 별 좋아요수 추이';	
              	}
              	if(result.type == 'month'){
                    for(let i=0; i<likearr.length; i++){
                      	likedata.push(likearr[i].cnt);
                  		let label = likearr[i].month + "월"
                  		likelabel.push(label);
                  		$('#tagmonthselect').prop('disabled',true);
                  	}
              		title = year + '년 월 별 좋아요수 추이';	
              	}

              	likechart1.data.labels = likelabel; 
	     		likechart1.data.datasets[0].data = likedata;
	     		likechart1.options.plugins.title.text = title;
	     		likechart1.data.datasets[0].label = "좋아요 수";
	     		likechart1.update();
	     		

	     		
	        },
	        error: function(xhr, status, error) {
	            console.log(error);
	        }
	    });	
    })
    
	
	
</script>
</html>