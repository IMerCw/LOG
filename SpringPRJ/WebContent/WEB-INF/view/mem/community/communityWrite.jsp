<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	//제목 설정
	$('#pageName').html('커뮤니티 글 쓰기');
</script>
<style>
	textarea.form-control {
		height:400px;	
	}
	.form-horizontal .control-label{ 
		padding-bottom:12px; font-size:18px;
	}
	
</style>
</head>
<body>
	<div class="col-md-12">
		<form id="form" class="form-horizontal">
			<section class="panel">
				<header class="panel-heading">
					<h2 class="panel-title">커뮤니티 게시글 작성</h2>
					<p class="panel-subtitle">
						Basic validation will display a label with the error after the form control.
					</p>
				</header>
				<div class="panel-body">
					<div class="form-group">
						<label class="col-sm-12 control-label">글 제목 <span class="required"></span></label>
						<div class="col-sm-12">
							<input type="text" id="board_p_title" name="board_p_title" class="form-control" placeholder="글 제목을 작성해주세요." required>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-12 control-label">글 내용 <span class="required"></span></label>
						<div class="col-sm-12">
							<textarea name="board_p_content" id="board_p_content" rows="5" class="form-control" placeholder="글 내용을 작성해주세요." required></textarea>
						</div>
					</div>
				</div>
				<footer class="panel-footer">
					<div class="row">
						<div class="col-sm-12" style="text-align:center;">
							<button type="button" class="btn btn-primary" onclick="callCommunityWriteProc();">작성하기</button>
							<button type="button" class="btn btn-default" onclick="callCommunityMain();">목록보기</button>
						</div>
					</div>
				</footer>
			</section>
		</form>
	</div>
</body>

<script>
	function callCommunityMain() {
		$.ajax({
			type : "POST",
			url : "/mem/community/communityMain.do",
			dataType: "text",
			error: function() {
				alert("통신실패");
			},
			success: function(data) {
				$('.content-body').html(data);
			}
		})
	}
	function callCommunityWriteProc() {
		$.ajax({
			type : "POST",
			url : "/mem/community/communityWriteProc.do",
			dataType: "text",
			data : {board_p_title: $('#board_p_title').val(), board_p_content: $('#board_p_content').val() },
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