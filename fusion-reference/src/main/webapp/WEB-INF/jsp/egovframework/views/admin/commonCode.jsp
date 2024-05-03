<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공통 코드 관리</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<style>
	#upperTable>tr>td{
		cursor: pointer;
	}
	
	.upperTblTr{
		cursor: pointer;
	}
	.ChoiceTr{
		background-color : pink;
	}
	li{
		display : inline-block;
	}
	main{
		width : 1000px;
		margin : 0 auto;
	}
	.sections{
		margin : 30px 0;
	}
	table{
		margin : 10px;
	}
	#subTable{
		width : 200px;
	}
	#subTable>thead>tr{
		width : 200px;
	}
	.bgColor{
		background-color: yellow;
	}
	#littleMenu{
		background-color : beige;
	}
	#littleMenu>li{
	display : inline-block;
	margin-right : 30px;
	}
</style>
</head>
<body>
	<main>
	<h2>공통코드관리</h2>
	
	<ul id="littleMenu">
		<li><a href="/admin/commoncodelist.do">표</a></li>
		<li><a href="/admin/commoncodeTree.do">트리</a></li>
	</ul>
	
	<!-- 검색창!!  -->
	<div class="d-flex justify-content-center sections" >
		<select name="search_type" class="form-select" style="width:100px; margin-right : 5px" id="searchTypeSelect">
			<option value="codeId" class="types">코드</option>
			<option value="codeName" class="types">코드명</option>
		</select>
		<input type="text" id="search_word" class="form-control w-50" style="margin-right : 5px" >
		<button type="button" id="searchBtn" class="btn btn-primary" onclick="search()">검색</button>
	</div>
	<!-- 등록/수정폼 -->
	<div class="d-flex justify-content-around sections" >
		<div class="card" style="padding: 10px">
			<h4>대분류 등록</h4>
			<label for = "upper">대분류 명</label>
			<input type="text" id="upper" class="form-control" style="width:300px" maxlength = "10">
			<label >설명</label>
			<textarea id="expalin" class="form-control" style="width:300px" maxlength="30"></textarea>
			<button onclick="inputUpper()" class="btn btn-primary">등록</button>
		</div>
		
			<!-- 소분류 등록  -->
			<div class="card" style="padding: 10px">
				<h4>소분류 등록</h4>
				<label for="uppperSelc">대분류</label>
				<select id="uppperSelc"  class="form-select" style="width:300px"  >
					 <c:forEach items="${uppers}" var="upper">
						<option value="${upper.upper_id}" class="upperOp">${upper.upper_name}</option>
					</c:forEach>
				</select>
				<label for = "sub">소분류 명</label>
				<input type="text" id="sub" class="form-control" style="width:300px"  maxlength = "10">
				<br>
				<label >설명</label>
				<textarea id="explain" class="form-control" style="width:300px" maxlength="30"></textarea>
				<button onclick="subUpper()" class="btn btn-primary">등록</button>
			</div>
		</div>
		<!-- 삭제버튼들 -->
		<div class="sections d-flex justify-content-center">
			<button type="button" class="btn btn-danger" onclick="delUpper()" style="margin : 5px">대분류 선택 삭제</button>
			<button type="button" class="btn btn-danger" onclick="delSub()" style="margin : 5px">소분류 선택 삭제</button>
		</div>
		<!-- 데이터 -->
		<div style="margin: 0 auto;" class="d-flex justify-content-around sections">
			<table class="table table-bordered" style="width: 200px;" id="upperTable">
				<thead>
					<tr>
						<th>대분류 공통코드</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${uppers}" var="u">
					<tr class="upperTblTr" id="${u.upper_id}">
						<td>${u.upper_id}/${u.upper_name} <input type="checkbox" class="upperdelchks" value="${u.upper_id}">
							<input type="hidden" value="${u.upper_name}">
							<input type="hidden" value="${u.expalin}">
						</td>
					</tr>
				</c:forEach>
					<tr>
					
				</tbody>
			</table>
			
			<table id="subTable" style="display:none" class="table table-bordered">
				<thead>
					<tr>
						<th>소분류 공통코드</th>
					</tr>
				</thead>
			</table>
			
			<div id="upperSubInfo">
				<div id="upperInfoDiv" class="sections">
					<label for ="upperinfoid">대분류 코드</label>
					<input type="text" id="upperinfoid" class="form-control readonly"  readonly>
					<label for ="upperinfo">대분류명</label>
					<input type="text" id="upperinfo" class="form-control readonly"  maxlength = "10" readonly>
					<Br>
					<label for="upperDesc">대분류 설명</label>
					<textarea  id="upperDesc" class="form-control readonly"  maxlength="30" readonly ></textarea>					
					<button type="button" class="btn btn-primary " id="upperInfoModifyBtn" >대분류 수정</button>
					<div style="display:none" id="upperModifyFrmBtns">
						<button type="button" id="updateUpperBtn" class="btn btn-primary">수정</button>
						<button type="button" class="cancelModify btn btn-primary">취소</button>
					</div>
				</div>
				<div id="subInfoDiv" class="sections">
					<label for ="subinfoid">소분류 코드</label>
					<input type="text" id="subinfoid" class="form-control readonly"  readonly>
					<label for ="subinfoname">소분류명</label>
					<input type="text" id="subinfoname" class="form-control readonly"  readonly  maxlength = "10">
					<Br>
					<label for="subDesc">소분류설명</label>
					<textarea  id="subDesc" class="form-control readonly"  maxlength="30" readonly></textarea>					
					<button type="button" class="btn btn-primary " id="subInfoModifyBtn">소분류 수정</button>
					<div style="display:none" id="subModifyFrmBtns">
						<button type="button" id="updateSubBtn" class="btn btn-primary">수정</button>
						<button type="button" class="cancelModify btn btn-primary">취소</button>
					</div>
				</div>
			</div>
		</div>
	</main>
