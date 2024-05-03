<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 타일즈 사용하기 위해 -->
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	
</style>
</head>
<body>
	<div>
		<div><tiles:insertAttribute name="header" /></div>
		<div><tiles:insertAttribute name="body" /></div>
	</div>
</body>
</html>