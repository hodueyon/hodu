<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
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
<title>관리자페이지</title>
</head>
<body>
	<main>
	<h1>설문조사 관리자 페이지</h1>
	
	<!-- 생성 버튼 만들기 -->
	
		<button type="button" onclick="goInputFrm()" class="btn btn-primary" id="makeSurveyBtn">만들기</button>	
	
	
	<table class="table table-hover">
		<thead>
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>시작일</th>
				<th>종료일</th>
				<th>대상</th>
				<th></th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="l" varStatus="idx">
				<tr>
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
								${l.servey_target}
							</c:otherwise>
						</c:choose> 
					</td>
					<td><button type="button" class="btn btn-outline-secondary" onclick="delServey(this)" value="${l.servey_id}">❌</button></td>
					<td><button type="button" class="btn btn-outline-secondary" value="${l.servey_id}" onclick="goEdit(this)">수정</button></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	</main>
</body>
<script>
	function goInputFrm(){
		
		location.href= "/survey/surveyInputFrm.do";
		
	}
	
	function delServey(e){
		let survey_id = e.value;
		
		if(! confirm("삭제하시겠습니까?")){
			return;
		}
		$.ajax({
			  url: '/survey/delsurvey.do',
			  type: 'POST',
			  data: { survey_id: survey_id },
			  success: function(response) {
			    alert("삭제 되었습니다!");
			    location.reload();
			  },
			  error: function(xhr, status, error) {
			    console.log(error);
			  }
			});
	}
	
	function goEdit(e){
		let survey_id = e.value;

		$.ajax({
			  url: '/survey/ckBeforeEdit.do',
			  type: 'POST',
			  data: { survey_id: survey_id },
			  success: function(result) {
			    	if(result == 'true'){
			    		location.href = "/survey/editSurveyFrm.do?survey_id="+survey_id;
			    	}else{
			    		alert("제출된 답변이 있어 수정이 불가능 합니다!");
			    	}
			  },
			  error: function(xhr, status, error) {
			    console.log(error);
			  }
			});
	}
</script>
</html>