<%@page import="poly.dto.UserMemberDTO"%>
<%@page import="poly.util.CmmUtil"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.BoardPostDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	List<BoardPostDTO> bpDTOs = (List<BoardPostDTO>)request.getAttribute("bpDTOs");
	UserMemberDTO uDTO = (UserMemberDTO) session.getAttribute("uDTO");
	int totalPages = (Integer) request.getAttribute("totalPages"); //전체 페이지 개수
	String currentPage = (String) request.getAttribute("currentPage"); //현재 페이지 번호
	int startPage = ((Integer.parseInt(currentPage) - 1) / 5 * 5  ) + 1; //블럭 시작 번호	
	int endPage = (startPage + 4) > totalPages ? totalPages : (startPage+4); // 블럭 끝 번호
	if(endPage > totalPages) endPage = totalPages; //마지막 블럭 끝 번호가 전체 페이지의 갯수를 넘어가면 전체 페이지 개수로 치환
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
	p {
		margin:0;
	}
	.boardContent:hover{
		background-color:#eeeeee;
	}
</style>
</head>
<body>
	<div class="container-fluid panel" style="background-color:#ffffff; color:black; padding:10px;">
			<!-- Board content -->
			<div class="boardContent"></div>
			<%if(!bpDTOs.isEmpty()) {%>
				<%for(int i = 0; i < bpDTOs.size(); i++) {%>
					<div class="boardContent" onclick="javscript:callHelpCenterRead(<%=bpDTOs.get(i).getBoard_p_seq()%>)">	
						<div class="row" style="">
							<div class="col-xs-12 contentSubject"><%=bpDTOs.get(i).getBoard_p_title() %></div>
						</div>
						<div class="row boardWritingInfo">
							<div class="col-xs-6 col-sm-6">상담날짜: <%=bpDTOs.get(i).getReg_date() %></div>
							
							<%if (bpDTOs.get(i).getReply_total() != null) { %>
								<div class="col-xs-6 col-sm-6"><p class="text-success">처리완료</p></div>
							<%} else {%>
								<div class="col-xs-6 col-sm-6"><p class="text-muted">처리 중</p></div>
							<%} %>
						</div>
					</div>
				<%} %>
				
				<%if(!"0".equals(uDTO.getUser_seq())) {%>
				<!-- BUTTON -->
				<div style="margin-top:32px;"> 
					<button type="button" class="mb-xs mt-xs mr-xs btn btn-primary" style="float:right;" onclick="javscript:callHelpCenterWrite()">
						<i class="fa fa-pencil">&nbsp;글쓰기</i>
					</button>
				</div>
				<%} %>
			<%-- 	<!-- start: PAGINATION -->
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
				<!-- end: PAGINATION --> --%>
				
				<!-- start: PAGINATION -->
				<div class="row">
					<div class="col-md-12" style="text-align:center; margin:10px 0;">
						<nav aria-label="...">
							<ul class="pagination">
								<!-- 이전 페이지 블럭 버튼 -->
								<%if(startPage != 1) {%>
						    	<li class="page-item">
						    		<span class="page-link" onclick="callHelpCenterMain(<%=startPage-1%>)">이전</span>
						    	</li>
						    	<%} %>
						    	
						    	
						    	<%for (int i = startPage; i <= endPage; i++ ) {%>
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
							    
							    <!-- 다음 페이지 블럭 버튼 -->
						       <%if(endPage != totalPages) {%>
						    	<li class="page-item">
						    		<span class="page-link" onclick="callHelpCenterMain(<%=endPage+1%>)">다음</span>
						    	</li>
							    <%} %>
						  	</ul>
						</nav>
					</div>
				</div>
				<!-- end: PAGINATION -->
				<%}else { %>
				
				
				<div class="row">
					<div class="col-md-12 col-xs-12" style="text-align:center; font-size:18px;">
						<section class="panel">
							<div class="panel-body">
								등록된 게시글이 없습니다.
							</div>
						</section>
					</div>
				</div>
				<!-- BUTTON -->
				<div style="margin-top:32px;"> 
					<button type="button" class="mb-xs mt-xs mr-xs btn btn-primary" style="float:right;" onclick="javscript:callHelpCenterWrite()">
						<i class="fa fa-pencil">&nbsp;글쓰기</i>
					</button>
				</div>
				<%} %>
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
				currentPage : <%=currentPage%>
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
		var url = '<%=("0").equals(uDTO.getUser_seq()) ?  "/admin/adminHelpCenterMain.do" : "/mem/helpCenter/helpCenterMain.do" %>'; 
		$.ajax({
			type : "GET",
			url : url,
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