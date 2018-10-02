<%@page import="poly.dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	MemberDTO mDTO = (MemberDTO)request.getAttribute("mDTO");
%>
<html>
<head>
<title>WEB!</title>
</head>
<body>
	<table style="height: 100%; width: 100%">
		<tr height="7%" bgcolor="#00D8FF">
			<td>
				<%@include file="/WEB-INF/view/top.jsp" %>
			</td>
		</tr>
		<tr bgcolor="">
			<td align="middle">
				<!-- 여기에다가 회원 상세 정보를 출력해 주세요...디자인은 상관없이 마음대로 어떻게든 출력만 해주세요...ㅠㅠ -->
				<table style="height: 200px; width: 200px;">
					<tr>
						<td bgcolor="#00D8FF">회원 번호</td>
						<td><%= mDTO.getMember_id()%></td>
					</tr>
					<tr>
						<td bgcolor="#00D8FF">이름</td>
						<td><%= mDTO.getMember_name()%></td>
					</tr>
					<tr>
						<td bgcolor="#00D8FF">ID</td>
						<td><%= mDTO.getId()%></td>
					</tr>
					<tr>
						<td bgcolor="#00D8FF">password</td>
						<td><%= mDTO.getPassword()%></td>
					</tr>
					<tr>
						<td bgcolor="#00D8FF">성별</td>
						<td><%=mDTO.getGender() %></td>
					</tr>
				</table>
				<button onclick="location.href='/member/updateView.do?memberId=<%=mDTO.getMember_id()%>'">수정</button>
				<button onclick="location.href='/member/deleteMember.do?memberId=<%=mDTO.getMember_id()%>'">삭제</button>
			</td>
		</tr>
		<tr height="7%" bgcolor="#00D8FF">
			<td>
				<%@include file="/WEB-INF/view/bottom.jsp" %>
			</td>
		</tr>
	</table>
</body>
</html>