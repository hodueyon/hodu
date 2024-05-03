<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	.page{
		padding: 3% 2%;
		margin-top : 3%;
	}
	td{
		text-align : center;
	}
	th{
		text-align : center !important;	
	}
	.turns{
		cursor : pointer;
	}
</style>
<meta charset="UTF-8">
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<title>설문조사 Info</title>
<link href="<%=request.getContextPath()%>/css/egovframework/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<div class="border  border-1 rounded mx-auto page" style="width:70%">
		<p>퓨전소프트 회원분들을 대상으로 만족도 조사를 진행합니다.</p>
		<p>응답하신 내용은 통게법 33조(비밀의 보호)에 의거 비밀이 보장되며, 서비스 개선을 위한 자료 외에 어떠한 목적으로도
		사용되지 않음을 약속드립니다. 많은 참여 부탁드리며, 앞으로도 교육정책 및 교육과정 정보를 보다 빠르게 활용하실 수 있도록 더욱 노력하겠습니다.</p>
		<ul>
			<li>조사주관 : ${surveyInfo.writer}</li>
			<li>참여대상 :
				<c:choose>
	                <c:when test="${surveyInfo.servey_target eq 'users'}">
	                	전체 회원	
	 				</c:when>
	 				<c:otherwise>
						${surveyInfo.servey_target }
					</c:otherwise>
				</c:choose> 
			</li>
			<li>참여기간 : '			
				${fn:substring(surveyInfo.start_date, 2, 10)} (${surveyInfo.startday})' ~ '${fn:substring(surveyInfo.end_date, 2, 10)}(${surveyInfo.endday})', 총 ${surveyInfo.surveydays}일간 
			</li>
			<li>참여방법 : 하단의 설문시작 버튼을 클릭하여 총 ${cnt}개의 문항에 답변을 마치면 응모완료</li>
			<li>당첨자 발표 : ${fn:substring(surveyInfo.announce_date, 2, 10)}(${surveyInfo.announceday}), 퓨전소프트 공지사항 게시판</li>
		</ul>
		<p>🚨 유의사항</p>
		<ul>
			<li>당첨자 선정은 응답 내용의 성실성 등을 고려하여 선정됩니다.</li>
			<li>1인  '${surveyInfo.participate_cnt}'회에 한하여 참여가능 합니다.</li>
		</ul>
		
		<div class= "d-flex justify-content-center">
				<button type="button"  class="btn btn-primary me-1" onclick="goAnswerPage()">설문조사하기</button>
				<button type="button" class="btn btn-success me-1" onclick="location.href='/survey/surveyListForUser.do'">목록으로</button>
		</div>
		
		<c:if test="${not empty myanswers}">
			<div style="margin-top : 10px;">
				<h5 style="text-align : center">나의 설문조사 답변 목록</h5>
				<p style="text-align : center">수정 하시려면 해당 회차를 클릭해 주세요 </p>
				<table class="table table-hover">
					<tr>
						<th>답변 목록</th>
						<th>완료 여부</th>
					</tr>
					<c:forEach items="${myanswers}" var="my">
						<tr onclick="goeditpage(this)" id="${my.participate_num}">
							<td class="turns" >${my.participate_num} 회</td>
							<td class="completeyn">
								<c:if test="${my.temp_yn eq 'n'}">
									완료
								</c:if>
								<c:if test="${my.temp_yn eq 'y'}">
									미완료	
								</c:if>
							</td>
						</tr>	
					</c:forEach>
				</table>
			</div>
		</c:if>
	</div>


</body>
<script>
	var surveyid = ${surveyInfo.servey_id};
	var StartDate = "${surveyInfo.start_date}";
	var   endDate =  "${surveyInfo.end_date}";
	
	var todayDate = new Date(); 
	let year = todayDate.getFullYear();
	let month = ("0"+(1+ todayDate.getMonth())).slice(-2);
	let day =  ("0" + todayDate.getDate()).slice(-2);
	
	let today= year + "-" + month + "-" + day;
	
	console.log(endDate);
	
	//수정페이지 이동
	function goeditpage(td){
		console.log($(td));
		let participate_num = $(td).attr('id');
/* 		 if(StartDate > today){
				alert("아직 설문조사 시작 전입니다.");
				return false;
		}
		if(endDate < today){
			alert("설문조사가 이미 종료되었으므로 수정이 불가능합니다.");
			return false;	
		}  */
		location.href="/survey/myAnswerEdit.do?survey_id="+surveyid+"&participate_num="+participate_num;
	}
	
	//설문조사하러가는거
	function goAnswerPage(){
	/* 	if(StartDate > today){
			alert("아직 설문조사 시작 전입니다.");
			return false;
		}
		if(endDate < today){
			alert("설문조사가 이미 종료되었으므로 참여가 불가능합니다.");
			return false;	
		} */
	/* 	if ($('.completeyn').length) {
			$('.completeyn').each(function(){
				let completeyn= $(this).text();
				console.log(completeyn);
				
				if(completeyn.includes('미완료')){
					alert("미완료된 설문이 있습니다.\n해당 설문을 완료한 후 새로운 답변을 작성해주세요");
					return false;
				}
			})
		} */
		location.href="/survey/questionList.do?survey_id="+surveyid;
		
	}	
</script>
</html>