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
 <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<title>설문조사 통계</title>
<style>
	.quesList{
		margin-right : 30px;
		
	}
	#chartDiv{
		width :500px;
	}
	main{
		width : 1200px;
		margin : 0 auto;
	}
	#QuesAnsInfo{
		margin : 15px 0;
		padding : 15px;
		display : none;
	}
	#ques_num{
		font-weight : bold;
		font-size : xx-large;
		margin-right : 15px;	
	}
	
	#ques_con{
		font-size : 20px;
	}
	#chartDiv{
		margin : 0 auto;
		
	}
	#haveChildDiv{
		padding : 15px;
	}
	#shortAnsUl>li{
		padding : 10px;
		list-style : none;
	}
	#serveylist >tbody> tr{
		cursor : pointer;
	}
	
</style>
</head>
<body>
	<main>
	<h1>설문조사 통계</h1>
	<table class="table" id="serveylist">
		<thead>
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>시작일</th>
				<th>종료일</th>
				<th>대상</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="l" varStatus="idx">
				<tr id=${l.servey_id} onclick="getQuesNumList(this)">
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
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<input type="hidden" id="hiddenid">
	<div id="QuesNumList">
		<ul id="numlist">
		</ul>
		
	</div>
	
	<!-- 질문 답모음 -->
	<div id="QuesAnsInfo" class="card">
		<div id="QuesAns">
			<span id="ques_num"></span><span id="ques_con"></span>
		</div>
	</div>
	<div id="chartDiv" style="display:none" class="card">
		<div id="chartSelectDiv">
			<select id="userselect">
			
			</select>
			<select id="userlocation">
			
			</select>
			<button type="button" onclick="locationSrc()" class="btn btn-primary" id="srchBtn">보기</button>
		</div>
		<canvas id="chart">
		</canvas>
		<div class="d-flex " id="tableEtcDiv">
			<div>
				<table class="table" id="chartTable">
					<thead>
						<tr>
							<th>문항</th>
							<th>응답자수</th>
							<th>비율</th>
						</tr>
					</thead>
					<tbody id="chartTbTbody">
					
					</tbody>
				</table>
			</div>
			
			<!-- 여기에 기타 의견넣기 -->
			<div id="etcSmallDiv" style="display:none; margin-left : 20px;">
			
				<p style="margin-top : 10px">✔️ 기타의견</p>
				<ul id="etcContent">
				</ul>
			</div>
		</div>
		
	</div>
	
	
		
	<div style="display:none" id="shortAnsDiv">
		<h5>주관식 답변</h5>
		<div id="shortSelectDiv">
			<select id="userselectShortFrm">
			
			</select>
			<select id="userlocationShortFrm">
			
			</select>
			<button type="button" onclick="locationSrc()" class="btn btn-primary" id="srchBtnShort">보기</button>
		</div>
		<ul id="shortAnsUl">
		</ul>
	</div>
	
	<div style="display:none" id="nonResultfirst">
			<h5 style="text-align : center;" >해당 설문에는 응답한 유저가 없습니다!</h5>
	</div>
	
	<div style="display:none" id="nonResult">
			<div id="chartSelectDiv2">
			<select id="userselect2">
			
			</select>
			<select id="userlocation2">
				
			</select>
			<button type="button" onclick="locationSrc()" class="btn btn-primary" id="srchBtn2">보기</button>
		</div>
			<h5 style="text-align : center;" >해당 지역에는 응답한 유저가 없습니다!</h5>
	</div>
	
	<div style="display:none" id="nonResult">
			<div id="chartSelectDiv2">
			<select id="userselect2">
			
			</select>
			<select id="userlocation2">
				
			</select>
			<button type="button" onclick="locationSrc()" class="btn btn-primary" id="srchBtn2">보기</button>
		</div>
			<h5 style="text-align : center;" >해당 지역에는 응답한 유저가 없습니다!</h5>
	</div>
	
	
	<div id="haveChildDiv" class="card" style="display: none">
		<p>대문항은 통계 정보를 제공하지 않습니다.</p>
	</div>
	</main>
</body>

