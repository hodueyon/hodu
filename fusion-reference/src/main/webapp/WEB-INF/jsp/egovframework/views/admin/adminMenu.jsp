<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자메뉴</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<style>
	table{
		text-align : center;
	}
	label{
		margin-right : 5px;
		
	}
	#inputMenuFrm>div>input{
		margin-right : 15px; 
	}
	#inputMenuFrm>div>select{
		margin-right : 15px; 
	}
	#inputmenubtn{
	margin-top : 10px;
	}
</style>
</head>
<body>
	<div style="width : 60%; margin :30px auto;">
		<h3>메뉴</h3>
		<table class="table table-hover">
			<tr>
				<th>게시판 이름</th>
				<th>카테고리</th>
				<th>권한</th>
				<th></th>
				
			</tr>
			<c:forEach items="${menulists}" var="menu">
				<tr class="infoTr${menu.menu_id}">
					<td>${menu.menu_name}</td>
					<td id="${menu.menu_url}">${menu.m_category_name}</td>
					<td id=${menu.auth_id}>${menu.auth_name}</td>
					<td>
						<c:if test="${sessionScope.auth eq 1}">
							<button type="button" class="delMenuBtn btn btn-danger" value="${menu.menu_id}" onclick="delMenu(this)">삭제</button> 
						
							<button type="button" class="delMenuBtn btn btn-info" value="${menu.menu_id}" onclick="openUpdateFrm(this)">수정</button> 
						</c:if>	
					</td>
				</tr>
				<tr class="updateFrm" id="${menu.menu_id}" style="display:none">
					<c:if test="${menu.menu_category ne 5}">
					<td colspan="2">
						<input type="text" class="form-control updateInput"  maxlength="10" id="upNameInput">
						<input type="hidden" id="menuid">
						<input type="hidden" id="menucategory">
					</td>
					<td style="text-align : center">
							<select class="form-select selectauth" id="updateAuthSelect" style=" width:50%; margin : 0 auto;">
								<c:forEach items="${authes}" var="a" >
									<option value=${a.auth_id}>${a.auth_name}</option>
								</c:forEach>
							</select>
					</td>
					<td>	
						<button type="button" class="btn btn-primary updateDoBtn" onclick="updateDo(this)" value=${menu.menu_category}>수정</button>
					</td>
					</c:if>
					
					<c:if test="${menu.menu_category eq 5}">
						<td>
							<input type="text" class="form-control updateInput"  maxlength="10" id="upNameInput" >
							<input type="hidden" id="menuid">
						</td>
						<td>
							<label for="linkInput">링크</label>
							<input type="text" id="linkInput" class="form-control" maxlength="30">
						</td>
						<td style="text-align : center">
								<select class="form-select selectauth" id="updateAuthSelect" style=" width:50%; margin : 0 auto;">
									<c:forEach items="${authes}" var="a" >
										<option value=${a.auth_id}>${a.auth_name}</option>
									</c:forEach>
								</select>
						</td>
						<td>	
							<button type="button" class="btn btn-primary updateDoBtn" onclick="updateDo(this)" value=${menu.menu_category}>수정</button>
						</td>
					</c:if>
				</tr>	
			</c:forEach>
		</table>
	</div>
	<c:if test="${sessionScope.auth eq 1}">
		<div id="inputMenuFrm" style=" width : 60%; margin : 0 auto; text-align : center">
			<h3>메뉴 등록</h3>	
			<div style="margin: 0 auto; width : 80%; " class="d-flex align-items-center justify-content-center">
				
				<label  class="form-label">✔️ 메뉴이름</label>
				<input type="text" id="menu_name" class="form-control" style="width:200px;" maxlength="10">
				<label  class="form-label">✔️ 카테고리</label>
				<select class="selectcategory form-select"  style="width:200px;">
					<c:forEach items="${category}" var="c">
						<c:if test="${c.m_category_id ne 4 and c.m_category_id ne 6 and c.m_category_id ne 3}">
							<option value=${c.m_category_id}>${c.m_category_name}</option>
						</c:if>
					</c:forEach>
				</select>
					<label class="form-label">✔️ 권한</label>
				<select class="form-select selectauth" style="width:200px;">
					<c:forEach items="${authes}" var="a" >
						<option value=${a.auth_id}>${a.auth_name}</option>
				</c:forEach>
				</select>
			</div>
				<div id="urlInputFrm" style="display:none" style="width:80%;">
				<label  class="form-label">url</label><input type="text" class="form-control" style="width:80%; margin : 0 auto;" id="urlInput">
				</div>
				<button type="button" id="inputmenubtn" class="btn btn-primary" onclick="inputMenu()">메뉴등록</button>
			
		</div>
	</c:if>		
