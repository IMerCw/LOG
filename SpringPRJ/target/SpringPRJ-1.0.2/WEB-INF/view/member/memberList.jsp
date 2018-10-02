<%@page import="poly.dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	List<MemberDTO> mList = (List<MemberDTO>)request.getAttribute("mList");

%>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>WEB!</title>

<script>
	$(function(){
		
		$('#btn').click(function(){
			var search = $('#search').val();
			$.ajax({
				url : '/member/searchList.do',
				method : 'post',
				data : {'search': search},
				success : function(data){
					console.log(data);
					if(data.length > 0){
						$('#list').html('');
						var content = '';
						content += '<table style="width:100%">';
						content += '<tr bgcolor="#00D8FF">';
						content += '<td width="100">회원번호</td>';
						content += '<td width="100">id</td>';
						content += '<td width="100">이름</td>';
						content += '<td width="100">성별</td>';
						content += '</tr>';
						$.each(data, function(key, value){
							content += '<tr>';
							content += '<td>'+value.member_id+'</td>';
							content += '<td>'+value.id+'</td>';
							content += '<td>'+value.member_name+'</td>';
							content += '<td>'+value.gender+'</td>';
							content += '</tr>';
						});
						content += '</table>';
						
						$('#list').html(content);

					}else{
						alert('검색결과가 없습니다.');
					}
					
				}
			});
		})
		
		$('#r').click(function(){
			$.ajax({
				url : '/member/rList.do',
				method : 'post',
				success : function(data){
					console.log(data);
					if(data.length > 0){
						$('#list').html('');
						var content = '';
						content += '<table style="width:100%">';
						content += '<tr bgcolor="#00D8FF">';
						content += '<td width="100">회원번호</td>';
						content += '<td width="100">id</td>';
						content += '<td width="100">이름</td>';
						content += '<td width="100">성별</td>';
						content += '</tr>';
						$.each(data, function(key, value){
							content += '<tr>';
							content += '<td>'+value.member_id+'</td>';
							content += '<td>'+value.id+'</td>';
							content += '<td>'+value.member_name+'</td>';
							content += '<td>'+value.gender+'</td>';
							content += '</tr>';
						});
						content += '</table>';
						
						$('#list').html(content);

					}
				}
			});
		})

	})

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
				<div id="list">
				<table style="width:100%">
					<tr bgcolor="#00D8FF">
						<td width="100">회원 번호</td>
						<td width="100">id</td>
						<td width="100">이름</td>
						<td width="100">성별</td>
					</tr>
					<%for(int i = 0; i< mList.size(); i++){ %>
						<tr>
							<td><%=mList.get(i).getMember_id()%></td>
							<td><%=mList.get(i).getId() %></td>
							<td>
								<a href="/member/memberDetail.do?memberId=<%=mList.get(i).getMember_id()%>">
									<%=mList.get(i).getMember_name() %>
								</a>
							</td>
							<td><%=mList.get(i).getGender() %></td>
						</tr>
					<%} %>
				</table>
				</div>
				<input type="text" id="search"><input type="button" id="btn" value="검색">
				</br>
				<input type="button" id="r" value="되돌리기">
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