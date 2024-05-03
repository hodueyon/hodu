<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>    
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
<Script>
	let url = "${location}";
	console.log(url);
	 window.open(url, '_blank', width=800, height=800);
	 window.location.href = '/user/main.do';
</Script>
</html>