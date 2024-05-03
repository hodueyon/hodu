<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="<%=request.getContextPath()%>/css/egovframework/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>설문조사</title>
<style>
	.boldtxt{
		font-weight : bold;
	}
	.page{
		padding: 3% 2%;
	}
	.page > div{
		margin : 20px;
	}	
	.page > div> div{
		margin : 5px;
	}
	button {
	  display: inline-block ;
	}	
</style>
</head>
<body>
	<c:set var="count" value="0"/>
	<c:set var="page" value="1"  />
	<c:set var="pageClass" value="page1" />
	
	<c:set var="totalPage" value="${total%5}" />
	<c:if test="${totalPage gt 0}">
		<c:set var="totalpg" value="${total /5+1}"/>
	</c:if>
	<c:if test="${totalPage eq 0}">
		<c:set var="totalpg" value="${total/5}" />
	</c:if>
<%-- 	<c:out value="${totalPage}">${totalPage}</c:out><br>
	<c:out value="${totalpg}">${totalpg}</c:out>
	<c:out value="${total}">${total}</c:out> --%>
	<!-- pregressbar -->
	
	
	<div class="progress mx-auto"  style="width:70%">
	  <div class="progress-bar" role="progressbar"  aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
	</div>
	<div class="d-flex justify-content-end mx-auto" style="width:70%; margin : 5px 0">
			<button type="button" class="btn btn-primary me-1" onclick="gomain()">메뉴</button>
	    	<button type="button" class="btn btn-info" onclick="tempSave(this)">임시저장</button>
	  </div>
				
	<c:forEach var="q" items="${questions}" varStatus="status">
						
	        <c:if test="${count mod 5 eq 0}">
	            <c:set var="page" value="${count/5+1}"/>
	            <fmt:parseNumber var="percent" value="${page}" integerOnly="true" />
	            <div class="page ${percent}  border  border-1 rounded mx-auto"  id="qbox-${percent}" style="width:70%">
	            	
	        </c:if>
	        		
			        <div id="${q.question_id}" class="onequestions ${q.essential_yn}" >
			            <div>
			            	<input type="hidden" value="${q.max_choice_cnt}" id="maxcnt">
			                <c:if test="${q.question_num_child eq 0}">
			                    <span class='boldtxt'>문항 ${q.question_num}</span>
			                </c:if>
			                <c:if test="${q.question_num_child ne 0}">
			                    <span class='boldtxt'>${q.question_num}-${q.question_num_child}</span>
			                </c:if>
			                <c:if test="${not empty q.category_name}">
			                	<span class='boldtxt'>[ ${q.category_name} ]</span>
			                </c:if>
			                <span>${q.question_content}
			                	<c:if test="${q.max_choice_cnt gt 1}">
			                		<span>(${q.max_choice_cnt}개 선택)</span>
			                	</c:if>
			                	<c:if  test="${q.essential_yn eq 'n' && q.question_type ne 3}">
			                		<span style="color : blue;">선택 문항</span>
			                	</c:if>
			                </span>         
			            </div>
			            <c:set var="question_id" value="${q.question_id}" />
			            <div class="chkboxdiv" class="d-flex">
				            <c:forEach var="answer" items="${answers}">
				                <c:if test="${question_id eq answer.question_id &&answer.answer_type ne 2 }">
				                    <input type="checkbox" id="${answer.answer_type}" name="${answer.answer_id}" class="checks" value="${answer.answer_id}"><span>${answer.answer_content}</span>
	              					<c:if test="${answer.answer_type eq 3 }">
	              						  <!-- 기타 사항 입력칸 -->
							             <div class="etcinput" style="display:none">
							                 <input type="text" class="form-control" maxlength="200">
							             </div> 
	              					</c:if>
				                </c:if>
				                <c:if test="${question_id eq answer.question_id &&answer.answer_type eq 2}">
				                    <textarea id="${answer.answer_id}" class="form-control txtareaFrm" maxlength="200"></textarea>            
				                </c:if>
				            </c:forEach>
			          	</div>
			        </div>
			<c:if test="${q.question_type ne 3}">
	        	<c:set var="count" value="${count+1}"/>
	        </c:if>
	        <c:if test="${count mod 5 eq 0 or status.count eq fn:length(questions)}">
	            </div>
	        </c:if>
	</c:forEach>	
	<div class="d-flex justify-content-center mx-auto" style="margin : 5px 0">
	<button type="button" id="prevPage" onclick="goPrevPage()" class="btn btn-warning me-1" >이전</button>
	<button type="button" id="nextPage" onclick="goNextPage()" class="btn btn-warning me-1">다음</button>
	<button type="button" id="submitSurvey" onclick="submitSurvey()" class="btn btn-warning me-1">제출</button>
	</div>
