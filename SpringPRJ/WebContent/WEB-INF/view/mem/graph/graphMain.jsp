<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	//제목 설정
	$('#pageName').html('그래프 갤러리');
</script>
<style>
	.rating > .fa { color:#ed9c28 }
</style>
</head>
<body>
	<div class="row">
		<div class="col-md-12">
			<button type="button" class="mb-xs mt-xs mr-xs btn btn-primary" style="float:right;" onclick="javascript:callWriteGraphFirstStep()">그래프 작성하기</button>
		</div>
	</div>
	
	<div class="row">
		<section class="panel col-md-6">
			<div class="panel-body">
				Content.
			</div>
			<div class="panel-footer">
				<div class="row" style="font-size:18px;">
					<div class="col-md-12">그래프 제목</div>
				</div>
				<div class="row" style="font-size:11px; margin-top: 8px;">
					<div class="col-md-6 rating" style="text-align:left;">
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star-half-o"></i>
						<i class="fa fa-star-o"></i>
					</div>
					<div class="col-md-6" style="text-align:right;">
						작성자 &nbsp;
						조회수/작성날짜
					</div>
				</div>
			</div>
		</section>
	</div>
</body>
<script>

	//그래프 작성 1단계 이동
	function callWriteGraphFirstStep() {
		$.ajax({
			type : "GET",
			url : "/mem/graph/writeGraph/firstStep.do",
			dataType: "text",
			error: function() {
				alert("통신실패");
			},
			success: function(data) {
				$('.content-body').html(data);
			}
		})
	}
</script>
</html>