<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<%=request.getContextPath()%>/css/egovframework/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>
		.table{
			text-align : center;
			margin-top : 10px;
			margin-bottom : 30px !important;
		}
		
		#bodydiv{
			width : 1000px;
			margin : 50px auto;
		}
		.galSearchDiv{
			display: flex;
			margin-top : 10px;
			margin-bottom : 30px !important;
			cursor : pointer;
		}
		a{
			display : block;
		}
		td{
			cursor: pointer;
		}
</style>
</head>
<body>
<%
	Integer brdnum = 1;
	Integer serveynum = 1;

	
%> 
		<div id="bodydiv">
			<c:if test="${empty menu}">
				<h2 style="text-align : center">검색 결과가 없습니다</h2>
			</c:if>
		
		<c:forEach var="m" items="${menu}">
			<c:set var="brdnum" value="1" />
			<c:choose>
				<c:when test="${m.m_category_name == '게시판' }">
					<h3>${m.menu_name}</h3>
					<table class="table table-striped table-hover">
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="l" items="${list}">
						 	 	 <c:if test="${m.menu_id == l.menu_id}">
						 	 	 	<input type="hidden" id="${l.menu_id}">
						 	 	 	<tr id="${l.board_id}" onclick="goboardPost(this)" class="pointer">
						 	 	 		<td>${brdnum}</td>
						 	 	 		<td>${l.title}</td>
						 	 	 		<td>${l.writer}</td>
						 	 	 	</tr>
						 	 	 	  <c:set var="brdnum" value="${brdnum+1}" />
						 	 	 </c:if>
				   			</c:forEach>
			   			</tbody>
		   			</table>
		   			<a href="/board/boardList.do?search_type=${searchtype}&search_word=${searchword}&menu_id=${m.menu_id}" style="float:right">더보기</a>
		   		</c:when>
		   		
		   		<c:when test="${m.m_category_name == '갤러리' }">
		   			<h3>${m.menu_name}</h3>
		   			<div class="galSearchDiv">
			   			<c:forEach var="l" items="${list}">
					 	 	 <c:if test="${m.menu_id == l.menu_id}">
					 	 	 	<div class="col firstdiv"  >
					 	 	 	<input type="hidden" id="${l.menu_id}">
						          <div class="card shadow-sm"  id="${l.galary_id}" onclick="goGalaryPost(this)">
						            <img class="bd-placeholder-img card-img-top" width="100%" height="225" src="/resize/${l.file_route}" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false"
						             id="${l.galary_id}"></img>
						
						            <div class="card-body" >
						              <p class="card-text" id="${l.galary_id}">${l.title}</p>
						            	<p class="card-text" id="${l.galary_id}">${l.writername}</p>
						            </div>
						          </div>
						        </div>
					 	 	 </c:if>
			   			</c:forEach>
		   			</div>
		   			<a href="/galary/galaryList.do?search_type=${searchtype}&search_word=${searchword}&menu_id=${m.menu_id}" style="float:right">더보기</a>
	   			</c:when>
	   			
	   			<c:when test="${m.m_category_name == '설문조사' }">
	   				<h3>${m.menu_name}</h3>
	   				<table class="table table-striped table-hover">
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="l" items="${list}">
						 	 	 <c:if test="${m.menu_id == l.menu_id}">
						 	 	 	<input type="hidden" id="${l.menu_id}">
						 	 	 	<tr id="${l.servey_id}" onclick="goServey()" class="pointer">
						 	 	 		<td><%=serveynum++%></td>
						 	 	 		<td>${l.title}</td>
						 	 	 		<td>${l.writername}</td>
						 	 	 	</tr>
						 	 	 </c:if>
				   			</c:forEach>
			   			</tbody>
		   			</table>
	   			</c:when>
		  	 </c:choose>
		</c:forEach>
		</div>
</body>
<script>
  
  function goServey(){
	  location.href="/survey/sureveyInfo.do";
  }
  function goboardPost(e){
	  bid= e.id;
	  console.log(bid);
	  menuid = e.previousElementSibling.id;
	  console.log(menuid);
	 location.href="/board/boardPost.do?board_id="+bid+"&menu_id="+menuid;
  }
  
  function goGalaryPost(e){
	  console.log(e.id);
	  galid = e.id;
	  menuid = e.previousElementSibling.id;
	  location.href="/galary/galaryPost.do?galary_id="+galid+"&menu_id="+menuid;
  }
  
  var searchtype= "${searchtype}";
  var searchword = "${searchword}";
  
  if(searchtype != ""){
		$("#searchTypeSelect").val(searchtype).prop("selected", true);	
	}
	$("#srchfrm").val(searchword);
</script>
</html>