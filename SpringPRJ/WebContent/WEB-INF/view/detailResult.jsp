<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String name = (String)request.getAttribute("name");
	String age = (String)request.getAttribute("age");
	String gender = (String)request.getAttribute("gender");

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%="name : " + name %>
<%="age : " + age %>
<%="gender : " + gender %>
</body>
</html>