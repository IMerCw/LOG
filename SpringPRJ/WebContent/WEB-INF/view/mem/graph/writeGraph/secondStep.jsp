<%@page import="java.util.List"%>
<%@page import="poly.dto.PublicDataDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	//공공데이터 가져오기
	PublicDataDTO pdDTO = (PublicDataDTO) request.getAttribute("pdDTO");
	//csv list
	List<List<String>> csvResult = (List<List<String>>) request.getAttribute("csvResult");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
		<a href="javascript:callWriteeGraphThirdStep()">세 번째 이동</a>
		
		<!-- Header 목록 -->
		<div>
			<% for ( String item : csvResult.get(0)) {%>
			
					<h3><%=item%></h3>
					
			<%}%>
		</div>
		<div class="container-fluid">
			<div id="example">
			
			</div>
		</div>
	</div>
</body>
<script>
	// 1번째 단계 - 데이터 선택 이동
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
	

	// 3번째 단계 - 그래프 선택 이동
	function callWriteeGraphThirdStep() {
		$.ajax({
			type :"POST",
			url : "/mem/graph/writeGraph/thirdStep.do",
			dataType : "text",
			error: function() {
				alert("통신 실패");
			},
			success: function(data) {
				$('#w4-billing').html(data);
				$('.next').click();
			}
		});
	}
	

</script>

</html>