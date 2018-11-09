<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	//제목 설정
	$('#pageName').html('고객센터');
</script>
<style>
	.contentSubject {
		font-size:18px;
		text-overflow: ellipsis;
		overflow: hidden;
		white-space: nowrap;
	}
	.boardContent {
	    border-bottom: 1px solid #cccccc;
	    padding: 10px;
	}
	.boardWritingInfo{
		text-align:right; padding-top: 8px;
	}
</style>
</head>
<body>
	<div class="container-fluid" style="background-color:#ffffff; color:black; padding:10px;">
		<h2 style="margin-bottom:20px; ">고객센터</h2>
		<!-- Board content -->
		<div class="boardContent"></div>
		<div class="boardContent">
			<div class="row" style="">
				<div class="col-xs-12 contentSubject">가나다라마바사아자차카타파하하하하바바자잗다가나다라마바사아자차카타파하하하하바바자잗다타파하하하하바바자잗다</div>
			</div>
			
			<div class="row boardWritingInfo" style="padding-top: 6px;">
				<div class="col-xs-6 col-sm-6"></div>
				<div class="col-xs-3 col-sm-3">작성일</div>
				<div class="col-xs-3 col-sm-3">처리날짜</div>
			</div>
		</div>
		<!-- BUTTON -->
		<div style="margin-top:32px;"> 
			<button type="button" class="mb-xs mt-xs mr-xs btn btn-primary" style="float:right;">문의하기</button>
		</div>
		
	</div>
</body>
</html>