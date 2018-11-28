<%@page import="java.util.List"%>
<%@page import="poly.dto.BoardReplyDTO"%>
<%@page import="poly.dto.UserMemberDTO"%>
<%@page import="poly.dto.BoardPostDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	BoardPostDTO bpDTO = (BoardPostDTO)request.getAttribute("bpDTO");
	UserMemberDTO uDTO = (UserMemberDTO) session.getAttribute("uDTO");
	String userSeq;
	boolean isAdmin = uDTO.getUser_id().equals("admin"); //관리자 권한 참 거짓
	
	String boardPContent = bpDTO.getBoard_p_content();
/*     boardPContent.replaceAll("& lt;","<").replaceAll("& gt;",">");
    boardPContent.replaceAll("& #40;", "\\(").replaceAll("& #41;","\\)");
    boardPContent.replaceAll("& #39;", "'");
    boardPContent.replaceAll("","eval\\((.*)\\)");
    boardPContent.replaceAll("\"\"", "[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']");
    boardPContent.replaceAll("","script"); */
	
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
	}
	.boardWritingInfo{
		text-align:right; padding-top: 8px;
	}
	.boardWritingInfo > div:first-child {
		text-align:left;
	}
</style>
</head>
<body>
	<div class="container-fluid" style="background-color:#ffffff; color:black; border-radius: 4px; padding-bottom: 8px;">
		<div class="row" style="margin-bottom:10px;">
			<div class="col-md-12"><h3><%=bpDTO.getBoard_p_title()%></h3></div>
		</div>
		<div class="row">
		
			<div class="col-md-4" style="text-align:left;"><img src="<%=bpDTO.getFile_py_name()%>" style="width:28px;" class="img-circle">&nbsp;<%=bpDTO.getUser_name() %></div> 
			
			<div class="col-md-8" style="text-align:right;">
				문의날짜:<%=bpDTO.getReg_date() %>
			<%if (bpDTO.getReply_total() != null) { %>
				<p class="text-success">상담 처리완료</p>
			<%} else {%>
				<p class="text-muted">상담 처리 중</p>
			<%} %>
			</div>
		</div>
			
		<div class="row" style="width: 100%; background-color: #cccccc; margin: 10px 0; height: 2px;"></div>

		<div class="row" style="min-height: 180px; padding-top: 6px;">
			<div class="col-md-12">	<%=bpDTO.getBoard_p_content().replaceAll("& lt;", "<").replaceAll("& gt;", ">") %></div>
		</div>		
		
		<div class="row" style="padding:12px;"> 
		<%if(uDTO.getUser_seq().equals(bpDTO.getUser_seq())) {%>
			<button type="button" class="mb-xs mt-xs mr-xs btn btn-default" style="float:left; display: inline-block;" onclick="callHelpCenterMain();">목록보기</button>
			<button type="button" class="mb-xs mt-xs mr-xs btn btn-primary" style="float:right; display: inline-block;" onclick="callHelpCenterUpdate()">수정하기</button>
			<button type="button" class="mb-xs mt-xs mr-xs btn btn-danger" style="float:right; display: inline-block;" onclick="callHelpCenterDelete()">삭제하기</button>
		<%}else if (isAdmin) {%>
			<button type="button" class="mb-xs mt-xs mr-xs btn btn-default" style="float:left; display: inline-block;" onclick="callHelpCenterMain();">목록보기</button>
			<button type="button" class="mb-xs mt-xs mr-xs btn btn-danger" style="float:right; display: inline-block;" onclick="callHelpCenterDelete()">삭제하기</button>
		<%} %>
		</div>
		
		<!-- 댓글 출력 -->
		<div class="container-fluid" id="boardReplyContainer" style="padding:0;">
		<%-- 		
		<%for(int i = 0; i < brDTO.size(); i++) { %>
			
		<%} %> 
		--%>
		</div>
		<!-- 댓글 작성 입력 폼 -->
		<%if (isAdmin) {%>
			<div class="row">
				<div class="form-group">
					<div class="col-md-12">
						<textarea class="form-control" id="boardReply" rows="3" id="textareaAutosize" data-plugin-textarea-autosize="" placeholder="댓글을 작성해주세요." 
							style="width:100%; overflow: hidden; overflow-wrap: break-word; resize: none; height: 74px;"></textarea>
					</div>
				</div>
			</div>
			<div> 
				<button type="button" class="mb-xs mt-xs mr-xs btn btn-primary" style="float:right; display: inline-block;" onclick="callBoardReplyWriteProc();">답변 작성</button>
			</div>
		<%} %>
	</div>
