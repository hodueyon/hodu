<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공통코드관리 트리형</title>


<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<style>
	#littleMenu>li{
		display : inline-block;
		margin-right : 30px;
	}
	main{
		width : 1000px;
		margin : 0 auto;
	}
	.sections{
		margin : 30px 0;
	}
	#kt_docs_jstree_basic{
		font-size: x-large;
	}
	.bgColor{
		background-color :yellow;
	}
	#littleMenu{
		background-color : beige;
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
				<input type="text" id="upper" class="form-control" style="width:300px">
				<label >설명</label>
				<textarea id="expalin" class="form-control" style="width:300px"></textarea>
				<button onclick="inputUpper()" class="btn btn-primary">등록</button>
			</div>
			
				<!-- 소분류 등록  -->
				<div class="card" style="padding: 10px">
					<h4>소분류 등록</h4>
					<label for="uppperSelc">대분류</label>
					<select id="uppperSelc"  class="form-select" style="width:300px">
						 <c:forEach items="${uppers}" var="upper">
							<option value="${upper.upper_id}" class="upperOp">${upper.upper_name}</option>
						</c:forEach>
					</select>
					<label for = "sub">소분류 명</label>
					<input type="text" id="sub" class="form-control" style="width:300px">
					<br>
					<label >설명</label>
					<textarea id="explain" class="form-control" style="width:300px"></textarea>
					<button onclick="subUpper()" class="btn btn-primary">등록</button>
				</div>
			</div>
		
			
			<!-- 삭제버튼들 -->
			<div class="sections d-flex justify-content-center">
				<button type="button" class="btn btn-danger" onclick="delUpper()" style="margin : 5px">대분류 선택 삭제</button>
				<button type="button" class="btn btn-danger" onclick="delSub()" style="margin : 5px">소분류 선택 삭제</button>
			</div>
		
		
		
		<!-- 트리-->
		<div class="d-flex justify-content-around sections">
			<div id="kt_docs_jstree_basic">
			    <ul>
			        <c:forEach items="${uppers}" var="u">
							<li id="${u.upper_id}"  style="cursor:pointer;">
								<span class="upperLi" style="padding:0 3px;" id="${u.upper_id}">${u.upper_id} / ${u.upper_name }</span> 
								<input type="checkbox" class="upperdelchks" value="${u.upper_id}" >
								<input type="hidden" value="${u.upper_name}" id="hiddenname">
								<input type="hidden" value="${u.expalin}" id="hiddenexpalin">
								<div class="subdiv"></div>
							</li>
					</c:forEach>
			    </ul>
			</div>
			
			
				<div id="upperSubInfo"  class="d-flex">
					<div id="upperInfoDiv" style="margin : 10px">
						<label for ="upperinfoid">대분류 코드</label>
						<input type="text" id="upperinfoid" class="form-control readonly"  readonly>
						<label for ="upperinfo">대분류명</label>
						<input type="text" id="upperinfo" class="form-control readonly" readonly>
						<Br>
						<label for="upperDesc">대분류 설명</label>
						<textarea  id="upperDesc" class="form-control readonly"  readonly></textarea>					
						<button type="button" class="btn btn-primary " id="upperInfoModifyBtn" >대분류 수정</button>
						<div style="display:none" id="upperModifyFrmBtns">
							<button type="button" id="updateUpperBtn">수정</button>
							<button type="button" class="cancelModify">취소</button>
						</div>
					</div>
					<div id="subInfoDiv" style="margin : 10px">
						<label for ="subinfoid">소분류 코드</label>
						<input type="text" id="subinfoid" class="form-control readonly"  readonly>
						<label for ="subinfoname">소분류명</label>
						<input type="text" id="subinfoname" class="form-control readonly"  readonly>
						<Br>
						<label for="subDesc">소분류설명</label>
						<textarea  id="subDesc" class="form-control readonly"  readonly></textarea>					
						<button type="button" class="btn btn-primary " id="subInfoModifyBtn">소분류 수정</button>
						<div style="display:none" id="subModifyFrmBtns">
							<button type="button" id="updateSubBtn">수정</button>
							<button type="button" class="cancelModify">취소</button>
						</div>
					</div>
				</div>
		
		</div>
	</main>
