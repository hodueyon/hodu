<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
	alert("등록되었습니다.");
	window.close();
	opener.document.location.href="/board/boardList.do?nowPage=1&cntPerPage=10&menu_id=${menu_id}";
</script>
</body>
</html>