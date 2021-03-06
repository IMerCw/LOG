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
	$('#pageName').html('커뮤니티');
</script>
	
	<!-- Specific Page Vendor CSS -->
	<link rel="stylesheet" href="/assets/vendor/pnotify/pnotify.custom.css" />

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
</style>
</head>
<body>
	<div class="container-fluid" style="background-color:#ffffff; color:black; border-radius: 4px; padding-bottom: 8px;">
		<div class="row"  style="margin-bottom:10px;">
			<div class="col-md-12"><h3><%=bpDTO.getBoard_p_title()%></h3></div>
		</div>
		<div class="row">
			<div class="col-md-6" style="text-align:left;"><img src="<%=bpDTO.getFile_py_name()%>" class="img-circle" style="width:28px;"> &nbsp; <%=bpDTO.getUser_name() %></div>
			<div class="col-md-6" style="text-align:right;">조회수:<%=bpDTO.getBoard_count() %> / <%=bpDTO.getReg_date() %></div>
		</div>
		
		<div class="row" style="width: 100%; background-color: #cccccc; margin: 10px 0; height: 2px;"></div>

		<div class="row" style="min-height: 180px; padding-top: 6px;">
			<div class="col-md-12">
				<%=bpDTO.getBoard_p_content().replaceAll("& lt;", "<").replaceAll("& gt;", ">") %>
			</div>
		</div>		
		
		<%if(uDTO.getUser_seq().equals(bpDTO.getUser_seq()) || "0".equals(uDTO.getUser_seq()) )  {%>
			<div class="row" style="padding:12px;"> 
				<button type="button" class="mb-xs mt-xs mr-xs btn btn-primary" style="float:right; display: inline-block;" onclick="callCommunityUpdate()">수정하기</button>
				<button type="button" class="mb-xs mt-xs mr-xs btn btn-danger" style="float:right; display: inline-block;" onclick="callCommunityDelete()">삭제하기</button>
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
		<div class="row">
			<div class="form-group">
				<div class="col-md-12">
					<textarea class="form-control" id="boardReply" rows="3" id="textareaAutosize" data-plugin-textarea-autosize="" placeholder="댓글을 작성해주세요." 
						style="width:100%; overflow: hidden; overflow-wrap: break-word; resize: none; height: 74px;"></textarea>
				</div>
			</div>
		</div>
		<div> 
			<button type="button" class="mb-xs mt-xs mr-xs btn btn-default" style="float:left; display: inline-block;" onclick="callCommunityMain();">목록보기</button>
			<button type="button" class="mb-xs mt-xs mr-xs btn btn-primary" style="float:right; display: inline-block;" onclick="callBoardReplyWriteProc();">댓글작성</button>
		</div>
		
	</div>
</body>
<script>

	//게시글 목록
	function callCommunityMain() {
		$.ajax({
			type : "POST",
			url : "/mem/community/communityMain.do",
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
	function callCommunityUpdate() {
		$.ajax({
			type : "POST",
			url : "/mem/community/communityUpdate.do",
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
	function callCommunityDelete() {
		$.ajax({
			type : "POST",
			url : "/mem/community/communityDelete.do",
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

	//댓글 목록 불러오기
	callBoardRepliesPage();
	<%-- 
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
				$.each($.parseJSON(data), function(key,value) {
					contents += '<div class="row" id="'+ value.reply_seq +'" style="padding: 4px; border-radius: 2px; background-color: #cccccc; margin:10px 0; border: 1px solid #bbbbbb;">';
					contents += '<div style="min-height: 64px; padding: 4px;" id="replyContent'+ value.reply_seq +'">'+ value.reply_content+'</div>';
					contents += '<div class="col-md-6" style="text-align:left;">'
					contents += '<img src="' + value.file_py_name + '"alt="Joseph Doe" class="img-circle" data-lock-picture="/assets/images/!logged-user.jpg" />';
					contents += ' / ' +  value.user_name + ' / ' +  value.reg_date + '</div>';
					contents += '<div class="col-md-6" style="text-align:right">';
					
					현재유저와 작성자 일치 확인
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
	} --%>
	
	//댓글 작성
	function callBoardReplyWriteProc(){
		if($('#boardReply').val() == '') {
			displayErrorNotice();
			return null;
		}
		
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
				displaySuccessNotice();
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
		if( $('#replyContentUpdate').val() == '') {
			displayErrorNotice();
			return false;
		}
		
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
				displaySuccessNotice();
			}
		})
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
					displayDeleteNotice();
				}
			})
		}
	}
	/*---------------------모달---------------------*/
	<%-- 모달 --%>
	function displaySuccessNotice() {
		new PNotify({
			title: '댓글 쓰기 성공',
			text: '댓글 쓰기가 완료되었습니다.',
			type: 'success',
			shadow: true
		});
	}
	function displayErrorNotice() {
		new PNotify({
			title: '댓글 쓰기 실패',
			text: '댓글을 작성해주세요.',
			type: 'error',
			shadow: true
		});
	}
	function displayDeleteNotice() {
		new PNotify({
			title: '댓글 삭제 완료',
			text: '댓글을 정상적으로 삭제하였습니다.',
			shadow: true
		});
	}
</script>
	<!-- Vendor -->
	<script src="/assets/vendor/jquery/jquery.js"></script>
	<script src="/assets/vendor/jquery-browser-mobile/jquery.browser.mobile.js"></script>
	<script src="/assets/vendor/bootstrap/js/bootstrap.js"></script>
	<script src="/assets/vendor/nanoscroller/nanoscroller.js"></script>
	<script src="/assets/vendor/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
	<script src="/assets/vendor/magnific-popup/magnific-popup.js"></script>
	<script src="/assets/vendor/jquery-placeholder/jquery.placeholder.js"></script>
	
	<!-- Specific Page Vendor -->
	<script src="/assets/vendor/pnotify/pnotify.custom.js"></script>
	
	<!-- Theme Base, Components and Settings -->
	<script src="/assets/javascripts/theme.js"></script>
	
	<!-- Theme Custom -->
	<script src="/assets/javascripts/theme.custom.js"></script>
	
	<!-- Theme Initialization Files -->
	<script src="/assets/javascripts/theme.init.js"></script>

	<!-- Examples -->
	<script src="/assets/javascripts/ui-elements/examples.notifications.js"></script>

</html>