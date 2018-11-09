<%@page import="poly.util.CmmUtil"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.BoardPostDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	List<BoardPostDTO> bpDTOs = (List<BoardPostDTO>)request.getAttribute("bpDTOs");
	int totalPages = (Integer) request.getAttribute("totalPages");
	String currentPage = (String) request.getAttribute("currentPage");
%>
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
	    cursor:pointer;
	}
	.boardWritingInfo{
		text-align:right; padding-top: 8px;
	}
	.boardWritingInfo > div:first-child {
		text-align:left;
	}
	.boardWritingInfo > div:last-child {
		text-align:right;
	}
	.pagination >li {
		cursor:pointer;
	}
</style>
</head>
<body>
	<div class="container-fluid panel" style="background-color:#ffffff; color:black; padding:10px;">
			<!-- Board content -->
			<div class="boardContent"></div>
			
			<%for(int i = 0; i < bpDTOs.size(); i++) {%>
				<div class="boardContent" onclick="javscript:callHelpCenterRead(<%=bpDTOs.get(i).getBoard_p_seq()%>)">	
					<div class="row" style="">
						<div class="col-xs-12 contentSubject"><%=bpDTOs.get(i).getBoard_p_title() %></div>
					</div>
					<div class="row boardWritingInfo">
						<div class="col-xs-6 col-sm-6"><%=bpDTOs.get(i).getUser_name() %> / <%=bpDTOs.get(i).getReg_date() %></div>
						<div class="col-xs-6 col-sm-6">조회수 <%=bpDTOs.get(i).getBoard_count() %></div>
					</div>
				</div>
			<%} %>
			
			<!-- BUTTON -->
			<div style="margin-top:32px;"> 
				<button type="button" class="mb-xs mt-xs mr-xs btn btn-primary" style="float:right;" onclick="javscript:callHelpCenterWrite()">
					<i class="fa fa-pencil">&nbsp;글쓰기</i>
				</button>
			</div>
			
			<!-- start: PAGINATION -->
			<div class="row">
				<div class="col-md-12" style="text-align:center; margin:10px 0;">
					<nav aria-label="...">
						<ul class="pagination">
					    	<li class="page-item disabled">
					    		<span class="page-link">이전</span>
					    	</li>
					    	<%for(int i = 1; i <= totalPages; i++) {%>
				    			<%if (i == Integer.parseInt(currentPage)) {%>
					    			<li class="page-item active">
									  <span class="page-link">
									    <%=i %>
									    <span class="sr-only">(current)</span>
									  </span>
									</li>
				    			<%} else { %>
					    			<li class="page-item"><a class="page-link" onclick="callHelpCenterMain(<%=i%>)"><%=i%></a></li>
				    			<%} %>
						    <%} %>
					    	<li class="page-item">
					      	<a class="page-link" href="#">다음</a>
					    	</li>
					  	</ul>
					</nav>
				</div>
			</div>
			<!-- end: PAGINATION -->
		</div>
</body>
<script>

	//글 보기 상세
	function callHelpCenterRead(board_p_seq) {
		$.ajax({
			type : "GET",
			url : "/mem/helpCenter/helpCenterRead.do",
			dataType: "text",
			data: {
				board_p_seq : board_p_seq,
				currentPage : <%=currentPage%>,
			},
			error: function() {
				alert("통신실패");
			},
			success: function(data) {
				$('.content-body').html(data);
			}
		})
	}
	
	//글쓰기
	function callHelpCenterWrite() {
		$.ajax({
			type : "GET",
			url : "/mem/helpCenter/helpCenterWrite.do",
			dataType: "text",
			error: function() {
				alert("통신실패");
			},
			success: function(data) {
				$('.content-body').html(data);
			}
		})
	}
	
	//페이지 이동
	function callHelpCenterMain(pageNum) {
		$.ajax({
			type : "GET",
			url : "/mem/helpCenter/helpCenterMain.do",
			data: {currentPage: pageNum},
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