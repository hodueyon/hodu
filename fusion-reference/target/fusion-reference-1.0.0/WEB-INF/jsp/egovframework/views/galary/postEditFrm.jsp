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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<title>퓨전 게시판(수정)</title>
<style>
	.remove{
		border : 2px solid red;
	}
	.delete{
		display : none;
	}
	.removeTag{
		text-decoration: line-through ;
		text-decoration-color : red;
	}
	.deleteTag{
		display : none;
	}
	.deleteTagNonUse{
		display : none;
	}
	.tags{
		margin-right : 10px;
	}
</style>
</head>
<body>
	<main class="mt-5 pt-5">
	<div class="container-fluid px-4" style="width:50%">
		<h1 class="mt-4">갤러리 수정</h1>
		<div class="card mb-4">
			<div class="card-body">
				<form  id="registerFrm">
					<input type="hidden" name="galary_id" value="${galaryPost.galary_id}" />
					<div class="mb-3">
						<label for="category" class="form-label">✔️ 분류</label>
						<input type="radio" class="flexRadioDefault" id="category" name="category" value=1>동물
						<input type="radio" class="flexRadioDefault" id="category" name="category" value=2>음식
						<input type="radio" class="flexRadioDefault" id="category" name="category" value=3>풍경
						<input type="radio" class="flexRadioDefault" id="category" name="category" value=4>캐릭터
					</div>
					<div class="mb-3">
						<label for="title" class="form-label">✔️ 제목</label>
						<input type="text" class="form-control" id="title" name="title" value="${galaryPost.title}" minlength="1" maxlength="30" required>
					</div>
					<div class="mb-3">
						<div class="d-flex justify-content-between align-items-center">
						<label for="content" class="form-label">✔️ 이미지</label>
							<div class="align-items-center">		
								<input type="file" class="custom-file-input" name="uploadFiles" id="uploadFiles" multiple accept="image/*" >
								<button type="button"  class="btn btn-sm btn-outline-secondary" id="deleteImg" id="inputImageBtn">선택 이미지 삭제</button>
							</div>
						</div>
						<p style="margin: 6px 0; color: gray">첨부된 이미지를 삭제하시려면 해당 이미지들을 클릭 후 선택 이미지 삭제를 눌러주세요!</p>
						<c:set var="listSize" value="${fn:length(Images)}" /> 
						<div class="d-flex">
							<c:forEach items="${Images}" var="image">
							      <img src="/resize/${image.file_route}"  class="inputImages" alt="..."  width="${100/listSize}%" id="${image.media_id}" name="${image.original_name}">   
							 </c:forEach>
						</div>
						
					</div>
					<div class="mb-3">
						<label for="nail" class="form-label">✔️ 썸네일고르기</label>
						<ul id="thumnailCadidate">
							<c:forEach items="${Images}" var = "image">
								<li><span  id="${image.media_id}">${image.original_name}</span><input type="radio" class="thumbnail-choice" name="thumbnail"></li>
							</c:forEach>
						</ul>
					</div>
					<div class="mb-3">
						<label for="content" class="form-label">✔️ 내용</label>
						<textarea class="form-control" id="content" name="content" minlength="1" maxlength="500" required>${galaryPost.content}</textarea>
					</div>
					<div class="mb-3">
						<label for="writer" class="form-label">✔️ 작성자</label>
						<input type="text" class="form-control" id="writer" value="${galaryPost.user_name}" disabled>
					</div>
					<div class="mb-3">
						<div class="d-flex justify-content-between align-items-center">
						<label for="content" class="form-label">✔️ 태그</label>
							<div class="d-flex align-items-center">
								<div class="d-flex" style="height:31.666px">
									<input type="text" class="form-control" id="inputTagFrm" minlength="1" maxlength="10">
									<button type="button" style="display: flex;" class="btn btn-sm btn-outline-secondary" onclick="addTag()">+</button>	
								</div>
								<button type="button"  class="btn btn-sm btn-outline-secondary" id="deleteTag" >선택 태그 삭제</button>
							</div>
						</div>
						<p style="margin: 6px 0; color: gray">태그를 삭제하시려면 해당 태그들을 클릭 후 선택 태그 삭제를 눌러주세요!</p>
						<div class="d-flex justify-content-start align-items-center" id="tagList">
							<c:if test="${not empty taglist}">
							<c:forEach items="${taglist}" var="t">
								<div id="${t.tag_id}" class="tags">
		              		  		<span ># ${t.tag_name}</span>
		              		  	</div>
		              		 </c:forEach>
		              		 </c:if>
						</div>
						<ul id="tag-list">
						</ul>	
					</div>
					<button class="btn btn-outline-warning" id="submitbtn" type="button">수정하기</button>
				</form>
			</div>
		</div>
	</div>
	</main>
