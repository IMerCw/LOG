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
			<form action="/member/memberUpdateProc.do" method="post">
			<input type="hidden" name="memberId" value="<%=mDTO.getMember_id() %>">
				<table style="height: 200px; width: 200px;">
					<tr>
						<td bgcolor="#00D8FF">이름</td>
						<td>
						<input type="text" name="name" value="<%= mDTO.getMember_name()%>">
						</td>
					</tr>
					<tr>
						<td bgcolor="#00D8FF">ID</td>
						<td><input type="text" name="id" value="<%= mDTO.getId()%>"></td>
					</tr>
					<tr>
						<td bgcolor="#00D8FF">password</td>
						<td><input type="text" name="password" value="<%= mDTO.getPassword()%>" required="required"></td>
					</tr>
					<tr>
						<td bgcolor="#00D8FF">성별</td>
						<td>
						남 : <input type="radio" name="gender" value="0" required="required">
						여 : <input type="radio" name="gender" value="1" required="required">
						</td>
					</tr>
				</table>
				<input type="submit" value="수정">
				</form>
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