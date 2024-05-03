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
<style>

</style>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<title>퓨전 게시판(상세보기)</title>
<style>
	#inputReply{
		display : flex;
		justify-content: space-between;
		align-content: center;
	}
	#inputReply>button{
		width : 20%;
	}
	.ReReplyFrm{
		display:none;
	}
	.updateFrm{
		display : none;
	}
	#galaryTiTLe{
		margin : 8px 0 ; !important
	}
	.likeandcnt{
		margin : 5px;
		margin-right : 20px;
	}
</style>
</head>
<body>
	<main class="mt-5 pt-5">
	<div class="container-fluid px-4" style="width:50%">
		<div class="d-flex justify-content-between align-items-center">
			<h1 class="mt-4" id="galaryTiTLe">게시글 조회</h1>
			<div class="d-flex justify-content-between align-items-center">
				 <div class="likeandcnt">
		             <span class="text-muted">❤️ : </span><span> ${galPost.likescnt}</span><span>개</span>
		         </div>
				<div class="likeandcnt">
		             <span class="text-muted">조회수 : </span><span>${galPost.cnt}</span><span> 회</span>
		         </div>
	         </div>
         </div>
		<div class="card mb-4">
			<div class="card-body">
				<div class="mb-3">
					<label for="title" class="form-label">제목</label>
					<input type="text" class="form-control" id="title" name="title" value="${galPost.title}" readOnly>
				</div>
				<div class="mb-3">
					<label for="title" class="form-label">작성일</label>
					<input type="text" class="form-control" value="${galPost.register_dt}" readOnly>
				</div>
				<!-- 사진 -->
				<div class="mb-3">
				  	<c:forEach items="${Images}" var="image">
					    <div>
					      <img src="/resize/${image.file_route}"  class="d-block w-100" alt="...">
					    </div>
					    <c:if test="${not empty loginId}">
						     <a href="/original/${image.file_route}" download="${image.original_name}" class="downloads"  id="${image.media_id}">
							    📁 "${image.original_name}" 다운로드
							</a>
						</c:if>
					 </c:forEach>
				</div>
				
				
				<div class="mb-3">
					<label for="content" class="form-label">내용</label>
					<textarea class="form-control" id="content" name="content" rows="8" readOnly>${galPost.content}</textarea>
				</div>
				<div class="mb-3">
					<label for="writer" class="form-label">작성자</label>
					<input type="text" class="form-control" id="writer" name="writer" value="${galPost.user_name}" disabled>
				</div>
				<button type="button" class="btn btn-outline-secondary" onclick="goList()">목록</button>
				<c:if test="${galPost.writer eq loginId}">
					<button class="btn btn-outline-warning" onclick="location.href='/galary/galaryPostEditFrm.do?galary_id=${galPost.galary_id}&menu_id=${menu_id}'">수정하기</button>
					<button class="btn btn-outline-danger" onclick="delPost()">삭제하기</button>
				</c:if>
				 <c:if test="${likeyn>=1 && not empty loginId}">
					<button type="button"  id="yesLike" class="btn btn-outline-secondary" onclick="delLike()">❤️</button>
				</c:if> 
				<c:if test="${likeyn == 0 && not empty loginId}">
					<button type="button"  id="noLike" class="btn btn-outline-secondary" onclick="addLike()">🤍</button>
				</c:if>
			</div>
		</div>
	</div>

	</main>
</body>
<script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript">
	//다운로드 기록 남기기
	/* function insdownRecord(){
		let thiss = this;
		console.log(thiss);
		let mediaId = this.id;
		console.log(mediaId);
		
	} */
	var menuid = ${menu_id};
	
	//목록이동
	function goList(){
		let category = "${category}";
		let cntperpage =  "${cntPerPage}";
		let nowpage= "${nowPage}";
		let searchtype= "${search_type}";
		let searchword = "${search_word}";
		
		location.href="/galary/galaryList.do?&category="+category+"&cntPerPage="+cntperpage+"&nowPage="+nowpage+"&search_type="+searchtype+"&search_word="+searchword+"&menu_id="+menuid;

	}
	
	
	//down
	$(document).on('click', '.downloads', function() {
	    var mediaId = $(this).attr('id');
		var galid = "${galPost.galary_id}";
	    //다운 로그 남기기
	    $.ajax({
  		  url : '/galary/insDownRecord.do',
  		  method : 'POST',
  		  data : {media_id : mediaId, galary_id : galid},
  		  success:function(result){
  			  console.log("기록완료");
  		  }, error : function(){
  			  console.log(error);
  		  }
  	  })
  	  

	});
	
	
	//글 삭제
	function delPost(){	
		let galId = ${galPost.galary_id};
		
		console.log(galId);
		let  delConfirm = confirm("정말로 삭제하시겠습니까?");
		
		if(delConfirm){
			location.href='/galary/delGalaryPost.do?galary_id='+galId+"&menu_id="+menuid;	
		}else{
			alert("삭제 취소 되었습니다!");
		}	
	}
	//좋아요
	function addLike(){
		let galary_id = ${galPost.galary_id};
		console.log(galary_id);
		
		  $.ajax({
    		  url : '/galary/addLike.do',
    		  method : 'POST',
    		  data : {galary_id : galary_id},
    		  success:function(result){
    			  //좋아요 갯수 변경
    			  //하트 변경
    			  let check = result.num;
			    	 if(check == 0){
			    		 $("#noLike").show();
			    		 $("#yesLike").hide();
			    	 }else{
			    		 $("#yesLike").show();
			    		 $("#noLike").hide();	 
			    	 }
			    	 location.reload();
    		  }, error : function(){
    			  console.log(error);
    		  }
    	  })
	}
	
	//조아요 해제 
	function delLike(){
		let galary_id = ${galPost.galary_id};
		console.log(galary_id);
		
		$.ajax({
  		  url : '/galary/delLikes.do',
  		  method : 'POST',
  		  data : {galary_id : galary_id},
  		  success:function(result){
  			  //좋아요 갯수 변경
  			  //하트 변경
  			  let check = result.num;
			    	 if(check == 0){
			    		 $("#noLike").show();
			    		 $("#yesLike").hide();
			    	 }else{
			    		 $("#yesLike").show();
			    		 $("#noLike").hide();	 
			    	 } 
			    	 location.reload();
  		  },
  		  error : function(){
  			  console.log(error);
  		  }
  	  })
	}
</script>
</html>