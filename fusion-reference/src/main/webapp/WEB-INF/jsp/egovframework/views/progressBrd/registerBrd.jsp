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
  #bodydiv{
  	width : 1200px;
  	margin : 20px auto;
  }
  .getmargin{
  	margin : 10px 0;
  }

</style>
</head>
<body>
	<!-- 검색 -->

	<!-- ck editor -->
	<div class="container-fluid px-4 mb-4" id="bodydiv">
		<div class="card mb-4">
		<div  class="card-body container-fluid px-4">
			
			<form action="/sns/inputSns.do" method="POST" style="width: 1000px; margin : 0 auto">
		      	<h1>게시글 등록</h1>
		      <div class="d-flex getmargin" >
			      <label for="title"  class="form-label">제목</label>
			      <input type="text" id="title"  class="form-control" maxlength="30" required>
		      </div>
		      <div class="d-flex getmargin" >
		      	<label for="manage"  class="form-label">관리자</label>
		      	<input type="text" class="form-label" id="manager" required disabled>
		      	<input type="hidden" class="form-label" id="hiddenmanager">
		      	<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" id="manageBtn">
					관리자 고르기
				</button>
		      </div>
		     <input type="hidden" value="${menu_id}" name="menu_id" id="hiddenMenuid"> 
		      <textarea name="content" id="editor"></textarea>
		      <div class="d-flex justify-content-end getmargin" >
		   		<input type="button" id="inputBtn"class="btn btn-primary mt-3 mx-2" value="작성완료" />
		   		<input type="button" id="resetBtn" class="btn btn-primary mt-3 mx-2" value="취소"  />
		   		</div>
		    </form>
	    </div>
	</div>
	</div>
	
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
	        		
	        		<tbody>
	        			<c:forEach items="${manageList}" var="m" >
		        		<tr onclick="choiceManagerInc(this)" id="${m.user_id}">
	        				<td>${m.user_name}</td>
	        				<td>${m.real_name}</td>
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
	
	
</body>

<script>
	var data = {};
	var content;
	var length;
	var replacecon;
	var menu_id = ${menu_id};
	var nowPage = ${nowPage};
	var cntperpage = ${cntperpage};
	var progress = "${progress}";
	
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
	
	//글등록
	$('#inputBtn').on("click", function(){
		data = {};
		
		data.content = CKEDITOR.instances.editor.getData();
		 let snscontent = CKEDITOR.instances.editor.getData().trim();
		 data.title = $('#title').val();
		 data.manager = $('#hiddenmanager').val();
		 data.menu_id = parseInt($('#hiddenMenuid').val());
		 
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
            url: '/progress/inputBrd.do',
            data: JSON.stringify(data),
            dataType : "json",
            contentType : 'application/json',
            success: function(result) {
                console.log(result);
                alert('글 등록 되셨습니다!');
                location.href="/progress/boardList.do?menu_id=43";
            },
            error: function(xhr, status, error) {
                console.log(error);
            }
        });	 
	})
	
	//취소 버튼 눌렀을때 뒤로 가기
	$('#resetBtn').on('click', function(){
		
        location.href="/progress/boardList.do?menu_id="+menu_id+"&nowPage="+nowPage+"&cntPerPage="+cntperpage+"&progress="+progress;
	})
</script>
	
</body>
</html>
