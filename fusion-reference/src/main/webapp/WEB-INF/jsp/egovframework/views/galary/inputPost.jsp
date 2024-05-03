<%
/*********************************************************
 * 업 무 명 : 게시판 컨트롤러
 * 설 명 : 게시판을 조회하는 화면에서 사용 
 * 작 성 자 : 김민규
 * 작 성 일 : 2022.10.06
 * 관련테이블 : 
 * Copyright ⓒ fusionsoft.co.kr
 *
 *********************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<title>퓨전 게시판(작성)</title>
</head>
<body>
	<main class="mt-5 pt-5">
	<div class="container-fluid px-4" style="width:50%">
		<h1 class="mt-4">게시글 작성</h1>
		<div class="card mb-4">
			<div class="card-body">
				<form id="registerFrm" method="post">
					<input type="hidden" value=${menu_id} name="menu_id">
					<div class="mb-3">
						<label for="category" class="form-label">분류</label>
						<input type="radio" class="flexRadioDefault" id="category" name="category" value=1>동물
						<input type="radio" class="flexRadioDefault" id="category" name="category" value=2>음식
						<input type="radio" class="flexRadioDefault" id="category" name="category" value=3>풍경
						<input type="radio" class="flexRadioDefault" id="category" name="category" value=4>캐릭터
					</div>
					<div class="mb-3">
						<label for="title" class="form-label">제목</label>
						<input type="text" class="form-control" id="title" name="title" value="" minlength="1" maxlength="30" required>
					</div>
					<div class="mb-3">
						<label for="content" class="form-label">내용</label>
						<textarea class="form-control" id="content" name="content" value="" minlength="1" maxlength="500" required></textarea>
					</div>
					<div class="mb-3">
						<label for="content" class="form-label">이미지</label>
						<input id="uploadFiles" class="custom-file-input" type="file" name="uploadFiles" accept="image/*"  multiple required/>
				<!-- 이미지미리보기 -->
						<div id="imagePreview"></div>
				<!-- 썸네일고르기 -->
						 <div id="fileList">
    					</div>
					</div>
					<div class="mb-3">
						<label for="title" class="form-label">태그</label>
						
						<p style="color:gray">입력하신 태그를 삭제하시려면 해당 태그를 클릭하세요</p>
						<input type="text" class="form-control" id="inputTagFrm" minlength="1" maxlength="10" >
						<button type="button" onclick="addTag()">태그 추가</button>
						<ul id="tag-list">
						</ul>
				</div>
					<button class="btn btn-outline-warning" type="button" id="submitbtn">등록하기</button>
				</form>
				<!-- <div class="mb-3">
						<label for="title" class="form-label">태그</label>
						<input type="text" class="form-control" id="inputTagFrm"  minlength="1" maxlength="30" required>
						<button onclick="addTag()">태그 추가</button>
						<ul id="tag-list">
						</ul>
				</div> -->
			</div>
		</div>
	</div>
	</main>
</body>
<script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function() {
		 
	});
	var tags = [];
	var menuid = ${menu_id};
	
	//태그삭제
	var taglist = document.getElementsByTagName('li');
	
	for (var i = 0; i < taglist.length; i++) {
			taglist[i].addEventListener("click", function() {
		    console.log(this.innerHTML);
	
		    //배열에서 있는지 없는지 체크 후 있으면 삭제
		    var itemIndex = tags.indexOf(this.innerHTML);
		    if (itemIndex !== -1) {
		    	tags.splice(itemIndex, 1);
		    }
		    
		  	//사라지게
		    this.remove();
		  	console.log(tags);
		  });
	};
	
	//썸네일 고를때 음 파일명 뜨는거
	  $("input[type=file]").change(function () {
          var fileInput = document.getElementById("uploadFiles");
         
          var files = fileInput.files;
          var file;
          let fileList = '<p>'+"썸네일 고르기"+'</p>';
          if (files.length > 5) {
      	    alert('최대 5개의 파일만 선택할 수 있습니다.');
      	    // 파일 선택을 취소하고 입력한 파일들을 초기화
      	    fileInput.value = null;
      	    return;
      	  }
          for (var i = 0; i < files.length; i++) {
              var fileSize = files[i].size / 1024 / 1024; // 파일 크기(MB) 계산
              if (fileSize > 10) {
                  alert('최대 10MB까지만 업로드할 수 있습니다.');
                  fileInput.value = null;
                  return;
              }
              else if (!files[i].type.match('image.*')) {
                  alert('이미지 파일만 업로드할 수 있습니다.');
                  fileInput.value = null;
                  return;
              }
          
              //썸네일 고르기 목록에 넣기 
           	  fileList += '<span>' + files[i].name + '</span>' +
                 '<input type="radio" class="thumbnail-choice" name="thumbnail" data-filename="' + files[i].name + '">' + '<br>';
                 
                 target2 = document.getElementById('fileList');
                 target2.innerHTML =fileList;
                  
               $('#imagePreview').empty();
               
              //이미지미리보기
                 const reader = new FileReader();
                 reader.onload = (e) => {
                   const img = document.createElement('img');
                   img.src = e.target.result;
                   img.style.maxWidth = '100px';
                   img.style.maxHeight = '100px';
                   img.style.marginRight = '10px';
                   imagePreview.appendChild(img);
                 };

                 reader.readAsDataURL(files[i]);    

      }
	  });
	
	let selectedFileName = '';
	//체크된 값 가져오기
	  $('body').on('change', 'input[type=radio].thumbnail-choice', function() {
       selectedFileName = $(this).data('filename');
      console.log('선택된 파일 이름: ', selectedFileName);
    });

	
	var counter = 0;
	
	function addTag(){
		let inputTagVal = $("#inputTagFrm").val();
		console.log(inputTagVal);
		
		//공백확인
		if($("#inputTagFrm").val().trim() == ''){
			alert("입력하세요!");
			return;
		}
		if($.inArray(inputTagVal, tags) != -1){
			alert("중복되는 태그입니다!");
			return;
		}
		
		if(tags.length >= 5){
			alert("태그는 5개까지 등록할 수 있습니다");
			return;
		}
		
		tags.push(inputTagVal);
		console.log(tags);
		
		//일단 ul li태그 입력 - 보이게 하는것
		var tag = document.createElement("li");
		var text = document.createTextNode(inputTagVal);
		tag.appendChild(text);
		document.getElementById("tag-list").appendChild(tag);
		
		//동적으로 만든쿼리는 이래야된다..
		tag.addEventListener("click", function() {
		    console.log(this.innerHTML);
			
		    if(confirm("정말로 삭제하시겠습니까")){
		    	var itemIndex = tags.indexOf(this.innerHTML);
			    if (itemIndex !== -1) {
			        tags.splice(itemIndex, 1);
			    }

			    this.remove();
			    console.log(tags);	
		    }
		    
		});

		//입력창 초기화;
		$("#inputTagFrm").val("");
		

	}
	
	
	
	
	
	function checkRadioBtns() {
		 var fileInput = document.getElementById("uploadFiles");
         var files = fileInput.files;
	    var category = document.getElementsByName('category');
	    var thumnailcadidatelist = document.getElementsByClassName('thumbnail-choice')
	    var checked = false;
	    var thumnail = false;

	    for (var i = 0; i < category.length; i++) {
	        if (category[i].checked) {
	            checked = true;
	            break;
	        }
	    }
	    for(var i=0; i< thumnailcadidatelist.length; i++){
	    	if(thumnailcadidatelist[i].checked){
	    		thumnail = true;
	    		break;
	    	}
	    }
	    
	    if (!checked) {
	        alert('카테고리을 선택해주세요.');
	        return false;
	    }
	    
	    if($("#title").val().trim() == ''){
	    	 alert('제목 입력 해주세요!');
	    	 return false;
	    }
	    
	    if($("#content").val().trim() == ''){
	    	alert("내용을 입력 해주세요!");
	    	return false;
	    }
	    if(files.length ==0){
	    	alert("이미지 파일을 등록해 주세요!");
	    	return false;
	    }
	    if(!thumnail){
	    	alert("썸네일 사진을 골라주세요!");
	    	return false;
	    }
	    
	    return true;
	}
	
	//폼 서브밋
	$("#submitbtn").on("click", function(){
		
		if(checkRadioBtns()){
		
//		let data = new FormData($('#registerFrm')[0]);
		let thumnail = $('input.thumbnail-choice:checked').data('filename');
		console.log(thumnail);
		let data = new FormData(document.getElementById("registerFrm"));
		
		for(let i=0; i<tags.length; i++){
			data.append('tagArr', tags[i]);
		}
		data.append('original_name', thumnail);
		
		for (let key of data.keys()) {
			console.log(key, ":", data.get(key));
		}
		 console.log('data!!!!!' + data);
		
		//console.log(data.keys());
		
 		 $.ajax({
			url: '/galary/insGalaryPost.do',
			method: 'POST',
			enctype: 'multipart/form-data',
			data: data,
			processData: false,
			contentType: false,
			success: function (result) {
				alert("성공");
				location.href="/galary/galaryList.do?menu_id="+menuid;
			},
			error: function (error) {
				console.log(error);
				alert('실패');
			}
		}) 
		 
		
		}//end if
	})
	
 
	
</script>
</html>