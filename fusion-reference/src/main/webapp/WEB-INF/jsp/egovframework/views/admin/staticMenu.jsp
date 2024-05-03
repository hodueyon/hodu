<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<meta charset="UTF-8">
<title>통계</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<style>
	#bodydiv{
		width : 1200px;
		margin : 0 auto;
	}
	.title{
		width : 20%;
		margin : 0 auto;
		text-align : center;
		padding : 10px 5px;
		background-color: #F2F2F2;
		font-size: large;
	}
	#bodydiv>div{
		margin : 30px 0;
	}
	table{
		width : 1200px;
		text-align : center;
	}
	table>th{
		background-color #F2F2F2: 
	}
	#yeartitle{
		margin-bottom : 30px;
	}

</style>

</head>
<body>
	<div id="bodydiv">	
		<div >
			<div id="yeartitle" class="title"></div>
			<table id="yearStatic" style="width: 1200px" class="table table-bordered  align-middle">
			</table>
			
		</div>
		
		<div id="monthdiv">
			<div id="monthtitle" class="title"></div>
			<select>
				<option class="monyearop" value="">All</option>
				<option class="monyearop" value="2020">2020년</option>
				<option class="monyearop"  value="2021">2021년</option>
				<option class="monyearop"  value="2022">2022년</option>
				<option class="monyearop"  value="2023">2023년</option>
			</select>
			<button type="button" onclick="getMonthStaticsRcd()">조회</button>
			<button type="button" onclick="getMonthStatics()">초기화</button>
			<table id="MonthStatic" style="width: 1200px" class="table table-bordered  align-middle">
			</table>
		</div>
		
		<div id="daydiv">
			<div id="daytitle" class="title"></div>
			<select>
				<option class="dayyearop" value="">All</option>
				<option class="dayyearop"  value="2020">2020년</option>
				<option class="dayyearop"  value="2021">2021년</option>
				<option class="dayyearop"  value="2022">2022년</option>
				<option class="dayyearop"  value="2023">2023년</option>
			</select>
			<select>
			<option class="daymonop" value="">All</option>
			<c:forEach var="i" begin="1" end="12" step="1">
				<option class="daymonop" value="${i}">${i}월</option>
			</c:forEach>
			</select>
			<button type="button" onclick="getDayStaticsRcd()">조회</button>
			<button type="button" onclick="getDayStatics()">초기화</button>
			<table id="DayStatic" style="width: 1200px" class="table table-bordered  align-middle">
			</table>
		</div>
		
		<div id="timediv">
			<div id="timetitle" class="title"></div>
			<select>
				<option class="timeyearop"  value="">All</option>
				<option class="timeyearop"  value="2020">2020년</option>
				<option class="timeyearop"  value="2021">2021년</option>
				<option class="timeyearop"  value="2022">2022년</option>
				<option class="timeyearop"  value="2023">2023년</option>
			</select>
			<select id="timemonselect">
			<option class="timemonop"  value="">All</option>
			<c:forEach var="i" begin="1" end="12" step="1">
				<option class="timemonop" value="${i}">${i}월</option>
			</c:forEach>
			</select>
			<select id="timedayselect">
				<option class="timedayop"  value="">All</option>
				<c:forEach var="i" begin="1" end="31" step="1">
					<option  class="timedayop" value="${i}">${i}일</option>
				</c:forEach>
			</select>
			<button type="button" onclick="getTimeStaticsRcd()" >조회</button>
			<button type="button" onclick="getTimeStatics()">초기화</button>
			<table id="TimeStatic" style="width: 1200px" class="table table-bordered  align-middle">
			</table>
		</div>
		</div>	
