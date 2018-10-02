<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>detail</title>
</head>
<body>
<form action="detailResult.do" method="post">
	이름 : <input type="text" name="name" />
	나이 : <input type="text" name="age" />
	남 : <input type="radio" name="gender" value="man"/>
	여 : <input type="radio" name="gender" value="woman"/>
	<input type="submit" value="전송">
</form>
</body>
</html>