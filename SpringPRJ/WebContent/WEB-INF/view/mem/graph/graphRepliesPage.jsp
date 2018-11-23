<%@page import="poly.dto.GraphReplyDTO"%>
<%@page import="poly.dto.UserMemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	List<GraphReplyDTO> grDTOs = (List<GraphReplyDTO>) (request.getAttribute("grDTOs"));
	UserMemberDTO uDTO = (UserMemberDTO) session.getAttribute("uDTO");
	String userSeq;
	boolean isAdmin = uDTO.getUser_id().equals("admin"); //관리자 권한 참 거짓
	Float starRate;
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
	<%for(GraphReplyDTO grDTO : grDTOs) {%>
		<div class="row reply_container" id="<%=grDTO.getReply_seq()%>" style="padding: 4px; border-radius: 2px; background-color: #cccccc; margin:10px 0; border: 1px solid #bbbbbb;">
		
			<div style="min-height: 64px; padding: 6px 14px;" id="replyContent<%=grDTO.getReply_seq()%>"><%=grDTO.getReply_content() %></div>								
			
			<div class="col-md-10" style="text-align:left;">
				<img src="<%=grDTO.getFile_py_name() %>" alt="이모티콘" class="img-circle"/>
				/ 
				<%=grDTO.getUser_name() %>
				/  
				<%=grDTO.getReg_date() %> 
				/
				<%-- 별점 표시 --%>
				<span style="color:sandybrown;">
				<%if(grDTO.getStar_rate() != null) {%>
					<% starRate = Float.valueOf(grDTO.getStar_rate()); %>
					<%for(int j = 0; j < 5; j++, starRate--) {%>
						<%if(starRate == 0.5 ) {%>
							<i class="fa fa-star-half-o"></i> 
						<%} else if (starRate <= 0.0 ){ %>
							<i class="fa fa-star-o"></i> 
						<%}else { %>
							<i class="fa fa-star"></i>
						<%} %>
					<%} %>
				<%} else { %>
					별점이 없습니다.
				<%} %>
				</span>
			</div>
			
			<div class="col-md-2" style="text-align:right">
				<%if(uDTO.getUser_seq().equals(grDTO.getUser_seq()) || isAdmin) {%>
				<%--<img src="/assets/images/previous_white.svg" style="height:18px; margin: 0 8px; cursor:pointer;" onclick="callReReply('<%=grDTO.getReply_seq()%>')" /> --%>
					<img src="/assets/images/edit.svg" style="height:18px; margin: 0 8px; cursor:pointer;" onclick="callGraphReplyUpdate('<%=grDTO.getReply_seq()%>')" />
					<img src="/assets/images/garbage.svg" style="height:18px; cursor:pointer;" onclick="callGraphReplyDelete('<%=grDTO.getReply_seq()%>')" />
				<%} %>								
			</div>
		</div>
	<%} %>
</body>
</html>