</body>
<script>
	//설문조사 정보
	var surveyid = ${surveyInfo.servey_id};
	var StartDate = "${surveyInfo.start_date}";
	var endDate =  "${surveyInfo.end_date}";
	var tempyn = null;
	
	var todayDate = new Date(); 
	let year = todayDate.getFullYear();
	let month = ("0"+(1+ todayDate.getMonth())).slice(-2);
	let day =  ("0" + todayDate.getDate()).slice(-2);
	
	let today= year + "-" + month + "-" + day;
	
	console.log(StartDate + ' ~' + endDate + '~'+ today)
	
	//설문조사 번호 
	var surveyId = ${surveyId};
	var loginId = "${loginId}";
	var pcnt = ${pcnt};
	console.log(surveyId);
	console.log(loginId);
	
	//배열 - 데이터 전송용
	var data =[];
	//프로그레스바용 
	var total = ${total};
	var pgtotal = ${pgtotal};
	let finishcnt  = 0;
	
	let page = ${totalpg};
	var totalpage = Math.floor(page);

	var nowpage = 1;


	var dives = $('.onequestions');
	var target = $('.onequestions');
	
	//수정용데이터아작스로 불러오기 위한 것들
	var myanscnt = "${myanscnt}";
	

	console.log("myanscnt" + myanscnt);
	console.log("pcnt" + pcnt);
	
	$(document).ready(function() {
  		
  		// 처음 페이지는 보여줌
  		$('.page').hide();
  		$('.page.1').css("display", "block");
  		$('#paging').show();
	
  		$('#prevPage').css("display", "none");
  		
  		$('#prevPage').hide();
		$('#submitSurvey').hide();
		$("#nextPage").hide();
		checkInputNumber();
  		showBtns();
  		//showETC();
  		cntProgressCnt();
  		
  		//getMyAnswerRecord();
  		
  		if(${not empty myanscnt}){
  			getmyRecrdByAjax();
  		}


	});
	
	function gomain(){
		if(confirm("임시저장을 하지 않으면 설문조사 응답이 저장되지 않습니다.")){
			location.href='/user/main.do';
			}
		}
		
	//임시저장
	function tempSave(btn){
		console.log(btn);
		//console.log(btn.parentNode.parentNode);
		data = [];
		var chkboxcnt = $('.onequestions').find('input[type="checkbox"]:checked').length;
		var textarea = $('.onequestions').find('textarea');
		var textareacnt = 0;
		tempyn = 'y';
		
		textarea.each(function(){
			if ($(this).val().trim().length > 0) {
				textareacnt++;
			  }
		})
		
		var cnt = chkboxcnt+textareacnt;
		
		if(cnt <=0){
			alert(" 만약 하나 이상의 문항에 응답하지 않았다면, 임시저장이 불가능합니다");
			return false;
		}
		
		if(${not empty myanscnt}){
			console.log("수정임시저장");
			
			let myoldansinfo = {};
			myoldansinfo.user_id = loginId;
			myoldansinfo.survey_id = surveyId;
			myoldansinfo.participate_num = myanscnt;
			
			 $.ajax({
				url: '/survey/myAnswerEditInc.do',
				method: 'POST',
				data : JSON.stringify(myoldansinfo),
				contentType : 'application/json', 
				success: function (result) {
					if(result == "pass"){
						makeSubmitAnswer();
					}else{
						alert(result);
						location.href="/survey/sureveyInfo.do?servey_id="+surveyId;	
					}

				},
				error: function (error) {
					console.log(error);
					alert('실패');
				}
			}); 
		}else{
			console.log("신규임시저장");
			makeSubmitAnswer();	
		}

	}

	//체크수정용 아작스로 부르는거
	function getmyRecrdByAjax(){
		let data = {};
		data.user_id = loginId;
		data.survey_id = surveyId;
		data.participate_num = myanscnt;
		
		 $.ajax({
				url: '/survey/getmySurveyRecord.do',
				method: 'POST',
				data : JSON.stringify(data),
				contentType : 'application/json', 
				success: function (result) {
					console.log(result);
					if(result.length > 0){
	
						for(var i = 0; i<result.length; i++){
	
							let questionId = result[i].question_id;
							let answerId = result[i].answer_id;
							var stransid = answerId.toString();
							
							//프로그레스바때문에 
							$('.onequestions#'+questionId).addClass('procresscnt');
							cntProgressCnt();
							
							//객관식일때 
							if(result[i].question_type == 1){
								$('.onequestions#'+questionId).find('input[type="checkbox"][name="' + answerId + '"]').attr('checked', true);
								if(result[i].answer_content === '기타'){
									$('.onequestions#'+questionId).find(".etcinput").css('display', 'block');
									let etcCon = result[i].etc_content;
									$('.onequestions#'+questionId)
													.find(".etcinput")
													.find('input[type="text"]')
													.val(result[i].etc_content);
	
								}
							}
							
							//주관식일때
							if(result[i].question_type == 2){
								if(result[i] !== null){
									$('.onequestions#'+questionId).find('textarea').text(result[i].answer_content);	
								}
							} 
						}	
					}	
				} 
				,
				error: function (error) {
					console.log(error);
					alert('실패');
				}
			}); 
		 
	}
	
	//프로그레스바업업 !
	//1)체크박스
	$(".checks").change(function(){
		$(this).parent().parent().removeClass('procresscnt');
		
		let etcYn = false;
		let maxcount =  $(this).parent().prev().find('#maxcnt').val();
		//console.log(maxcount);
		let motherdiv = $(this).parent();
		let checkedlength = $(this).parent().find('input[type="checkbox"]:checked').length;
		
		//없음, 기타 관련 체크체크
		$(this).parent().find('input[type="checkbox"]:checked').each(function() {
			  if ($(this).attr('id') == 4) {
				  maxcount = 1;
				  etcYn = true;
			  }
			  if ($(this).attr('id') == 3) {
			    maxcount = 1;
			    $(this).parent().find(".etcinput").css('display', 'block');
			    var etcInput = $(this).parent().find(".etcinput").find('input[type="text"]');
			    etcInput.on('change', function() {
			      var etcInputVal = $(this).val().trim();
			      etcYn = (etcInputVal.length > 0);
			  });
			}
		});

		//총갯수 확인
		if(maxcount == checkedlength && $(this).attr('id') != 3){
			 etcYn = true; 
			
		}
		if(etcYn){
			$(this).parent().parent().addClass('procresscnt');
		}
		
		 $(this).parent().find('input[type="checkbox"]').each(function() {
		    if ($(this).attr('id') == 3) {
		      maxcount = 1;
		      if (!$(this).is(":checked")) {
		    	  $(this).parent().find(".etcinput").css('display', 'none');
				    var etcInput = $(this).parent().find(".etcinput").find('input[type="text"]');
		        etcInput.val("");
		        $(this).parent().removeClass('procresscnt');
		        cntProgressCnt();
		      }

		    }
		  });
		//addclass
		cntProgressCnt();
		
	});
	
	//1-2)기타창
	$(".etcinput").find('input[type="text"]').change(function(){
		$(this).parent().parent().parent().removeClass('procresscnt');
		
		let etcinputlength = $(this).val().trim().length;
		if( etcinputlength > 0){
			if($(this).parent().prev().prev('input[type="checkbox"]:checked')){
				$(this).parent().parent().parent().addClass('procresscnt');	
			}
		}
		cntProgressCnt();
	})
	

	//2)textarea
	$(".txtareaFrm").change(function(){
		$(this).parent().parent().removeClass('procresscnt');
		
		//비었는지 확인후 
		//console.log($(this).val().trim());
		let textareaVal =  $(this).val().trim().length;
		console.log(textareaVal);
		
		if( textareaVal > 0){
			$(this).parent().parent().addClass('procresscnt');
		}
		
		//progressbar때문에
		cntProgressCnt();
	});
	
	//3)프로그레스바 퍼센트용  클래스 몇갠지
	function cntProgressCnt(){

		finishcnt  = $('.procresscnt').length;

		pc = Math.round(finishcnt / pgtotal * 100);
		$('.progress-bar').css('width', pc + "%");
		$('.progress-bar').attr('aria-valuenow', pc);
		
		$('.progress-bar').text(pc + '%');

	};
	//앞페이지가기
	var goPrevPage = function(){		
		console.log(nowpage);
		let prevpage = nowpage-1;
		$(".page").hide();
		$(".page."+prevpage).show();
		
		nowpage = nowpage-1;
		console.log(nowpage);
		
		showBtns();
	}
	
	var goNextPage = function(){
			let movePageAble = false;
			let chknum = 0;

			let nextpage = nowpage+1;
			let etcno = false;
			

			let qdiv = $(".page."+nowpage);
			let ckboxes = $(".page." + nowpage).find('.y').find('div.chkboxdiv:has(input[type="checkbox"]), div.chkboxdiv:has(textarea)');
		
			let ckboxeslength =$(".page." + nowpage).find('.y').find('div.chkboxdiv:has(input[type="checkbox"]), div.chkboxdiv:has(textarea)').length;
			let inputchks = $(".page."+nowpage).find('.y').find('div.chkboxdiv').find('input[type="checkbox"]');
			console.log(ckboxes);
			console.log("--------------dddddd---------------------");
			ckboxes.each(function() {
				console.log($(this));
				console.log("-----------------------------------");
				
		 		  var checkedCount = $(this).find('input[type="checkbox"]:checked').length;
				  var textareacnt = $(this).find('textarea').length;
				  var notNullTextareaCnt  = 0;
				  let maxcnt = $(this).prev().find('input#maxcnt').val();

				  
				//없음 선택했을때 고려 ㅎㅎ 
				$(this).find('input[type="checkbox"]:checked').each(function() {
				  if ($(this).attr('id') === '4') {
					maxcnt = 1;
				    console.log("바뀐maxcnt"+maxcnt);
				  }
				  if($(this).attr('id') === '3'){
					  //기타창에 input 기입했는지 여부 
					  let etcinput = $(this).parent().find(".etcinput").find('input[type="text"]').val().trim();

						maxcnt = 1;
					  if(etcinput.length <= 0){
						  alert("기타 사항 작성해주세요");
						  movePageAble = false;
						  etcno = true;
						  return false;
					  }
				  }
				});
				  
				 //textarea 고려
				 $(this).find('textarea').each(function(){
					 console.log($(this).val());
					 if ($(this).val().trim().length >0) {
						    notNullTextareaCnt++;
						    console.log("비지않은 textarea갯수" + notNullTextareaCnt)
					}
				 })
					
	 			 if(etcno){
					return false;
				 }
				  
				  if(maxcnt == checkedCount+notNullTextareaCnt){
					  chknum ++;
						movePageAble = true;
				  }else{
					  var uncheckedCheckbox = $(this).find('input[type="checkbox"]:not(:checked)').first();
					  var nullboxname = uncheckedCheckbox.parent().prev().find('span').first().text();
					  var nulltxtarea = null;
					  let  txtbox = null;
					  
					  //빈 textarea
					  $(this).find('textarea').each(function() {
						  if ($(this).val().trim().length<=0) {
							  nulltxtarea = $(this);
							}
						})
						
						if(nulltxtarea != null){
							txtbox = nulltxtarea.parent().prev().find('span').first().text();	
						}
					  
					  console.log(nulltxtarea);
					  console.log(txtbox);
					  
					  if(textareacnt ==0 && nullboxname != null){
						  alert( nullboxname+"번 확인해 주세요");  
					  }
					  if(textareacnt>=1 && txtbox != null){
						  alert(txtbox+"번 확인해 주세요");
					  } 
					  movePageAble = false;
					  //return false;
				  }   
			});
	
			 if(movePageAble){
				$(".page").hide();
				$(".page."+nextpage).show();
				nowpage = nowpage +1;
			 } 

			console.log(nowpage);
			showBtns();
		
	}
	
	//버튼보이기
	var showBtns = function(){
		if(nowpage <= 1){
			$("#prevPage").hide();
			$('#submitSurvey').hide();
			$("#nextPage").show();
			return false;
		}
		
		if(nowpage >= totalpage){
			$("#submitSurvey").show();
			$("#nextPage").hide();
			$('#prevPage').show();
			return false;
		}
		
		$('#prevPage').show();
		$('#submitSurvey').hide();
		$("#nextPage").show();
	}
	
	
	//입력할수 있는 체크갯수 제한
	var checkInputNumber = function(){
		var targetDivs = $(".chkboxdiv");
		  targetDivs.on('change', function(){
			var checkboxes = $(this).find('input[type="checkbox"]');
			
			var checkedCount = checkboxes.filter(':checked').length;
			var maxcnt = $(this).prev().find('#maxcnt').val();
			
			checkboxes.each(function() {
			  if ($(this).prop('checked') && $(this).attr('id') === '4') {
				  maxcnt = 1;
				  return false;
			  }
			  if ($(this).prop('checked') && $(this).attr('id') === '3') {
				  maxcnt = 1;
				  return false;
			  }
			});
			
			 if(checkedCount > maxcnt){
		    	  alert("선택할 수 있는 선택지의 개수를 초과하였습니다.");
		    	  $(this).find("input[type='checkbox']").prop("checked", false);
		    	  
		    	  $(this).find(".etcinput").css("display", "none");
		    	  $(this).find(".etcinput").find("input[type='text']").val('');
		    	  $(this).parent().removeClass('procresscnt');
		    	  cntProgressCnt();
		    }
			
		  })
	}
	

	function pageChage(){
		let chagepage = $(this);
		console.log(changepage);
		
	}
	
	
	//작성 데이터 모으고 서브밋
	function makeSubmitAnswer(){
		data = [];
		
		var chkboxcnt = $('.onequestions.y').find('input[type="checkbox"]:checked').length;
		var textarea = $('.onequestions.y').find('textarea');
		var textareacnt = 0;
		
		
		textarea.each(function(){
			if ($(this).val().trim().length > 0) {
				textareacnt++;
			  }
		})
		
		var cnt = chkboxcnt+textareacnt;
		
		if(cnt <=0){
			alert(" 만약 하나 이상의 문항에 응답하지 않았다면, 임시저장이 불가능합니다");
			return false;
		}
			
		$('.onequestions').each(function(){
			//console.log($(this));
			let did = $(this).attr('id')-1;
		
			
			//1)체크 박스
			$(this).find('input[type="checkbox"]:checked').each(function(){
				let obj = {};
				obj.question_id = did+1;
				obj.survey_id = surveyId;
				obj.user_id=loginId;
				obj.participate_num = pcnt;
				obj.temp_yn = tempyn;
				
				let opId =  $(this).attr('name');
				console.log(opId);
				let opCon = $(this).next('span').text();
				console.log(opCon);
				obj.answer_id = opId;
				obj.answer_content = opCon;
	
				//기타창에 작성한거 담기  
				  if($(this).attr('id') === '3'){
					  let etcinput = $(this).parent().find(".etcinput").find('input[type="text"]').val();
					 obj.etc_content = etcinput;
				  } 
		 		
				  data.push(obj);
			});
			
			 //2) textarea
			 $(this).find('textarea').each(function(){
				 console.log($(this).val());
				 let obj = {};
					obj.question_id = did+1;
					obj.survey_id = surveyId;
					obj.user_id=loginId;
					obj.participate_num = pcnt;
					obj.temp_yn = tempyn;
					
					let opId =  $(this).attr('id');
					let opCon = $(this).val();
					
					obj.answer_id = opId;
					obj.answer_content = opCon;
					
	
					console.log(opCon);
			 		
					data.push(obj);
			 })
	
		});	
		
			console.log(data);
			  $.ajax({
				url: '/survey/inputSurvey.do',
				method: 'POST',
				data : JSON.stringify(data),
				contentType : 'application/json', 
				success: function (result) {
					if(result == 'pass'){
						alert("제출완료 되었습니다!");
						location.href="/survey/sureveyInfo.do?servey_id="+surveyId;	
					}else{
						alert(result);
						location.href="/survey/sureveyInfo.do?servey_id="+surveyId;	
					}
				},
				error: function (error) {
					console.log(error);
					alert('실패');
				}
			}) //end of ajax  	
	};	
	
	//설문조사 제출
	function submitSurvey(){

		let questions = $('.onequestions');
		tempyn = 'n';
		
		if(${not empty myanscnt}){
			console.log("수정");
			
			let myoldansinfo = {};
			myoldansinfo.user_id = loginId;
			myoldansinfo.survey_id = surveyId;
			myoldansinfo.participate_num = myanscnt;
			
			 $.ajax({
					url: '/survey/myAnswerEditInc.do',
					method: 'POST',
					data : JSON.stringify(myoldansinfo),
					contentType : 'application/json', 
					success: function (result) {
						if(result ==  "pass"){
							makeSubmitAnswer();
						}else{
							alert(result);
							location.href="/survey/sureveyInfo.do?servey_id="+surveyId;	
						}

					},
					error: function (error) {
						console.log(error);
						alert('실패');
					}
				}); 
		}else{
			console.log("새로");
			makeSubmitAnswer();
		}
	 
	}
	
</script>
</html>