</body>
<script>

	//게시글 목록
	function callHelpCenterMain() {
		var url = '<%=("0").equals(uDTO.getUser_seq()) ?  "/admin/adminHelpCenterMain.do" : "/mem/helpCenter/helpCenterMain.do" %>';
		$.ajax({
			type : "POST",
			url : url,
			dataType: "text",
			data:{currentPage: '${currentPage}' },
			error: function() {
				alert("통신실패");
			},
			success: function(data) {
				$('.content-body').html(data);
			}
		})
	}
	
	//게시글 수정
	function callHelpCenterUpdate() {
		$.ajax({
			type : "POST",
			url : "/mem/helpCenter/helpCenterUpdate.do",
			dataType: "text",
			data:{
				board_p_seq: '<%=bpDTO.getBoard_p_seq()%>', 
				board_p_title: '<%=bpDTO.getBoard_p_title()%>', 
				board_p_content: '<%=bpDTO.getBoard_p_content()%>',
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
	
	//게시글 삭제
	function callHelpCenterDelete() {
		$.ajax({
			type : "POST",
			url : "/mem/helpCenter/helpCenterDelete.do",
			dataType: "text",
			data : {board_p_seq : '<%=bpDTO.getBoard_p_seq()%>'},
			error: function() {
				alert("통신실패");
			},
			success: function(data) {
				callHelpCenterMain();
			}
		})
	}
	
	/*----------------------------------------*/
	//댓글 불러오기
	function callBoardRepliesPage() {
		var contents = '';
		$.ajax({
			type : "POST",
			url : "/mem/community/getBoardRepliesPage.do",
			dataType: "text",
			data : {
				board_p_seq : '<%=bpDTO.getBoard_p_seq()%>'
			},
			error: function() {
				alert("통신실패");
			},
			success: function(data) {
				$('#boardReplyContainer').html(data);
			}
		});
	};

	//댓글 목록 불러오기 실행
	callBoardRepliesPage();
	
	//댓글 작성
	function callBoardReplyWriteProc(){
		$.ajax({
			type : "POST",
			url : "/mem/community/boardReplyWriteProc.do",
			dataType: "text",
			data : {
				board_p_seq : '<%=bpDTO.getBoard_p_seq()%>',
				reply_content : $('#boardReply').val(),
				user_seq : '<%=uDTO.getUser_seq()%>'
			},
			error: function() {
				alert("통신실패");
			},
			success: function(data) {
				$('#boardReply').val(function(){return ''}); //작성한 내용 지우기				
				callBoardRepliesPage(); //댓글 목록 불러오기	
			}
		})
	}
	
	//댓글 수정 화면 전환
	function callBoardReplyUpdate(replySeq){
		var updateContents = '';
		updateContents += '<div class="form-group">';
		updateContents += '<div class="col-md-12">'; 
		updateContents += '<textarea class="form-control" rows="3" id="replyContentUpdate" data-plugin-textarea-autosize=""'; 
		updateContents += 'style="width:100%; overflow: hidden; overflow-wrap: break-word; resize: none; height: 74px;">';
		updateContents += $('#replyContent'+replySeq).html();
		updateContents += '</textarea>';
		updateContents += '<div style="text-align:right;">';
		updateContents += '<a href="javascript:callBoardRepliesPage()">취소</a> / <a href="javascript:callBoardReplyUpdateProc(' + replySeq + ')">수정</a></div>';
		updateContents += '</div>';
		updateContents += '</div></div>';
		
		$('#'+replySeq).html(function(){return updateContents});
		
	}
	
	//댓글 수정 처리 Procedure
	function callBoardReplyUpdateProc(replySeq){
		var r = confirm("수정하시겠습니까?");
		if (r) {
			$.ajax({
				type : "POST",
				url : "/mem/community/boardReplyUpdateProc.do",
				dataType: "json",
				data : {
					reply_seq : replySeq,
					reply_content : $('#replyContentUpdate').val(),
					user_seq : '<%=uDTO.getUser_seq()%>'
				},
				error: function() {
					alert("통신실패");
				},
				success: function(data) {
					//댓글 목록 불러오기
					callBoardRepliesPage();
				}
			})
		}
	}
	
	//댓글 삭제
	function callBoardReplyDelete(replySeq){
		var r = confirm("정말로 삭제하시겠습니까?");
		if(r) {
			$.ajax({
				type : "POST",
				url : "/mem/community/boardReplyDelete.do",
				dataType: "text",
				data : {
					reply_seq : replySeq
				},
				error: function() {
					alert("통신실패");
				},
				success: function(data) {
					console.log(data);
					//댓글 목록 불러오기 , 새로고침
					callBoardRepliesPage();
				}
			})
		}
	}
</script>
</html>