<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<title>설문조사 등록</title>
<style>
	#choiceQuesOption{
		margin: 5px 0; 
	}
	.choiceQuLi{
		list-style: none;
	}
	ul{
		padding : 0;
	}
	 #childItemTr > td{
	 	margin : 0 auto;
	 }
	 #childItemTr > td > table{
	 	margin : 0 auto !important;
	 	width : 80%;
	 	text-align : center;
	 }
	 #childItemTr > td > table> thead>tr{
			width : 100%;
	 }
	 
	main{
		width : 2000px;
		margin : 0 auto;
	}
  
</style>

</head>
<body>
	<main>
	<div class="container-fluid px-4">
		<h1 class="mt-4">설문조사 수정</h1>
		<div class="card mb-4">
			<div class="card-body">
				<form method="post" action="#" id="registerFrm">
					<div class="mb-3">
						<label for="title" class="form-label">제목</label>
						<input type="text" class="form-control" id="title" name="title"  maxlength="30" value="${info.title}" maxlength="50" required>
					</div>
					<div class="mb-3">
						<label for="title" class="form-label">주최</label>
						<input type="text" class="form-control" id="writer" name="writer"  maxlength="30" value="${info.writer}" maxlength="30" required>
					</div>
					<div class="d-flex">
						<div class="mb-3">
							<label for="start_date" class="form-label">시작 날짜</label>
							<input type="date" class="form-control" id="start_date" name="start_date"  value="${info.start_date.substring(0, 10)}" required>
						</div>
						<div class="mb-3">
							<label for="end_date" class="form-label">종료 날짜</label>
							<input type="date" class="form-control" id="end_date" name="end_date" value="${info.end_date.substring(0, 10)}"  required>
						</div>
						<div class="mb-3">
							<label for="announce_date" class="form-label">발표 날짜</label>
							<input type="date" class="form-control" id="announce_date" name="announce_date" value="${info.announce_date.substring(0, 10)}" required>
						</div>
					</div>
					<div class="mb-3">
						<label for="participate_cnt" class="form-label">참여 가능 횟수</label>
						<input type="number" class="form-control" id="participate_cnt" name="participate_cnt" max = "10"  value="${info.participate_cnt}" required>
					</div>
					<div class="mb-3">
						<label for="participate_cnt" class="form-label">조사 대상</label>
						<select class="form-select" aria-label="Default select example" id="servey_target" >
							<option value="users" <c:if test="${info.servey_target == 'users'}">selected</c:if>>전체</option>	
							<c:forEach items="${targetList}" var="target">
								<c:if test="${target.auth_id <4 }">
									<option value="${target.auth_name}" <c:if test="${info.servey_target == target.auth_name}">selected</c:if>>${target.auth_name}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
					
					<h4 class="mt-4">설문지 문항</h4>
					<button type="button" class="btn btn-primary" onclick="addTr()">추가</button>
					<div class="mb-3"> 
						<table class="table" id="QuesTb">
							 <thead>
							 	<tr>
					            <th ></th>
					            <th>질문 번호</th>
					            <th>질문 유형</th>
					            <th>답변 유형</th>
					            <th>필수 질문</th>
					            <th>답변 개수</th>
					            <th>질문 내용</th>
					            </tr>
					       </thead>
					       <tbody>
					       <c:forEach items="${ques}" var="q">
					       	<c:if test="${q.question_num_child eq 0}">
					         <tr class="item " id="itmtr">
					            <td style="text-align:center;">
					                <button id="delQuestRow" type="button" class="btn" onclick="delQuesTr(this)" value="${q.question_id}">❌</button>
					            </td>
					            <td id="qustNo" class="drag-handle" ><span class="questNo">${q.question_num}</span></td>
					            <td>
					            	<!-- 수정 필요 부분 -->
					            	<select class="form-select" id="question_category">
										<c:forEach items="${quesCategory}" var="c">
										<c:if test="${empty c.category_name }">
											<option value="${c.q_category_id}" <c:if test="${q.question_category == c.q_category_id}">selected</c:if>>선택 안함</option>
										</c:if>
										<c:if test="${not empty c.category_name }">
											<option value="${c.q_category_id}" <c:if test="${q.question_category == c.q_category_id}">selected</c:if>>${c.category_name}</option>
										</c:if>
										</c:forEach>
					                </select>
								</td>
					            <td> 
					               <select name="qustType" id="qustType" class="form-select qustType">
										<option value="1" <c:if test="${q.question_type == 1}">selected</c:if>>객관식</option>
										<option value="2" <c:if test="${q.question_type == 2}">selected</c:if>>주관식</option>
										<option value="3" <c:if test="${q.question_type == 3}">selected</c:if>>대문항</option>
									</select>
					            </td>
					            <td>
					            	<select class="form-select" name="essential_yn">
					            		<option value="y" <c:if test="${q.essential_yn == 'y'}">selected</c:if>>필수</option>
					                    <option value="n" <c:if test="${q.essential_yn == 'n'}">selected</c:if>>선택</option>
					            	</select>
					            </td>
					            <td>
					            	<c:choose>
					            		 <c:when test = "${q.question_type == 1}">					            	
					            			<input type="number" class="form-control maxchoiceInput" min = '1' id="max_choice_cnt" value="${q.max_choice_cnt}">
					            		</c:when>
					            		<c:otherwise >					            	
					            			<input type="number" class="form-control maxchoiceInput" min = '1' id="max_choice_cnt" disabled>
					            		</c:otherwise>
					            	</c:choose>
					            </td>
					            <td>
					                <div class="surv_opt_box">
					                    <input id="qustCont" type="text" placeholder="질문을 입력해주세요" class="form-control" value="${q.question_content}" maxlength="100">
					                    <c:if test="${q.question_type == 1 }">
						                    <div id="choiceQuesOption">
						                    	<p>선택 문항</p>
						                    	<ul>
						                    		 <c:set var="ckOptionyn" value="false" />	
						                    		<c:forEach items="${options}" var="op">
						                    			<c:if test ="${op.question_id == q.question_id && q.question_type == 1}">
							                    		<li class="choiceQuLi" id="choiceQuLiItem">
								                    		<div class="d-flex"><button type="button" class="btn delOpRow" onclick="delOptionLi(this)">❌</button>
									                    		<select name="answer_type" onchange="makeOptionStyle(this)" class="ansTypeSelect">
									                    			<option value=1 <c:if test="${op.answer_type == 1}">selected</c:if>>일반</option>
									                    			<option value=3 <c:if test="${op.answer_type == 3}">selected</c:if>>기타</option>
									                    			<option value=4 <c:if test="${op.answer_type == 4}">selected</c:if>>없음</option>
									                    		</select>
									                    		<c:choose>
							            		 					<c:when test = "${op.answer_type == 1}">					           
										                    			<input type="text" class="form-control optioninputFrm" id="answer_content" onChange="duplicateValCk(this)" value="${op.answer_content}" maxlength="20">
								                    				</c:when>
	                									            <c:otherwise>
	                									            	<input type="text" class="form-control optioninputFrm" id="answer_content" onChange="duplicateValCk(this)" disabled maxlength="20">					            	
								                    				</c:otherwise>
								                    			</c:choose>
								                    		</div>
							                    		</li>
							                    		</c:if>
						                    		</c:forEach>
						                    	</ul>
						                    	<button type="button" class="btn btn-primary"  onclick="addOption(this)"> 옵션 추가</button>
						                    </div>
					                    </c:if>
					                    <c:if test="${q.question_type != 1 }">
					                    	 <div id="choiceQuesOption" style="display:none">
						                    	<p>선택 문항</p>
						                    	<ul>
						                    		<li class="choiceQuLi" id="choiceQuLiItem">
							                    		<div class="d-flex"><button type="button" class="btn delOpRow" onclick="delOptionLi(this)">❌</button>
								                    		<select name="answer_type" onchange="makeOptionStyle(this)" class="ansTypeSelect">
								                    			<option value=1 >일반</option>
								                    			<option value=3 >기타</option>
								                    			<option value=4 >없음</option>
								                    		</select>
               									            	<input type="text" class="form-control optioninputFrm" id="answer_content" onChange="duplicateValCk(this)" maxlength="20">					            	
							                    		</div>
						                    		</li>
						                    	</ul>
						                    	<button type="button" class="btn btn-primary"  onclick="addOption(this)"> 옵션 추가</button>
						                    </div>
										</c:if>
					                </div>
					            </td>
					         </tr>
					         
					         
					         <tr id="childItemTr" >
					         	<td colspan="7">
					         		<c:if test="${q.question_type == 3 }">
							         	<table id="childQuesTb"  class="table table-light " >
							         		<thead>
							         			<tr>
							         				<th></th>
							         				<th>소질문 번호</th>
							         				<th>질문 유형</th>
										            <th>답변 유형</th>
										            <th>필수 질문</th>
										            <th>답변 개수</th>
										            <th>질문 내용</th>
										            <th><button type="button" class="btn btn-primary addSubTr">소질문 추가</button></th>
							         			</tr>
							         		</thead>
							         		<tbody>						         		
											    <c:set var="matchingSubques" value="false" />						         		
							         			<c:forEach items="${subqueslist}" var="q2" varStatus = "idx">
							         				<c:if test="${q.question_num eq q2.question_num}">
							         				  <c:set var="matchingSubques" value="true" />
								         			<tr class="subitem" id="subitmtr">
											            <td style="text-align:center;">
											                <button id="delQuestRow" type="button" class="btn" onclick="delQuesSubTr(this)" value="${q2.question_id}">❌</button>
											            </td>
											            <td id="subqustNo" class="subquestNo">${q2.question_num_child}</td>
										                <td>
											            	<!-- 수정 필요 부분 -->
											            	<select class="form-select" id="question_category">
																<c:forEach items="${quesCategory}" var="c">
																<c:if test="${empty c.category_name }">
																	<option value="${c.q_category_id}" <c:if test="${q2.question_category == c.q_category_id}">selected</c:if>>선택 안함</option>
																</c:if>
																<c:if test="${not empty c.category_name }">
																	<option value="${c.q_category_id}" <c:if test="${q2.question_category == c.q_category_id}">selected</c:if> >${c.category_name}</option>
																</c:if>
																</c:forEach>
											                </select>
														</td>
											            <td> 
											                <select name="qustType" id="qustType" class="form-select qustType">
																<option value="1" <c:if test="${q2.question_type == 1}">selected</c:if>>객관식</option>
																<option value="2" <c:if test="${q2.question_type == 2}">selected</c:if>>주관식</option>
															</select>
											            </td>
											            <td>
											            	<select class="form-select" name="essential_yn">
											            		<option value="y" <c:if test="${q2.essential_yn == 'y'}">selected</c:if>>필수</option>
											                    <option value="n" <c:if test="${q2.essential_yn == 'n'}">selected</c:if>>선택</option>
											            	</select>
											            </td>
											            <td>
											            	<c:choose>
											            		 <c:when test = "${q2.question_type == 1}">					            	
											            			<input type="number" class="form-control subMaxcnt maxchoiceInput" min = '1' id="max_choice_cnt" value="${q2.max_choice_cnt}">
											            		</c:when>
											            		<c:otherwise >					            	
											            			<input type="number" class="form-control subMaxcnt maxchoiceInput" min = '1' id="max_choice_cnt" disabled>
											            		</c:otherwise>
											            	</c:choose>
											            </td>
											            <td>
											                <div class="surv_opt_box">
											                    <input id="qustCont" type="text" placeholder="질문을 입력해주세요" class="form-control" value="${q2.question_content}">
											                    <c:if test="${ q2.question_type == 1 }">
												                    <div id="choiceQuesOption">
												                    	<p>선택지 옵션</p>
												                    	<ul>
												                    		<c:forEach items="${options}" var="op">
							                    							<c:if test ="${op.question_id == q2.question_id && q2.question_type == 1}">
													                    		<li class="choiceQuLi" id="choiceQuLiItem">
														                    		<div class="d-flex">
															                    		<button type="button" class="btn delOpRow" onclick="delOptionLi(this)">❌</button>
															                    		<select name="answer_type" onchange="makeOptionStyle(this)" class="ansTypeSelect">
															                    				<option value=1 <c:if test="${op.answer_type == 1}">selected</c:if>>일반</option>
																                    			<option value=3 <c:if test="${op.answer_type == 3}">selected</c:if>>기타</option>
																                    			<option value=4 <c:if test="${op.answer_type == 4}">selected</c:if>>없음</option>
															                    		</select>
															                    		<c:choose>
													            		 					<c:when test = "${op.answer_type == 1}">					           
																                    			<input type="text" class="form-control optioninputFrm" id="answer_content" onChange="duplicateValCk(this)" value="${op.answer_content}" maxlength="20">
														                    				</c:when>
							                									            <c:otherwise>
							                									            	<input type="text" class="form-control optioninputFrm" id="answer_content" onChange="duplicateValCk(this)" maxlength="20" disabled>					            	
														                    				</c:otherwise>
														                    			</c:choose>
													                    			</div>
													                    		</li>
												                    		</c:if>
												                    		</c:forEach>
												                    	</ul>
												                    	<button type="button" class="btn btn-primary"  onclick="addOption(this)"> 옵션 추가</button>
												                    </div>
											                    </c:if>
											                    <c:if test="${ q2.question_type != 1 }">
											                    	<div id="choiceQuesOption" style="display:none">
												                    	<p>선택지 옵션</p>
												                    	<ul>
													                    		<li class="choiceQuLi" id="choiceQuLiItem">
														                    		<div class="d-flex">
															                    		<button type="button" class="btn delOpRow" onclick="delOptionLi(this)">❌</button>
															                    		<select name="answer_type" onchange="makeOptionStyle(this)" class="ansTypeSelect">
															                    				<option value=1 >일반</option>
																                    			<option value=3 >기타</option>
																                    			<option value=4 >없음</option>
															                    		</select>

							                									           <input type="text" class="form-control optioninputFrm" id="answer_content" maxlength="20" onChange="duplicateValCk(this)" >					            	

													                    			</div>
													                    		</li>

												                    	</ul>
												                    	<button type="button" class="btn btn-primary"  onclick="addOption(this)"> 옵션 추가</button>
												                    </div>
																</c:if>	
											                </div>
											            </td>
											            <td>
											            </td>
											         </tr>
										         	</c:if>
						
	 									         </c:forEach>
	 									         <c:if test="${matchingSubques eq 'false'}">
	 									         	<tr class="subitem" id="subitmtr">
											            <td style="text-align:center;">
											                <button id="delQuestRow" type="button" class="btn" onclick="delQuesSubTr(this)">❌</button>
											            </td>
											            <td id="subqustNo" class="subquestNo">1</td>
										                <td>
											            	<select class="form-select" id="question_category">
																<c:forEach items="${quesCategory}" var="q">
																<c:if test="${empty q.category_name }">
																	<option value="${q.q_category_id}">선택 안함</option>
																</c:if>
																<c:if test="${not empty q.category_name }">
																	<option value="${q.q_category_id}">${q.category_name}</option>
																</c:if>
																</c:forEach>
											                </select>
														</td>
											            <td> 
											                <select name="qustType" id="qustType" class="form-select" onchange="makeChildQStyle(this)">
											                    <option value="1">객관식</option>
											                    <option value="2">주관식</option>
											                </select>
											            </td>
											            <td>
											            	<select class="form-select" name="essential_yn">
											            		<option value="y">필수</option>
											                    <option value="n">선택</option>
											            	</select>
											            </td>
											            <td>
											            	<input type="number" class="form-control subMaxcnt" min = '1'  required >
											            </td>
											            <td>
											                <div class="surv_opt_box">
											                    <input id="qustCont" type="text" placeholder="질문을 입력해주세요" class="form-control" maxlength="100">
											                    <div id="choiceQuesOption">
											                    	<ul>
											                    		<li class="choiceQuLi" id="choiceQuLiItem">
												                    		<div class="d-flex"><button type="button" class="btn delOpRow" onclick="delOptionLi(this)">❌</button>
												                    		<select name="answer_type" onchange="makeOptionStyle(this)" class="ansTypeSelect">
												                    			<option value=1>일반</option>
												                    			<option value=3>기타</option>
												                    			<option value=4>없음</option>
												                    		</select>
												                    		<input type="text" class="form-control optioninputFrm"  onChange="duplicateValCk(this)" maxlength="20"></div>
											                    		</li>
											                    	</ul>
											                    	<button type="button" class="btn btn-primary"  onclick="addOption(this)"> 옵션 추가</button>
											                    </div>
											                </div>
											            </td>
											         </tr>
	 									         </c:if>
	 					         		</tbody>
							         	</table>
						         	</c:if> <!-- end of c:if 대문항 -->
						         	
						         	<!-- 대문항 아닐때  -->
						         	<c:if test="${q.question_type != 3 }">
							         	<table id="childQuesTb"  class="table table-light "  style="display:none">
							         		<thead>
							         			<tr>
							         				<th></th>
							         				<th>소질문 번호</th>
							         				<th>질문 유형</th>
										            <th>답변 유형</th>
										            <th>필수 질문</th>
										            <th>답변 개수</th>
										            <th>질문 내용</th>
										            <th><button type="button" class="btn btn-primary addSubTr">소질문 추가</button></th>
							         			</tr>
							         		</thead>
							         		<tbody>						         		
											    <c:set var="matchingSubques" value="false" />						         		
							         			<c:forEach items="${subqueslist}" var="q2" varStatus = "idx">
							         				<c:if test="${q.question_num eq q2.question_num}">
							         				  <c:set var="matchingSubques" value="true" />
								         			<tr class="subitem" id="subitmtr">
											            <td style="text-align:center;">
											                <button id="delQuestRow" type="button" class="btn" onclick="delQuesSubTr(this)" value="${q2.question_id}">❌</button>
											            </td>
											            <td id="subqustNo" class="subquestNo">1</td>
										                <td>
											            	<!-- 수정 필요 부분 -->
											            	<select class="form-select" id="question_category">
																<c:forEach items="${quesCategory}" var="c">
																<c:if test="${empty c.category_name }">
																	<option value="${c.q_category_id}" <c:if test="${q2.question_category == c.q_category_id}">selected</c:if>>선택 안함</option>
																</c:if>
																<c:if test="${not empty c.category_name }">
																	<option value="${c.q_category_id}" <c:if test="${q2.question_category == c.q_category_id}">selected</c:if> >${c.category_name}</option>
																</c:if>
																</c:forEach>
											                </select>
														</td>
											            <td> 
											                <select name="qustType" id="qustType" class="form-select qustType">
																<option value="1" <c:if test="${q2.question_type == 1}">selected</c:if>>객관식</option>
																<option value="2" <c:if test="${q2.question_type == 2}">selected</c:if>>주관식</option>
															</select>
											            </td>
											            <td>
											            	<select class="form-select" name="essential_yn">
											            		<option value="y" <c:if test="${q2.essential_yn == 'y'}">selected</c:if>>필수</option>
											                    <option value="n" <c:if test="${q2.essential_yn == 'n'}">selected</c:if>>선택</option>
											            	</select>
											            </td>
											            <td>
											            	<c:choose>
											            		 <c:when test = "${q2.question_type == 1}">					            	
											            			<input type="number" class="form-control subMaxcnt maxchoiceInput" min = '1' id="max_choice_cnt" value="${q2.max_choice_cnt}">
											            		</c:when>
											            		<c:otherwise >					            	
											            			<input type="number" class="form-control subMaxcnt maxchoiceInput" min = '1' id="max_choice_cnt" disabled>
											            		</c:otherwise>
											            	</c:choose>
											            </td>
											            <td>
											                <div class="surv_opt_box">
											                    <input id="qustCont" type="text" placeholder="질문을 입력해주세요" class="form-control" value="${q2.question_content}" maxlength="100">
											                    <div id="choiceQuesOption">
											                    	<p>선택지 옵션</p>
											                    	<ul>
											                    		<c:forEach items="${options}" var="op">
						                    							<c:if test ="${op.question_id == q2.question_id && q2.question_type == 1}">
												                    		<li class="choiceQuLi" id="choiceQuLiItem">
													                    		<div class="d-flex">
														                    		<button type="button" class="btn delOpRow" onclick="delOptionLi(this)">❌</button>
														                    		<select name="answer_type" onchange="makeOptionStyle(this)" class="ansTypeSelect">
														                    				<option value=1 <c:if test="${op.answer_type == 1}">selected</c:if>>일반</option>
															                    			<option value=3 <c:if test="${op.answer_type == 3}">selected</c:if>>기타</option>
															                    			<option value=4 <c:if test="${op.answer_type == 4}">selected</c:if>>없음</option>
														                    		</select>
														                    		<c:choose>
												            		 					<c:when test = "${op.answer_type == 1}">					           
															                    			<input type="text" class="form-control optioninputFrm" id="answer_content" onChange="duplicateValCk(this)" value="${op.answer_content}" maxlength="20">
													                    				</c:when>
						                									            <c:otherwise>
						                									            	<input type="text" class="form-control optioninputFrm" id="answer_content" onChange="duplicateValCk(this)" disabled maxlength="20">					            	
													                    				</c:otherwise>
													                    			</c:choose>
												                    			</div>
												                    		</li>
											                    		</c:if>
											                    		</c:forEach>
											                    	</ul>
											                    	<button type="button" class="btn btn-primary"  onclick="addOption(this)"> 옵션 추가</button>
											                    </div>
											                </div>
											            </td>
											         </tr>
										         	</c:if>
						
	 									         </c:forEach>
	 									         <c:if test="${matchingSubques eq 'false'}">
	 									         	<tr class="subitem" id="subitmtr">
											            <td style="text-align:center;">
											                <button id="delQuestRow" type="button" class="btn" onclick="delQuesSubTr(this)">❌</button>
											            </td>
											            <td id="subqustNo" class="subquestNo">1</td>
										                <td>
											            	<select class="form-select" id="question_category">
																<c:forEach items="${quesCategory}" var="q">
																<c:if test="${empty q.category_name }">
																	<option value="${q.q_category_id}">선택 안함</option>
																</c:if>
																<c:if test="${not empty q.category_name }">
																	<option value="${q.q_category_id}">${q.category_name}</option>
																</c:if>
																</c:forEach>
											                </select>
														</td>
											            <td> 
											                <select name="qustType" id="qustType" class="form-select" onchange="makeChildQStyle(this)">
											                    <option value="1">객관식</option>
											                    <option value="2">주관식</option>
											                </select>
											            </td>
											            <td>
											            	<select class="form-select" name="essential_yn">
											            		<option value="y">필수</option>
											                    <option value="n">선택</option>
											            	</select>
											            </td>
											            <td>
											            	<input type="number" class="form-control subMaxcnt" min = '1'  required >
											            </td>
											            <td>
											                <div class="surv_opt_box">
											                    <input id="qustCont" type="text" placeholder="질문을 입력해주세요" class="form-control" maxlength="100">
											                    <div id="choiceQuesOption">
											                    	<ul>
											                    		<li class="choiceQuLi" id="choiceQuLiItem">
												                    		<div class="d-flex"><button type="button" class="btn delOpRow" onclick="delOptionLi(this)">❌</button>
												                    		<select name="answer_type" onchange="makeOptionStyle(this)" class="ansTypeSelect">
												                    			<option value=1>일반</option>
												                    			<option value=3>기타</option>
												                    			<option value=4>없음</option>
												                    		</select>
												                    		<input type="text" class="form-control optioninputFrm"  onChange="duplicateValCk(this)"></div>
											                    		</li>
											                    	</ul>
											                    	<button type="button" class="btn btn-primary"  onclick="addOption(this)"> 옵션 추가</button>
											                    </div>
											                </div>
											            </td>
											             <td>
											            </td>
											         </tr>
	 									         </c:if>
	 					         		</tbody>
							         	</table>
						         	</c:if> <!-- end of c:if 대문항 -->
					         	<td>
					         </tr>
					         </c:if>
					         </c:forEach>
					       </tbody>
					    </table>
					</div>
					

					<button class="btn btn-outline-warning" type="button" id="submitbtn" onclick="submitSurvey()">수정하기</button>
				</form>
			</div>
		</div>
	</div>

	</main>
