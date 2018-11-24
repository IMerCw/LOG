<%@page import="poly.dto.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<NoticeDTO> nDTOs = (List<NoticeDTO>) request.getAttribute("nDTOs"); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style>
	#noticeContentsBody div{
		text-overflow:ellipsis;
		overflow:hidden;
		white-space: nowrap;
	}
</style>
<div class="dropdown-menu notification-menu" style="display: block; right: 4px;">
	<div class="notification-title" style="background-color:#0088cc;">
		<!-- 세 소식 개수 3개이상일 경우 3+ 로 표현 -->
		<span class="pull-right label label-default" style='background-color:#ffffff; color:black; font-size: 12px;'>
			<%= nDTOs.size() > 3 ? "3+" : nDTOs.size() %>
		</span>
		새 소식 알림
	</div>

	<div class="content">
		<ul>
			<%int index = 0; %>
			<%for(NoticeDTO nDTO : nDTOs) {%>
				<%if(index > 2) break;%>
				<li>
					<a href="#" class="clearfix" id="noticeContentsBody">
						<div class="col-xs-3">
							<img src="<%=nDTO.getFile_py_name() %>" class="img-circle" style="width:32px; height:32px;"/>
						</div>
						<div class="col-xs-9 title"><%=nDTO.getReply_content()%></div>
						<div class="col-xs-9 message"><%=nDTO.getUser_name() + " " + nDTO.getReg_date() %></div>
					</a>
				</li>
				<%index++;%>
			<%} %>
			
		</ul>

		<hr />

		<div class="text-right">
			<p onclick="callNotificationDetail(); return false;" class="view-more" style="cursor:pointer;">더 보기</a>
		</div>
	</div>
</div>
<script>

</script>
</html>