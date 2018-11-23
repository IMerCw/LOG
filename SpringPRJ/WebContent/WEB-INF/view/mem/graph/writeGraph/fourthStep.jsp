<%@page import="poly.dto.UserMemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String graphSelect = (String) request.getParameter("graphSelect"); //그래프 종류
	UserMemberDTO uDTO = (UserMemberDTO)session.getAttribute("uDTO"); //유저정보
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


	<!-- Load c3.css -->
	<link href="/assets/c3Chart/c3.css" rel="stylesheet">
	<!-- Load d3.js and c3.js -->
	<script src="/assets/d3/d3.v5.js"></script>
	<script src="/assets/c3Chart/c3.js"></script>
	<style>
	.btn-group {
		margin: 0 -4px;
	}
	</style>
</head>
<body>

	<div class="panel-body">
		<%if(graphSelect.equals("lineChart")){ %>
		<%@include file="/WEB-INF/view/mem/graph/writeGraph/graphSources/lineChart.jsp"%>
		<%} else if (graphSelect.equals("barChart")) {%>
		<%@include file="/WEB-INF/view/mem/graph/writeGraph/graphSources/barChart.jsp"%>
		<%} else if (graphSelect.equals("pieChart")) {%>
		<%@include file="/WEB-INF/view/mem/graph/writeGraph/graphSources/pieChart.jsp"%>
		<%} else if (graphSelect.equals("scatterChart")) {%>
		<%@include file="/WEB-INF/view/mem/graph/writeGraph/graphSources/scatterChart.jsp"%>
		<%} else if (graphSelect.equals("areaChart")) {%>
		<%@include file="/WEB-INF/view/mem/graph/writeGraph/graphSources/areaChart.jsp"%>
		<%}%>
	</div>

	<h3>게시글 작성</h3>
	<input class="form-control input-lg mb-md" type="text" id="graph_title" placeholder="글 제목">
	<%@include file="/assets/summernote/summernote.jsp"%>
    <div class="form-group">
		<label class="col-sm-12 control-label">해시태그<span class="required"></span></label>
		<div class="col-sm-12">
			<input type="text" id="graph_hashtag" name="graph_hashtag" class="form-control" placeholder="글 제목을 작성해주세요." value="#그래프" required>
		</div>
	</div>

    <div class="row">
		<button type="button" onclick="completeWriteGraph()" class="btn btn-primary" id="submit" style="width: 100%;  margin: 20px 0; font-size: 18px;">작성 완료</button>
	</div>
	
</body>



<script>



// 4번째 단계 - 그래프 선택 완료
function completeWriteGraph() {
	$.ajax({
		type : "POST",
		url : "/mem/graph/writeGraph/completeWriteGraph.do",
		dataType: "text",
		data : {
			graph_type: '<%=graphSelect%>',
			user_seq: '<%=uDTO.getUser_seq()%>',
			graph_title: $('#graph_title').val(),
			graph_content: $('.note-editable').html(),
			graph_hashtag: $('#graph_hashtag').val(),
			result_data: JSON.stringify(resultData),
			result_cate: resultCategory.toString(),
			result_x: resultXItem.toString()
		},
		error: function() {
			alert("통신실패");
		},
		success: function(data) {
			$('.content-body').html(data);
		}
	})
}
	
      
      
</script>
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
	<script src="/assets/javascripts/theme.init.js"></script>
	<script src="/assets/javascripts/forms/examples.advanced.form.js" /></script>
	
</html>