</body>
<script>
	//선언파트
	var origintr = $('.item').first().clone();
	var originSubTr = $('.subitem').first().clone();
	var qtr;
	var choiceOptionDiv;
	var childQuesTb;
	var childQuesTr
	var data = [];
	var count = 0;
	var surveyId = ${surveyId};
	var msg;
	makeQStyle();
	addSubTrInc();
	ckMaxCnt();
	
	//빈값체크하기
	function cknull(){
		var ck =true;
		
		$('.item').each(function(){
			
			let target = $(this);
			let type = $(this).find('.qustType').val();
			if(type == 1){
				//객관식일때 
				let input = $(this).find('input:enabled');
				input.each(function(){
					let inputck = $(this).val().trim().length; 
					if(inputck <=0){
						alert("객관식 항목에 빈값이 있습니다. 확인해 주세요");
						ck = false;
						return false;	
					}
				})// end of input.each
			}//endof 객관식
			if(type == 2){
				let input = $(this).find('#qustCont').val().trim();
				if(input.length <=0){
					alert("주관식 질문 내용에 빈값이 있습니다. 확인해 주세요");
					ck = false;
					return false;
				}
			}//end of 2
			if(type == 3){
				//대항목 
				let input = $(this).find('#qustCont').val().trim();
				if(input.length <=0){
					alert("대항목 질문 내용에 빈값이 있습니다. 확인해 주세요");
					ck = false;
					return false;
				}
				
				let sub = $(this).next().find('.subitem');
				let subtype = sub.find('#qustType');
				sub.each(function(){
					if(!ck){
						return false;
					}
					if(subtype ==1){
						let input = $(this).find('input:enabled');
						input.each(function(){
							let inputck = $(this).val().trim().length; 
							if(inputck <=0){
								alert("소질문 객관식 옵션 항목에 빈값이 있습니다. 확인해 주세요");
								ck = false;
								return false;
							}
						})
					}else{
						let input = $(this).find('input:enabled:not(.optioninputFrm)');
						input.each(function(){
							let inputck = $(this).val().trim().length; 
							if(inputck <=0){
								alert("소질문 항목에 빈값이 있습니다. 확인해 주세요");
								ck = false;
								return false;
							}
						})
					}
					let input = $(this).find('input:enabled'); 
					
				})//end of sub
			}// end of 3
			if(!ck){
				return false;
			}else{
				return true;
			}
		})
		if(!ck){
			return false;
		}else{
			return true;
		}
	}
	//
	function ckMaxCnt(){
		$(".maxchoiceInput").on("change", function(){
			let val = $(this).val();
			let type = $(this).parent().prev().prev().find('select').val();
			var length = $(this).parent().next().find('.ansTypeSelect').filter(function() {
				  return $(this).val() === "1";
			}).length;
			
			if(val ==0){
				alert('0은 들어갈 수 없습니다.');
				 $(this).val('');
				
			}
			 if(type == 1 && val>1 && length< val){
				 alert('옵션보다 많은 답변갯수를 입력할 수 없습니다.');
				 $(this).val('');
			 } 
			
		})
	}
	
	//추가 클릭시 td 클론하기
	function addTr(){
		
		//이전 tr에 객관식형식일떄 옵션값없는지, 뭐..이것저것 확인하고ㅡ,질문제목 빠진거 없는지
		//고려할 사항..
		
		qtr  = $('#itmtr');
		childItemTr = $('#childItemTr');
		//let clonetr = qtr.clone();
		let clonetr = origintr.clone();
		let clonechildTr = childItemTr.clone();
		clonetr.find('input').val('');
		let option = clonetr.find('.choiceQuLi');
		clonetr.find('.maxchoiceInput').prop('disabled', false);
		clonetr.find('#choiceQuesOption').css('display', 'block');
		if(option.length >1){
			option.slice(1).remove();
		} 
		
		clonetr.find('select').prop('selectedIndex', 0)
		clonechildTr.find('input').val('');
		let subclonetr = clonechildTr.find('.subitem');
		if(subclonetr.length>1){
			subclonetr.slice(1).remove();
		}
		clonechildTr.find('select').prop('selectedIndex', 0);

		//clonechildTr.css('display', 'none');
		clonechildTr.find('table').css('display', 'none');
		$('#QuesTb').append(clonetr, clonechildTr);
		$('#QuesTb').find('')
		
		 // questNo의 값을 증가시킴

		  clonetr.after(clonechildTr);
		
		  $('.questNo').each(function(index) {
			  var questNo = index + 1;
			  $(this).text(questNo);
			});
		makeQStyle();
		makeData();
		addSubTrInc();
		ckMaxCnt();
	}
	
	//등록 날짜 제한 
	let start = $('input#start_date');
	let end = $('input#end_date');
	let announce = $('input#announce_date');
	console.log(end.val());
	var today = new Date().toISOString().split('T')[0];
	start.prop('min', today);
	end.prop('min', start.val());
	
	start.on('input', function() {
		end.prop('min', start.val());
		if(end.val().trim() > 0 && end.val() < start.val()){
			alert("시작일이 변경되었습니다. 수정해주세요");
		}
	});

	end.on('input', function() {
		announce.prop('min', end.val());
		if(announce.val().trim() > 0 && announce.val() < end.val()){
			alert("종료일이 변경되었습니다. 수정해주세요");
		}
	});
	
	
	//질문 유형 선택시 질문내용 td 바꾸기
	//대분류 같은경우는 밑에 소분류 추가 나타나게 
	function makeQStyle() {
	  $('.qustType').on("change", function () {
		  
	    let selectval = $(this).val();
	    let tr = $(this).parent().parent();

	    let childQuesTr = tr.next();

	
	    let choiceOptionDiv = tr.find("#choiceQuesOption");
	    let childQuesTb = childQuesTr.find("#childQuesTb");
	
	    let inputAnstd = $(this).parent().next().next();
	    let inputAns = inputAnstd.find('input[type="number"]').eq(0);
	    
	    let inputquestd = $(this).parent().next().next().next();
	    let inputques = inputquestd.find('input[type="text"]').eq(0);
	    
	    
	    let essential = $(this).parent().next().find('select');
	
	    // 소분류
	     if (selectval === '1') {
	      // 객관식
	      choiceOptionDiv.find('input').val('');
	      choiceOptionDiv.css('display', 'block');
	      childQuesTb.css('display', 'none');
	      inputAns.prop('disabled', false);
	      inputques.val("");
		    essential.prop('disabled', false);

	    } else if (selectval === '3') {
	      // 대분류
	      childQuesTb.find('input').val('');
	      choiceOptionDiv.css('display', 'none');
	      childQuesTb.css('display', 'block')
	      	essential.val('n').prop('selected', true);
		    essential.prop('disabled', true);
	      inputAns.prop('disabled', true);
	      inputques.val("");
		    inputAns.val('');
	    } else {
	      // 주관식
	      choiceOptionDiv.css('display', 'none');
	      childQuesTb.css('display', 'none');
	      inputAns.prop('disabled', true);
		  essential.prop('disabled', false);
		  inputques.val("");
		    inputAns.val('');
	    }
	  });
	}
	
	//소질문 답변유형 선택 ㅎ;;
	function makeChildQStyle(){
		
		$('.qustType').change(function(){
			let selectval = $(this).val();
			let tr = $(this).parent().parent();
			
			console.log(selectval);
			choiceOptionDiv = tr.find("#choiceQuesOption");
			
			let inputAnstd = $(this).parent().next().next();
			let inputAns = inputAnstd.find('input[type="number"]')[0];
			let inputAnsConttd = $(this).parent().next().next().next();
			let inputAnsCont = inputAnsConttd.find('input[type="text"]')[0];
			
			//소분류
			
			if (selectval == '1') {
				//객관식
			    choiceOptionDiv.css('display', 'block');
			    inputAns.disabled = false;
			    inputAnsCont.value = '';
			  } else {
				  //주관식
			   choiceOptionDiv.css('display', 'none');
			    inputAns.disabled = true;
			    inputAnsCont.value = '';

			  }		
		})
		
	}
	
	//먼저 객관식 옵션 빈값 확인 및 중복값 확인
	function optioninputCkNull() {
	  let isNull = true;
	  let  array = [];
	  
	  let target = event.target;
	  let ul = $(target.closest('#choiceQuesOption'));
	  let list = ul.find('.optioninputFrm:not([disabled])');

	 	list.each(function() {
		 let val = $(this).val().trim();
		 
	    if (val.length <= 0) {
	      alert("빈 옵션을 먼저 작성해주세요");
	      isNull = false;
	      return false; 
	    }else if (array.includes(val)) {
	        alert("중복된 옵션 값이 있습니다");
	        $(this).val('');
	        isNull = false;
	        return false;
	      } else {
	    	  array.push(val); 
	      }
	  });
	
	  return isNull;
	}
	
	//객관식 선택문항 추가
	function addOption(e) {
	  
	  let oplist = $(e.previousElementSibling);
	  let item = $('#choiceQuLiItem');
	  
	  if(optioninputCkNull()){
		  let liclone = $('<li class="choiceQuLi"><div class="d-flex"><button type="button" class="btn delOpRow" onclick="delOptionLi(this)">❌</button><select name="answer_type" onchange="makeOptionStyle(this)" class="ansTypeSelect"><option value="1">일반</option><option value="3">기타</option><option value="4">없음</option></select><input type="text" class="optioninputFrm form-control" value="" onchange="duplicateValCk(this)"></div></li>');
		  oplist.append(liclone);
	  };

	}
	
	//객관식 옵션 중에 없음. 기타 선택했을 경우 
	function makeOptionStyle(e){
		let  array = [];
		let textfrm = e.nextElementSibling;
		let ul = $(e.closest('.choiceQuLi').parentNode);

		let selectlist = ul.find('.ansTypeSelect');
		
		selectlist.each(function(){
			if($(this).val() != 1 && array.includes($(this).val())){
				alert("기타, 없음은 문항 당 한번만 등록할 수 있습니다.");
				 $(this).val("1");
				return false;
			}else{
				array.push($(this).val());
			}
		})
		
		if(e.value != 1){
			textfrm.classList.remove('optioninputFrm');
			textfrm.value = '';
			textfrm.disabled = true;
		}else{
			textfrm.classList.add('optioninputFrm');
			textfrm.disabled = false;	
		}
		
	}
	
	//모든 객관식 옵션 중에서 변화할떄 마다 같은 값 있는지 체크합니다!
	function duplicateValCk(e){
		 let ul = $(e.closest('#choiceQuesOption'));
		  let list = ul.find('.optioninputFrm');
		  
		  let isNull = true;
		  let  array = [];

		 	list.each(function() {
			 let val = $(this).val().trim();
			 
		    if (val.length <= 0) {
		      alert("빈 옵션을 먼저 작성해주세요");
		      isNull = false;
		      return false; 
		    }else if (array.includes(val)) {
		        alert("중복된 옵션 값이 있습니다");
		        $(this).val('');
		        isNull = false;
		        return false;
		      } else {
		    	  array.push(val); 
		      }
		  });
		
		  return isNull;
	}
	
	//설문지 문항 삭제 
 	function delQuesTr(e){
		let tr = e.parentNode.parentNode;
		let nexttr = e.parentNode.parentNode.nextElementSibling;

		let length = $('.item').length;
		
		
		if(length <= 1){
			alert("최소 1개의 문항은 존재해야 합니다.");
			return false;
		}
		
		if( !confirm("삭제하시겠습니까?")){
			return false;
		}else{
			tr.remove();
			nexttr.remove();
		}
		

	  $('.questNo').each(function(index) {
		  var questNo = index + 1;
		  $(this).text(questNo);
		});
		
	}
	
	//소질문 삭제
	function delQuesSubTr(e){
		let mom = e.parentNode.parentNode;
		let tr = $(e.parentNode.parentNode.parentNode);
		
		let length = tr.find('.subitem').length;

		if(length <= 1){
			alert("최소 1개의 문항은 존재해야 합니다.");
			return false;
		}
		
		if( !confirm("삭제하시겠습니까?")){
			return false;
		}else{
			mom.remove();	
		}
		
		tr.find( '.subquestNo').each(function(index) {
		  var questNo = index + 1;
		  $(this).text(questNo);
		});
	}
	
	//옵션 삭제 
	function delOptionLi(e){
		let li = $(e.closest('.choiceQuLi'));
		let ul = $(e.closest('ul'));
		let oplist = ul.find('.choiceQuLi');
		let length = oplist.length;
		
		if(length <= 1){
			alert("최소 1개의 문항은 존재해야 합니다.");
			return false;
		}
		
		if( !confirm("삭제하시겠습니까?")){
			return false;
		}else{
			li.remove();
		}

	}

	//대문항의 소문항 추가
	function addSubTrInc(){
		
		$('.addSubTr').on("click", function(){
			
			let subtr = $(this).closest('#childQuesTb').find('#subitmtr');
			let num = parseInt($(this).closest('#childQuesTb').find('.subquestNo').last().text());
			
			let nextnum = num+1;
			let clonechildTr = originSubTr.clone();
			clonechildTr.find('input').val('');
			clonechildTr.find('select').prop('selectedIndex', 0);
			clonechildTr.find('.maxchoiceInput').prop('disabled', false);
			let subclonetr = clonechildTr.find('.subitem');
			if(subclonetr.length>1){
				subclonetr.slice(1).remove();
			}
			
			let table = $(this).closest('#childQuesTb')
			table.append(clonechildTr);
			$(this).closest('#childQuesTb').find('.subquestNo').each(function(index) {
				  var questNo = index + 1;
				  $(this).text(questNo);
			});
	
			makeChildQStyle();
		})
		
	}
	
	
	function makeData(){
		//데이터 만들기
		data = [];
		$('.item').each(function(){
				
			$(this).find('#qustType').each(function(){
					
					let qobj = {};
					let obj = {};
					let lobj = {};
					let mainQList = [];
					let ansList = [];
					let ansobj = {};
					
					

					let list = [];
					let subAnsList = [];
					
					let answer_order = 1;
					
					let questype= $(this).val();
					let tr = $(this).parent().parent();
					
					//설문조사 정보
					lobj.start_date = $('#start_date').val();
					lobj.end_date = $('#end_date').val();
					lobj.announce_date = $('#announce_date').val();
					lobj.participate_cnt = $('#participate_cnt').val();
					lobj.servey_target = $('#servey_target').val();
					lobj.title = $('#title').val();
					lobj.menu_id = 8;
					lobj.writer = '퓨전소프트';
					
					list.push(lobj);
					
					
					//공통
					
					//객관식일때
					if(questype === '1'){
						
						let maxcnt = parseInt(tr.find('#max_choice_cnt').val());
						qobj.question_category = parseInt(tr.find('#question_category').val());
						qobj.question_type =  parseInt(questype);
						qobj.question_content = tr.find('#qustCont').val();
						qobj.essential_yn = tr.find('select[name="essential_yn"]').val();
						qobj.question_num = parseInt(tr.find('.questNo').text());
						
						qobj.max_choice_cnt = maxcnt;
						qobj.question_num_child = 0;
						mainQList.push(qobj);
						
						//옵션 값 담기
						tr.find('.choiceQuLi').each(function(index){
							ansobj = {};
							
							ansobj.answer_order = answer_order;
							//ansobj.answer_content = $(this).find('.optioninputFrm').val();
							let ansType = parseInt($(this).find('.ansTypeSelect').val());
							ansobj.answer_type = ansType;
							ansList.push(ansobj)
							answer_order++;
							if(ansType === 3 || ansType ===4 ){
								if(ansType == 3){
									ansobj.answer_content = '기타';
								}
								if(ansType == 4){
									ansobj.answer_content = '없음';
								}	
						      maxcnt = maxcnt + 1;
						    } else {
						    	ansobj.answer_content = $(this).find('.optioninputFrm').val();
						    }
						})
							
						
						
						mainQList.max_choice_cnt = maxcnt;
						obj.ansList = ansList;
						obj.mainQList = mainQList;
						obj.list = list;
						data.push(obj);
					}
					
					if(questype === '2'){
						qobj.question_category = parseInt(tr.find('#question_category').val());
						qobj.question_type =  parseInt(questype);
						qobj.question_content = tr.find('#qustCont').val();
						qobj.essential_yn = tr.find('select[name="essential_yn"]').val();
						qobj.question_num = parseInt(tr.find('.questNo').text());
						
						qobj.max_choice_cnt = 1;
						qobj.question_num_child = 0;
						mainQList.push(qobj);
						ansobj.answer_order = 1;
						ansobj.answer_content = '';
						ansobj.answer_type = 2;
						
						ansList.push(ansobj)
						obj.ansList = ansList;
						obj.mainQList = mainQList;
						obj.list = list;
						data.push(obj);
					}
					
					if(questype === '3'){
						
						qobj.question_category = parseInt(tr.find('#question_category').val());
						qobj.question_type =  parseInt(questype);
						qobj.question_content = tr.find('#qustCont').val();
						qobj.essential_yn = 'n';
						qobj.question_num = parseInt(tr.find('.questNo').text());
						
						qobj.max_choice_cnt = 0;
						qobj.question_num_child = 0;
						mainQList.push(qobj);
						
						let subtr = tr.next();
						console.log(subtr);
						let subQtype= parseInt($(this).closest('.item').next().find('#qustType').val());
						
						obj.list = list;
						obj.mainQList = mainQList;
						data.push(obj);
						
						subtr.find('.subitem').each(function(){
							console.log($(this));
							let subQList = [];
							let subqobj = {};
							let anotherobj = {};
							let anotherarr = [];
							
						
							let child_order = parseInt($(this).find('.subquestNo').text());
							let maxcnt = parseInt($(this).find('.subMaxcnt').val());
							let qtype= $(this).find('#qustType').val();
							console.log(qtype);
							
							subqobj.question_category = parseInt(subtr.find('#question_category').val());
							subqobj.question_type =  parseInt(qtype);
							subqobj.question_content = $(this).find('#qustCont').val();
							subqobj.essential_yn = $(this).find('select[name="essential_yn"]').val();
							subqobj.question_num = parseInt($(this).closest('#childItemTr').prev().find('.questNo').text());
							
							console.log(subQtype);
							if(qtype == 1){
								console.log("소문항객관식");
							  $(this).find('.choiceQuLi').each(function(index) {
								  let subansobj = {};
								
								  	//질문
								  	console.log(maxcnt);
									subqobj.max_choice_cnt = maxcnt;
									subqobj.question_num_child = child_order;
									subQList.push(subqobj);
								  	//답
								    subansobj.answer_order = answer_order;
								    let ansType = parseInt($(this).find('.ansTypeSelect').val());
								    subansobj.answer_type = ansType;
								    
								    if (ansType === 3 || ansType === 4) {
								    	if(ansType == 3){
								    		subansobj.answer_content = '기타';
										}
										if(ansType == 4){
											subansobj.answer_content = '없음';
										}	
								      maxcnt = maxcnt + 1;
								    } else {
								      subansobj.answer_content = $(this).find('.optioninputFrm').val();
								    }
								    
								    anotherarr.push(subansobj);
								    answer_order++;
								  });

							}else if(qtype == 2){
								//질문
								
								console.log("2입니당");
								subqobj.max_choice_cnt = 0;
								subqobj.question_num_child = child_order;
								subQList.push(subqobj);
								
								
								ansobj = {};
								ansobj.answer_order = 1;
								ansobj.answer_content = '';
								ansobj.answer_type = 2;

								
								anotherarr.push(ansobj)	
							}
							
							anotherobj.subQList = subQList;
							anotherobj.subAnsList = anotherarr;
							data.push(anotherobj);
							
						})
						
					}
					
			})
			
		})
		return data;
	}
	
	function deleteforEdit(){
		console.log(surveyId);
		 $.ajax({
			url : '/survey/delForEdit.do',
			type : 'POST',
			data : {survey_id : surveyId},
			 success: function (result) {
				 console.log(result);
				 msg = result;
			},
			error: function (error) {
				console.log(error);
				alert('실패');
			}
		})

		 
	}
	function submitSurvey(){
		//데이타 만들기 
		makeData();
		
		
		if( $('#title').val().trim().length <=0){
			alert("제목을 입력해 주세요!");
			return false;
		}
		
		if($('#start_date').val().trim().length <=0){
			alert("시작 날짜 입력해 주세요!");
			return false;
		}
		

		if($('#end_date').val().trim().length <=0){
			alert("종료 날짜 입력해 주세요!");
			return false;
		}
		
		if($('#announce_date').val().trim().length <= 0 ){
			alert('발표 날짜를 입력해 주세요');
			return false;
		}
		
		if($('#start_date').val() < today){
			alert('오늘 날짜 이전에 시작할 수 없습니다!');
			return false;
		}
		
		if($('#start_date').val() > $('#end_date').val()){
			alert('종료일은 시작일보다 빠를 수 없습니다!');
			return false;
		}
		
		if($('#start_date').val() > $('#announce_date').val()){
			alert('발표일은 시작일보다 빠를 수 없습니다!');
			return false;
		}
		
		if($('#end_date').val() > $('#announce_date').val()){
			alert('발표일은 종료일보다 빠를 수 없습니다!');
			return false;
		}

		if($('#participate_cnt').val().trim().length <= 0){
			alert("참여 가능 횟수 작성해 주세요");
			return false;
		}
		
		if($('#participate_cnt').val() <=0 ){
			alert("참여 가능 횟수는 최소 1회입니다.");
			return false;
		}
		if($('#participate_cnt').val() >5 ){
			alert("참여 가능 횟수는 최대 5회입니다.");
			return false;
		}
		
		//빈값 찾기
		var submitbefore = cknull();
		console.log(submitbefore);
		if(submitbefore){
			
		
		console.log(data);
		
		deleteforEdit();
		
		     $.ajax({
			url : '/survey/surveyInput.do',
			type : 'POST',
			data : JSON.stringify(data),
			contentType : 'application/json', 
			success: function (result) {
				alert("수정 완료!");
				//관리자 페이지로이동하기
				location.href ="/survey/surveyAdmin.do?menu_id=42"
			},
			error: function (error) {
				console.log(error);
				alert('실패');
			}
		}) 
		}
	}
</script>
</html>