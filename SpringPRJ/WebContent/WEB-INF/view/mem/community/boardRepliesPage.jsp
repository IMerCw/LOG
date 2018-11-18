<%@page import="poly.dto.UserMemberDTO"%>
<%@page import="poly.dto.BoardReplyDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	List<BoardReplyDTO> brDTOs = (List<BoardReplyDTO>)(request.getAttribute("brDTO"));
	UserMemberDTO uDTO = (UserMemberDTO) session.getAttribute("uDTO");
	String userSeq;
	boolean isAdmin = uDTO.getUser_id().equals("admin"); //관리자 권한 참 거짓
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
	.reply_container:hover {
		background-color:#eeeeee;
	}
</style>
</head>
<body>
	<%for(BoardReplyDTO brDTO : brDTOs) {%>
		<div class="row reply_container" id="<%=brDTO.getReply_seq()%>" style="padding: 4px; border-radius: 2px; background-color: #cccccc; margin:10px 0; border: 1px solid #bbbbbb;">
		
			<div style="min-height: 64px; padding: 6px 14px;" id="replyContent<%=brDTO.getReply_seq()%>"><%=brDTO.getReply_content() %></div>								
			
			<div class="col-md-6" style="text-align:left;">
				<img src="<%=brDTO.getFile_py_name() %>" alt="이모티콘" class="img-circle"/>
				/ 
				<%=brDTO.getUser_name() %>
				/  
				<%=brDTO.getReg_date() %> 
			</div>
			
			<div class="col-md-6" style="text-align:right">
				<%if(uDTO.getUser_seq().equals(brDTO.getUser_seq()) || isAdmin) {%>
					
					<img src="/assets/images/previous_white.svg" style="height:18px; margin: 0 8px; cursor:pointer;" onclick="callReReply('<%=brDTO.getReply_seq()%>')" />
					<img src="/assets/images/edit.svg" style="height:18px; margin: 0 8px; cursor:pointer;" onclick="callBoardReplyUpdate('<%=brDTO.getReply_seq()%>')" />
					<img src="/assets/images/garbage.svg" style="height:18px; cursor:pointer;" onclick="callBoardReplyDelete('<%=brDTO.getReply_seq()%>')" />
				<%} %>								
			</div>
		</div>
	<%} %>
</body>
</html>