</body>
<script>
	var data = {};
	
	$('.updateInput').change(function(){
		var name = this.value;
		console.log(name);
		 var input = $(this);
		input.removeClass("changeName");
		
		 $.ajax({
				url: '/menu/ckMenuName.do',
				method: 'POST',
				data: JSON.stringify({menu_name:name}),
				contentType : 'application/json', 
				success: function (result) {
						if(result >= 1){
							alert("중복되는 메뉴명입니다.");
			                input.val("");
						}else{
							input.addClass("changeName");
						}
				},
				error: function (error) {
					console.log(error);
					alert('실패');
				}
			});	 
		 
		 
	});
	
	//권한수정시
	$('#updateAuthSelect').on('change', function() {
	    var updateselect = $(this);
	    updateselect.addClass("updateAuth");
	    	    	    
	});
	//입력 바뀔때 이름 중복되는지 확인ㅎㅎ
	$('#menu_name').change(function(){
		
		var name = this.value;
		console.log(name);
		
		 $.ajax({
				url: '/menu/ckMenuName.do',
				method: 'POST',
				data: JSON.stringify({menu_name:name}),
				contentType : 'application/json', 
				success: function (result) {
						if(result >= 1){
							alert("중복되는 메뉴명입니다.");
							$('#menu_name').val("");
						}
				},
				error: function (error) {
					console.log(error);
					alert('실패');
				}
			});	 
	})
	//메뉴수정폼열기
	function openUpdateFrm(a){
		let aid = a.value;
		let menuname = $('.infoTr'+aid).children('td:eq(0)').text();
		let authid = $('.infoTr'+aid).children('td:eq(2)').attr('id');
		let url = $('.infoTr'+aid).children('td:eq(1)').attr('id');
		console.log(url);
		//console.log(authid);
		console.log(aid);
		/* $('.updateFrm#'+aid).find('select option[value="'+authid+'"]').prop('selected', true);
		$('.updateFrm#'+aid).find('input[id="upNameInput"]').val(menuname);
		$('.updateFrm#'+aid).find('input[id="linkInput"]').val(url);
		$('.updateFrm#'+aid).find('input[id="menuid"]').val(aid); */
		$('.updateFrm').each(function() {
			  if ($(this).attr('id') === aid) {
				$(this).find('select option[value="'+authid+'"]').prop('selected', true);
				$(this).find('input[id="upNameInput"]').val(menuname);
				$(this).find('input[id="linkInput"]').val(url);
				$(this).find('input[id="menuid"]').val(aid);
			    $(this).css('display', 'table-row');
			  }
			});
		}
	
	//수정!
	function updateDo(a){
		data = {};
		let tr = a.parentNode.parentNode;
		console.log(tr);
		let menuname= tr.querySelector('td:first-child input[id="upNameInput"]').value;
		
		let menuid = tr.querySelector('td:first-child input[type="hidden"]').value;
		let auth_id; 
		let url;
		let nameinput  = tr.querySelector('td:first-child input[type="text"]');
		let select = tr.querySelectorAll('td')[1].querySelector('select')
		
		if(event.target.value != 5){
			auth_id = tr.querySelectorAll('td')[1].querySelector('select').value;
			data.menu_url = url;
		}
		
		if(event.target.value == 5){
			 url = tr.querySelector('td:nth-child(2) input[id="linkInput"]').value;
			auth_id = tr.querySelectorAll('td')[2].querySelector('select').value;
			data.menu_url = url;
		}
		
		
		data.menu_name = menuname;
		data.menu_id = menuid;
		data.auth_id = auth_id;
		//onsole.log(menuname.length);
		if(menuname == ''){
			alert("메뉴명을 입력해 주세요");
			return false;
		}
		if(event.target.value == 5){
			if(url == ''){
				alert("링크를 입력해주세요");
				return false;
			}else{
				data.menu_url = url;
			}
		}
		
		
 		  $.ajax({
			url: '/menu/updateMenu.do',
			method: 'POST',
			data : JSON.stringify(data),
			contentType : 'application/json', 
			success: function (result) {
/* 
				if(nameinput.classList.contains('changeName') && !select.classList.contains("updateAuth")){
					document.location.reload();	
				} 
				 if(select.classList.contains("updateAuth")){ 
					location.href="/user/main.do";
				 }  */
				document.location.reload();
			},
			error: function (error) {
				console.log(error);
				alert('실패');
			}
		});	  
		
	}
	
	//메뉴삭제
	function delMenu(a){
		let menuid = a.value;
		
		if(confirm("삭제 시 돌이킬 수 없습니다")){
			location.href = "/menu/delMenu.do?menu_id="+menuid;	
		}

	}
	//메뉴등록
	function inputMenu(){
		data = {};
		data.menu_name = $('#menu_name').val();
		data.auth_id = $(".selectauth option:selected").val();
		data.menu_category = $(".selectcategory option:selected").val();
		
		if($('#menu_name').val()== ''){
			alert("메뉴명을 입력해 주세요");
			return false;
		}
		if($(".selectcategory option:selected").val() == 5){
			if($('#urlInput').val().trim().length ==0 ){
				alert("링크를 입력해 주세요!");
				return false;
			}
		}
		
		let a = $(".selectcategory option:selected").val();
		switch (a) {
		  case '1':
		    data.menu_url = "/board/boardList.do?menu_id=";
		    break;
		  case '2':
			  data.menu_url = "/galary/galaryList.do?menu_id=";
		    break;
		  case '3':
			  data.menu_url = "/board/boardList.do?menu_id=";
		    break;
		  case '4':
			  data.menu_url = "/board/boardList.do?menu_id=";
			break;
		  case '5':
			  data.menu_url = $('#urlInput').val();
			  break;
		  default:
			  data.menu_url = 0;
		}
		console.log(data);
		
		  $.ajax({
				url: '/menu/inputMenu.do',
				method: 'POST',
				data : JSON.stringify(data),
				contentType : 'application/json', 
				success: function (result) {
					document.location.reload();
				},
				error: function (error) {
					console.log(error);
					alert('실패');
				}
			});	 
	}
	//url창 나타나게 하기 
	$('.selectcategory').change(function(){
		let select = $(".selectcategory option:selected").val();

		if(select == 5){
			$('#urlInputFrm').css('display', 'block');
		}else{
			$('#urlInputFrm').css('display', 'none');	
		}
		
		
	})
	
</script>
</html>