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
		<div class="row">
			<div class="col-md-12"><h3><%=bpDTO.getBoard_p_title()%></h3></div>
		</div>
		<div class="row">
			<div class="col-md-12" style="text-align:right;">문의날짜:<%=bpDTO.getReg_date() %> / <span id="reply_date" class="text-muted">상담 처리 중</span></div>
		</div>
		
		<div class="row" style="width: 100%; background-color: #cccccc; margin: 10px 0; height: 2px;"></div>

		<div class="row" style="min-height: 180px; padding-top: 6px;">
			<div class="col-md-12"><%=bpDTO.getBoard_p_content() %></div>
		</div>		
		
		<%if(uDTO.getUser_seq().equals(bpDTO.getUser_seq())) {%>
			<div class="row" style="padding:12px;"> 
				<button type="button" class="mb-xs mt-xs mr-xs btn btn-default" style="float:left; display: inline-block;" onclick="callHelpCenterMain();">목록보기</button>
				<button type="button" class="mb-xs mt-xs mr-xs btn btn-primary" style="float:right; display: inline-block;" onclick="callHelpCenterUpdate()">수정하기</button>
				<button type="button" class="mb-xs mt-xs mr-xs btn btn-danger" style="float:right; display: inline-block;" onclick="callHelpCenterDelete()">삭제하기</button>
			</div>
		<%}%>
		
		<!-- 댓글 출력 -->
		<div class="container-fluid" id="boardReplyContainer" style="padding:0;">
		<%-- 		
		<%for(int i = 0; i < brDTO.size(); i++) { %>
			
		<%} %> 
		--%>
		</div>
		<!-- 댓글 작성 입력 폼 -->
		<%if (uDTO.getUser_seq().equals("0")) {%>
			<div class="row">
				<div class="form-group">
					<div class="col-md-12">
						<textarea class="form-control" id="boardReply" rows="3" id="textareaAutosize" data-plugin-textarea-autosize="" placeholder="댓글을 작성해주세요." 
							style="width:100%; overflow: hidden; overflow-wrap: break-word; resize: none; height: 74px;"></textarea>
					</div>
				</div>
			</div>
			<div> 
				<button type="button" class="mb-xs mt-xs mr-xs btn btn-primary" style="float:right; display: inline-block;" onclick="callBoardReplyWriteProc();">댓글작성</button>
			</div>
		<%} %>
	</div>
</body>
<script>

	//게시글 목록
	function callHelpCenterMain() {
		$.ajax({
			type : "POST",
			url : "/mem/helpCenter/helpCenterMain.do",
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
				$('.content-body').html(data);
			}
		})
	}
	
	/*----------------------------------------*/
	//댓글 불러오기
	function callBoardReplies() {
		var contents = '';
		$.ajax({
			type : "POST",
			url : "/mem/community/getBoardReplies.do",
			dataType: "text",
			data : {
				board_p_seq : '<%=bpDTO.getBoard_p_seq()%>'
			},
			error: function() {
				alert("통신실패");
			},
			success: function(data) {
				
				$('#reply_date').html('처리 날짜 : ' + $.parseJSON(data)[0].reg_date );
				$('#reply_date').removeClass('text-muted');				
				$('#reply_date').addClass('text-success');				
				
				$.each($.parseJSON(data), function(key,value) {
					contents += '<div class="row" id="'+ value.reply_seq +'" style="padding: 4px; border-radius: 2px; background-color: #cccccc; margin:10px 0; border: 1px solid #bbbbbb;">';
					contents += '<div style="min-height: 64px; padding: 4px;" id="replyContent'+ value.reply_seq +'">'+ value.reply_content+'</div>';
					contents += '<div class="col-md-6" style="text-align:left;">' + '이모티콘 ' + ' / ' +  value.user_name + ' / ' +  value.reg_date + '</div>';
					contents += '<div class="col-md-6" style="text-align:right">';
					
					<%-- 현재유저와 작성자 일치 확인 --%>
					if(value.user_seq == '<%=uDTO.getUser_seq()%>') {
						contents += '<img src="/assets/images/edit.svg" style="height:18px; margin: 0 8px; cursor:pointer;" onclick="callBoardReplyUpdate(' + value.reply_seq + ')" />';
						contents += '<img src="/assets/images/garbage.svg" style="height:18px; cursor:pointer;" onclick="callBoardReplyDelete(' + value.reply_seq + ')" />';
					}
					contents += '</div>';
					contents += '</div>';
					contents += '</div>';
				})
				/* value.reply_seq */
				$('#boardReplyContainer').html(contents);
			}
		})
	}
	
	//댓글 목록 불러오기
	callBoardReplies();
	
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
				callBoardReplies(); //댓글 목록 불러오기	
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
		updateContents += '<a href="javascript:callBoardReplies()">취소</a> / <a href="javascript:callBoardReplyUpdateProc(' + replySeq + ')">수정</a></div>';
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
					callBoardReplies();
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
					callBoardReplies();
				}
			})
		}
	}
</script>
</html>