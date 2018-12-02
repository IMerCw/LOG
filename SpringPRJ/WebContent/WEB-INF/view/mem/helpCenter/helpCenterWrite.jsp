<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
					<h2 class="panel-title">고객센터 게시글 작성</h2>
					<p class="panel-subtitle">
						문의하고 싶은 사항을 작성해 주시기 바랍니다. 규정에 위반되는 게시글은 삭제됩니다.
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
							<%@include file="/assets/summernote/summernote.jsp"%>
						</div>
					</div>
				</div>
				<footer class="panel-footer">
					<div class="row">
						<div class="col-sm-12" style="text-align:center;">
							<button type="button" class="btn btn-primary" onclick="callHelpCenterWriteProc();">작성하기</button>
							<button type="button" class="btn btn-default" onclick="callHelpCenterMain();">목록보기</button>
						</div>
					</div>
				</footer>
			</section>
		</form>
	</div>
</body>

<script>
	function callHelpCenterMain() {
		$.ajax({
			type : "POST",
			url : "/mem/helpCenter/helpCenterMain.do",
			dataType: "text",
			data : {currentPage : '1'},
			error: function() {
				alert("통신실패");
			},
			success: function(data) {
				$('.content-body').html(data);
			}
		})
	}
	function callHelpCenterWriteProc() {
		$.ajax({
			type : "POST",
			url : "/mem/helpCenter/helpCenterWriteProc.do",
			dataType: "text",
			data : {board_p_title: $('#board_p_title').val(), board_p_content: $('.note-editable').html() },
			error: function() {
				alert("통신실패");
			},
			success: function(data) {
				$('.content-body').html(data);
			}
		})
		
	}
	
	//서머노트 에디터 불러오기
	$('.summernote').summernote({
	    height : 350,
	   	onImageUpload : function(files, editor, welEditable) {
	    	console.log('start: onImageUpload');	
	        sendFile(files[0], editor, welEditable);
	    },
	    lang : 'ko-KR'
	});

	//이미지 업로드
	function sendFile(file, editor, welEditable) {
	    data = new FormData();
	    data.append("uploadFile", file);
	    $.ajax({
	        data : data,
	        type : "POST",
	        url : "/imageUpload.do",
	        cache : false,
	        contentType : false,
	        processData : false,
	        success : function(data) {
	        	console.log(data);
	            editor.insertImage(welEditable, data.imgPyName);
	        }
	    });

	}

</script>
	

</html>