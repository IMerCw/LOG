<%@page import="poly.dto.UserMemberDTO"%>
<%@page import="poly.dto.BoardPostDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	BoardPostDTO bpDTO = (BoardPostDTO) request.getAttribute("bpDTO"); 
	UserMemberDTO uDTO = (UserMemberDTO) session.getAttribute("uDTO");
	
	String boardPContent = bpDTO.getBoard_p_content();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- Specific Page Vendor CSS -->
	<link rel="stylesheet" href="/assets/vendor/jquery-ui/css/ui-lightness/jquery-ui-1.10.4.custom.css" />
	<link rel="stylesheet" href="/assets/vendor/select2/select2.css" />
	<link rel="stylesheet" href="/assets/vendor/bootstrap-multiselect/bootstrap-multiselect.css" />
	<link rel="stylesheet" href="/assets/vendor/bootstrap-tagsinput/bootstrap-tagsinput.css" />
	<link rel="stylesheet" href="/assets/vendor/bootstrap-colorpicker/css/bootstrap-colorpicker.css" />
	<link rel="stylesheet" href="/assets/vendor/bootstrap-timepicker/css/bootstrap-timepicker.css" />
	<link rel="stylesheet" href="/assets/vendor/dropzone/css/basic.css" />
	<link rel="stylesheet" href="/assets/vendor/dropzone/css/dropzone.css" />
	<link rel="stylesheet" href="/assets/vendor/bootstrap-markdown/css/bootstrap-markdown.min.css" />
	<link rel="stylesheet" href="/assets/vendor/summernote/summernote.css" />
	<link rel="stylesheet" href="/assets/vendor/summernote/summernote-bs3.css" />
	<link rel="stylesheet" href="/assets/vendor/codemirror/lib/codemirror.css" />
	<link rel="stylesheet" href="/assets/vendor/codemirror/theme/monokai.css" />
	
	<!-- Skin CSS -->
	<link rel="stylesheet" href="/assets/stylesheets/skins/default.css" />

	<!-- Theme Custom CSS -->
	<link rel="stylesheet" href="/assets/stylesheets/theme-custom.css">

	<!-- Head Libs -->
	<script src="/assets/vendor/modernizr/modernizr.js"></script>
	
	<!-- Specific Page Vendor -->
	<script src="/assets/vendor/jquery-ui/js/jquery-ui-1.10.4.custom.js"></script>
	<script src="/assets/vendor/jquery-ui-touch-punch/jquery.ui.touch-punch.js"></script>
	<script src="/assets/vendor/select2/select2.js"></script>
	<script src="/assets/vendor/bootstrap-multiselect/bootstrap-multiselect.js"></script>
	<script src="/assets/vendor/jquery-maskedinput/jquery.maskedinput.js"></script>
	<script src="/assets/vendor/bootstrap-tagsinput/bootstrap-tagsinput.js"></script>
	<script src="/assets/vendor/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
	<script src="/assets/vendor/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
	<script src="/assets/vendor/fuelux/js/spinner.js"></script>
	<script src="/assets/vendor/dropzone/dropzone.js"></script>
	<script src="/assets/vendor/bootstrap-markdown/js/markdown.js"></script>
	<script src="/assets/vendor/bootstrap-markdown/js/to-markdown.js"></script>
	<script src="/assets/vendor/bootstrap-markdown/js/bootstrap-markdown.js"></script>
	<script src="/assets/vendor/codemirror/lib/codemirror.js"></script>
	<script src="/assets/vendor/codemirror/addon/selection/active-line.js"></script>
	<script src="/assets/vendor/codemirror/addon/edit/matchbrackets.js"></script>
	<script src="/assets/vendor/codemirror/mode/javascript/javascript.js"></script>
	<script src="/assets/vendor/codemirror/mode/xml/xml.js"></script>
	<script src="/assets/vendor/codemirror/mode/htmlmixed/htmlmixed.js"></script>
	<script src="/assets/vendor/codemirror/mode/css/css.js"></script>
	<script src="/assets/vendor/summernote/summernote.js"></script>
	<script src="/assets/vendor/bootstrap-maxlength/bootstrap-maxlength.js"></script>
	<script src="/assets/vendor/ios7-switch/ios7-switch.js"></script>

	<!-- Theme Base, Components and Settings -->
	<script src="/assets/javascripts/theme.js"></script>
	
	<!-- Theme Custom -->
	<script src="/assets/javascripts/theme.custom.js"></script>
	
	<!-- Theme Initialization Files -->
	<script src="/assets/javascripts/ui-elements/examples.notifications.js"></script>
	<script src="/assets/javascripts/theme.init.js"></script>
	<script src="/assets/javascripts/forms/examples.advanced.form.js" /></script>
<script>
	//제목 설정
	$('#pageName').html('고객센터 글 쓰기');
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
					<h2 class="panel-title">고객센터 게시글 수정</h2>
					<p class="panel-subtitle">
						Basic validation will display a label with the error after the form control.
					</p>
				</header>
				<div class="panel-body">
					<div class="form-group">
						<label class="col-sm-12 control-label">글 제목 <span class="required"></span></label>
						<div class="col-sm-12">
							<input type="text" id="board_p_title" name="board_p_title" class="form-control" placeholder="글 제목을 작성해주세요." value=<%=bpDTO.getBoard_p_title()%> required>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-12 control-label">글 내용 <span class="required"></span></label>
						<div class="col-sm-12">
							<%@include file="/assets/summernote/summernote.jsp"%>
						</div>
					</div>
				</div>
				<footer class="panel-footer">
					<div class="row">
						<div class="col-sm-6" style="text-align:left;">
							<button type="button" class="btn btn-default" onclick="callHelpCenterMain();">목록보기</button>
						</div>
						<div class="col-sm-6" style="text-align:right;">
							<button type="button" class="btn btn-primary" onclick="callHelpCenterUpdateProc();">수정하기</button>
							<button type="button" class="btn btn-default" onclick="callHelpCenterRead();">취소하기</button>
						</div>
					</div>
				</footer>
			</section>
		</form>
	</div>
</body>

<script>

//이전 게시물의 내용 불러오기
$('.note-editable').html('<%=bpDTO.getBoard_p_content().replaceAll("& lt;", "<").replaceAll("& gt;", ">").replaceAll("\r","/r")%>');

	//목록 보기
	function callHelpCenterMain() {
		$.ajax({
			type : "POST",
			url : "/mem/helpCenter/helpCenterMain.do",
			dataType: "text",
			data:{currentPage: '${currentPage}'},
			error: function() {
				alert("통신실패");
			},
			success: function(data) {
				$('.content-body').html(data);
			}
		})
	}
	//수정 하기
	function callHelpCenterUpdateProc() {
		var graph_content = $('.note-editable').html();
		if(graph_content == '') return false;
		
		$.ajax({
			type : "POST",
			url : "/mem/helpCenter/helpCenterUpdateProc.do",
			dataType: "text",
			data:{
				board_p_seq: '<%=bpDTO.getBoard_p_seq()%>', 
				board_p_title: $('#board_p_title').val(), 
				board_p_content: graph_content,
				update_user_seq: '<%=uDTO.getUser_seq()%>',
				currentPage: '${currentPage}'
			},
			error: function() {
				alert("통신실패");
			},
			success: function(data) {
				$('.content-body').html(data);
			}
		})
	}
	
	//취소하기 글 보기 상세
	function callHelpCenterRead() {
		$.ajax({
			type : "GET",
			url : "/mem/helpCenter/helpCenterRead.do",
			dataType: "text",
			data: {board_p_seq : '<%=bpDTO.getBoard_p_seq()%>'},
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