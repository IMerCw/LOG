<%@page import="poly.dto.GraphDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	GraphDTO gDTO = (GraphDTO) request.getAttribute("gDTO");
	Float starRate;
%>
<html>
<head>
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


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- ckeditor -->

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
	.boardWritingInfo > div:first-child {
		text-align:left;
	}
	.img-circle {
		width:20px; max-height: 28px;
	}
	.btn-group {
		margin: 0 -4px;
	}
</style>
</head>
<body>

	
		<%-- 그래프 출력 --%>
		<%------------------%>
		
		<form id="form" class="form-horizontal">
			<header class="panel-heading">
				<h2 class="panel-title">그래프 게시글 수정</h2>
				<p class="panel-subtitle">
					그래프 게시글을 수정하세요. 규정에 위반되는 게시글은 삭제됩니다.
				</p>
			</header>
			<div class="panel-body">
				<div class="form-group">
					<label class="col-sm-12 control-label">글 제목 <span class="required"></span></label>
					<div class="col-sm-12">
						<input type="text" id="graph_title" name="graph_title" class="form-control" placeholder="글 제목을 작성해주세요." value="<%=gDTO.getGraph_title()%>" required>
					</div>
				</div>
				<%@include file="/assets/summernote/summernote.jsp"%>
				<div class="form-group">
					<label class="col-sm-12 control-label">해시태그<span class="required"></span></label>
					<div class="col-sm-12">
						<input type="text" id="graph_hashtag" name="graph_hashtag" class="form-control" placeholder="해쉬태그작성" value="<%=gDTO.getGraph_hashtag()%>" required>
					</div>
				</div>
			</div>
			<footer class="panel-footer">
				<div class="row">
					<div class="col-sm-6" style="text-align:left;">
						<button type="button" class="btn btn-default" onclick="callPage('graphGallery');">목록보기</button>
					</div>
					<div class="col-sm-6" style="text-align:right;">
						<button type="button" class="btn btn-primary" onclick="callGraphUpdateProc();">수정완료</button>
						<button type="button" class="btn btn-default" onclick="callGraphDetail();">취소하기</button>
					</div>
				</div>
			</footer>
		</form>
</body>

<script>

//이전 게시물의 내용 불러오기
$('.note-editable').html('<%=gDTO.getGraph_content().replaceAll("& lt;", "<").replaceAll("& gt;", ">")%>');

/*-------------게시글-------------*/
//게시글 목록
function callGraphMain() {
	$.ajax({
		type : "POST",
		url : "/mem/graph/graphMain.do",
		dataType: "text",
		error: function() {
			alert("통신실패");
		},
		success: function(data) {
			$('.content-body').html(data);
		}
	})
}

//게시글 수정완료
function callGraphUpdateProc() {
	var graph_content = $('.note-editable').html();
	if(graph_content) return false;
	
	$.ajax({
		type : "POST",
		url : "/mem/graph/updateGraphProc.do",
		dataType: "text",
		data:{
			graph_seq: '<%=gDTO.getGraph_seq()%>', 
			graph_title: $('#graph_title').val(), 
			graph_content: graph_content,
			graph_hashtag: $('#graph_hashtag').val()
		},
		error: function() {
			alert("통신실패");
		},
		success: function(data) {
			$('.content-body').html(data);
		}
	})
}	

//그래프 게시글 상세보기
function callGraphDetail() {
	$.ajax({
		type : "POST",
		url : "/mem/graph/readGraph.do",
		dataType: "text",
		data : {
			graph_seq: '<%=gDTO.getGraph_seq()%>'
		},
		error: function() {
			alert("통신실패");
		},
		success: function(data) {
			$('.content-body').html(data);
		}
	})
	
}

//////////////

</script>

</html>