<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<!DOCTYPE html>
<html>
<style>
	tr{
		cursor : pointer;
	}
	main{
		width : 1200px;
		margin : 0 auto;
	}
	
	h1{
		margin : 30px 0 !important;
	}
	#makeSurveyBtn{
		float : right;
	}
	table{
		margin : 15px 0 !important;
	}
	
</style>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<title>설문조사</title>
</head>
<body>
<main>
	<div class="container-fluid px-4">
		<div id="title" class="d-flex justify-content-between">
			<h1 class="mt-4" onclick="location.href='/survey/surveyListForUser.do'">설문조사</h1>
		</div>
		<div class="mb-4">

			<div class="mb-4">
			<div >
				<table class="table table-hover table-striped" >
					<thead>
						<tr>
							<th>글번호</th>
							<th>제목</th>
							<th>시작일</th>
							<th>종료일</th>
							<th>대상</th>
						</tr>
					</thead>
					<tbody>
						<c:if test = "${not empty list}">
						<c:forEach items="${list}" var="l" varStatus="idx">
							<tr id=${l.servey_id} onclick="goinfo(this)">
								<td>${idx.count}</td>
								<td>${l.title}</td>
								<td>${l.start_date}</td>
								<td>${l.end_date}</td>
								<td>
									<c:choose>
						                <c:when test="${l.servey_target eq 'users'}">
						                	전체 회원	
						 				</c:when>
						 				<c:otherwise>
											${l.servey_target }
										</c:otherwise>
									</c:choose> 
								</td>		
							</tr>
						</c:forEach>
						</c:if>
						<c:if test = "${empty list}">
							<tr>
								<td colspan="5" style="text-align:center;">설문조사가 없습니다</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
			</div>
		</div>
		
		</div>
		
	</main>	
</body>
<script>
	function goinfo(e){
		let id = e.id;
		location.href= "/survey/sureveyInfo.do?servey_id="+id;
	}
</script>
</html>