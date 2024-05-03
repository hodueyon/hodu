<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous"></head>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.css" />
<title>독서실예약</title>
<style>
	#calendar {
		
	}
	.seatDiv{
		cursor : pointer;
		width : 90px;
		aspect-ratio : 1/1 auto;
		margin : 10px;
	}
	#allTimeList td{
		cursor : pointer;
	}
	.disabledDiv{
		background-color : #A4A4A4;
		margin : 10px;
		padding : 5px;
	}
	.pickDiv{
		background-color : #E3F6CE;
	}
	.choiceday{
		background-color : #fcf8e3;
	}
	.addLine{
		text-decoration : line-through;
		background-color  :#F2F2F2; 
		color : #BDBDBD;
	}
	#calendarDiv{
		width: 80%;
		margin : 40px auto;
	}
	#topdiv {
		width : 1000px;
		margin : 20px auto;
	}
	#btndiv{
		width: 90%;
		text-align : right;
	}
	#timeTable{
		width : 1000px;
		margin : 20px auto;
		padding : 10px;
	}
	.ableDiv{
		margin : 10px;
		padding : 5px;
		
	}
	#reserveDiv{
		width : 1000px;
		margin : 20px auto;
		padding : 10px;
	}
</style>
</head>
<body>
	<!--  -->
	<div id ="topdiv">
		<h3 style="text-align : center">✏️ 독서실 예약 ✏️</h3>
	</div>
	<div id="btndiv">
		<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" id="manageBtn">
			내 예약 내역 확인
		</button>
	</div>	
	<!-- 달력 및 좌석 -->
	<div class="d-flex" id="calendarDiv">
	
		<div id="calendar" class="w-50"></div>
		<c:if test="${!empty seats}">
		  <div class="card w-50" id="seatList" style="margin-left : 30px">
		  <div class="card-body d-flex justify-content-center align-items-center">
		  <div class="container">
		    <div class="row row-cols-4">
		      <c:forEach items="${seats}" var="seat" varStatus="arrange">
				 <div class="col bigdiv d-flex justify-content-center">
				<c:choose>
				    <c:when test="${seat.total >= gap}">
				        <div class="card seatDiv disabledDiv" id="${seat.seat_id}">
				            <p>${arrange.count}</p>
				        </div>
				    </c:when>
				    <c:otherwise>
				        <div class="card seatDiv ableDiv" id="${seat.seat_id}">
				            <p>${arrange.count}</p>
				        </div>
				    </c:otherwise>
				</c:choose>
		        </div>
		      </c:forEach>
		      </div>
		    </div>
		    </div>
		  </div>
		</c:if>
	</div>
	
	<!-- 예약날짜 및 예약여부 띄우는거 -->
	<div class="card" id="timeTable" style="display:none">
		<div class="d-flex justify-content-between" style="margin : 10px 0">
			<span>✔️ 예약 현황 확인</span>
			<span style="color : red; font-weight : bold">선택날짜 : ${use_start}</span>
		</div>
		<div id="reservationListDiv">
			<table class="table" id="allTimeList">
			
			</table>
		</div>
	</div>
	
	<!-- 예약하기 -->
	<div class="card" id="reserveDiv" style="display:none">
		<div style="margin : 10px 0">✔️ 예약목적및 시간 선택</div>
		<table class="table">
			<tr>
				<th class="table-secondary">사용목적</th>
				<td>
					<select id="purposeSelect">
						<c:forEach items="${purposes}" var="purpose">
							<option value="${purpose.purpose_id}">${purpose.purpose_content}:${purpose.default_time}시간 기본사용</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th class="table-secondary">사용시간</th>
				<td>
					<select id="startSelect">
						<option>시작시간</option>
						  <c:forEach begin="${info.time_start}" end="${info.time_end-1}" step="1" var="num1">
						    <option value="${num1}">${num1}:00</option>
						  </c:forEach>
					</select>
					 ~ 
					 <select id="endSelect" disabled>
					 		<option>종료시간</option>
						   <c:forEach begin="${info.time_start+1}" end="${info.time_end}" step="1" var="num2">
						    <option value="${num2}">${num2}:00</option>
						  </c:forEach>
					 </select>
				</td>
			</tr>
		</table>
		<input type="hidden" id="hiddenseatid">
		<div style="text-align : center">
			<button type="button" class="btn btn-primary" onclick="inputReserv()">예약하기</button>
		</div>
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">나의 예약현황</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      	<table class="table" style="text-align: center">
	        		<thead>
	        			<tr>
	        				<th>좌석번호</th>
	        				<th>이용시간</th>
	        				<th></th>
	        			</tr>
	        		</thead>
	        		
	        		<tbody id="modalTableTbody">
	        			<c:forEach items="${myReservations}" var="m" >
		        		<tr>
		        			<th>${m.seat_num}번 자리</th>
	        				<td>${m.use_start} - ${m.use_end}</td>
	        				<td><button type="button" id="${m.reserve_id}" class="btn btn-danger" onclick="cancelReserv(this)">예약취소</button></td>
		        		</tr>
		        		</c:forEach> 
	        		</tbody>
	        		
	        	</table>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/locale/ko.js"></script>