</body>
<script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript">

	var inputImages = [];
	var deleteImages = [];
	var delTagsArr = [];
	var addTagArr = [];
	var liveTags = [];
	//이름 비교 위한 것
	var imageNameList = [];
	var thumnailChoice = '';
	
	$(document).ready(function() {
		//라디오버튼 체크시키기
		 var cvalue = ${galaryPost.category}; 
		
		 $(":radio[name='category'][value='" + cvalue + "']").attr('checked', true);
		  /* $(".categories").each(function() {
		    if ($(this).val() === value) {
		    	console.log($(this).val())
		      $(this).prop("checked", true); 
		    }
		  }); */ 
		  


		  
		//등록되는 이미지 배열에 넣기 
		$(".inputImages").each(function() {
		    var id = $(this).attr("id");
		    let name = $(this).attr("name");
		    inputImages.push(id);
		    //이름 리스트에 넣기
		    imageNameList.push(name);
		});
	
	
		 console.log(inputImages.length);
		if(inputImages.length >=5){
			$("#uploadFiles").hide();
		}
		
		//활성화된 태그들리스트에 넣기
		$(".tags").each(function(){
			var id= $(this).attr("id");
			liveTags.push(id);
		})
	
	});
	

	
	 console.log(inputImages.length);
	//등록되는? 이미지? 리스트 뽑기
	function makeInputImageArray(){
		inputImages = [];
		$(".inputImages").each(function() {
		    var id = $(this).attr("id");
		    let name = $(this).attr("name");
		    inputImages.push(id);
		    imageNameList.push(name);

		});	
	}
	
	//삭제배열만들기 
	function makedelImageArr(){
		 deleteImages = [];	
		 $(".delete").each(function() {
			    var id = $(this).attr("id");
			    deleteImages.push(id);
			});
	}
	

	console.log(inputImages);
	
	//이미지 클릭시 삭제 이미지 후보로 선정하는 클래스로 지정하기 -> 재 클릭시 취소한다
	$('img').on("click", function(){
		console.log($(this).prop('id'));
		  // 버튼에 'active' 클래스가 있는지 확인
	    if ($(this).hasClass('remove')) {
	      // 'active' 클래스가 있으면 제거
	      $(this).removeClass('remove');
	    } else {
	      // 'active' 클래스가 없으면 추가
	      $(this).addClass('remove');
	    }
	})
	
	//삭제 버튼 누르면 삭제되는 이미지 클래스 넣어주고, 삭제이미지 배열에 넣고, 해당클래스는 안보이게 하기 - > confirm추가하기
	$("#deleteImg").on("click", function(){
        var removes = $('.remove');
        var deletes = $('.delete');
        if (removes.length === 0) {
          alert('선택된 요소가 없습니다!');
        } else {
        	if(confirm("정말로 삭제하시겠습니까")){
        		removes.removeClass('inputImages remove').addClass('delete');

        		//배열 다시 만들기  		
        		makedelImageArr();
        		inputImages = inputImages.filter(item => !deleteImages.includes(item));
        		console.log(inputImages);
        		console.log(deleteImages);
        		
        		//썸네일 리스트에서도 안보이게
        		var liElements = document.getElementsByTagName('li');
				for (var i = 0; i < liElements.length; i++) {
					 var spanValue = liElements[i].querySelector('span').id;
					  if (deleteImages.includes(spanValue)) {
					    liElements[i].classList.add('delete');
					}//end if
        	}//end for
        }
        }
	})
	
	 
	
	//추가시 이미 있는 이미지들과 같은 이름이라면 등록 불가능하게 하기 !
	//파일 갯수 확인
	//파일아이디
	var fileInput = document.getElementById('uploadFiles');
	
	//파일 들어갈때 
	fileInput.addEventListener('change', function(e) {
	  //배열초기화
	  makeInputImageArray();
	  
	// ul 요소의 자식 요소들 중에서 동적으로 추가된 요소들을 삭제합니다.
	  var ultag = document.getElementById('thumnailCadidate');
	  var addFile = ultag.querySelectorAll('.added');
	  for (var i = 0; i < addFile.length; i++) {
		  ultag.removeChild(addFile[i]);
	  }
	  
	  var files = e.target.files;
	  
	  let filelistsize = inputImages.length;

	  // 최대 5개의 파일만 허용
	  if (files.length + filelistsize > 5) {
		  let n = 5-filelistsize;
	    alert('최대' + n+  '개의 파일만 선택할 수 있습니다.');
	    // 파일 선택을 취소하고 입력한 파일들을 초기화
	    fileInput.value = null;
	    return;
	  }
	  
	  //중복되는거 있는지 없는지 체크
	  for (var i = 0; i < files.length; i++) { 
		  var fileSize = files[i].size / 1024 / 1024; // 파일 크기(MB) 계산
		  
		  if(imageNameList.indexOf(files[i].name) > 0)  {
			  alert("중복되는 이미지가 이미 존재합니다 !");
			  fileInput.value = null;
			    return;
			}
           if (!files[i].type.match('image.*')) {
              alert('이미지 파일만 업로드할 수 있습니다.');
              fileInput.value = null;
              return;
          }
           if (fileSize > 10) {
               alert('최대 10MB까지만 업로드할 수 있습니다.');
               fileInput.value = null;
               return;
           }
      }
	  
	  let fileList = '';
	
	  for (var i = 0; i < files.length; i++) {
		  var li = document.createElement('li');
		  li.className = 'added';
		  inputImages.push(files[i].name);

          var span = document.createElement('span');
          span.textContent = files[i].name;
          li.appendChild(span);
          
          var radio = document.createElement('input');
          radio.type = 'radio';
          radio.name = 'thumbnail';
          radio.className = 'thumbnail-choice'
          li.appendChild(radio);
          
          target2 = document.getElementById('thumnailCadidate');
          target2.append(li);
          console.log(inputImages);
      }
	  
	});
	
	
	//삭제할 태그 리스트 만들기 
	function makeDelTagAry(){
		delTagsArr = [];
				$(".deleteTag").each(function() {
				    var id = $(this).attr("id");
				    delTagsArr.push(id);
				});	
	}
	
	
	//활성화되는 태그 리스트 만들기
	function makeLiveTagAry(){
		liveTags = [];
		$(".tags").each(function(){
			var id= $(this).attr("id");
			liveTags.push(id);
		})
	}
	
	//추가되는 태그 만들기 
	function makeAddTagAry(){
		addTagArr = [];
		$(".newTag").each(function(){
			var id= $(this).attr("id");
			addTagArr.push(id);
		})
	}
	
	//태그 클릭시 삭제 태그  후보로 선정하는 클래스로 지정하기 -> 재 클릭시 취소한다
	$('.tags').on("click", function(){
		console.log($(this).prop('id'));
	    if ($(this).hasClass('removeTag')) {
	      // 'active' 클래스가 있으면 제거
	      $(this).removeClass('removeTag');
	    } else {
	      // 'active' 클래스가 없으면 추가
	      $(this).addClass('removeTag');
	    }
	})
	
	//태그 삭제
	/*  $("#deleteTag").on("click", function(){
	    var removes = $('.removeTag');
        var deletes = $('.deleteTag');
        if (removes.length === 0) {
          alert('삭제할 태그가 없습니다');
        } else {
        	if(confirm("정말로 삭제하시겠습니까")){
        		if ($(this).hasClass('newTag')){
        			removes.removeClass('removeTag newTag').addClass('deleteTag');
        			//추가되는 배열 다시 만들기 
        			makeAddTagAry();
        		}else{
        			removes.removeClass('removeTag newTag').addClass('deleteTag');
            		deletes.each(function() {
            			deleteImages.push($(this).attr('id'));
            			console.log(deleteImages);
                    });
            		//배열 다시 만들기 
            		makeDelTagAry();
            		makeLiveTagAry()
            		makeAddTagAry();
            		console.log(delTagsArr);
            		console.log(addTagArr);
        		}
        	}
        }
	}) 
	 */
	//태그삭제
	document.getElementById("deleteTag").addEventListener("click", function() {
	  // DOM 함수를 적용할 요소들의 선택자를 지정
	  var removessss = document.querySelectorAll(".removeTag");
	  
	  // DOM 함수를 적용할 로직을 구현
	  for (var i = 0; i < removessss.length; i++) {  
		if (removessss[i].classList.contains("newTag")) {
		  removessss[i].classList.remove("removeTag"); // 
		  removessss[i].classList.remove("newTag");
		  removessss[i].classList.remove("tags");
		  removessss[i].classList.add("deleteTagNonUse"); 
		  }else{
			  removessss[i].classList.remove("removeTag");
			  removessss[i].classList.remove("tags");
			  removessss[i].classList.add("deleteTag");  
		  }
		makeDelTagAry();
		makeLiveTagAry()
		makeAddTagAry();
		console.log(liveTags);
		console.log(delTagsArr);
		console.log(addTagArr);
		
	  }
	});
	
	//태그 넣기
	function addTag(){
		makeLiveTagAry();

		let inputTagVal = $("#inputTagFrm").val();
		console.log(inputTagVal);
		
		//공백확인
		if($("#inputTagFrm").val().trim() == ''){
			alert("입력하세요!");
			return;
		}
		if($.inArray(inputTagVal, liveTags) != -1){
			alert("중복되는 태그입니다!");
			return;
		}
		
		if(liveTags.length >= 5){
			alert("태그는 5개까지 등록할 수 있습니다");
			return;
		}
		
	/* 	liveTags.push(inputTagVal);
		addTagArr.push(inputTagVal); */

		//일단 ul li태그 입력 - 보이게 하는것
		let tagdiv = $('<div>').prop({
			            id: inputTagVal,
			            innerText: inputTagVal,
			            class: 'tags newTag'
			        });
		tagdiv.on("click", function(){
						console.log($(this).prop('id'));
					    if ($(this).hasClass('removeTag')) {
					      $(this).removeClass('removeTag');
					    } else {
					      $(this).addClass('removeTag');
					    }
					})
		 $('#tagList').append(tagdiv);
		
		//입력창 초기화;
		$("#inputTagFrm").val("");
		//넣을 태그 목록 만들기 
		makeAddTagAry();
		makeLiveTagAry();
		console.log(liveTags);
		console.log(addTagArr);
	}
	
	//썸네일로 인증받은자식
	$(document).on('click', '.thumbnail-choice', function() {
	    // 클릭된 input 요소의 다음 형제인 span 요소의 텍스트 값을 가져옴
	    let textValue = $(this).prev('span').text();
	    console.log(textValue); // 
	    thumnailChoice = textValue;
	});
		
	//
	
	//폼 서브밋
	$("#submitbtn").on("click", function(){
		//다 들어갔는지 확인하기
		 var thumnailcadidatelist = document.getElementsByClassName('thumbnail-choice');
		 //var li = thumbnailCandidateList.querySelectorAll('li');  
			var category = document.getElementsByName('category');
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
		    if(inputImages.length ==0){
		    	alert("이미지 파일이 하나도 없습니다! 추가해주세요");
		    	return false;
		    }
		    if(!thumnail){
		    	alert("썸네일 사진을 골라주세요!");
		    	return false;
		    }
		    
		   

		console.log(thumnailChoice);
		let data = new FormData(document.getElementById("registerFrm"));
		//삭제할 태그
		if(delTagsArr.length>0){
			for(let i=0; i<delTagsArr.length; i++){
				data.append('delTagArr', delTagsArr[i]);
			}	
		}
		
		//삭제할 이미지 데이터에 넣기
		if(deleteImages.length>0){
			for(let i=0; i<deleteImages.length; i++){
				data.append('imgDelArr', deleteImages[i]);
			}	
		}
		 
		//추가되는 태그들
		if(addTagArr.length>0){
			for(let i=0; i<addTagArr.length; i++){
				data.append('tagArr', addTagArr[i]);
			}		
		}
		
		let nowThumnail = '${thumnail.original_name}';
		let nowThumnailid = '${thumnail.media_id}';
		console.log(nowThumnail);
		console.log(nowThumnailid);
		
		//현재썸네일이랑 비교
		if(nowThumnail != thumnailChoice){
			data.append("original_name" ,thumnailChoice);
			data.append("nowThumnailId", nowThumnailid);
		}
		
		//삭제할 이미지목록
		deleteImages
		console.log(deleteImages);
		//삭제할 태그목록
		delTagsArr
		console.log(delTagsArr);
		//넣을 태그목록
		addTagArr
		console.log(addTagArr);
		//썸네일로 체크된 사진이름
		console.log(thumnailChoice);

		//data.append('original_name', thumnail);
		console.log(inputImages);
		
		data.forEach(function(value, key){
			  console.log(key + ': ' + value);
		});
		
		 //아작스 !
		 $.ajax({
				url: '/galary/editGalaryPost.do',
				enctype: 'multipart/form-data',
				method: 'POST',
				processData: false,
				contentType: false,
				data: data,
				success: function (result) {
					alert("수정되었습니다!");
					galId = ${galaryPost.galary_id};
					location.href="/galary/galaryPost.do?galary_id="+galId;
				},
				error: function (error) {
					console.log(error);
					alert('실패');
				}
			})  
		 
	
	})
	
	

</script>
</html>