<script>
	var data = {};
	var chartData = [];
	var labelArr = [];
	var questionNum;


	var colors = [
		  '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF',
		  '#FF9F40', '#5AD3D1', '#FFCD56', '#5A9A98', '#E05D5D',
		  '#FFC870', '#528C8B', '#BF4F4F', '#FAA23B', '#A9D18E',
		  '#9C6A6A', '#F5B041', '#7BCECC', '#FFB34D', '#85929E',
		  '#C39BD3', '#3498DB', '#F4D03F', '#1ABC9C', '#9B59B6',
		  '#E74C3C', '#2ECC71', '#F39C12', '#27AE60', '#E67E22'
		];

	var donutOptions = {
			responsive: true,
		  cutoutPercentage: 85, 
		  legend: {
			    display: true,
			    position: 'right'
			  },
		};
	
	function getQuesNumList(e){
		//모든 내용 초기화
		$('#QuesAnsInfo').css('display', 'none');
		$('#chartDiv').css('display', 'none');
		$('#nonResult').css('display', 'none');
		$('#nonResultfirst').css('display', 'none');
		$('#haveChildDiv').css('display', 'none');

		
		$('#hiddenid').val(e.id);
		let serveyid= e.id;
		data.servey_id = Number(serveyid);

		 $.ajax({
			url: '/survey/getQuesList.do',
			type: 'POST',
			data: JSON.stringify(data),
			contentType : "application/json; charset=utf-8",
			 success: function(result) {
				 $('#numlist').empty();
				 
				 for(let i=0; i<result.length; i++){
					 var li = $('<li>').val(result[i].question_id);
					 li.css('margin-right', '30px');
					 li.css('cursor', 'pointer');
					  li.addClass("quesList");
					  li.on('click', getDataForChart);

					 li.css('display', 'inline-block');

			        if (result[i].question_num_child !== 0) {
			            li.text(result[i].question_num + '-' + result[i].question_num_child+'번');
			        } else {
			            li.text(result[i].question_num + '번');
			        }
					 
					 $('#numlist').append(li);
				 }
					
			  },
			  error: function(xhr, status, error) {
			    console.log(error);
			  }
			
		}) 
	}
	
	function getDataForChart(){
		
		let serveyid= $(this).val();
		let hiddenid = $('#hiddenid').val();

		data.servey_id = $('#hiddenid').val();
		$(this).css('background-color', 'pink');
		$('.quesList').not('[value='+serveyid+']').css('background-color', '');

		data.question_id = serveyid;
		
		delete data.location;

		 $.ajax({
			url: '/survey/getDataForChart.do',
			type: 'POST',
			data: JSON.stringify(data),
			contentType : "application/json; charset=utf-8",
			 success: function(result) {
				 $('#etcSmallDiv').css('display', 'none');
				 $('#chartTbTbody').empty();
				 $('#etcContent').empty();
				 $('#shortAnsUl').empty();
				 let locations = result.location;
				 chartData = [];
				 labelArr = [];
				 let target = result.info.servey_target;
				 
				//질문정보
				if (result.quesInfo.question_num_child !== 0) {
		            $('#ques_num').text(result.quesInfo.question_num + '-' + result.quesInfo.question_num_child+'번');
		        } else {
		        	$('#ques_num').text(result.quesInfo.question_num+'번');
		        }
				$('#ques_con').text(result.quesInfo.question_content);
				$('#QuesAnsInfo').css('display', 'block');
				$('#nonResult').css("display", "none");
				 $('#haveChildDiv').css('display', 'none');


				 $('#srchBtn').val(serveyid);
				 $('#srchBtn2').val(serveyid);
				 $('#srchBtnShort').val(serveyid);
				 
				 if(result.answererCnt <=0){
					 $('#nonResultfirst').css('display', 'block');
				 }
				 else{
				 if(result.type == 1){
					 
						 $('#userselect').empty();
						 $('#userlocation').empty();
						 let userop = $('<option value="users">'+"회원"+'</option>');
						 $('#userselect').append(userop);
						 
						 let allop = $('<option value="all">전체</option>');
						 $('#userlocation').append(allop);
						 
						 for(let i = 0; i<locations.length; i++){
							 let op = $('<option value="'+locations[i].sub_id+'">'+locations[i].sub_name+'</option>')
							 $('#userlocation').append(op);
						 }
					

					 //비회원 누르면 지역 고르는거 비 활성화 !
					 makeDisabled();
					 $('#chartDiv').css('display', 'block');
					 $('#shortAnsDiv').css('display', 'none');
					 $('#haveChildDiv').css('display', 'none');

					 let list = result.list;
					 let etcs = result.etces;
					 for(let i=0; i<list.length; i++){
						 var row = $('<tr>');
						 let pc = Number(list[i].answer_ratio)*100;
						 chartData.push(pc);
						 if (list[i].question_num_child !== 0) {
							 questionNum = list[i].question_num + '-' + list[i].question_num_child+'번';
					        } else {
					        	questionNum = list[i].question_num + '번';
					        }
						 labelArr.push(list[i].answer_content);
						 
						
						 //표 만들기					 
						 var ansCon =  $('<td>').text(list[i].answer_content);
						 var  ansCnt =  $('<td>').text(list[i].answer_cnt + '명');
						 var ansPc =  $('<td>').text(pc.toFixed(2) + '%');
						 row.append(ansCon, ansCnt, ansPc);
						 $('#chartTbTbody').append(row);	 
					 }
					 
					 //기타 작성 한거 꺼내기
					 if(etcs!= null){
						 for(let i=0; i<etcs.length; i++){
							 var li = $('<li>');
							 let content = etcs[i].etc_content;
							 li.text(content); 
							 $('#etcContent').append(li);
						 }
						 $('#etcSmallDiv').css('display', 'block');
					}
					 var row2 = $('<tr>');
					 var ansCon2 =  $('<td>').text('전체');
					 var  ansCnt2 =  $('<td>').text(result.answererCnt+ '명');
					 var ansPc2 =  $('<td>').text('100%');
					 row2.append(ansCon2, ansCnt2, ansPc2);
					 $('#chartTbTbody').append(row2);	 
					 
					 
					 makeChart();
				 }	
				
				 //주관식
				 if(result.type == 2){
					 if(target == 'all'){
						 $('#userselectShortFrm').empty();
						 $('#userlocationShortFrm').empty();
						 
						 let userop = $('<option value="users">'+"회원"+'</option>');
						 let nonuserop = $('<option value="nonuser">'+"비회원"+'</option>');
						 
						 for(let i = 0; i<locations.length; i++){
							 let op = $('<option value="'+locations[i].sub_id+'">'+locations[i].sub_name+'</option>')
							 $('#userlocationShortFrm').append(op);
						 }
						 
						 $('#userselectShortFrm').append(userop, nonuserop);
					}else{
						 $('#userselectShortFrm').empty();
						 $('#userlocationShortFrm').empty();
						 let userop = $('<option value="users">'+"회원"+'</option>');
						 $('#userselectShortFrm').append(userop);
						 
						 let allop = $('<option value="all">전체</option>');
						 $('#userlocationShortFrm').append(allop);
						 
						 
						 for(let i = 0; i<locations.length; i++){
							 let op = $('<option value="'+locations[i].sub_id+'">'+locations[i].sub_name+'</option>')
							 $('#userlocationShortFrm').append(op);
						 }
					 }
					 
					 //비회원 선택시 - 비활성화도 시켜야될듯
					 
					 $('#chartDiv').css('display', 'none');
					 $('#shortAnsDiv').css('display', 'block');
					 $('#haveChildDiv').css('display', 'none');
					
					 
					 let answers = result.answers;
					 for(let i=0; i<answers.length; i++){
						 var li = $('<li><div class="card p-1">'+answers[i].answer_content+'</div></li>');
						 $('#shortAnsUl').append(li);
					 }

				 }
				 }
				 if(result.type == 3){
					 $('#chartDiv').css('display', 'none');
					 $('#shortAnsDiv').css('display', 'none');
					 $('#haveChildDiv').css('display', 'block');
					 $('#nonResultfirst').css('display', 'none');		 

			  }
				 },
			  error: function(xhr, status, error) {
			    console.log(error);
			  }
			
		}) 
	}
	
	function makeChart(){

		var chDonutData1 = {
				  labels: labelArr,
			    datasets: [
			      {
			        backgroundColor: colors,
			        borderWidth: 0,
			        data: chartData,
			        cutout: "60%"
			      }
			    ]
			};
			
			var chDonut1 = document.getElementById("chart");
			if (chDonut1) {
			  if (chDonut1.chart) {
			    chDonut1.chart.destroy(); // 이전 차트를 파괴합니다.
			  }
			  chDonut1.chart = new Chart(chDonut1, {
			    type: 'doughnut',
			    data: chDonutData1,
			    options: {
			    	cutoutPercentage: 85,
			        responsive: true,
			        plugins: {
			          legend: {
			            position: 'top',
			          }
			        }	
			    }
    
			  });
			}
	}
	
	function makeDisabled(){
		$('#userselect').on('change', function(){
			if($(this).val() == 'nonuser'){
				$('#userlocation').prop('disabled', true);			
			}else{
				$('#userlocation').prop('disabled', false);			
			}	
		})
	}
	
	function locationSrc(){
		data = {};
		data.servey_id = $('#hiddenid').val();
		let question_id = event.target.value
		data.question_id = question_id;
		let location; 
		let searchType = $('#userselect').val();
		let target = $(event.target);
		let parent = target.parent();


		if(parent.attr('id') == 'chartSelectDiv'){
			console.log("객관식");
			location =  $('#userlocation').val();	
		}else if(parent.attr('id') == 'shortSelectDiv'){
			location = $('#userlocationShortFrm').val();
		}else{
			location = $('#userlocation2').val();
		}
	
		
		if(location == 'all'){

		}else{
			//전체검색
			data.location = location;	
		}

		  $.ajax({
				url: '/survey/getDataForChart.do',
				type: 'POST',
				data: JSON.stringify(data),
				contentType : "application/json; charset=utf-8",
				 success: function(result) {
					 $('#nonResultfirst').css('display', 'none');
					 $('#etcSmallDiv').css('display', 'none');
					 $('#chartTbTbody').empty();
					 $('#etcContent').empty();
					 $('#shortAnsUl').empty();
					 let locations = result.location;
					 chartData = [];
					 labelArr = [];
					 let target = result.info.servey_target;
					 $('#srchBtn').val(question_id);
					 
					 $('#userlocation').find('option').each(function(){
						 if($(this).val() == location){
							 $(this).prop("selected", true);
							 
						 }
					 })
					 if(result.type == 1){
						 
						 console.log(location);

						 //$('#userselect').empty();
						 //$('#userlocation').empty();
						 $('#userselect2').empty();
						 $('#userlocation2').empty();
						 
						 let userop = $('<option value="users">'+"회원"+'</option>');
						 $('#userselect').append(userop);
						 $('#userselect2').append(userop);
						 
						 let allop = $('<option value="all">전체</option>');
						 $('#userlocation').append(allop);
						 $('#userlocation2').append(allop);
						 
						 for(let i = 0; i<locations.length; i++){
							 let op = $('<option value="'+locations[i].sub_id+'">'+locations[i].sub_name+'</option>')
							 $('#userlocation').append(op);
							 $('#userlocation2').append(op);
						 }
						 

						 $('#userlocation').val(location);
						 $('#userlocation2').val(location);

						 
						 $('#chartDiv').css('display', 'block');
						 $('#shortAnsDiv').css('display', 'none');
						 $('#haveChildDiv').css('display', 'none');

						 let list = result.list;
						 let etcs = result.etces;
						 
						 if(result.answererCnt ==0){
							$('#nonResult').css("display", "block");
							 $('#chartDiv').css('display', 'none');
							
						 }
						 
						 if(result.answererCnt >0){
							 $('#nonResult').css("display", "none");
							 for(let i=0; i<list.length; i++){
								 var row = $('<tr>');
								 let pc = Number(list[i].answer_ratio)*100;
								 chartData.push(pc);
								 if (list[i].question_num_child !== 0) {
									 questionNum = list[i].question_num + '-' + list[i].question_num_child+'번';
							        } else {
							        	questionNum = list[i].question_num + '번';
							        }
								 labelArr.push(list[i].answer_content);
								 
							
								 //표 만들기					 
								 var ansCon =  $('<td>').text(list[i].answer_content);
								 var  ansCnt =  $('<td>').text(list[i].answer_cnt + '명');
								 var ansPc =  $('<td>').text(pc.toFixed(2) + '%');
								 row.append(ansCon, ansCnt, ansPc);
								 $('#chartTbTbody').append(row);	 
							 }
							 
							 //기타 작성 한거 꺼내기
		 					 if(etcs!= null){
								 for(let i=0; i<etcs.length; i++){
									 var li = $('<li>');
									 let content = etcs[i].etc_content;
									 li.text(content); 
									 $('#etcContent').append(li);
								 }
								 $('#etcSmallDiv').css('display', 'block');
							 }
		 					
						 }
					
						 
						 var row2 = $('<tr>');
						 var ansCon2 =  $('<td>').text('전체');
						 var  ansCnt2 =  $('<td>').text(result.answererCnt+ '명');
						 var ansPc2 =  $('<td>').text('100%');
						 row2.append(ansCon2, ansCnt2, ansPc2);
						 $('#chartTbTbody').append(row2);	 
						 
						 makeChart();
					 }	
					
					 //주관식
					 if(result.type == 2){
						 $('#chartDiv').css('display', 'none');
						 $('#shortAnsDiv').css('display', 'block');
						 $('#nonResult').css("display", "none");
						
						 let answers = result.answers;
						 

						 $('#userlocationShortFrm').val(location);

						 if(answers.length <=0){
							 $('#nonResult').css("display", "block");
							 $('#userselect2').css("display", "none");
							 $('#userlocation2').css("display", "none");
							 $('#srchBtn2').css("display", "none");
							 
						 }
						 
						 
						 
						 for(let i=0; i<answers.length; i++){
							 var li = $('<li><div class="card">'+answers[i].answer_content+'</div></li>');
							 $('#shortAnsUl').append(li);
						 }

					 }
					 
					 if(result.type == 3){
						 $('#chartDiv').css('display', 'none');
						 $('#shortAnsDiv').css('display', 'none');
						 $('#haveChildDiv').css('display', 'block');
					 }
				  },
				  error: function(xhr, status, error) {
				    console.log(error);
				  }
				
			})  
	}
</script>
</html>