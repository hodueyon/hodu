<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous"></head>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<title>글 등록</title>
<script src="https://cdn.ckeditor.com/4.17.1/standard/ckeditor.js"></script>
<script src="https://cdn.ckeditor.com/4.17.1/standard/lang/ko.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
   .ck.ck-editor {
    	max-width: 800px;
    	margin : 0 auto;
	}
	.ck-editor__editable {
	    min-height: 400px;
	}
  .ck-content { font-size: 12px; }
  
  table {
  	text-align : center;
  }
  tr{
  	cursor : pointer;
  }	
	main{
		width : 1000px;
		margin : 0 auto;
	}
</style>
</head>
<body>
	<!-- 검색 -->
	<main>
	<!-- ck editor -->

		<h1 class="mt-4">게시글 수정</h1>
		<form action="/sns/inputSns.do" method="POST" style="width: 1000px; margin : 0 auto">
	      <div class="d-flex">
		      <label for="title"  class="form-label">제목</label>
		      <input type="text" id="title"  class="form-control" value="${boardPost.title}" maxlength="30" required>
	      </div>
	      <div class="d-flex">
	      	<input type="hidden" id="hiddenCon" value='<c:out value="${boardPost.content}" escapeXml="true"/>'>
	      	<label for="manage"  class="form-label">관리자</label>
	      	<input type="text" class="form-label" id="manager" value="${boardPost.mag_name}" required disabled>
	      	<input type="hidden" class="form-label" id="hiddenmanager" value="${boardPost.manager}">
	      	<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" id="manageBtn">
				관리자 고르기
			</button>
	      </div>
	     <input type="hidden" value="${menu_id}" name="menu_id" id="hiddenMenuid"> 
	      <textarea name="content" id="editor"></textarea>
	   		<input type="button" id="updateBtn" class="btn btn-primary mt-3 mx-2"  value="수정" />
	   		<input type="reset" id="resetBtn" class="btn btn-primary mt-3 mx-2" value="취소"  />
	    </form>
	
	
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">검토받을 관리자를 골라주세요</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        	<table class="table">
	        		<thead>
	        			<tr>
	        				<th>아이디</th>
	        				<th>이름</th>
	        			</tr>
	        		</thead>
	        		<c:forEach items="${manageList}" var="m" >
	        		<tbody>
		        		<tr onclick="choiceManagerInc(this)" id="${m.user_id}">
	        				<td>${m.user_name}</td>
	        				<td>${m.real_name}</td>
		        		</tr>
	        		</tbody>
	        		</c:forEach>
	        	</table>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	</main>
</body>

<script>
	var data = {};
	var content;
	var length;
	var replacecon;
	
	var cntperpage = ${cntPerPage};
	var nowpage = ${nowPage};
	var menuid= ${menu_id};
	var id= ${boardPost.board_id};
	var progress = "${boardPost.progress}";
	
	
	CKEDITOR.replace('editor', {
		filebrowserUploadUrl : '/progress/imageUpload.do?',
		language: 'ko',
		on: {
			change: function() {
				content = this.getData();
				length = this.getData().trim().length;
				replacecon = this.getData().replaceAll('<p>', '').replaceAll('</p>', '')
								.replaceAll('&nbsp;', '').replaceAll('<strong>', '')
								.replaceAll('</strong>','').replaceAll('<s>', '')
								.replaceAll('<em>', '').replaceAll('</s>','')
								.replaceAll('</em>', '').trim().length;
	
	
				//글자수 제한
				if(length >4000){
					alert("작성 범위를 초과했습니다.");
				}
	
			}
		}
	});
	
	var content = $('#hiddenCon').val();
	 CKEDITOR.instances.editor.setData(content);
	 
	//모달창오픈
	$('#manageBtn').click(function(e){
		e.preventDefault();
		$('#exampleModal').modal("show");
	});
	
	//관리자 고르기
	function choiceManagerInc(e){	
		let id = e.id;
		let target = $(e);
		let name = target.find('td').eq(0).text();
		$('#manager').val(name);
		$('#hiddenmanager').val(id);
		$('#exampleModal').modal("hide");

	}
	
	//글수정
	$('#updateBtn').on("click", function(){
		data = {};
		
	
		data.content = CKEDITOR.instances.editor.getData();
		 let snscontent = CKEDITOR.instances.editor.getData().trim();
		 data.title = $('#title').val();
		 data.manager = $('#hiddenmanager').val();
		 data.menu_id = parseInt($('#hiddenMenuid').val());
		 data.board_id = id;
		 
		 if($('#title').val().trim().length <=0 ){
			 alert("제목을 입력하세요");
			 return false;
		 }
		 if($('#manager').val().trim().length <=0){
			 alert("검토받을 관리자를 선택해주세요");
			 return false;
		 }
		 if(snscontent.length <= 0 || replacecon <=0){
				alert("내용을 입력하세요");
				return false;
		}
			
		if(content.length >4000){
			alert("작성 범위를 초과했습니다.");
			return false;
		}
		
		console.log(data);
		
 	 	 $.ajax({
            type: 'POST',
            url: '/progress/boardEditInc.do',
            data: JSON.stringify(data),
            dataType : "json",
            contentType : 'application/json',
            success: function(result) {
                console.log(result);
                alert('글 수정 되셨습니다!');
                location.href="/progress/getPost.do?board_id="+id+"&cntPerPage="+cntperpage+"&nowPage="+nowpage+"&menu_id="+menuid+"&progress="+progress;
            },
            error: function(xhr, status, error) {
                console.log(error);
            }
        });  
	})
	
	//취소 눌렀을때
	$('#resetBtn').on("click", function(){
		
		location.href="/progress/getPost.do?board_id="+id+"&cntPerPage="+cntperpage+"&nowPage="+nowpage+"&menu_id="+menuid+"&progress="+progress;
	})
	
	//탭이동
	//탭이동
 	$('.tabs').on("click", function(){
 		let progress = $(this).attr('id');
 		let cntPerPage = $('#perpagechoose').val();
 		//현재페이지도 추가
 		
 		let menuid = ${menu_id};
 		location.href="/progress/boardList.do?menu_id="+menuid+"&progress="+progress+"&cntPerPage="+cntPerPage;
 	})
</script>
	
</body>
</html>
