<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
<script>
	//let surveyId = "${surveyId}";
	if(${not empty msg1}){
		alert("${msg1}");
		location.href="/survey/surveyListForUser.do";
	}
	
	if(${not empty msg2}){
		alert("${msg2}");
		location.href='/user/loginfrm.do';
	}
</script>
</html>