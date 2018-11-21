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
	<!-- Load c3.css -->
	<link href="/assets/c3Chart/c3.css" rel="stylesheet">
	<!-- Load d3.js and c3.js -->
	<script src="/assets/d3/d3.v5.js"></script>
	<script src="/assets/c3Chart/c3.js"></script>
	
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

	<h1>게시글 작성</h1>
	<input class="form-control input-lg mb-md" type="text" id="graph_title" placeholder="글 제목">
	
	<textarea name="content" id="graph_content" width="420px">
	
        	게시글 내용을 작성해주세요.
    </textarea>
    <div class="form-group">
		<label class="col-sm-12 control-label">해시태그<span class="required"></span></label>
		<div class="col-sm-12">
			<input type="text" id="graph_hashtag" name="graph_hashtag" class="form-control" placeholder="글 제목을 작성해주세요." value="#그래프" required>
		</div>
	</div>

    <div class="row">
		<button type="button" class="btn btn-primary" id="submit" style="width: 100%;  margin: 20px 0; font-size: 18px;">작성 완료</button>
	</div>
	
</body>



<script>



// 1번째 단계 - 그래프 선택 완료
function completeWriteGraph(editorData) {
	$.ajax({
		type : "POST",
		url : "/mem/graph/writeGraph/completeWriteGraph.do",
		dataType: "text",
		data : {
			graph_type: '<%=graphSelect%>',
			user_seq: '<%=uDTO.getUser_seq()%>',
			graph_title: $('#graph_title').val(),
			graph_content: $('#graph_content').val(),
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
</html>