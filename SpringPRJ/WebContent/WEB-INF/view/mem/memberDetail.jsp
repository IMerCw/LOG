<%@page import="poly.dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
				<table style="height: 200px; width: 200px;">
					<tr>
						<td bgcolor="#00D8FF">회원 번호</td>
						<td>${mDTO.member_id}</td>
					</tr>
					<tr>
						<td bgcolor="#00D8FF">이름</td>
						<td>${mDTO.member_name }</td>
					</tr>
					<tr>
						<td bgcolor="#00D8FF">ID</td>
						<td>${mDTO.id}</td>
					</tr>
					<tr>
						<td bgcolor="#00D8FF">비번</td>
						<td>${mDTO.password}</td>
					</tr>
					<tr>
						<td bgcolor="#00D8FF">성별</td>
						<td><c:out value=" ${mDTO.gender eq 0 ? '남자' : '여자' }"/></td>
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