<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.anychart.com/releases/v8/js/anychart-base.min.js"></script>
<script src="https://cdn.anychart.com/releases/v8/js/anychart-tag-cloud.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>
	<div class="chart-area">
		<div id="container" style="width:80%; height:100%;"></div>
	</div>
</body>
<script>
	anychart.onDocumentReady(function () {
	    var data = [];
	    $.ajax({
	        url: '/galary/getTagCloudData.do',
	        type: 'GET',
	        contentType: 'application/json',
	        success: function(result) {
	            data = result;
	
	            // 태그 클라우드 차트 생성
	            var chart = anychart.tagCloud(data);
	            chart.angles([0]);
	            chart.container("container");
	
	            // 글꼴 크기 조정
	            chart.normal().fontSize([10, 40]);
	
	            // 모양 변경
	            chart.mode("rectangular");
	
	            // 색상 범위 비활성화
	            chart.colorRange().enabled(false);
	
	            // 차트 그리기
	            chart.draw();
	        },
	        error: function(xhr, status, error) {
	            console.log(error);
	        }
	    });
	});




</script>
</html>