</body>
<script>

	$(document).ready(function() {
		getYearStatic();
		getMonthStatics();
		getDayStatics();
		getTimeStatics();
	});
	
	$('#timemonselect').change(function(){
		var monVal = $(this).val();
		console.log(monVal);
	    var endVal = 0;
	    if(monVal == 2){
	        endVal = 28;
	    } else if(monVal == 4 || monVal == 6 || monVal == 9 || monVal == 11){
	        endVal = 30;
	    } else {
	        endVal = 31;
	    }
	    
	    $('#timedayselect').html('');
	    for(var i = 1; i <= endVal; i++){
	    	var ophtml;
	    	ophtml += "<option value="+i+">"+i+"일</option>";
	    }

        $('#timedayselect').append(ophtml);
	})
	function getMonthStaticsRcd(){
		let year = $('.monyearop:selected').val();
		console.log(year);
		
		if($('.monyearop:selected').text() == 'All'){
			getMonthStatics();
		}else{
			$.ajax({
				  url: "/static/staticMenuMonth.do",
				  type: "GET",
				  dataType: "json",
				  data: {
					    year: year

					},
				  success: function(data) {
				    console.log(data);
				   var MonthStatic = $('#MonthStatic');
				   $("#MonthStatic").empty();
				   $('#monthtitle').empty();
				   
				    if(data.year != null ){
				    	titleText= '<span>'+data.year+'</span><span>'+'년 월별 조회수' + '</span>';
				    	 $('#monthtitle').append(titleText);
				    	
				    }
				   
				    var thead = $("<thead>");
				    for (var i = 0; i < data.monthList.length; i++) {
				    var tr = $("<tr>");
				    tr.append($("<th>").text("메뉴명"));
				    tr.append($("<th>").text("1월"));
				    tr.append($("<th>").text("2월"));
				    tr.append($("<th>").text("3월"));
				    tr.append($("<th>").text("4월"));
				    tr.append($("<th>").text("5월"));
				    tr.append($("<th>").text("6월"));
				    tr.append($("<th>").text("7월"));
				    tr.append($("<th>").text("8월"));
				    tr.append($("<th>").text("9월"));
				    tr.append($("<th>").text("10월"));
				    tr.append($("<th>").text("11월"));
				    tr.append($("<th>").text("12월"));

				    }
				    thead.append(tr);
				    MonthStatic.append(thead);
				   
				    // 표 바디 만들기
				    var tbody = $("<tbody>");
				    for (var i = 0; i < data.monthList.length; i++) {
				      var row = data[i];
				      var tr = $("<tr>");
				      tr.append($("<th>").text(data.monthList[i].menu_name));
				      tr.append($("<td>").text(data.monthList[i].mon1));
				      tr.append($("<td>").text(data.monthList[i].mon2));
				      tr.append($("<td>").text(data.monthList[i].mon3));
				      tr.append($("<td>").text(data.monthList[i].mon4));
				      tr.append($("<td>").text(data.monthList[i].mon5));
				      tr.append($("<td>").text(data.monthList[i].mon6));
				      tr.append($("<td>").text(data.monthList[i].mon7));
				      tr.append($("<td>").text(data.monthList[i].mon8));
				      tr.append($("<td>").text(data.monthList[i].mon9));
				      tr.append($("<td>").text(data.monthList[i].mon10));
				      tr.append($("<td>").text(data.monthList[i].mon11));
				      tr.append($("<td>").text(data.monthList[i].mon12));

				      tbody.append(tr);
				    }
				    MonthStatic.append(tbody);
				    
				    
				  },
				  error: function(jqXHR, textStatus, errorThrown) {
				    console.log("Error: " + textStatus + " - " + errorThrown);
				  }
				});		
			
		}
		
		
	};
	function getDayStaticsRcd(){

		let year = $('.dayyearop:selected').val();
		console.log(year);
		let month = $('.daymonop:selected').val();
		//if($('.dayyearop:selected').text() == 'All' && )
		if($('.dayyearop:selected').text()  == 'All' && $('.daymonop:selected').text() == 'All'){
			getDayStatics();
		}else{
			$.ajax({
				  url: "/static/staticMenuDay.do",
				  type: "GET",
				  data: {
					    year: year,
					    month : month
					},
				  dataType: "json",
				  success: function(data) {
					  console.log(data);
				    // 받아온 데이터를 JSON 형태로 처리
				     var MonthStatic = $('#DayStatic');
				     $("#DayStatic").empty();
				  	$('#daytitle').empty();
				     
				     if(data.year != "" && data.month == ""){
				    	titleText= '<span>'+data.year+'</span><span>'+'년 일별 조회수' + '</span>';
				    	$('#daytitle').prepend(titleText);
				    	
				    }
				     if(data.year != "" && data.month !=  ""){
				    	 titleText= '<span>'+data.year+'</span><span>'+' 년' + +data.month+ '월 일별 조회수' + '</span>';
				    	 $('#daytitle').prepend(titleText);	 
				     }
				     if(data.year == "" && data.month !=  ""){
				    	 titleText=  '<span>'+'전체 기간 '+'</span><span>' + data.month + '월 일별 조회수' + '</span>';
				    	 $('#daytitle').prepend(titleText);	 
				     } 
				   
					  var table = $("<table>").addClass("table");
					    var thead = $("<thead>");
					    for (var i = 0; i < data.dayList.length; i++) {
					    var tr = $("<tr>");
					    tr.append($("<th>").text("메뉴명"));
					    tr.append($("<th>").text("1일"));
					    tr.append($("<th>").text("2일"));
					    tr.append($("<th>").text("3일"));
					    tr.append($("<th>").text("4일"));
					    tr.append($("<th>").text("5일"));
					    tr.append($("<th>").text("6일"));
					    tr.append($("<th>").text("7일"));
					    tr.append($("<th>").text("8일"));
					    tr.append($("<th>").text("9일"));
					    tr.append($("<th>").text("10일"));
					    tr.append($("<th>").text("11일"));
					    tr.append($("<th>").text("12일"));
					    tr.append($("<th>").text("13일"));
					    tr.append($("<th>").text("14일"));
					    tr.append($("<th>").text("15일"));
					    tr.append($("<th>").text("16일"));
					    tr.append($("<th>").text("17일"));
					    tr.append($("<th>").text("18일"));
					    tr.append($("<th>").text("19일"));
					    tr.append($("<th>").text("20일"));
					    tr.append($("<th>").text("21일"));
					    tr.append($("<th>").text("22일"));
					    tr.append($("<th>").text("23일"));
					    tr.append($("<th>").text("24일"));
					    tr.append($("<th>").text("25일"));
					    tr.append($("<th>").text("26일"));
					    tr.append($("<th>").text("27일"));
					    tr.append($("<th>").text("28일"));
					    tr.append($("<th>").text("29일"));
					    tr.append($("<th>").text("30일"));
					    tr.append($("<th>").text("31일"));
					    }
					    thead.append(tr);
					    MonthStatic.append(thead);
					   
					    // 표 바디 만들기
					    var tbody = $("<tbody>");
					    for (var i = 0; i < data.dayList.length; i++) {
					    	  var dayList = data.dayList[i];
					    	  var tr = $("<tr>");
					    	  tr.append($("<th>").text(dayList.menu_name));
					    	  
					    	  for (var j = 1; j <= 31; j++) {
					    	    var day = dayList["day" + j];
					    	    tr.append($("<td>").text(day));
					    	  }
					    	  
					    	  tbody.append(tr);
					    	}

					    	MonthStatic.append(tbody);
				  },
				  error: function(jqXHR, textStatus, errorThrown) {
				    console.log("Error: " + textStatus + " - " + errorThrown);
				  }
				});			
		}

		
	};
	function getTimeStaticsRcd(){
		let year = $('.timeyearop:selected').val();
		let month = $('.timemonop:selected').val();
		let day = $('.timedayop:selected').val();
		
		if($('.timeyearop:selected').text() == 'All' 
				&& $('.timemonop:selected').text() == 'All' 
				&& $('.timedayop:selected').text()  == 'All'){
			getTimeStatics();	
		}else{
			$.ajax({
				  url: "/static/staticMenuTime.do",
				  type: "GET",
				  data:{
					  year : year,
					  month : month,
					  day : day
				  },
				  dataType: "json",
				  success: function(data) {
				    // 받아온 데이터를 JSON 형태로 처리
				    console.log(data);
				     var TimeStatic = $('#TimeStatic');
				     $("#TimeStatic").empty();
				     $("#timetitle").empty();
				     
				     if(data.year != null && data.month == null && data.day == null){
				    	titleText= '<span>'+data.year+'</span><span>'+'년 시간 별 조회수' + '</span>';
				    	$('#timetitle').prepend(titleText);
				    	
				    }
				     if(data.year != null && data.month != null && data.day == null){
					    	titleText= '<span>'+data.year+'</span><span>'+'년' + data.month+ ' 월 시간 별 조회수' + '</span>';
					    	$('#timetitle').prepend(titleText);
					    	
					 }
				     if(data.year != null && data.month !=  null && data.day != null){
				    	 titleText= '<span>'+data.year+'</span><span>'+' 년' + +data.month+ '월 ' + '</span><span>' +data.day+ '일 시간 별 조회수';
				    	 $('#timetitle').prepend(titleText);	 
				     }
				     if(data.year == "" && data.month !=  "" && data.day == ""){
				    	 titleText=  '<span>'+'전체 기간 '+'</span><span>' + data.month + '월 시간 별 조회수' + '</span>';
				    	 $('#timetitle').prepend(titleText);	 
				     }
				     if(data.year == "" && data.month ==  "" && data.day != ""){
				    	 titleText=  '<span>'+'전체 기간 내 '+'</span><span>' + data.day + '일 시간 별 조회수' + '</span>';
				    	 $('#timetitle').prepend(titleText);	 
				     }
				     
				     
					  var table = $("<table>").addClass("table");
					    var thead = $("<thead>");
					    for (var i = 0; i < data.timeList.length; i++) {
					    var tr = $("<tr>");
					    tr.append($("<th>").text("메뉴명"));
					    tr.append($("<th>").text("0시"));
					    tr.append($("<th>").text("1시"));
					    tr.append($("<th>").text("2시"));
					    tr.append($("<th>").text("3시"));
					    tr.append($("<th>").text("4시"));
					    tr.append($("<th>").text("5시"));
					    tr.append($("<th>").text("6시"));
					    tr.append($("<th>").text("7시"));
					    tr.append($("<th>").text("8시"));
					    tr.append($("<th>").text("9시"));
					    tr.append($("<th>").text("10시"));
					    tr.append($("<th>").text("11시"));
					    tr.append($("<th>").text("12시"));
					    tr.append($("<th>").text("13시"));
					    tr.append($("<th>").text("14시"));
					    tr.append($("<th>").text("15시"));
					    tr.append($("<th>").text("16시"));
					    tr.append($("<th>").text("17시"));
					    tr.append($("<th>").text("18시"));
					    tr.append($("<th>").text("19시"));
					    tr.append($("<th>").text("20시"));
					    tr.append($("<th>").text("21시"));
					    tr.append($("<th>").text("22시"));
					    tr.append($("<th>").text("23시"));


					    }
					    thead.append(tr);
					    TimeStatic.append(thead);
					   
					    // 표 바디 만들기
					    var tbody = $("<tbody>");
					    for (var i = 0; i < data.timeList.length; i++) {
					      var row = data[i];
					      var tr = $("<tr>");
					      tr.append($("<th>").text(data.timeList[i].menu_name));
					      tr.append($("<td>").text(data.timeList[i].time0));
					      tr.append($("<td>").text(data.timeList[i].time1));
					      tr.append($("<td>").text(data.timeList[i].time2));
					      tr.append($("<td>").text(data.timeList[i].time3));
					      tr.append($("<td>").text(data.timeList[i].time4));
					      tr.append($("<td>").text(data.timeList[i].time5));
					      tr.append($("<td>").text(data.timeList[i].time6));
					      tr.append($("<td>").text(data.timeList[i].time7));
					      tr.append($("<td>").text(data.timeList[i].time8));
					      tr.append($("<td>").text(data.timeList[i].time9));
					      tr.append($("<td>").text(data.timeList[i].time10));
					      tr.append($("<td>").text(data.timeList[i].time11));
					      tr.append($("<td>").text(data.timeList[i].time12));
					      tr.append($("<td>").text(data.timeList[i].time13));
					      tr.append($("<td>").text(data.timeList[i].time14));
					      tr.append($("<td>").text(data.timeList[i].time15));
					      tr.append($("<td>").text(data.timeList[i].time16));
					      tr.append($("<td>").text(data.timeList[i].time17));
					      tr.append($("<td>").text(data.timeList[i].time18));
					      tr.append($("<td>").text(data.timeList[i].time19));
					      tr.append($("<td>").text(data.timeList[i].time20));
					      tr.append($("<td>").text(data.timeList[i].time21));
					      tr.append($("<td>").text(data.timeList[i].time22));
					      tr.append($("<td>").text(data.timeList[i].time23));

					      tbody.append(tr);
					    }
					    TimeStatic.append(tbody);

				  },
				  error: function(jqXHR, textStatus, errorThrown) {
				    console.log("Error: " + textStatus + " - " + errorThrown);
				  }
				});	
		}
		
		
		
	};
	
	
	
	function getYearStatic(){

		$.ajax({
			  url: "/static/staticMenu.do",
			  type: "GET",
			  dataType: "json",
			  success: function(data) {
			    // 받아온 데이터를 JSON 형태로 처리
			    console.log(data);
				var yearStatic = $('#yearStatic');	
				yearStatic.empty();
			    // 받아온 데이터로 표 만들기
				
			    titleText= '<span>'+ '년도 별 조회수' + '</span>';
				    	$('#yeartitle').prepend(titleText);
			    
			    var thead = $("<thead>");
			    var tr = $("<tr>");
			    tr.append($("<th>").text("메뉴명"));
			    tr.append($("<th>").text("2020"));
			    tr.append($("<th>").text("2021"));
			    tr.append($("<th>").text("2022"));
			    tr.append($("<th>").text("2023"));
			    thead.append(tr);
			    yearStatic.append(thead);

			    // 표 바디 만들기
			    var tbody = $("<tbody>");
			    for (var i = 0; i < data.yearlist.length; i++) {
			      var row = data[i];
			      var tr = $("<tr>");
			      tr.append($("<td>").text(data.yearlist[i].menu_name));
			      tr.append($("<td>").text(data.yearlist[i].year20));
			      tr.append($("<td>").text(data.yearlist[i].year21));
			      tr.append($("<td>").text(data.yearlist[i].year22));
			      tr.append($("<td>").text(data.yearlist[i].year23));
			      
			      tbody.append(tr);
			    }
			    yearStatic.append(tbody);
			    
			    // 표를 표시할 위치에 추가
			  },
			  error: function(jqXHR, textStatus, errorThrown) {
			    console.log("Error: " + textStatus + " - " + errorThrown);
			  }
			});
	}
	
	function getMonthStatics(){
		var titleDiv = $("<div>");
		var titleText
		$.ajax({
			  url: "/static/staticMenuMonth.do",
			  type: "GET",
			  dataType: "json",
			  success: function(data) {
			    console.log(data);
			    //$('#monthdiv').empty();
				   $("#MonthStatic").empty();
				   $("#monthtitle").empty();
				   
			    if(data.year == null){
			    	titleText = '<span>'+ "전체 월별 조회수 "+'</span>';
			    	$('#monthtitle').prepend(titleText);
			    }
			    if(data.year != null){
			    	titleText= '<span>'+data.year+'</span><span>'+'년 월별 조회수' + '</span>';
			    	$('#monthdiv').prepend(titleText);
			    	
			    }

			   var MonthStatic = $('#MonthStatic');
			  
			   
			    var thead = $("<thead>");
			    for (var i = 0; i < data.monthList.length; i++) {
			    var tr = $("<tr>");
			    tr.append($("<th>").text("메뉴명"));
			    tr.append($("<th>").text("1월"));
			    tr.append($("<th>").text("2월"));
			    tr.append($("<th>").text("3월"));
			    tr.append($("<th>").text("4월"));
			    tr.append($("<th>").text("5월"));
			    tr.append($("<th>").text("6월"));
			    tr.append($("<th>").text("7월"));
			    tr.append($("<th>").text("8월"));
			    tr.append($("<th>").text("9월"));
			    tr.append($("<th>").text("10월"));
			    tr.append($("<th>").text("11월"));
			    tr.append($("<th>").text("12월"));

			    }
			    thead.append(tr);
			    MonthStatic.append(thead);
			   
			    // 표 바디 만들기
			    var tbody = $("<tbody>");
			    for (var i = 0; i < data.monthList.length; i++) {
			      var row = data[i];
			      var tr = $("<tr>");
			      tr.append($("<th>").text(data.monthList[i].menu_name));
			      tr.append($("<td>").text(data.monthList[i].mon1));
			      tr.append($("<td>").text(data.monthList[i].mon2));
			      tr.append($("<td>").text(data.monthList[i].mon3));
			      tr.append($("<td>").text(data.monthList[i].mon4));
			      tr.append($("<td>").text(data.monthList[i].mon5));
			      tr.append($("<td>").text(data.monthList[i].mon6));
			      tr.append($("<td>").text(data.monthList[i].mon7));
			      tr.append($("<td>").text(data.monthList[i].mon8));
			      tr.append($("<td>").text(data.monthList[i].mon9));
			      tr.append($("<td>").text(data.monthList[i].mon10));
			      tr.append($("<td>").text(data.monthList[i].mon11));
			      tr.append($("<td>").text(data.monthList[i].mon12));

			      tbody.append(tr);
			    }
			    MonthStatic.append(tbody);
			    
			    
			  },
			  error: function(jqXHR, textStatus, errorThrown) {
			    console.log("Error: " + textStatus + " - " + errorThrown);
			  }
			});	
	}
	
	function getDayStatics(){
		$.ajax({
			  url: "/static/staticMenuDay.do",
			  type: "GET",
			  dataType: "json",
			  success: function(data) {
				  console.log(data);
			    // 받아온 데이터를 JSON 형태로 처리
			     var MonthStatic = $('#DayStatic');
			     /* $('#daydiv').empty(); */
			     $("#DayStatic").empty();
			     $("#daytitle").empty();
			     
			     if(data.year == null && data.month == null){
				    	titleText = '<span>'+ "전체 일별 조회수 "+'</span>';
				    	$("#daytitle").prepend(titleText);
			    }
			   
			   
				  var table = $("<table>").addClass("table");
				    var thead = $("<thead>");
				    for (var i = 0; i < data.dayList.length; i++) {
				    var tr = $("<tr>");
				    tr.append($("<th>").text("메뉴명"));
				    tr.append($("<th>").text("1일"));
				    tr.append($("<th>").text("2일"));
				    tr.append($("<th>").text("3일"));
				    tr.append($("<th>").text("4일"));
				    tr.append($("<th>").text("5일"));
				    tr.append($("<th>").text("6일"));
				    tr.append($("<th>").text("7일"));
				    tr.append($("<th>").text("8일"));
				    tr.append($("<th>").text("9일"));
				    tr.append($("<th>").text("10일"));
				    tr.append($("<th>").text("11일"));
				    tr.append($("<th>").text("12일"));
				    tr.append($("<th>").text("13일"));
				    tr.append($("<th>").text("14일"));
				    tr.append($("<th>").text("15일"));
				    tr.append($("<th>").text("16일"));
				    tr.append($("<th>").text("17일"));
				    tr.append($("<th>").text("18일"));
				    tr.append($("<th>").text("19일"));
				    tr.append($("<th>").text("20일"));
				    tr.append($("<th>").text("21일"));
				    tr.append($("<th>").text("22일"));
				    tr.append($("<th>").text("23일"));
				    tr.append($("<th>").text("24일"));
				    tr.append($("<th>").text("25일"));
				    tr.append($("<th>").text("26일"));
				    tr.append($("<th>").text("27일"));
				    tr.append($("<th>").text("28일"));
				    tr.append($("<th>").text("29일"));
				    tr.append($("<th>").text("30일"));
				    tr.append($("<th>").text("31일"));
				    }
				    thead.append(tr);
				    MonthStatic.append(thead);
				   
				    // 표 바디 만들기
				    var tbody = $("<tbody>");
				    for (var i = 0; i < data.dayList.length; i++) {
				      var row = data[i];
				      var tr = $("<tr>");
				      tr.append($("<th>").text(data.dayList[i].menu_name));
				      tr.append($("<td>").text(data.dayList[i].day1));
				      tr.append($("<td>").text(data.dayList[i].day2));
				      tr.append($("<td>").text(data.dayList[i].day3));
				      tr.append($("<td>").text(data.dayList[i].day4));
				      tr.append($("<td>").text(data.dayList[i].day5));
				      tr.append($("<td>").text(data.dayList[i].day6));
				      tr.append($("<td>").text(data.dayList[i].day7));
				      tr.append($("<td>").text(data.dayList[i].day8));
				      tr.append($("<td>").text(data.dayList[i].day9));
				      tr.append($("<td>").text(data.dayList[i].day10));
				      tr.append($("<td>").text(data.dayList[i].day11));
				      tr.append($("<td>").text(data.dayList[i].day12));
				      tr.append($("<td>").text(data.dayList[i].day13));
				      tr.append($("<td>").text(data.dayList[i].day14));
				      tr.append($("<td>").text(data.dayList[i].day15));
				      tr.append($("<td>").text(data.dayList[i].day16));
				      tr.append($("<td>").text(data.dayList[i].day17));
				      tr.append($("<td>").text(data.dayList[i].day18));
				      tr.append($("<td>").text(data.dayList[i].day19));
				      tr.append($("<td>").text(data.dayList[i].day20));
				      tr.append($("<td>").text(data.dayList[i].day21));
				      tr.append($("<td>").text(data.dayList[i].day22));
				      tr.append($("<td>").text(data.dayList[i].day23));
				      tr.append($("<td>").text(data.dayList[i].day24));
				      tr.append($("<td>").text(data.dayList[i].day25));
				      tr.append($("<td>").text(data.dayList[i].day26));
				      tr.append($("<td>").text(data.dayList[i].day27));
				      tr.append($("<td>").text(data.dayList[i].day28));
				      tr.append($("<td>").text(data.dayList[i].day29));
				      tr.append($("<td>").text(data.dayList[i].day30));
				      tr.append($("<td>").text(data.dayList[i].day31));
				      tbody.append(tr);
				    }
				    MonthStatic.append(tbody);

			  },
			  error: function(jqXHR, textStatus, errorThrown) {
			    console.log("Error: " + textStatus + " - " + errorThrown);
			  }
			});	
	}
	
	function getTimeStatics(){
		$.ajax({
			  url: "/static/staticMenuTime.do",
			  type: "GET",
			  dataType: "json",
			  success: function(data) {
			    // 받아온 데이터를 JSON 형태로 처리
			    
			     var TimeStatic = $('#TimeStatic');
			    
			    $("#TimeStatic").empty();
			     $('#timetitle').empty(); 
			     
			     if(data.year == null && data.month == null && data.time == null){
				    	titleText = '<span>'+ "전체 시간 별 조회수 "+'</span>';
				    	$('#timetitle').prepend(titleText);
			    }
			     
			     
				  var table = $("<table>").addClass("table");
				    var thead = $("<thead>");
				    for (var i = 0; i < data.timeList.length; i++) {
				    var tr = $("<tr>");
				    tr.append($("<th>").text("메뉴명"));
				    tr.append($("<th>").text("0시"));
				    tr.append($("<th>").text("1시"));
				    tr.append($("<th>").text("2시"));
				    tr.append($("<th>").text("3시"));
				    tr.append($("<th>").text("4시"));
				    tr.append($("<th>").text("5시"));
				    tr.append($("<th>").text("6시"));
				    tr.append($("<th>").text("7시"));
				    tr.append($("<th>").text("8시"));
				    tr.append($("<th>").text("9시"));
				    tr.append($("<th>").text("10시"));
				    tr.append($("<th>").text("11시"));
				    tr.append($("<th>").text("12시"));
				    tr.append($("<th>").text("13시"));
				    tr.append($("<th>").text("14시"));
				    tr.append($("<th>").text("15시"));
				    tr.append($("<th>").text("16시"));
				    tr.append($("<th>").text("17시"));
				    tr.append($("<th>").text("18시"));
				    tr.append($("<th>").text("19시"));
				    tr.append($("<th>").text("20시"));
				    tr.append($("<th>").text("21시"));
				    tr.append($("<th>").text("22시"));
				    tr.append($("<th>").text("23시"));


				    }
				    thead.append(tr);
				    TimeStatic.append(thead);
				   
				    // 표 바디 만들기
				    var tbody = $("<tbody>");
				    for (var i = 0; i < data.timeList.length; i++) {
				      var row = data[i];
				      var tr = $("<tr>");
				      tr.append($("<th>").text(data.timeList[i].menu_name));
				      tr.append($("<td>").text(data.timeList[i].time0));
				      tr.append($("<td>").text(data.timeList[i].time1));
				      tr.append($("<td>").text(data.timeList[i].time2));
				      tr.append($("<td>").text(data.timeList[i].time3));
				      tr.append($("<td>").text(data.timeList[i].time4));
				      tr.append($("<td>").text(data.timeList[i].time5));
				      tr.append($("<td>").text(data.timeList[i].time6));
				      tr.append($("<td>").text(data.timeList[i].time7));
				      tr.append($("<td>").text(data.timeList[i].time8));
				      tr.append($("<td>").text(data.timeList[i].time9));
				      tr.append($("<td>").text(data.timeList[i].time10));
				      tr.append($("<td>").text(data.timeList[i].time11));
				      tr.append($("<td>").text(data.timeList[i].time12));
				      tr.append($("<td>").text(data.timeList[i].time13));
				      tr.append($("<td>").text(data.timeList[i].time14));
				      tr.append($("<td>").text(data.timeList[i].time15));
				      tr.append($("<td>").text(data.timeList[i].time16));
				      tr.append($("<td>").text(data.timeList[i].time17));
				      tr.append($("<td>").text(data.timeList[i].time18));
				      tr.append($("<td>").text(data.timeList[i].time19));
				      tr.append($("<td>").text(data.timeList[i].time20));
				      tr.append($("<td>").text(data.timeList[i].time21));
				      tr.append($("<td>").text(data.timeList[i].time22));
				      tr.append($("<td>").text(data.timeList[i].time23));

				      tbody.append(tr);
				    }
				    TimeStatic.append(tbody);

			  },
			  error: function(jqXHR, textStatus, errorThrown) {
			    console.log("Error: " + textStatus + " - " + errorThrown);
			  }
			});	
	}
</script>
</html>