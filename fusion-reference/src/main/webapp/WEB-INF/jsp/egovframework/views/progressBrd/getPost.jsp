
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<style>

</style>
<head>
<meta charset="UTF-8">

<script src="https://cdnjs.cloudflare.com/ajax/libs/es6-promise/4.1.1/es6-promise.auto.js"></script>
<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>
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
	#ManegerDiv{
		text-align : center;
	}
	main{
		width : 800px;
		margin : 0 auto;
	}
	.afterEditOpenBtns{
		display : none;
	}
	#brdcondiv img{
		width : 80% !important;
		height : 80% !important;
	}
</style>
</head>
<body>

	<main class="mt-2 pt-5">
		
		<!-- 탭탭  -->
		<c:set var ="done_loop" value="false" />
		
		<ul class="nav nav-tabs">
			<c:forEach items="${tabs}" var="tab" varStatus="status">
				<c:if test="${done_loop ne true}">
					<li class="nav-item tabs" id="${tab.sub_id}">
						<a class="nav-link active" aria-current="page" href="#"  id="${tab.sub_id}">${tab.sub_name}</a>
					</li>
					<c:if test="${tab.sub_id eq boardPost.progress}">
						<c:set var="done_loop" value="true"/>
					</c:if>

				</c:if>
			</c:forEach>
		</ul>
	
		<div class="container-fluid px-4">
			<h1 class="mt-4">게시글 조회</h1>
			<div class="card mb-4">
				<div class="card-body">
					<div class="mb-3">
						<label for="title" class="form-label">제목</label>
						<input type="text" class="form-control" id="title" name="title" value="${boardPost.title}" readOnly>
					</div>
					<div class="mb-3">
						<label for="title" class="form-label">작성일자</label>
						<input type="text" class="form-control" id="title" name="title" value="${boardPost.register_dt}" readOnly>
					</div>
					<div>
						<c:if test="${auth <3 }">
							<!-- 관리자 로그인시 -->
							<label for="title" class="form-label">작성자</label>
							<input type="text" class="form-control" id="title" name="writer" value="${boardPost.writer_name}" readOnly>
						</c:if>
						<c:if test="${auth >=3 }">
							<!-- 사용자 -->
							<label for="title" class="form-label">담당 관리자</label>
							<input type="text" class="form-control" id="title" name="writer" value="${boardPost.mag_name}" readOnly>
						</c:if>
					</div>
					<div class="mb-3">
						<label for="content" class="form-label">내용</label>
						<div class="card" id="brdcondiv">
							<c:out value="${boardPost.content}" escapeXml="false" />
						</div>
					</div>
					<button type="button" class="btn btn-outline-secondary" onclick="goList()">목록</button>
					<c:if  test="${boardPost.progress eq 'E04'}">
						<button type="button" class="btn btn-outline-secondary" onclick="goAllRecord()">이력조회</button>
						<button type="button" class="btn btn-outline-secondary" onclick="pdfPrint()">현재페이지 PDF다운</button>
					</c:if>
					<!-- 사용자, 검토중 , 이의제기 때일때만 수정버튼 띄우기 -->
					<c:if test="${auth >=3 && boardPost.progress eq 'E01' }">
						<button type="button" class="btn btn-outline-secondary" value="${boardPost.board_id}" onclick="goEdit(this)">수정하기</button>
					</c:if>

				</div>
			</div>
		</div>
		
		<!-- 첫 반려 피드백 -->
		<c:if test="${empty recentObject }">
			<c:if test="${not empty firstFeedback}"> 
				<div class="container-fluid px-4">
					<div class="card mb-4">
						
						<div id="firstFeedBack" class="card-body container-fluid px-4">
							<h5>검토 결과</h5>
							<div>
								<label class="form-label">결과 : </label>
								<c:if test="${boardPost.status == 1}">
									<span style="color: green;">승인</span>
								</c:if>
								<c:if test="${boardPost.status == 2}">
									<span style="color: red;">반려</span>
								</c:if>
							</div>
							<textarea class="form-control"  readOnly>${firstFeedback.content}</textarea>
						</div>
							<c:if test="${auth >= 3 && boardPost.progress == 'E02'}">
								<div class="d-flex justify-content-center">
									<button type="button" class="btn btn-outline-primary" onclick="agreeFirstFeedBack()">결과 동의</button>
									<button type="button" class="btn btn-outline-danger" onclick="objectFrmOpen()">이의 제기</button>
								</div>
							</c:if>
					</div>
				</div>
			</c:if>
		</c:if>
		
		<!-- 가장 최신 이의제기  -->
		<c:if test="${not empty recentObject }">
			<div class="container-fluid px-4">
				<div class="card mb-4">			
					<div id="firstFeedBack" class="card-body container-fluid px-4">
						<div class="d-flex">
							<h5>이의제기</h5><strong>(${objectCnt}회차)</strong>
						</div>
						<input type="hidden" value="${recentObject.object_id}" id="objectid">
						<textarea class="form-control"  readOnly id="recentObjectCon" maxlength="200">${recentObject.user_content}</textarea>
						<!-- 사용자만 보이는 수정버튼 -->
						<c:if test="${auth >=3 && empty recentObject.reply_content }" >
							<button type="button" class="btn btn-outline-secondary" onclick="myObjectEditFrm()" id="openObjectEdit">수정</button>
						</c:if>
						<div class="d-flex">
							<button type="button" class="btn btn-outline-secondary afterEditOpenBtns" onclick="inputObjectEdit()">이의제기 수정</button>
							<button type="button" class="btn btn-outline-secondary afterEditOpenBtns" onclick="resetEditObject()">취소</button>
						</div>
					</div>
					<!-- 관리자의 이의제기 답변 -->
					<c:if test ="${not empty  recentObject.reply_content}">
						<div id="firstFeedBack" class="card-body container-fluid px-4">
							<div class="d-flex">
								<h5>이의제기 답변</h5><strong>(${objectCnt}회차)</strong>
							</div>
							<textarea class="form-control"  readOnly id="recentObjectCon">${recentObject.reply_content}</textarea>
						</div>
					</c:if>
					<c:if test="${auth eq 3 && boardPost.progress eq 'E02'}"> 
						<div class="d-flex justify-content-center">
							<button type="button" class="btn btn-outline-primary" onclick="agreeFirstFeedBack()">결과 동의</button>
							<button type="button" class="btn btn-outline-danger" onclick="objectFrmOpen()">이의 제기</button>
						</div>
					</c:if>
				</div>
			</div>
		</c:if>
		
		
		<!-- 관리자용 이의제기 대답  -->
		<c:if test="${auth <3 &&( boardPost.progress eq 'E01' || boardPost.progress eq 'E03')}">
			<div class="container-fluid px-4">
				<div class="card mb-4">			
					<div id="ManegerDiv" class="card-body container-fluid px-4">
						<h5>답변 작성</h5>
						<div class="d-flex justify-content-center">
							<button type="button" class="btn btn-outline-secondary decideBtn mt-3 mx-2" id="approveBtn" value=1>승인</button>
							<button type="button" class="btn btn-outline-secondary decideBtn mt-3 mx-2" id="rejectBtn" value=2>반려</button>
						</div>
						<textarea rows="" cols=""  class="form-control" id="content" maxlength="200"></textarea>
						<button type="button" onclick="submitDecision()" class="btn btn-outline-secondary">답변 제출</button>
					</div>
				</div>
			</div>
		</c:if>
		
		<!-- 이의제기 -->
		<c:if test="${objectCnt <3 }">
			<c:if test="${auth >=3 && boardPost.progress eq 'E02'}">
				<div class="container-fluid px-4" style="display:none;" id="objectfrm">
					<div class="card mb-4">
						<div  class="card-body container-fluid px-4" >
							<span>이의제기는 3회까지 가능합니다.</span><span>(현재 </span><span id="num"></span><span>회)</span>
							<textarea rows="" cols=""  class="form-control" id="user_content" maxlength="200"></textarea>
							<button type="button" onclick="objectinput()" class="btn btn-outline-secondary">이의 제출</button>
						</div>
					</div>
				</div>	
			</c:if>
		</c:if>
		
		
	</main>
