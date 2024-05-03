<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>설문조사</title>
</head>
<body>
	<div>
		<c:forEach var="q" items="${questions}">
			<div>
				<div>
					 <c:if test="${q.question_num_child eq 0}">
						<span>"문항 ${q.question_num}"</span>
					</c:if>
					 <c:if test="${q.question_num_child ne 0}">
						<span>"${q.question_num}-${q.question_num_child}"</span>
					</c:if>
					<span>${q.question_content}</span>		
				</div>
			  <c:set var="question_id" value="${q.question_id}" />
			  <c:forEach var="answer" items="${answers}">
			    <c:if test="${question_id eq answer.question_id}">
			    </c:if>
			  </c:forEach>
		  	</div>
		</c:forEach>	
	</div>
</body>
</html>