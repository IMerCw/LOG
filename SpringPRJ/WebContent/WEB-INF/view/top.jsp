<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id =  CmmUtil.nvl((String)session.getAttribute("id"));
%>
<div align="right">
<%if("".equals(id)){ %>
	<!-- 만약에 id가 ""(공백)이라면 로그인을 안하거나 못한 상태!!! -->
	<form action="/member/loginProc.do" method="post">
		<b>ID</b><input type="text" name="id" /> 
	  <b>PASS</b><input type="password"	name="password" /> 
	  			 <input type="submit" value="로그인" />
	</form>
<%}else{ %>
	<b><%=id + "님 환영합니다."%></b>
	<button onclick="location.href='/member/logout.do'">로그아웃</button>
<%} %>
</div>