<%@page import="java.util.List"%>
<%@page import="poly.util.CmmUtil"%>
<%@page import="poly.dto.UserMemberDTO"%>
<%@page import="poly.dto.BoardPostDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	List<BoardPostDTO> bpDTOs = (List<BoardPostDTO>)request.getAttribute("bpDTOs");
	UserMemberDTO uDTO = (UserMemberDTO) session.getAttribute("uDTO");
	int totalPages = (Integer) request.getAttribute("totalPages"); //전체 페이지 갯수
	String currentPage = (String) request.getAttribute("currentPage"); //현재 페이지 번호
	int startPage = ((Integer.parseInt(currentPage) - 1) / 5 * 5  ) + 1; //블럭 시작 번호	
	int endPage = (startPage + 4) > totalPages ? totalPages : (startPage+4); // 블럭 끝 번호
	int reply_total;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	//제목 설정
	$('#pageName').html('커뮤니티');
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
	.img-circle{
	    width: 25px;
	}
</style>
</head>
<body>
	<div class="container-fluid panel" style="background-color:#ffffff; color:black; padding:10px;">
			<!-- Board content -->
			<div class="boardContent"></div>
			
			<%for(int i = 0; i < bpDTOs.size(); i++) {%>
				<div class="boardContent" onclick="javscript:callCommunityRead(<%=bpDTOs.get(i).getBoard_p_seq()%>)">	
					<div class="row" style="">
						
						<div class="col-xs-6 contentSubject" style="text-align:left;"><%=bpDTOs.get(i).getBoard_p_title() %></div>
						<%reply_total = ( (bpDTOs.get(i).getReply_total()) != null ? Integer.parseInt(bpDTOs.get(i).getReply_total()) : 0 ); %>
						<div class="col-xs-6" style="text-align:right; font-size:16px;"><i class="fa fa-comments-o">&nbsp;<%=reply_total%></i></div>
					</div>
					<div class="row boardWritingInfo">
						<div class="col-xs-6 col-sm-6">
						
							<img src="/<%=bpDTOs.get(i).getFile_py_name()%>" alt="Joseph Doe" class="img-circle" 
								data-lock-picture="/assets/images/!logged-user.jpg" />
							<%=bpDTOs.get(i).getUser_name() %> / <%=bpDTOs.get(i).getReg_date() %>
						</div>
						<div class="col-xs-6 col-sm-6">조회수 <%=bpDTOs.get(i).getBoard_count() %></div>
					</div>
				</div>
			<%} %>
			
			<!-- BUTTON -->
			<div style="margin-top:32px;"> 
				<button type="button" class="mb-xs mt-xs mr-xs btn btn-primary" style="float:right;" onclick="javscript:callCommunityWrite()">
					<i class="fa fa-pencil">&nbsp;글쓰기</i>
				</button>
			</div>
			
			<!-- start: PAGINATION -->
			<div class="row">
				<div class="col-md-12" style="text-align:center; margin:10px 0;">
					<nav aria-label="...">
						<ul class="pagination">
							<%if(startPage != 1) {%>
					    	<li class="page-item">
					    		<span class="page-link" onclick="callCommunityMain(<%=startPage-1%>)">이전</span>
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
					    			<li class="page-item"><a class="page-link" onclick="callCommunityMain(<%=i%>)"><%=i%></a></li>
				    			<%} %>
						    <%} %>
						    
						    <%if(endPage != totalPages) {%>
						    	<li class="page-item">
						    		<span class="page-link" onclick="callCommunityMain(<%=endPage+1%>)">다음</span>
						    	</li>
						    <%} %>
					  	</ul>
					</nav>
				</div>
			</div>
			<!-- end: PAGINATION -->
		</div>
</body>
<script>

	//글 보기 상세
	function callCommunityRead(board_p_seq) {
		$.ajax({
			type : "GET",
			url : "/mem/community/communityRead.do",
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
	function callCommunityWrite() {
		$.ajax({
			type : "GET",
			url : "/mem/community/communityWrite.do",
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
	function callCommunityMain(pageNum) {
		$.ajax({
			type : "GET",
			url : "/mem/community/communityMain.do",
			dataType: "text",
			data:{currentPage: pageNum},
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