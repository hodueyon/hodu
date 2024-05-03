<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<title>회원 관리</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
	table{
		text-align : center;
		margin : 30px auto;
	}
	h1{
		text-align : center;
		margin : 20px 0;
	}
</style>
</head>
<body>
<%
	Integer usernum = 1;
%> 
	<div class="card-body" >
		<h1>회원관리</h1>
		<table class="table table-hover table-striped"  style="width:1000px; ">
			<thead>
				<tr>
					<th>번호</th>
					<th>아이디</th>
					<th>성함</th>
					<th>지역</th>
					<th>권한</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${users}" var="user" varStatus="num">
					<tr>
						<td>${num.count}</td>
						<td>${user.user_name}</td>
						<td>${user.real_name}</td>
						<td>${user.locationname}</td>
						<td>${user.auth_name}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>