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
	
	<!-- ckeditor -->
	<script src="/assets/ckeditor/ckeditor.js"></script>
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
    <div class="row">
		<button type="button" class="btn btn-primary" id="submit" style="width: 100%;  margin: 20px 0; font-size: 18px;">작성 완료</button>
	</div>
</body>



<script>
/* ckEditor */
let editor;

ClassicEditor
    .create( document.querySelector( '#graph_content' ) )
    .then( newEditor => {
        editor = newEditor;
    } )
    .catch( error => {
        console.error( error );
    } );

// Assuming there is a <button id="submit">Submit</button> in your application.
document.querySelector( '#submit' ).addEventListener( 'click', () => {
    const editorData = editor.getData();
    
    completeWriteGraph(editorData);
    // ...
} );
////////////////

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
			graph_content: editorData,
			graph_hashtag: 'test',
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