<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 타일즈 사용하기 위해 -->
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous"></head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<Style>
	.navbar22{
		background-color : skyblue;
		padding : 10px 0;
	}
	.navbar22>ul{
		list-style : none;
		margin : 0px;
	}
	.navbar22>ul>li{
		display : inline-block;
		margin-right : 100px;
		cursor : pointer;
	}
	img{
		cursor : pointer;	
	}
</Style>
<body>

	<div  class="d-flex  justify-content-between align-items-center" style="padding : 0 10%">
		<img src="<%=request.getContextPath()%>/images/fusionsoftLogo.png" style="width: 300px;" onclick="location.href='/user/main.do'">
		<div class="d-flex">
		<select name="search_type" class="form-select" style="width:100px; margin-right : 5px" id="searchTypeSelect">
			<option value="writer">작성자</option>
			<option value="title">제목</option>
			<option value="content">내용</option>
			<option value="whole" selected>전체</option>
		</select>
	 	<input type="text"  class="form-control" id="srchfrm" style="width: 500px">
	 	<button type="button" class="btn btn-primary" onclick="seartchAll()">검색</button>
	 	</div>
	 	<c:if test="${empty sessionScope.auth}">
	 		<button type="button" class="btn btn-primary"  onclick="location.href='/user/loginfrm.do'" >로그인</button>
		</c:if>
		<c:if test="${not empty sessionScope.auth}">
			<div class="gap-2">
			<span>${sessionScope.name}님🤍</span>
			<button type="button" class="btn btn-primary" onclick="location.href='/user/logout.do'">로그아웃</button>
			</div>
		</c:if>
	</div>
	
	 <div class="navbar22">
		<ul>
		    <c:forEach var="menu" items="${menulists}">
			    <li onclick="gopage(this)" id=${menu.menu_id}>${menu.menu_name}</li>
		    </c:forEach>
		</ul>
	</div>
</body>
<script>
	//전체검색
	function seartchAll(){
		let search_type = $("select[name='search_type'] option:selected").val();
		console.log(search_type);
		let search_word = $("#srchfrm").val();
		console.log(search_type + search_word);
		location.href="/menu/searchAll.do?search_type="+search_type+"&search_word="+search_word;
	}
	function gopage(a){
		
		let mid = a.id;
		location.href="/menu/moveMenu.do?menu_id="+mid;
	}
</script>	 
</html>
