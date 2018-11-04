<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>

<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>WEB!</title>
<script>
var idChkTF = false;
	$(function(){
		$('#idChk').click(function(){
			idChk();
		});
	});
	
	function idChk(){
		var id = $('#id').val();
		$.ajax({
			url : '/member/idChk.do',
			method : 'post',
			data : {'id' : id},
			success : function(data){
				if(data==0){
					
				}else{
					
				}
			}
		});
	};

</script>
</head>
<body>
	<table style="height: 100%; width: 100%">
		<tr height="7%" bgcolor="#00D8FF">
			<td>
				<%@include file="/WEB-INF/view/top.jsp" %>
			</td>
		</tr>
		<tr bgcolor="">
			<td>
				<form action="/member/memberRegProc.do" method="post">
					이름 : <input type="text" name="name"><br>
					성별  남 : <input type="radio" name="gender" value="0"> 여: <input type="radio" name="gender" value="1"><br>
					ID : <input type="text" name="id" id="id"> <input type="button" id="idChk" value="중복확인"><br>
					password : <input type="password" name="password">
					<input type="submit" value="회원가입">
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