</body>
<script>
	var data = {};
	
	//검색
	function search(){
		let word = $('#search_word').val();
		let type = $('.types:selected').val(); 
		location.href="/admin/commoncodelist.do?search_type="+type+"&search_word="+word;
	}
	//대분류등록
	function inputUpper(){
		let uppername = $('#upper').val().trim();
		let expalin = $('#expalin').val();

		data.upper_name = uppername;
		data.expalin = expalin;
		console.log(data);
		
		//빈칸검사
		if($('#upper').val().trim().length <=0){
			alert("대분류 명을 입력해 주세요");
			return false;
		}
		
		if($('#expalin').val().trim().length <=0){
			alert("설명을 입력해 주세요");
			return false;
		}
		
		//중복 검사 
		$.ajax({
			url : "/admin/upperDuplicateCk.do",
			type: "POST",
			data: JSON.stringify(data),    
			dataType: "json",
			contentType: 'application/json',
          	success: function(data) {
          		if(data == 0){
          			inputinc();
          		}else{
          			alert("중복된 대분류 명입니다.")
          			$('#upper').val(" ");
          			return false;
          		}
          	},
          	error: function(jqXHR, textStatus, errorThrown) {
	            console.log("Error: " + textStatus + " - " + errorThrown);
	          }	
		});
		
/* 		function inputinc(){
			 $.ajax({
					url : '/admin/inputUpper.do',
					data: JSON.stringify(data),
					type : "POST",
		          	dataType: "json",
		          	contentType: 'application/json',
		          	success: function(result) {
		          		if(result != "success"){
		          			alert(result);
		          		}
		          		document.location.reload();
		          	},
		          	error: function(error) {
			         	if(error.status === 418) {
			         		alert("i'm a teapot");
			         	}
		          	}
				}); 	
		} */
		
		//fetch -> header : 클라이언트가 서버로 보내는 요청이나 서버가 클라이언트로 보내는 응답과 관련된 메타데이터를 포함합니다.
		//
		
		function inputinc(){
			fetch('/admin/inputUpper.do',{
				method : 'POST',
				headers : {
				      'Content-Type': 'application/json'
				},
				body : JSON.stringify(data)
			})
			.then(response =>{
				if(response.status === 418){
					//alert("z가 아니네요~~~");
					throw new Error("z가 아닙니다");
				}
				return response.json();
			})
			.then(result => {
		      if (result !== 'success') {
		        alert(result);
		      }
		      document.location.reload();
		    })		
			.catch(error => {
		      	alert(error.message);
		    });
		}
		
	}
	
	
	//소분류등록
	function subUpper(){
		let upperid = $('.upperOp:selected').val();
		let sub_name = $('#sub').val().trim();
		let explain = $('#explain').val();
		
		data.sub_name  = sub_name;
		data.upper_id = upperid;
		data.explain = explain;
		
		//빈칸검사
		if($('#sub').val().trim().length <=0){
			alert("소분류명을 입력해 주세요");
			return false;
		}
		
		if($('#explain').val().trim().length <=0){
			alert("설명을 입력해 주세요");
			return false;
		}
		
		//중복 검사 
		$.ajax({
			url : "/admin/subDuplicateCk.do",
			type: "POST",
		    data: JSON.stringify({sub_name: sub_name
		    						, upper_id : upperid}),    
		    dataType: "json",
		    contentType: 'application/json',
          	success: function(data) {
          		if(data == 0){
          			inputsubind();
          		}else{
          			alert("중복된 소분류 명입니다.")
          			$('#sub').val(" ");
          			return false;
          		}
          	},
          	error: function(jqXHR, textStatus, errorThrown) {
	            console.log("Error: " + textStatus + " - " + errorThrown);
	          }	
		});
		
		
		function inputsubind(){
			
			$.ajax({
				url : '/admin/inputSub.do',
				data: JSON.stringify(data),
				type : "POST",
	          	dataType: "json",
	          	contentType: 'application/json',
	          	success: function(result) {
	          		document.location.reload();
	          	},
	          	error: function(jqXHR, textStatus, errorThrown) {
		            console.log("Error: " + textStatus + " - " + errorThrown);
		         }
			}); 	
		}
	}
	//대분류삭제
	function delUpper(){
		var numArr = [];
		let upperid ='';
		let delcanyn = '';
		$('.upperdelchks:checked').each(function(){
			upperid = $(this).val();
			numArr.push(upperid);
		})
		data.numArr = numArr;

		$.ajax({
	          url: "/admin/delbeforeCks.do",
	          type: "POST",
	          data: JSON.stringify({numArr: numArr}),
	          dataType: "json",
	          contentType: 'application/json',
	          success: function(data) {
	  				if(data == 'false'){
	  					delcanyn = 'false';
	  					alert("소분류가 존재해 삭제가 불가능합니다");
	  					return false;
	  				}
	  				if(data == 'true'){
	  					delcanyn = 'true';
	  					delUpperCode();
	  				}
	          },
	          error: function(jqXHR, textStatus, errorThrown) {
	            console.log("Error: " + textStatus + " - " + errorThrown);
	          }
	    });
		
		console.log(delcanyn);
		
		
		function delUpperCode(){
			$.ajax({
				url :"/admin/delUpperCode.do",
				type: "POST",
		          data: JSON.stringify(data),
		          contentType: 'application/json',
		          success: function(data) {
		        	  alert("삭제완료");
		        	  document.location.reload();	
		          },
		          error: function(jqXHR, textStatus, errorThrown) {
		            console.log("Error: " + textStatus + " - " + errorThrown);
		          }
			}); 	
		}	

	};
	
	//소분류삭제
	function delSub(){
		var numArr = [];
		let upperid ='';
		let delcanyn = '';
		$('.subdelchks:checked').each(function(){
			upperid = $(this).val();
			numArr.push(upperid);
		})
		data.numArr = numArr;
		

		$.ajax({
			url :"/admin/delSubCode.do",
			type: "POST",
	          data: JSON.stringify(data),
	          contentType: 'application/json',
	          success: function(data) {
	        	  alert("삭제완료");
	        	  document.location.reload();	
	          },
	          error: function(jqXHR, textStatus, errorThrown) {
	            console.log("Error: " + textStatus + " - " + errorThrown);
	          }
		}); 	
			
	}
	
	
	//대분류 수정
	$('#updateUpperBtn').on("click", function(){
    	let expalin = $('#upperDesc').val();
    	let upper_id = $('#upperinfoid').val();
    	let upper_name = $('#upperinfo').val();
    	
    	data.expalin = expalin;
    	data.upper_id = upper_id;
    	data.upper_name = upper_name;
    	console.log(data);
    	
    	//빈칸검사
		if($('#upperinfo').val().trim().length <=0){
			alert("대분류 명을 입력해 주세요");
			return false;
		}
		
		if($('#upperDesc').val().trim().length <=0){
			alert("설명을 입력해 주세요");
			return false;
		}
    	
    	//중복체크
    	$.ajax({
			url : "/admin/upperDuplicateCk.do",
			type: "POST",
		    data:  JSON.stringify(data),
		    dataType: "json",
		    contentType: 'application/json',
          	success: function(data) {
          		if(data == 0){
          			updateInc();
          		}else{
          			alert("중복된 대분류 명입니다.")
          			$('#upperinfo').val("");
          			return false;
          		}
          	},
          	error: function(jqXHR, textStatus, errorThrown) {
	            console.log("Error: " + textStatus + " - " + errorThrown);
	          }	
		});
    	
    	function updateInc(){
    		$.ajax({
  	          url: "/admin/updateUpperCode.do",
  	          type: "POST",
  	          data: JSON.stringify(data),
  	          dataType: "json",
  	          contentType: 'application/json',
  	          success: function(data) {
  	        	  alert("수정완료");
  	        	  document.location.reload();	
  	          },
  	          error: function(jqXHR, textStatus, errorThrown) {
  	            console.log("Error: " + textStatus + " - " + errorThrown);
  	          }
  	    	});	
    	}

	})
	//소분류 수정
	$('#updateSubBtn').on("click", function(){
    	let sub_id = $('#subinfoid').val();
    	let sub_name = $('#subinfoname').val();
    	let explain = $('#subDesc').val();
    	let upperid = $('#upperinfoid').val();
    	data.explain = explain;
    	data.sub_id = sub_id;
    	data.sub_name = sub_name;
    	data.upper_id = upperid;
    	console.log(data);
    	
    	
    	//증복검사
    	$.ajax({
			url : "/admin/subDuplicateCk.do",
			type: "POST",
		    data: JSON.stringify(data),    
		    dataType: "json",
		    contentType: 'application/json',
          	success: function(data) {
          		if(data == 0){
          			updatesubinc();
          		}else{
          			alert("중복된 소분류 명입니다.")
          			$('#subinfoname').val("");
          			return false;
          		}
          	},
          	error: function(jqXHR, textStatus, errorThrown) {
	            console.log("Error: " + textStatus + " - " + errorThrown);
	          }	
		});
    	
    	function updatesubinc(){
    		$.ajax({
  	          url: "/admin/updateSubCode.do",
  	          type: "POST",
  	          data: JSON.stringify(data),
  	          dataType: "json",
  	          contentType: 'application/json',
  	          success: function(data) {
  	        	  alert("수정완료");
  	        	  document.location.reload();	
  	          },
  	          error: function(jqXHR, textStatus, errorThrown) {
  	            console.log("Error: " + textStatus + " - " + errorThrown);
  	          }
  	    });	
    	}
    	
	})
	
	//취소버튼
	$('.cancelModify').on("click",function(){
		
		$('#subInfoDiv').css("display", "block");
		$('#upperInfoDiv').css("display", "block");
		$('.readonly').prop('readonly', true);
		$('#subModifyFrmBtns').css("display", "none");
		$('#upperModifyFrmBtns').css("display", "none");
		$('#upperInfoModifyBtn').css("display", "block");
		$('#subInfoModifyBtn').css("display", "block");
		
		//모든 입력칸 그냥 비우자
    	$('#subinfoid').val(' ');
    	$('#subinfoname').val(' ');
    	$('#subDesc').val(' ');
    	$('#upperinfoid').val(' ');
    	$('#upperinfo').val(' ');
    	$('#upperDesc').val(' ');
	})
	//대분류수정 폼 열기
	$('#upperInfoModifyBtn').on("click", function(){
		
		$('#upperInfoDiv').find('.readonly#upperinfo').removeAttr('readonly');
		$('#upperInfoDiv').find('.readonly#upperDesc').removeAttr('readonly');

		$('#subInfoDiv').css("display", "none");
		$('#upperInfoModifyBtn').css("display", "none");
		$('#upperModifyFrmBtns').css("display", "block");
	})
	//소분류 수정폼 열기
	$('#subInfoModifyBtn').on("click", function(){
		
		$('#subInfoDiv').find('.readonly#subinfoname').removeAttr('readonly');
		$('#subInfoDiv').find('.readonly#subDesc').removeAttr('readonly');


		$('#upperInfoDiv').css("display", "none");
		$('#subInfoModifyBtn').css("display", "none");
		$('#subModifyFrmBtns').css("display", "block");
	})
	
	//소분류 정보 가져오기
	$(document).on("click", ".getSubInfo", function() {
		let id = $(this).attr('id');

		$.ajax({
		    url: "/admin/getUpperSubInfo.do",
		    type: "POST",
		    data: {upper_id: id},
		    dataType: "json",
		    success: function(data) {
		    	$('#upperinfoid').val(data.upper_id);
		    	$('#upperinfo').val(data.upper_name);
		    	$('#upperDesc').val(data.expalin);
		    	$('#subinfoid').val(data.sub_id);
		    	$('#subinfoname').val(data.sub_name);
		    	$('#subDesc').val(data.explain);
		  		
		    	$('#upperSubInfo').css("display", "block");
		    	
		    },
		    error: function(jqXHR, textStatus, errorThrown) {
		        console.log("Error: " + textStatus + " - " + errorThrown);
		    }
		});
		
	});

	//해당하는 소분류 조회
	$('.upperTblTr').on("click", function(){
	    $("#subTable").empty();
	    
		var theId = $(this).attr('id');
	    $(this).addClass('ChoiceTr');
	    let subtable = $("#subTable");
	    $('.upperTblTr[id!=tr]').removeClass('ChoiceTr');
	    let name  = $(this).find(':nth-child(2)').val();
	    let desc = $(this).find(':nth-child(3)').val();
	    $('#upperinfoid').val(theId);
    	$('#upperinfo').val(name);
    	$('#upperDesc').val(desc);
    	$('#subinfoid').val(' ');
    	$('#subinfoname').val(' ');
    	$('#subDesc').val(' ');
    	
    	//초기화
    	$('#subInfoDiv').css("display", "block");
		$('#upperInfoDiv').css("display", "block");
		$('.readonly').prop('readonly', true);
		$('#subModifyFrmBtns').css("display", "none");
		$('#upperModifyFrmBtns').css("display", "none");
		$('#upperInfoModifyBtn').css("display", "block");
		$('#subInfoModifyBtn').css("display", "block");
		
	    $.ajax({
	          url: "/admin/getSubCommCode.do",
	          type: "POST",
	          data: JSON.stringify({upper_id: theId}),
	          dataType: "json",
	          contentType: 'application/json',
	          success: function(data) {
	        	  console.log(data);
	            var thead = $("<thead>");
	            var tbody = document.createElement('tbody');
	            let thtr = $('<tr>');
	            thtr.append($('<th>').text('소분류 공통코드'));
	            thead.append(thtr);
	            subtable.append(thead);
	            console.log(data.length);
	            if(data.length <=0){
	            	
	            	var tr = document.createElement('tr');
	            	var td = document.createElement('td');
	            	var span = document.createElement('span');
	            	span.innerHTML = '소분류가 없습니다';
	            	td.appendChild(span);
	            	tr.appendChild(td);
	            	tbody.appendChild(tr);
	            }
	            
	            for(var i = 0; i<data.length; i++){	
	            	var tr = document.createElement('tr');
	            	var td = document.createElement('td');
	            	td.classList.add('getSubInfo');
	            	td.id = data[i].sub_id;

	            	var span = document.createElement('span');
	            	span.innerHTML = data[i].upper_id + '-' + data[i].sub_id +'/' + data[i].sub_name;
	            	var checkbox = document.createElement('input');
	            	checkbox.type = 'checkbox';
	            	checkbox.classList.add('subdelchks');
	            	checkbox.value = data[i].sub_id;

	            	td.appendChild(span);
	            	td.appendChild(checkbox);
	            	tr.appendChild(td);
	            	tbody.appendChild(tr);
	            }
            	var tr = document.createElement('tr');
            	var td = document.createElement('td');
            	td.classList.add('inputTd');
            	td.id = theId;
            	var span = document.createElement('span');
            	span.innerHTML = '➕';
            	td.style.textAlign = "center";
            	td.appendChild(span);
            	tr.appendChild(td);
            	tbody.appendChild(tr);

	            subtable.append(tbody);
	          },
	          error: function(jqXHR, textStatus, errorThrown) {
	            console.log("Error: " + textStatus + " - " + errorThrown);
	          }
	    });
	    
	    $("#subTable").css("display", "block");
	});

	//더하기 클릭했을때 소분류 추가하기
	$(document).on("click", ".inputTd", function() {
		let parent =  $(this).attr('id');
		$("#uppperSelc").val(parent).attr("selected", "selected");
		
	})
	//대분류 더하기 클릭햇을때 대분류 추가하기 
	
</script>
</html>