</body>
<script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript">
	
	var data = {};
	var cntperpage = ${cntPerPage};
	var nowpage = ${nowPage};
	var menuid= ${menu_id};
	var cnt = ${objectCnt};
	var progress = "${progress}";
	var num = cnt+1;

	var auth = ${auth};
	var title = "${boardPost.title}";
	console.log(menuid);
	$(document).ready(function() {
		$('#num').text(num);
	});
	//이동!
	function goList(){
		location.href ="/progress/boardList.do?menu_id="+menuid+"&cntPerPage="+cntperpage+"&nowPage="+nowpage+"&progress="+progress;
	}
	
	//수정할러
	function goEdit(e){
			let id =  e.value;
			console.log(id);
			location.href="/progress/boardEditFrm.do?board_id="+id+"&cntPerPage="+cntperpage+"&nowPage="+nowpage+"&menu_id="+menuid;
	}
	
	//클릭하면 버튼 선택되게
	$('.decideBtn').on("click", function(){
		$('.decideBtn').removeClass('btn-success');
		$('.decideBtn').removeClass('decision');
		$('.decideBtn').addClass('btn-outline-secondary');

		let target = $(event.target);
		target.removeClass('btn-outline-secondary');
		target.addClass('btn-success');
		target.addClass('decision');

	});
	
	//결정하기
	function submitDecision(){
		data = {};
		let board_id = ${boardPost.board_id};

		let status = $('.decision').val();
		let content = $('#content').val();
		
		data.status = status;
		data.board_id = board_id;
		//cnt여부로 이의제기 답변인지, 첫번쨰 검토인지 체크하기 
		
	 	if($('.decision').length <=0){
			alert("승인/반려 여부를 선택해주세요");
			return false;
		}
		if(content.trim().length <=0){
			alert("내용을 입력해주세요");
			return false;
		}
		
		if(cnt <=0){
			
			data.content = content;

			 $.ajax({
					url : '/progress/inputDecision.do',
					method : 'POST',
					data : JSON.stringify(data),
					contentType : 'application/json',
		            success: function(result) {
		            	alert("등록 완료 되었습니다!");
		            	//페이징 추가
		            	location.href="/progress/boardList.do?menu_id=43&cntPerPage="+cntperpage+"&progress="+progress
		            },
		            error: function(xhr, status, error) {
		                console.log(error);
		            }
				}) 	
		}else{
			let objid = $('#objectid').val();
			data.object_id = objid;
			data.reply_content = content;
			
			$.ajax({
				url: '/progress/inputObjectReply.do',
				method : 'POST',
				data : JSON.stringify(data),
				contentType : 'application/json',
				 success: function(result) {
	            	alert("등록 완료 되었습니다!");
	            	//페이징 추가
	            	location.href="/progress/boardList.do?menu_id=43&cntPerPage="+cntperpage+"&progress="+progress
	            },
	            error: function(xhr, status, error) {
	                console.log(error);
	            }
			})
			
		}
	
	}

	//이의제기 폼 오픈
	
	function objectFrmOpen(){
		
		if($('#objecfrm').css('display') == 'block'){
			$('#objectfrm').css("display", "none");
		}else{
			$('#objectfrm').css("display", "block");
		}
		
	}
	
	//이의제기 제출 
	function objectinput(){
		data = {};
		let id = ${boardPost.board_id};
		let progress = 'E03';
		data.board_id = id;
		data.user_content = $('#user_content').val();
		
		if($('#user_content').val().trim().length <=0){
			alert("내용을 입력해주세요.");
			return false;
		}
		
		$.ajax({
			url: '/progress/objectInput.do',
			method : 'POST',
			data : JSON.stringify(data),
			contentType : 'application/json',
           success: function(result) {
            	alert("등록 완료 되었습니다!");
            	//페이징 추가
            	location.href="/progress/boardList.do?menu_id=43&progress="+progress+"&cntPerPage="+cntperpage;
            	
            },
            error: function(xhr, status, error) {
                console.log(error);
            }
		})
		
	}
	
	//이의제기 폼 오픈?
	function myObjectEditFrm(){
		$('#recentObjectCon').prop('readonly', false);
		$('.afterEditOpenBtns').css('display', 'block');
		$('#openObjectEdit').css('display', 'none');
		
	}
	
	//이의제기 수정 제출
	function inputObjectEdit(){
		data = {};
		let object_id = $('#objectid').val();
		let user_content = $('#recentObjectCon').val();
		data.object_id = object_id;
		data.user_content = user_content;
		
		if($('#recentObjectCon').val().trim().length <=0){
			alert("내용을 입력해주세요.");
			return false;
		}
		
		$.ajax({
			url: '/progress/objectEdit.do',
			method : 'POST',
			data : JSON.stringify(data),
			contentType : 'application/json',
           success: function(result) {
            	alert("수정 완료 되었습니다!");
            	location.reload();
            },
            error: function(xhr, status, error) {
                console.log(error);
            }
		})
	}
	
	//이의제기 수정 취소
	function resetEditObject(){
		$('#recentObjectCon').prop('readonly', true);
		
		let usercon = "${newcon}";
		$('.afterEditOpenBtns').css('display', 'none');
		$('#recentObjectCon').val(usercon);
		$('#openObjectEdit').css('display', 'block');
	}
	
	
	//이력조회
	function goAllRecord(){
		let id = ${boardPost.board_id};

		let url = '/progress/getAllRecord.do?board_id='+id;
		window.open( url,'팝업','width=800,height=800');                 
	}
	
	
	//동의
	function agreeFirstFeedBack(){
		let id = ${boardPost.board_id};

		
		if(confirm("동의 이후에는 의의제기가 불가능합니다.")){
			location.href = '/progress/agreeFirstFeedBack.do?board_id='+id+"&cntPerPage="+cntperpage+"&nowPage="+nowpage+"&menu_id="+43+"&progress="+progress;	
		}
		
	}
	//pdf바로다운
		 function pdfPrint(){

	        html2canvas(document.body, {
            onrendered: function (canvas) {

                var imgData = canvas.toDataURL('image/png');

                var imgWidth = 210; 
                var pageHeight = imgWidth * 1.414;  
                var imgHeight = canvas.height * imgWidth / canvas.width;
                var heightLeft = imgHeight;

                var doc = new jsPDF('p', 'mm');
                var position = 0;

                doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
                //이미지 높이만큼 페이지 높이를 감소시켜주는거. 
                heightLeft -= pageHeight;
	
                //20 - 여백값이라고 생각하면됨. 
                while (heightLeft >= 20) {
                    position = heightLeft - imgHeight;
                    doc.addPage();
                    doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
                    heightLeft -= pageHeight;
                }

                doc.save(title+'.pdf');


            }
            
        });
	        
	    }
		
		 $('.tabs').each(function(){
			if($(this).attr('id') == progress){
				$(this).addClass('active');
				console.log($(this));
				$(this).css({
				  'color': 'blue',
				  'font-weight': 'bold'
				});
			}
		})
			
		//탭이동
	 	$('.tabs').on("click", function(){
	 		let progress = $(this).attr('id');
	 		var cntperpage = ${cntPerPage};
	 		var nowpage = ${nowPage};
	 		//현재페이지도 추가
	 		
	 		let menuid = ${menu_id};
	 		location.href="/progress/boardList.do?menu_id="+menuid+"&progress="+progress+"&cntPerPage="+cntperpage+"&nowPage="+nowpage;
	 	})
	 	
	 		
		
</script>
</html>