</body>
<script>
	
	var data = {};
	
	function search(){
		let word = $('#search_word').val();
		let type = $('.types:selected').val(); 
		location.href="/admin/commoncodeTree.do?search_type="+type+"&search_word="+word;
	}
	
	//대분류등록
	function inputUpper(){
		let uppername = $('#upper').val();
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
		
		function inputinc(){
			 $.ajax({
					url : '/admin/inputUpper.do',
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
	
	
	//소분류등록
	function subUpper(){
		let upperid = $('.upperOp:selected').val();
		let sub_name = $('#sub').val();
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
		//모든 입력칸 그냥 비우자
    	$('#subinfoid').val(' ');
    	$('#subinfoname').val(' ');
    	$('#subDesc').val(' ');

		//모든 입력칸 그냥 비우자
    	$('#subinfoid').val(' ');
    	$('#subinfoname').val(' ');
    	$('#subDesc').val(' ');
    	$('#upperinfoid').val(' ');
    	$('#upperinfo').val(' ');
    	$('#upperDesc').val(' ');
    	
    	
		$('#subInfoDiv').css("display", "block");
		$('#upperInfoDiv').css("display", "block");
		$('.readonly').prop('readonly', true);
		$('#subModifyFrmBtns').css("display", "none");
		$('#upperModifyFrmBtns').css("display", "none");
		$('#upperInfoModifyBtn').css("display", "block");
		$('#subInfoModifyBtn').css("display", "block");
		
		
    	
    	
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
	
	
	//하나의 값 띄우기
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
		    	
		    },
		    error: function(jqXHR, textStatus, errorThrown) {
		        console.log("Error: " + textStatus + " - " + errorThrown);
		    }
		});
		
	});
	
	//이벤트전파 방지
	 /* $('.upperLi').children().click(function(event) {
	  event.stopPropagation();
	});   */
	//소분류 불러오기~~!!!! 
	$('.upperLi').on("click", function(){
		let upperid = $(this).attr("id");
        var upper = document.querySelector("#" + upperid + ".upperLi").parentNode;
        var div = upper.querySelector(".subdiv");
        $('#upperinfoid').val(upperid);
        let namee  = $(this).parent().find('#hiddenname').val();
        console.log(namee);
    	$('#upperinfo').val(namee);
    	let desc = $(this).parent().find('#hiddenexpalin').val();
    	$('#upperDesc').val(desc);
		//var div = document.createElement('div');
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
		
		div.innerHTML = '';
		$('.upperLi[id!=upperid]').parent().children('.subdiv').empty();
		
		  $.ajax({
	          url: "/admin/getSubCommCode.do",
	          type: "POST",
	          data: JSON.stringify({upper_id : upperid}),
	          dataType: "json",
	          contentType: 'application/json',
	          success: function(data) {
        	  	var ul = document.createElement('ul');
	            if(data.length <=0){
            	var li = document.createElement('li');	
	            	li.innerHTML = '소분류가 없습니다';
	           		 ul.appendChild(li);
	            }
	           
	            for(var i =0; i<data.length; i++){

	            	var li = document.createElement('li');
	            	var span = document.createElement('span');
	            	li.id = data[i].sub_id;
	            	li.style.cursor = 'pointer';
	            	span.innerHTML = data[i].upper_id + '-' + data[i].sub_id + '/' + data[i].sub_name;
	            	li.appendChild(span);
	            	span.classList.add('getSubInfo');
	            	span.id = data[i].sub_id;
	            	span.style.marginRight = '10px';
	            	var checkbox = document.createElement('input');
	            	
	            	checkbox.type = 'checkbox';
	            	checkbox.classList.add('subdelchks');
	            	checkbox.value = data[i].sub_id;
					
	            	li.appendChild(checkbox);
	            	 ul.appendChild(li);
	            }
	           
	            let upid = "#"+upperid;
	            div.appendChild(ul);
	            upper.appendChild(div);
	          },
	          error: function(jqXHR, textStatus, errorThrown) {
	            console.log("Error: " + textStatus + " - " + errorThrown);
	          }
	    }); 
	    
	   
	})
</script>
</html>