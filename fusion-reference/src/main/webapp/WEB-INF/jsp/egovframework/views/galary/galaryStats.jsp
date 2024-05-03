<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>

  <title>갤러리 통계</title>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/es6-promise/4.1.1/es6-promise.auto.js"></script>
<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  
  <style>
    canvas {
      max-width: 600px;
      margin: 20px auto;
      width : 100%;
    }
    .widthclass{
    	width : 1000px;
    	margin : 0 auto;
    }
    .thisGal{
    	font-weight : bold;
    	background-color : "rgb(204, 217, 207)";
    }
    .form-select{
    	width : 90px;
    }
/*    	#exampleModal .form-select{
	width : 25%;
	} */
  </style>
</head>
<body>
	<input type="hidden" id="menuid">
	<div class="d-flex widthclass align-items-center">
		<ul class="nav nav-tabs widthclass mt-3">
			<c:forEach items="${galMenu}" var="gm">
				  <li class="nav-item tabs" id="${gm.menu_id}">
				    <a class="nav-link active" aria-current="page" href="#"  id="${gm.menu_id}" >${gm.menu_name}</a>
				  </li>
		 	 </c:forEach>
		</ul>
		<div class="d-flex">
			<button type="button" class="btn btn-outline-secondary" onclick="pdfPrint()" style="width:150px; height: 40px">PDF파일</button>
			<button type="button" class="btn btn-outline-secondary"  style="width:150px; height: 40px" id="excelModal">엑셀</button>
			
		</div>
	</div>
	<div class="card widthclass">
		<div class="card-body">
			<div class="d-flex justify-content-center gap-1">
				<select id="cntSelect" class="typeSelect form-select">
					<option value="day">일</option>
					<option value="week">주</option>
					<option value="month">월</option>
				</select>
				<select id="cntyearselect" class="form-select">
					<option>2021</option>
					<option>2022</option>
					<option>2023</option>	
				</select>
				<select id="cntmonthselect" class="monthSelect form-select">
					<option  class="timedayop" value="0">All</option>
					<c:forEach var="i" begin="1" end="12" step="1">
						<option  class="timedayop" value="${i}">${i}월</option>
					</c:forEach>	
				</select>
				<button type="button" class="btn btn-outline-secondary"  id="btn1">조회</button>
			</div>
			<canvas id="cntchart"></canvas>
		</div>
	</div>
	
	
	<div class="card widthclass">
		<div class="card-body">
			<div class="d-flex justify-content-center gap-1">
				<select id="likeSelect"  class="typeSelect form-select">
					<option value="day">일</option>
					<option value="week">주</option>
					<option value="month">월</option>
				</select>
				<select id="likeyearselect" class="form-select">
					<option>2021</option>
					<option>2022</option>
					<option>2023</option>	
				</select>
				<select id="likemonthselect" class="monthSelect form-select">
					<option  class="timedayop" value="0">All</option>
					<c:forEach var="i" begin="1" end="12" step="1">
						<option  class="timedayop" value="${i}">${i}월</option>
					</c:forEach>	
				</select>
				<button type="button" class="btn btn-outline-secondary" id="btn2">조회</button>
			</div>
  			<canvas id="likechart"></canvas>
		</div>
	</div>
	
	<div class="card widthclass">
		<div class="card-body">
			<div class="d-flex justify-content-center gap-1">
				<select id="downSelect"  class="typeSelect form-select">
					<option value="day">일</option>
					<option value="week">주</option>
					<option value="month">월</option>
				</select>
				<select id="downyearselect"  class="form-select">
					<option>2021</option>
					<option>2022</option>
					<option>2023</option>	
				</select>
				<select id="downmonthselect" class="monthSelect form-select">
					<option  class="timedayop" value="0">All</option>
					<c:forEach var="i" begin="1" end="12" step="1">
						<option  class="timedayop" value="${i}">${i}월</option>
					</c:forEach>	
				</select>
				<button type="button" class="btn btn-outline-secondary" id="btn3">조회</button>
			</div>
  			<canvas id="downchart"></canvas>
		</div>
	</div>	
	
	<!-- 태그차트 -->  
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
					<option  class="timedayop" value="0">All</option>
					<c:forEach var="i" begin="1" end="12" step="1">
						<option  class="timedayop" value="${i}">${i}월</option>
					</c:forEach>	
				</select>
				<button type="button" class="btn btn-outline-secondary" id="btn4">조회</button>
			</div>
  			<canvas id="tagchart"></canvas>
		</div>
	</div>	

	<!-- 모달 -->
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">일자를 선택해 주세용</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      		<div class="card">
					<div class="card-body">
						<div class="d-flex justify-content-center gap-1">
							<select id="excelSelect"  class="typeSelect form-select">
								<option value="day">일</option>
								<option value="week">주</option>
								<option value="month">월</option>
							</select>
							<select id="excelyearselect"  class="form-select">
								<option>2021</option>
								<option>2022</option>
								<option>2023</option>	
							</select>
							<select id="excelmonthselect" class="monthSelect form-select">
								<option  class="timedayop" value="0">All</option>
								<c:forEach var="i" begin="1" end="12" step="1">
									<option  class="timedayop" value="${i}">${i}월</option>
								</c:forEach>	
							</select>
							<button type="button" class="btn btn-outline-secondary" id="excelDownBtn">다운로드</button>
						</div>
						
					</div>
				</div>	
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	
  <script>
	$(document).ready(function() {
	  	var data = {};
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
	      const downchart = document.getElementById('downchart');
	      // 차트 생성
	      const downchart1 = new Chart(downchart, {
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
			
	      const tagchart = document.getElementById('tagchart');
	      const tagchart1 = new Chart(tagchart, {
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
	 	getDataForChart();
	 	
 	//탭
	
 	$('#btn1').on('click', function(){
 		cntChartChange(); 
 	});
 	$('#btn2').on('click', function(){
 		likeChartChange(); 
 	});
 	$('#btn3').on('click', function(){
 		downChartChange(); 
 	});
 	$('#btn4').on('click', function(){
 		tagChartChange(); 
 	});
    // 데이터셋 생성 함수
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
    
    function getDataForChart(){
  	  let data = {};
  	  
  		$.ajax({
  			type : "GET",
  			url : "/galary/getgalstatistics.do",
  			data: {menu_id : 0},
              contentType : 'application/json',
              success: function(result) {
            	  console.log(result);
              	let cntarr = result.cnt;
              	let likearr = result.likes;
              	let downarr = result.down;
              	let tagarr = result.tags;
              	
              	let cntdata = [];
              	let cntlabel = [];
              	let likedata = [];
              	let likelabel = [];
              	let downdata = [];
              	let downlabel = [];
              	let tagdata = [];
              	let taglabel = [];
              	
              	for(let i=0; i<cntarr.length; i++){
              		cntdata.push(cntarr[i].cnt);
              		let label = cntarr[i].month + "월"
              		cntlabel.push(label);
              	}
              	let title = cntarr[0].year + '년 조회수 추이';
              	cntchart1.data.labels = cntlabel; 
              	cntchart1.data.datasets[0].data = cntdata;
              	cntchart1.options.plugins.title.text = title;
              	cntchart1.data.datasets[0].label = "조회수";

              	cntchart1.update();
                  
                  for(let i=0; i<likearr.length; i++){
                  	likedata.push(likearr[i].cnt);
              		let label = likearr[i].month + "월"
              		likelabel.push(label);
              	}
               title = likearr[0].year + '년 좋아요 수 추이';
     		  	likechart1.data.labels = likelabel; 
	     		likechart1.data.datasets[0].data = likedata;
	     		likechart1.options.plugins.title.text = title;
	     		likechart1.data.datasets[0].label = "좋아요 수";
	     		likechart1.update();
	                  
                  for(let i=0; i<downarr.length; i++){
                  	downdata.push(downarr[i].cnt);
              		let label = downarr[i].month + "월"
              		downlabel.push(label);
              	}
                title = downarr[0].year + '년 다운로드 수 추이';
      			
	     		
    		  downchart1.data.labels = downlabel; 
    		  downchart1.data.datasets[0].data = downdata;
    		  downchart1.options.plugins.title.text = title;
    		  downchart1.data.datasets[0].label = "다운로드 수";

    		  downchart1.update();
    		  
    		  for(let i=0; i<tagarr.length; i++){
                	tagdata.push(tagarr[i].cnt);
            		let label = tagarr[i].month + "월"
            		taglabel.push(label);
            	}
    		  
    		  
              title = tagarr[0].year + '년 태그 클릭 수 추이';
	  		  tagchart1.data.labels = taglabel; 
		  		tagchart1.data.datasets[0].data = tagdata;
		  		tagchart1.options.plugins.title.text = title;
		  		tagchart1.data.datasets[0].label = "태그 클릭 수";
	
	  		  tagchart1.update();
                //updateChart('downchart', downdata, downlabel, title);
				
                 $('#menuid').val(result.menuid);
				
				$('.nav-item').each(function(){
					if($(this).attr('id') == result.menuid){
						$(this).addClass('thisGal');
					}else{
						$(this).removeClass('thisGal')
					}
				})
				
				$('#cntSelect').val('month');
				$('#cntyearselect').val(result.year);
	    		$('.monthSelect').prop('disabled',true);
	    		$('#likeSelect').val('month');
	    		$('#likeyearselect').val(result.year);
	    		$('#downSelect').val('month');
	    		$('#downyearselect').val(result.year);
	    		$('#tagSelect').val('month');
	    		$('#tagyearselect').val(result.year);
	    		
	    		

                 
              },
              error: function(xhr, status, error) {
                  console.log(error);
              }
  		})
    }


	
    //select 비활성화 시키기
    $('.typeSelect').on('change', function(){
    	let val = $(this).val();
    	if(val == 'month'){
    		$(this).parent().find('.monthSelect').prop('disabled',true);
    		$(this).parent().find('.monthSelect').find('option').each(function(){
    			if($(this).val() == 0){
    				$(this).show();
    			}
    		})
    		$(this).parent().find('.monthSelect').val(0);
    	}
    	else{
    		$(this).parent().find('.monthSelect').prop('disabled',false);
    		$(this).parent().find('.monthSelect').find('option').each(function(){
    			if($(this).val() == 0){
    				$(this).hide();
    			}
    		})
    		$(this).parent().find('.monthSelect').val(1);
    	}
    	
    })
    
    
  	//조회수 차트 갈기
  	function cntChartChange(){
    	data = {};
    	let start_date;
    	let end_date;
		let year = $('#cntyearselect').val();
		let month = $('#cntmonthselect').val();
    	let chartype = $('#cntSelect').val();
    	let menuid = parseInt($('#menuid').val());
    	data.chartype= chartype;
    	
    	if(chartype != 'month'){
    		start = new Date(year, month-1,1 );
    		let dayval = new Date(year, month-1, 0).getDate();
			end = new Date(year, month-1,dayval );   
	    	end_date = end.getFullYear() + '-' + ('0' + (end.getMonth() + 1)).slice(-2) + '-' + ('0' + end.getDate()).slice(-2);
	    	start_date = start.getFullYear() + '-' + ('0' + (start.getMonth()+ 1)).slice(-2) + '-' + ('0' + start.getDate()).slice(-2);
    	}else{
    		start = new Date(year, 1,1 );
    		end = new Date(year, 11, 31);
    		end_date = end.getFullYear() + '-' + ('0' + (end.getMonth() + 1)).slice(-2) + '-' + ('0' + end.getDate()).slice(-2);
    		start_date = start.getFullYear() + '-' + ('0' + (start.getMonth())).slice(-2) + '-' + ('0' + start.getDate()).slice(-2);
    	}

    	data.start_date = start_date;
    	data.end_date = end_date;
    	data.menu_id = menuid;
    	
    	console.log(data);
    	
    	
    	$.ajax({
    		url : '/galay/changeCntChart.do',
    		type : 'POST',
    		data : JSON.stringify(data),
        	contentType : 'application/json',
            success: function(result) {
            	console.log(result);
              	let cntarr = result.cnt;
            	let cntdata = [];
              	let cntlabel = [];
              	let title;
              	
              	
              	if(chartype =='day'){
              		for(let i=0; i<cntarr.length; i++){
                  		cntdata.push(cntarr[i].cnt);
                  		let label = cntarr[i].month + "월" + cntarr[i].day + "일"
                  		cntlabel.push(label);
                  	}
                  	title = year + '년' + month + '월 일 별 조회수 추이';
                  	//createChart('cntchart', cntdata, cntlabel, title);
                     
              	}
				
              	if(chartype =='week'){
              		for(let i=0; i<cntarr.length; i++){
                  		cntdata.push(cntarr[i].cnt);
                  		let label = month + "월" + (i+1) + "주"
                  		cntlabel.push(label);
                  	}
                  	title = year + '년'+month+ '월 주 별 조회수 추이';
                  	//updateChart('cntchart', cntdata, cntlabel, title);	
              	}
              	
              	if(chartype =='month'){
              		for(let i=0; i<cntarr.length; i++){
                  		cntdata.push(cntarr[i].cnt);
                  		let label = cntarr[i].month + "월"
                  		cntlabel.push(label);
                  	}
                  	title = cntarr[0].year + '년 조회수 추이';
                  	//updateChart('cntchart', cntdata, cntlabel, title);	
              	}
              	
              	cntchart1.data.labels = cntlabel; 
              	cntchart1.data.datasets[0].data = cntdata;
              	cntchart1.options.plugins.title.text = title;
              	cntchart1.update();

            },
            error: function(xhr, status, error) {
                console.log(error);
            }

    	})
  		
  	}
  	
  	//좋아요 차트 갈기
  	function likeChartChange(){
    	data = {};
    	let start_date;
    	let end_date;
		let year = $('#likeyearselect').val();
		let month = $('#likemonthselect').val();
    	let chartype = $('#likeSelect').val();
    	let menuid = parseInt($('#menuid').val());
    	data.chartype= chartype;
    	
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

    	data.start_date = start_date;
    	data.end_date = end_date;
    	data.menu_id = menuid;
    	
    	console.log(data);
    	
    	
    	$.ajax({
    		url : '/galay/changeLikeChart.do',
    		type : 'POST',
    		data : JSON.stringify(data),
        	contentType : 'application/json',
            success: function(result) {
            	console.log(result);
              	let likearr = result.like;
         
            	let likedata = [];
              	let likelabel = [];
              	let title;
              	
              	
              	if(chartype =='day'){
              		for(let i=0; i<likearr.length; i++){
                  		likedata.push(likearr[i].cnt);
                  		let label = likearr[i].month + "월" + likearr[i].day + "일"
                  		likelabel.push(label);
                  	}
                  	title = year + '년' + month + '일 별 좋아요 수 추이';

                     
              	}
				
              	if(chartype =='week'){
              		for(let i=0; i<likearr.length; i++){
                  		likedata.push(likearr[i].cnt);
                  		let label = month + "월" + (i+1) + "주"
                  		likelabel.push(label);
                  	}
                  	title = year + '년'+month+ '월 주 별 좋아요 수  추이';

              	}
              	
              	if(chartype =='month'){
              		for(let i=0; i<likearr.length; i++){
                  		likedata.push(likearr[i].cnt);
                  		let label = likearr[i].month + "월"
                  		likelabel.push(label);
                  	}
                  	title = year + '년 좋아요 수  추이';

              	}
              	
     		  	likechart1.data.labels = likelabel; 
	     		likechart1.data.datasets[0].data = likedata;
	     		likechart1.options.plugins.title.text = title;
	     		console.log(likechart1);
	     		likechart1.update();
            },
            error: function(xhr, status, error) {
                console.log(error);
            }

    	})
  	}
  	
  	//다운로드 수 차트 갈기
  	function downChartChange(){
    	data = {};
    	let start_date;
    	let end_date;
		let year = $('#downyearselect').val();
		let month = $('#downmonthselect').val();
    	let chartype = $('#downSelect').val();
    	let menuid = parseInt($('#menuid').val());
    	
    	data.chartype= chartype;
    	
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

    	data.start_date = start_date;
    	data.end_date = end_date;
    	data.menu_id = menuid;
    	
    	console.log(data);
    	
    	
    	$.ajax({
    		url : '/galay/changedownChart.do',
    		type : 'POST',
    		data : JSON.stringify(data),
        	contentType : 'application/json',
            success: function(result) {
            	console.log(result);
              	let downarr = result.down;
         
            	let downdata = [];
              	let downlabel = [];
              	
              	if(chartype =='day'){
              		for(let i=0; i<downarr.length; i++){
                  		downdata.push(downarr[i].cnt);
                  		let label = downarr[i].month + "월" + downarr[i].day + "일"
                  		downlabel.push(label);
                  	}
                  	title = year + '년' + month + '일 별 다운로드 수 추이';

                     
              	}
				
              	if(chartype =='week'){
              		for(let i=0; i<downarr.length; i++){
                  		downdata.push(downarr[i].cnt);
                  		let label = month + "월" + (i+1) + "주"
                  		downlabel.push(label);
                  	}
                  	title = year + '년'+month+ '월 주 별 다운로드 수  추이';
              	}
              	
              	if(chartype =='month'){
              		for(let i=0; i<downarr.length; i++){
                  		downdata.push(downarr[i].cnt);
                  		let label = downarr[i].month + "월"
                  		downlabel.push(label);
                  	}
                  	title = year + '년 다운로드 수  추이';

              	}
              	
      		  downchart1.data.labels = downlabel; 
    		  downchart1.data.datasets[0].data = downdata;
    		  downchart1.options.plugins.title.text = title;
    		  downchart1.update();

            },
            error: function(xhr, status, error) {
                console.log(error);
            }

    	})
  	}
  	
  	//태그 차트 갈기
  	function tagChartChange(){
    	data = {};
    	let start_date;
    	let end_date;
		let year = $('#tagyearselect').val();
		let month = $('#tagmonthselect').val();
    	let chartype = $('#tagSelect').val();
    	let menuid = parseInt($('#menuid').val());
    	
    	data.chartype= chartype;
    	
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

    	data.start_date = start_date;
    	data.end_date = end_date;
    	data.menu_id = menuid;
    	
    	console.log(data);
    	
    	
    	$.ajax({
    		url : '/galay/changeTagChart.do',
    		type : 'POST',
    		data : JSON.stringify(data),
        	contentType : 'application/json',
            success: function(result) {
            	console.log(result);
              	let tagarr = result.tag;
         
            	let tagdata = [];
              	let taglabel = [];
              	
/*               	var downchart = Chart.getChart('downchart');
              	if (downchart) {
              		downchart.destroy();
              	}
              	 */
              	if(chartype =='day'){
              		for(let i=0; i<tagarr.length; i++){
              			tagdata.push(tagarr[i].cnt);
                  		let label = tagarr[i].month + "월" + tagarr[i].day + "일"
                  		taglabel.push(label);
                  	}
                  	title = year + '년 ' + month + '월 별 태그 클릭 수 추이';
                      //createChart('downchart', downdata, downlabel, title);
                     
              	}
				
              	if(chartype =='week'){
              		for(let i=0; i<tagarr.length; i++){
              			tagdata.push(tagarr[i].cnt);
                  		let label = month + "월" + (i+1) + "주"
                  		taglabel.push(label);
                  	}
                  	title = year + '년'+month+ '월 주 별 태그 클릭 수  추이';
                      //createChart('downchart', downdata, downlabel, title);	
              	}
              	
              	if(chartype =='month'){
              		for(let i=0; i<tagarr.length; i++){
              			tagdata.push(tagarr[i].cnt);
                  		let label = tagarr[i].month + "월"
                  		taglabel.push(label);
                  	}
                  	title = year + '년 태그 클릭 수  추이';
                    //createChart('downchart', downdata, downlabel, title);	
              	}
              	
  	  		  tagchart1.data.labels = taglabel; 
		  		tagchart1.data.datasets[0].data = tagdata;
		  		tagchart1.options.plugins.title.text = title;
		  		tagchart1.data.datasets[0].label = "태그 클릭 수";
		  		tagchart1.update();

            },
            error: function(xhr, status, error) {
                console.log(error);
            }

    	})  		
  	}
	$('.nav-item').on('click', function(){
		 let data = {};
	  	let menu_id = parseInt($(this).attr('id'));
	  		$.ajax({
	  			type : "GET",
	  			url : "/galary/getgalstatistics.do",
	  			data: {menu_id : menu_id},
	              contentType : 'application/json',
	              success: function(result) {
	            	  console.log(result);
	            	  let cntarr = result.cnt;
	                	let likearr = result.likes;
	                	let downarr = result.down;
	                	
	                	let cntdata = [];
	                	let cntlabel = [];
	                	let likedata = [];
	                	let likelabel = [];
	                	let downdata = [];
	                	let downlabel = [];
	                	
	                	for(let i=0; i<cntarr.length; i++){
	                		cntdata.push(cntarr[i].cnt);
	                		let label = cntarr[i].month + "월"
	                		cntlabel.push(label);
	                	}
	                	let title = cntarr[0].year + '년 조회수 추이';
	                	cntchart1.data.labels = cntlabel; 
	                	cntchart1.data.datasets[0].data = cntdata;
	                	cntchart1.options.plugins.title.text = title;
	                	cntchart1.update();
	                    
	                    for(let i=0; i<likearr.length; i++){
	                    	likedata.push(likearr[i].cnt);
	                		let label = likearr[i].month + "월"
	                		likelabel.push(label);
	                	}
	                 title = likearr[0].year + '년 좋아요 수 추이';
	       		  	likechart1.data.labels = likelabel; 
	  	     		 likechart1.data.datasets[0].data = likedata;
	  	     		likechart1.options.plugins.title.text = title;
	  	     		likechart1.update();
	  	                  
	                    for(let i=0; i<downarr.length; i++){
	                    	downdata.push(downarr[i].cnt);
	                		let label = downarr[i].month + "월"
	                		downlabel.push(label);
	                	}
	                  title = downarr[0].year + '년 다운로드 수 추이';
	        		
	      		  downchart1.data.labels = downlabel; 
	      		  downchart1.data.datasets[0].data = downdata;
	      		  downchart1.options.plugins.title.text = title;
	      		  downchart1.update();
	                  //updateChart('downchart', downdata, downlabel, title);
	  				
	                   $('#menuid').val(result.menuid);
	  				
	  				$('.nav-item').each(function(){
	  					if($(this).attr('id') == result.menuid){
	  						$(this).addClass('thisGal');
	  					}else{
	  						$(this).removeClass('thisGal')
	  					}
	  				})
	              },
	              error: function(xhr, status, error) {
	            	  console.log("에러");
	                  console.log(error);
	              }
	  		})
	})
	
		//엑셀

	
	});//end of documnet ready

	 function pdfPrint(){
			let title = "갤러리 통계";
	        html2canvas(document.body, {
	            onrendered: function (canvas) {

	                var imgData = canvas.toDataURL('image/png');

	                var imgWidth = 210; //a4기준으로 잡기
	                var pageHeight = imgWidth * 1.414;  
	                var imgHeight = canvas.height * imgWidth / canvas.width;
	                var heightLeft = imgHeight;

	                var doc = new jsPDF('p', 'mm');
	                var position = 0;

	                doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
	                heightLeft -= pageHeight;

	                while (heightLeft >= 20) {
	                    position = heightLeft - imgHeight;
	                    doc.addPage();
	                    doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
	                    heightLeft -= pageHeight;
	                }

	                doc.save( title+'.pdf');

	                //이미지로 표현
	                //document.write('<img src="'+imgData+'" />');
	            }
	            
	        });
	        
	    }
	
		$("#excelModal").click(function(e) {
			  e.preventDefault();
			  
			   $('#exampleModal').modal("show");

		})
		
		$('#excelDownBtn').click(function(){
			
			let obj = {};
			let chartype = $('#excelSelect').val();
			let downyear = $('#excelyearselect').val();
			let downmonthSelect = document.getElementById('excelmonthselect');
			let downmonth = downmonthSelect.value;
			let menuid = parseInt($('#menuid').val());
			let start;
			let end;
			let start_date;
			let end_date;

			obj.chartype= chartype;

	    	if(chartype != 'month'){
	    		start = new Date(downyear, downmonth-1,1 );
	    		let dayval = new Date(downyear, downmonth-1, 0).getDate();
				end = new Date(downyear, downmonth-1,dayval );   
		    	end_date = end.getFullYear() + '-' + ('0' + (end.getMonth() + 1)).slice(-2) + '-' + ('0' + end.getDate()).slice(-2);
		    	start_date = start.getFullYear() + '-' + ('0' + (start.getMonth()+ 1)).slice(-2) + '-' + ('0' + start.getDate()).slice(-2);
	    	}else{
	    		start = new Date(downyear, 1,1 );
	    		end = new Date(downyear, 11, 31);
	    		end_date = end.getFullYear() + '-' + ('0' + (end.getMonth() + 1)).slice(-2) + '-' + ('0' + end.getDate()).slice(-2);
	    		start_date = start.getFullYear() + '-' + ('0' + (start.getMonth())).slice(-2) + '-' + ('0' + start.getDate()).slice(-2);
	    	}
	    	
	    	obj.start_date = start_date;
	    	obj.end_date = end_date;
	    	obj.menu_id = menuid;
	    	obj.chartype= chartype;
			
	    	let data = JSON.stringify(obj);
	    	
	    	$.ajax({
	    		url : '/galary/getExcelfile.do',
	    		data : data,
	    		type : 'POST',
	    		contentType : 'application/json',
	            success: function(result) {
	            	

	            },
	            error: function(xhr, status, error) {
	                console.log(error);
	            }
	    	})
	    	
		})

  </script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
  
</body>
</html>


