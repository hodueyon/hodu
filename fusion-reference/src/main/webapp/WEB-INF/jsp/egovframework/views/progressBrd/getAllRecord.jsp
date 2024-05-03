
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/es6-promise/4.1.1/es6-promise.auto.js"></script>
<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>
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
		<div class="container-fluid px-4">
			<h1 class="mt-4">게시글 이력</h1>
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
					<div class="mb-3">
						<!-- 관리자 로그인시 -->
						<label for="title" class="form-label">작성자</label>
						<input type="text" class="form-control" id="title" name="writer" value="${boardPost.writer_name}" readOnly>
					</div>
					<div class="mb-3">
							<label for="title" class="form-label">담당 관리자</label>
							<input type="text" class="form-control" id="title" name="writer" value="${boardPost.mag_name}" readOnly>
					</div>
					<div class="mb-3">
							<label for="title" class="form-label">최종 결과</label>
							<c:if test="${boardPost.status == 1}">
								<input type="text" class="form-control" id="title" name="writer" value="승인" readOnly>
							</c:if>
							<c:if test="${boardPost.status == 2}">
								<input type="text" class="form-control" id="title" name="writer" value="반려" readOnly>
							</c:if>
							
					</div>
					<div class="mb-3">
						<label for="content" class="form-label">내용</label>
						<div class="card" id="brdcondiv">
							<c:out value="${boardPost.content}" escapeXml="false" />
						</div>
					</div>

						
						<button type="button" class="btn btn-outline-secondary" onclick="pdfPrint()">PDF파일</button>
					<!-- 사용자, 검토중 , 이의제기 때일때만 수정버튼 띄우기 -->
					<c:if test="${auth >=3 && boardPost.progress eq 'E01' }">
						<button type="button" class="btn btn-outline-secondary" value="${boardPost.board_id}" onclick="goEdit(this)">수정하기</button>
					</c:if>

				</div>
			</div>
		</div>
		
		<!-- 첫 반려 피드백 -->
		<div class="container-fluid px-4">
			<div class="card mb-4">
				
				<div id="firstFeedBack" class="card-body container-fluid px-4">
					<h5>검토 결과</h5>
					<textarea class="form-control"  readOnly>${firstFeedback.content}</textarea>
				</div>
			</div>
		</div>

		
		<!-- 가장 최신 이의제기  -->
			<div class="container-fluid px-4">
				<c:forEach items="${objects}"  var="o" varStatus="Cnt">
					<div class="card mb-4">			
						<div id="firstFeedBack" class="card-body container-fluid px-4">
							<div class="d-flex">
								<h5>이의제기</h5><strong>(${Cnt.count}회차)</strong>
							</div>
							<input type="hidden" value="${o.object_id}" id="objectid">
							<textarea class="form-control"  readOnly id="recentObjectCon">${o.user_content}</textarea>
						</div>
						<!-- 관리자의 이의제기 답변 -->
						<c:if test ="${not empty  o.reply_content}">
							<div id="firstFeedBack" class="card-body container-fluid px-4">
								<div class="d-flex">
									<h5>이의제기 답변</h5>
								</div>
								<textarea class="form-control"  readOnly id="recentObjectCon">${o.reply_content}</textarea>
							</div>
						</c:if>
					</div>
				</c:forEach>
			</div>
		
		
	</main>
</body>
<script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript">
	var data = {};
	var title = "${boardPost.title}"+'이력';
	//let menuid= ${menu_id};
	//console.log(menuid);
	$(document).ready(function() {
		
	});
	
	 function pdfPrint(){

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

</script>
</html>