<script>
	var lastCkVal = "true";
	var lastOverlapCK = "true";
	var lastOverlapCKtime = "true";
	
	//올해 끝 날짜
	var today = new Date();
	var endOfYear = new Date(today.getFullYear(), 11, 31);

	$(document).ready(function() {
		
		$('#calendar').fullCalendar({
			defaultView: 'month',
			defaultDate: moment().format("YYYY-MM-DD"),
			locale: 'ko',
		    validRange: function(nowDate) {
		        return {
		        	start: moment().startOf('day'),
		        	end : endOfYear
		        };
		      },
			dayClick: function(date, jsEvent, view) {
				let data = date.format();
				$(this).addClass('choiceDate');
				location.href="/study/studyRoom.do?use_start="+data;
			},
		});
		
		//오늘 눌러씅ㄹ때
		$('.fc-today-button').on('click', function(){
			let data = $('.fc-today').data('date');
			location.href="/study/studyRoom.do?use_start="+data;
		})
		//default date바꾸기
		 var use_start = moment().format("YYYY-MM-DD");
	    var params = new URLSearchParams(window.location.search);
	    if (params.has('use_start')) {
	        use_start = params.get('use_start');
	    }
	
	    // defaultDate 설정
	    $('#calendar').fullCalendar('gotoDate', use_start);
		changecolor();
	});
	

	//모달창오픈
	$('#manageBtn').click(function(e){
		e.preventDefault();
		$('#exampleModal').modal("show");
	});
	
	
	function changecolor(){
		let date = "${use_start}";
		
		$('.fc-today').removeClass('fc-today');
		$('.fc-day').filter(function() {
			return $(this).data('date') === date;
		}).addClass('fc-today');

	}
	
	getReserveBySeat();

	//div 좌석 클릭시 예약현황띄우기
	function getReserveBySeat(){
	    	$('#reserveDiv').css("display", "none");

		console.log("체크용입니다")
		let allTimeList = document.getElementById("allTimeList");
	
		data = {};
		var today = new Date();
		var nowHours = today.getHours();
		var minutes = today.getMinutes();  // 분
		var seconds = today.getSeconds();  // 초
		let paramToday = "${today}";
		let srcDate = "${use_start}";
		
		//정각이 아닐때 
		if (minutes > 0 || seconds > 0 ){
			nowHours = nowHours+1;
			console.log(nowHours);
		}
		
		$('.seatDiv').on("click", function(){
			const t = $(this);
			$(this).addClass("pickDiv");
			
			let seatid = parseInt($(this).attr('id'));
			$('.seatDiv:not(#' + seatid + ')').removeClass("pickDiv");

			let use_start = "${use_start}";
			let room_id = 1;
			
			data.seat_id= seatid;
			data.use_start = use_start;
			data.room_id = room_id;
			 $.ajax({
				url : '/study/getInfoReserveBySeat.do',
				data : JSON.stringify(data),
				method : 'POST',
				contentType : 'application/json',
		  		success: function(result) {
		  			let time_start;
		  			let time_end;
		  			allTimeList.innerHTML = "";
		  			console.log(result);
		  			let list = result.list;
		  			let seatid = list[0].seat_id;
		  			if(list[0].time_start !=null){
		  				time_start =list[0].time_start;	
		  			}
		  			if(list[0].time_end !=null){
		  				time_end =list[0].time_end;	
		  			}

		  		    $('#hiddenseatid').val(list[0].seat_id);
		  		    for (var i = time_start; i < time_end; i += 2) {
		  		      	let row = document.createElement('tr');
		  		        let cell1 = document.createElement('td');
		  		      cell1.innerHTML = '<span class="timerange" data-start="' +i + '">' + i + '</span>:00 - <span>' + (i + 1) + '</span>:00 <span class="colorFont">(예약가능)</span>';
		  		        
		  		     	let cell2 = document.createElement('td');
		  		        cell2.innerHTML = '<span class="timerange" data-start="' +(i+1) + '">' + (i+1) + '</span>:00 - <span>' + (i + 2) + '</span>:00 <span class="colorFont">(예약가능)</span>';;

	  		        row.appendChild(cell1);
	  		        row.appendChild(cell2);

	                allTimeList.appendChild(row);

		  		}
	  		        
	  		    //예약 불가능하게
	  		    if(list.length >=1 && list[0].usestart != null){
	  		    	//오늘 기준으로 현재시간 이전시간 예약을 막아버리기 ~~!
	  		    	if( paramToday == srcDate){
		                $('.timerange').each(function(){
		  		        	let time = $(this).attr('data-start');
		  		        	for (var j = 0; j < list.length; j++) {
		  		        		if (time < nowHours) {
		  		        		    $(this).parent().addClass('addLine');
		  		        		}
		  		       	 }
		            	})	
	  		    	}
	                $('.timerange').each(function(){
	  		        	let time = $(this).attr('data-start');
	  		        	for (var j = 0; j < list.length; j++) {
	  		        		if (time >= list[j].usestart  && time < list[j].useend) {
	  		        		    $(this).parent().addClass('addLine');
	  		        		}

	  		       	 }
	            	})	
	  		    }
	  		    
	  		    //예약없는 날 + 예약일이 오늘일떄
	  		  if(list.length >=1 && list[0].usestart == null){
	  		    	//오늘 기준으로 현재시간 이전시간 예약을 막아버리기 ~~!
	  		    	if( paramToday == srcDate){
		                $('.timerange').each(function(){
		  		        	let time = $(this).attr('data-start');

	  		        		if (time < nowHours) {
	  		        		    $(this).parent().addClass('addLine');
	  		        		}
		            	})	
	  		    	}

	  		    }
				
	  		    //옵션만들기
	  		     $('#startSelect').empty();
	  		   $('#startSelect').append('<option value="no">시작시간</option>')
	  		    let start = $('.timerange').filter(function() {
					return !$(this).parent().hasClass('addLine');
				});
				
	  		    start.each(function() {
					let option = '<option value="' + $(this).data('start') + '">' + $(this).data('start') + ' :00</option>';
					$('#startSelect').append(option);
	  		    })
				
	  		    //예약가능한 시간 표 클릭하면 사용시간 시작시간에 세팅하기 ~!
/* 	  		    let canReservTime = $('#allTimeList').find('td').filter(function(){
	  		    		return !$(this).hasClass('addLine');
	  		    		
	  		    });
	  		    
	  		  canReservTime.each(function(){
	  		    	$(this).click(function(){
	  		    		let choiceStart= $(this).find('.timerange').data('start');
	  		    		$('#startSelect').val(choiceStart).filter(":selected").prop("selected", false);
	  		    	})
	  		    }) */ 
					
	  		    //풀예약이면(예약불가능 상태)이면 예약 신청폼을 안뜨기하기
	  		    console.log(seatid);
	  		    console.log(t);
	  		    if(t.hasClass('disabledDiv')){
	  		    	console.log("안보이게");
	  		    	$('#reserveDiv').css("display", "none");
	  		    }else{
	  		    	console.log("보이게");
	  		    	$('#reserveDiv').css("display", "block");
	  		    }

	  		  	$('#timeTable').css('display', 'block');
		  		},
	            error: function(xhr, status, error) {
	                console.log(error);
	            }
				
			}) 
		})
	}
	
	//클릭했을때 색깔띄우기
	
	//예약하기
	function inputReserv(){
		data= {};
	
		let valResult = lastCK();
		console.log(valResult);
		if(valResult){
			console.log("들어왔어`~~~~~~~~");
	
		let purpose = parseInt($('#purposeSelect').val());
		let date = "${use_start}";
		let start = $('#startSelect').val();
		let end = $('#endSelect').val();
		let seat_id = parseInt($('#hiddenseatid').val());
		
		var startTime = new Date(date);

		var year = startTime.getFullYear();
		var month = startTime.getMonth() + 1;
		var day = startTime.getDate();
		var hours = start;


		if (month < 10) {
		  month = '0' + month;
		}

		if (day < 10) {
		  day = '0' + day;
		}

		if (hours < 10) {
		  hours = '0' + hours;
		}


		var formattedDate = year + '-' + month + '-' + day + ' ' + hours + ':' + '00' + ':' + '00';
		
		data.use_start = formattedDate; 
		
		//종료 시간 변환
		var endTime = new Date(date);
		var year2 = endTime.getFullYear();
		var month2 = endTime.getMonth() + 1;
		var day2 = endTime.getDate();
		var hours2 = end;


		if (month2 < 10) {
		  month = '0' + month;
		}

		if (day2 < 10) {
		  day = '0' + day;
		}

		if (hours2 < 10) {
		  hours = '0' + hours;
		}


		var formattedDate2 = year2 + '-' + month2 + '-' + day2+ ' ' + hours2 + ':' + '00' + ':' + '00';
		
		data.use_end = formattedDate2; 

		data.purpose_id = purpose;
		data.seat_id = seat_id;
		console.log(data);
		
	 	$.ajax({
			url: '/study/inputReservation.do',
			data : JSON.stringify(data),
			method : 'POST',
			contentType : 'application/json',
	  		success: function(result) {
				if(result == 'true'){
					alert("예약 완료되셨습니다.");
					location.href="/study/studyRoom.do?use_start="+date;	
				}else if(result == "mincheob"){
					alert("해당 사용 시작 시간 이후에는 예약이 불가능 합니다.");
				}else{
					alert("다른 유저가 먼저 등록했습니다.");
				}
            },
            error: function(xhr, status, error) {
                console.log(error);
            }
			
		})//end of ajax
		
		}//end of if
	}
	
	//예약취소
	function cancelReserv(e){
		let num = e.id;
		if(confirm("예약 취소하시겠습니까?")){
			$.ajax({
				url: '/study/cancelReservation.do',
				data : {reserve_id : num},
				method : 'POST',
		  		success: function(result) {
					alert("예약 취소되셨습니다.");
					
					if($('.pickDiv').length > 0) {
						resetTimeTable();
					}
					console.log(result);
					$('#modalTableTbody').empty();
					let tbody = $('#modalTableTbody');
		  		    for (var i = 0; i <result.length; i++) {
		  		    	var row = $('<tr></tr>'); 
		  		
		  		    	row.append($('<td></td>').text(result[i].seat_num + '번 자리'));
		  		    	row.append($('<td></td>').text(result[i].use_start+' - '+result[i].use_end));
		  		    	row.append($('<td></td>').html('<button type="button" id="' + result[i].reserve_id + '" class="btn btn-danger" onclick="cancelReserv(this)">예약취소</button>'));
		  		    tbody.append(row);

		  		}
		  		    
					
	            },
	            error: function(xhr, status, error) {
	                console.log(error);
	            }
				
			}) 
			
		}
	}
	
	//발리데이션 걸기~!
	$('#purposeSelect').change(function(){
	  let selectedOption = $(this).find('option:selected');
	  let text = selectedOption.text();
	  //숫자 찾기
	  let number = text.match(/\d+/)[0];
	  console.log(number);
	});
	
	
	//ㅅ사용시간 셀렉션 바뀔때 
	$('#startSelect').change(function(){
		 let selectnumstart;
		 let purpose = $('#purposeSelect').find('option:selected');
		  let text = purpose.text();
		  //목적에서 숫자만 뽑은거
		  let number = text.match(/\d+/)[0];
		  //사용 시작시간 -숫자 뽑을려구찾기
		 let val = $('#startSelect').find('option:selected').val();
		 let val2 = $('#endSelect').find('option:selected').val();
		
		 if(val != "no"){
			 selectnumstart = $('#startSelect').find('option:selected').val().match(/\d+/)[0];
		 }
		
		let end = parseInt($('#endSelect').find('option:selected').val());
		let start = parseInt($('#startSelect').find('option:selected').val());
		let endSelect = $('#endSelect');
		
		let base = ${info.time_start};
		let limit = ${info.time_end};
		console.log(start);
		console.log(limit);
	
		if(val != "no"){
			$('#endSelect').empty();
			  $('#endSelect').append('<option value="no">종료시간</option>');
			  
			  let arr = [];
			  
			  let realend = $('.timerange').each(function() {
				if($(this).data('start') >= start) {
					if(!$(this).parent().hasClass('addLine')) {
						arr.push($(this).data('start'));
						if(Number($(this).data('start')) === Number(limit - 1)) {
							arr.push(Number($(this).data('start')) + 1);
						}
					}
					else {
						arr.push($(this).data('start'));
						return false;
					}
				}
			})
	
			//선택스타트 뺴주기
			  arr.shift();
			
			  //종료시간만들기
			  arr.forEach(function(ar) {
					let option = '<option value="' + ar + '">' + ar + ' :00</option>';
					$('#endSelect').append(option);
	  		  })
	  		  
	  	$("#endSelect").attr("disabled", false);
	  
		
		//이미 누군가가 등록한 시간은 안되게
		 if($('#startSelect').val() != "no" && $('#endSelect').val() != "no"){
				ckReserOverlap();
		 }
		if(end-start < number){
			alert("목적에 해당하는 최소 이용시간 만큼은 이용해주셔야 합니다.");
			return false;
		}
		
		if(start >= end){
			alert("사용 종료 시간은 시작 시간보다 이후여야 합니다~!")
		}
		
		
	}
	})
	
	$('#endSelect').change(function(){
		 let purpose = $('#purposeSelect').find('option:selected');
		  let text = purpose.text();
		  let number = text.match(/\d+/)[0];
		let end = parseInt($('#endSelect').find('option:selected').val());
		let start = parseInt($('#startSelect').find('option:selected').val());
		console.log(number);
		console.log(end);
		
		if($('#startSelect').val() != "no" && $('#endSelect').val() != "no"){
			ckReserOverlap();	
		}

		if(end-start < number){
			alert("목적에 해당하는 최소 이용시간 만큼은 이용하시게끔 사용 시간을 조정해주세요.");
			return false;
		}
		
		if(start >= end){
			alert("사용 종료 시간은 시작 시간보다 이후여야 합니다~!")
		}
	})
	
	//이미예약했는지 여부 체크
	function ckReserOverlap(){
		lastOverlapCK = "true";
		data = {};
		let date = "${use_start}";
		let seatid = parseInt($('#hiddenseatid').val());
		let startnumCK = $('#startSelect').find('option:selected').val().match(/\d+/);
		let endnumCK = $('#startSelect').find('option:selected').val().match(/\d+/);
		
		let startTime = new Date(date);
		let year = startTime.getFullYear();
		let month = startTime.getMonth() + 1;
		let day = startTime.getDate();
		let hours = $('#startSelect').val();;
	
		
		if(startnumCK != null){
			if (month < 10) {
				  month = '0' + month;
				}
	
				if (day < 10) {
				  day = '0' + day;
				}
	
				if (hours < 10) {
				  hours = '0' + hours;
				}
	
				let formattedDate = year + '-' + month + '-' + day + ' ' + hours + ':' + '00' + ':' + '00';
				data.use_start = formattedDate;	
		}
		
		data.seat_id = seatid;
		
		//종료시간
		//종료 시간 변환
		if(endnumCK != null){
			var endTime = new Date(date);
			var year2 = endTime.getFullYear();
			var month2 = endTime.getMonth() + 1;
			var day2 = endTime.getDate();
			var hours2 = $('#endSelect').find('option:selected').val();


			if (month2 < 10) {
			  month2= '0' + month2;
			}

			if (day2 < 10) {
			  day2 = '0' + day2;
			}

			if (hours2 < 10) {
			  hours2 = '0' + hours2;
			}
			var formattedDate2 = year2 + '-' + month2 + '-' + day2+ ' ' + hours2 + ':' + '00' + ':' + '00';
			
			data.use_end = formattedDate2; 	
		}
		
		$.ajax({
			url : '/study/ckOverlapTime.do',
			data : JSON.stringify(data),
			method : 'POST',
			async: false,
			contentType : 'application/json',
			success : function(result){

				if(result == "false"){
					alert("이미 예약된 좌석입니다.");
					lastOverlapCK = "false";
					resetTimeTable();
					 $("#startSelect").prop("selectedIndex", 0);
					 $("#endSelect").prop("selectedIndex", 0);
				}
			},
            error: function(xhr, status, error) {
                console.log(error);
            }
		})
				
	}

	//등록전 발리데이션 체크체크
	function lastCK(){
		console.log("발리데이션체크 ");
		lastCkVal = "true";
		lastOverlapCK = "true";
		lastOverlapCKtime = "true";

		let start = parseInt($('#startSelect').val());
		let end = parseInt($('#endSelect').val());


		//시작 숫자인지
		if($('#startSelect').val() == "no"){
			alert("사용시간을 선택해주세요");
			return false;
		}
		
		console.log("1");
		//시작이 종료보다 이른지
		if(start > end){
			alert("시작시간은 종료시간 보다 앞서야 합니다.");
			return false;	
		}
		console.log("2");

		//종료 숫자인지
		if($('#endSelect').val() == "no"){
			alert("사용 종료 시간을 선택해주세요");

			return false;
		}
		
		console.log("3");

		//내가 혹시 다른 자리에 동일 시간대에 예약했는지 체크 
		ckReservOverlapMyTime();
		
		if(lastOverlapCKtime == 'false'){

			return false;
		}
		
		console.log("4");

		
		//누군가 예약했는지
		ckReserOverlap();
		
		if(lastOverlapCK == 'false'){

			return false;
		}
		
		console.log("5");

		//목적에 맞는 시간 갭을 가졌는지
		 let selectedOption = $('#purposeSelect').find('option:selected');
		  let text = selectedOption.text();
		  //숫자 찾기
		  let number = text.match(/\d+/)[0];
		if(end-start <number){
			alert("사용목적에 맞는 시간 사용시간을 설정해 주세요.");

			return false;
		}
		return true;
	}
	
	//내가 혹시 다른곳을 예약했는지 - 동시간대에 ~!
	function ckReservOverlapMyTime(){
		console.log("동시간대 타좌석 예약 체크");
		lastOverlapCKtime = "true";
		data = {};
		let date = "${use_start}";
		let seatid = parseInt($('#hiddenseatid').val());
		let startnumCK = $('#startSelect').find('option:selected').val().match(/\d+/);
		let endnumCK = $('#startSelect').find('option:selected').val().match(/\d+/);
		
		let startTime = new Date(date);
		let year = startTime.getFullYear();
		let month = startTime.getMonth() + 1;
		let day = startTime.getDate();
		let hours = $('#startSelect').val();;
	
		
		if(startnumCK != null){
			if (month < 10) {
				  month = '0' + month;
				}
	
				if (day < 10) {
				  day = '0' + day;
				}
	
				if (hours < 10) {
				  hours = '0' + hours;
				}
	
				let formattedDate = year + '-' + month + '-' + day + ' ' + hours + ':' + '00' + ':' + '00';
				data.use_start = formattedDate;	
		}
		
		data.seat_id = seatid;
		
		//종료시간
		//종료 시간 변환
		if(endnumCK != null){
			var endTime = new Date(date);
			var year2 = endTime.getFullYear();
			var month2 = endTime.getMonth() + 1;
			var day2 = endTime.getDate();
			var hours2 = $('#endSelect').find('option:selected').val();


			if (month2 < 10) {
			  month2= '0' + month2;
			}

			if (day2 < 10) {
			  day2 = '0' + day2;
			}

			if (hours2 < 10) {
			  hours2 = '0' + hours2;
			}


			var formattedDate2 = year2 + '-' + month2 + '-' + day2+ ' ' + hours2 + ':' + '00' + ':' + '00';
			
			data.use_end = formattedDate2; 	
		}
		
		console.log(data);
		$.ajax({
			url : '/study/ckMyOverlapTimeSeat.do',
			data : JSON.stringify(data),
			method : 'POST',
			async: false,
			contentType : 'application/json',
			success : function(result){
				console.log(result);
				console.log("내가 혹시 다른 자리에 예약을 했나요");
				if(result == "false"){
					alert("이미 다른자리에 예약이 되어있습니다.!");
					resetTimeTable();
					lastOverlapCKtime = "false";
					 $("#startSelect").prop("selectedIndex", 0);
					 $("#endSelect").prop("selectedIndex", 0);
				}
			},
            error: function(xhr, status, error) {
                console.log(error);
            }
		})
				
	}
	
	
	//데이터초기화
	function resetTimeTable(){

		console.log("초기화용입니다")
		let allTimeList = document.getElementById("allTimeList");
	
		data = {};
		var today = new Date();
		var nowHours = today.getHours();
		var minutes = today.getMinutes();  // 분
		var seconds = today.getSeconds();  // 초
		let paramToday = "${today}";
		let srcDate = "${use_start}";
		
		//정각이 아닐때 
		if (minutes > 0 || seconds > 0 ){
			nowHours = nowHours+1;
		}
		
			let seatid = parseInt($('.pickDiv').eq(0).attr('id'));
			
			let use_start = "${use_start}";
			let room_id = 1;
			
			data.seat_id= seatid;
			data.use_start = use_start;
			data.room_id = room_id;
			
			 $.ajax({
				url : '/study/getInfoReserveBySeat.do',
				data : JSON.stringify(data),
				method : 'POST',
				contentType : 'application/json',
		  		success: function(result) {
		  			let time_start;
		  			let time_end;
		  			allTimeList.innerHTML = "";
		  			console.log(result);
		  			let list = result.list;
		  			let seatid = list[0].seat_id;
		  			if(list[0].time_start !=null){
		  				time_start =list[0].time_start;	
		  			}
		  			if(list[0].time_end !=null){
		  				time_end =list[0].time_end;	
		  			}

		  		    $('#hiddenseatid').val(list[0].seat_id);
		  		    for (var i = time_start; i < time_end; i += 2) {
		  		      	let row = document.createElement('tr');
		  		        let cell1 = document.createElement('td');
		  		      cell1.innerHTML = '<span class="timerange" data-start="' +i + '">' + i + '</span>:00 - <span>' + (i + 1) + '</span>:00 <span class="colorFont">(예약가능)</span>';
		  		        
		  		     	let cell2 = document.createElement('td');
		  		        cell2.innerHTML = '<span class="timerange" data-start="' +(i+1) + '">' + (i+1) + '</span>:00 - <span>' + (i + 2) + '</span>:00 <span class="colorFont">(예약가능)</span>';;

	  		        row.appendChild(cell1);
	  		        row.appendChild(cell2);

	                allTimeList.appendChild(row);

		  		}
	  		        
	  		    //예약 불가능하게
	  		    if(list.length >=1 && list[0].usestart != null){
	  		    	//오늘 기준으로 현재시간 이전시간 예약을 막아버리기 ~~!
	  		    	if( paramToday == srcDate){
		                $('.timerange').each(function(){
		  		        	let time = $(this).attr('data-start');
		  		        	for (var j = 0; j < list.length; j++) {
		  		        		if (time < nowHours) {
		  		        		    $(this).parent().addClass('addLine');
		  		        		}
		  		       	 }
		            	})	
	  		    	}
	                $('.timerange').each(function(){
	  		        	let time = $(this).attr('data-start');
	  		        	for (var j = 0; j < list.length; j++) {
	  		        		if (time >= list[j].usestart  && time < list[j].useend) {
	  		        		    $(this).parent().addClass('addLine');
	  		        		}

	  		       	 }
	            	})	
	  		    }
	  		    
	  		    //예약없는 날 + 예약일이 오늘일떄
	  		  if(list.length >=1 && list[0].usestart == null){
	  		    	//오늘 기준으로 현재시간 이전시간 예약을 막아버리기 ~~!
	  		    	if( paramToday == srcDate){
		                $('.timerange').each(function(){
		  		        	let time = $(this).attr('data-start');

	  		        		if (time < nowHours) {
	  		        		    $(this).parent().addClass('addLine');
	  		        		}
		            	})	
	  		    	}

	  		    }
				
	  		    //옵션만들기
	  		     $('#startSelect').empty();
	  		   $('#startSelect').append('<option value="no">시작시간</option>')
	  		    let start = $('.timerange').filter(function() {
					return !$(this).parent().hasClass('addLine');
				});
				
	  		    start.each(function() {
					let option = '<option value="' + $(this).data('start') + '">' + $(this).data('start') + ' :00</option>';
					$('#startSelect').append(option);
	  		    })
				
	  		    //예약가능한 시간 표 클릭하면 사용시간 시작시간에 세팅하기 ~!
	  		    let canReservTime = $('#allTimeList').find('td').filter(function(){
	  		    		return !$(this).hasClass('addLine');
	  		    		
	  		    });
	  		    
	  		  canReservTime.each(function(){
	  		    	$(this).click(function(){
	  		    		let choiceStart= $(this).find('.timerange').data('start');
	  		    		$('#startSelect').val(choiceStart).filter(":selected").prop("selected", false);
	  		    	})
	  		    })
					
	  		    //풀예약이면(예약불가능 상태)이면 예약 신청폼을 안뜨기하기
	  		    if($('.seatDiv#'+seatid).hasClass('disabledDiv')){
	  		    	$('#reserveDiv').css("display", "none");
	  		    }else{
	  		    	//추후 수정 필요 
	  		    	//$('#purposeSelect').
	  		    	$('#reserveDiv').css("display", "block");
	  		    }

	  		  	$('#timeTable').css('display', 'block');
		  		},
	            error: function(xhr, status, error) {
	                console.log(error);
	            }
				
			}) 	
	}
</script>
</body>
</html>
