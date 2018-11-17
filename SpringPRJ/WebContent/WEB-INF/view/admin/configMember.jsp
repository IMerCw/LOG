<%@page import="poly.dto.UserMemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	List<UserMemberDTO> uDTOs = (List<UserMemberDTO>) request.getAttribute("uDTOs"); 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	//제목 설정
	$('#pageName').html('회원관리');
</script>
<style>
	th, td {
		text-align: center;
		font-size: 14px;
		padding:12px;
		
	}
	tbody tr {
	    height: 64px;
	}
	td {
		font-size:12px;
		vertical-align: middle !important;
	}
	.content-body{
	    padding-left: 20px;
  		padding-right: 20px;
	}
	p {
		margin:0;
	}
	#userSeach:focus {
		border : 1px solid #999999;
	}
	.fa {
		font-size:18px;
	}
</style>
	
</head>
<body>
	<%for(int i = 0; i < uDTOs.size(); i++) {%>
		
	
	<%} %>
	<div class="container-fluid panel" style="background-color:#ffffff; color:black; padding:10px;">
		<!-- 회원 검색 -->
		<div class="row" style="margin-bottom: 10px;">
			<div class="col-md-8"></div>
			<div class="col-md-4">
				<div class="input-group input-search">
					<input type="text" class="form-control" name="q" id="userSeach" placeholder="회원검색...">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button" onclick="adminSearchUser(); return false;">
							<i class="fa fa-search"></i>
						</button>
					</span>
				</div>
			</div>
		</div>
		
		<div class="table-responsive">
			<table class="table table-hover mb-none">
			
				<thead>
					<tr>
						<th>#</th>
						<th>회원 아이디</th>
						<th>회원 이름</th>
						<th>이모티콘</th>
						<th>가입날짜</th>
						<th>회원상태</th>
						<th>수정</th>
					</tr>
				</thead>
				
				<tbody>
					<%for(UserMemberDTO uDTO: uDTOs) {%>
						<tr>
							<td><%=uDTO.getUser_seq() %>      </td>
							<td><%=uDTO.getUser_id() %>       </td>
							
							<!-- 유저 이름 -->
							<td style="width:180px;" id="userName<%=uDTO.getUser_seq()%>"> <%=uDTO.getUser_name() %></td>
							<!---- 숨겨진 input box ---->
							<td style="display:none" id="userNameBox<%=uDTO.getUser_seq()%>">
								<input type="text" class="form-control input-sm" id="userNameBoxInput<%=uDTO.getUser_seq()%>" value="<%=uDTO.getUser_name()%>"/>
							</td>
							<!-------------->
							
							<td style=" text-align:center;"> <img src="<%=uDTO.getFile_py_name() %>" class="img-circle" style="max-height:32px;"/></td> 
							<td><%=uDTO.getUser_reg_date() %> </td>
							<td id="userState<%=uDTO.getUser_seq() %>">
								<%if(uDTO.getUser_state().equals("1") && uDTO.getKakao_user_yn().equals("1")) {%>
									<p style="color: #ed9c28; font-weight: bold;">카카오유저</p>
								<%} else if(uDTO.getUser_state().equals("1")) {%>
									<p style="color: #09B23C; font-weight: bold;">정상</p>
								<%} else if ( uDTO.getUser_state().equals("0")) { %>
									<p style="color: #428bca; font-weight: bold;">가입대기</p>
								<%} else if ( uDTO.getUser_state().equals("-1")) { %>
									<p style="color: #FF0000; font-weight: bold;">탈퇴</p>
								<%} %>
							</td>
							
							<!-- 수정 버튼 클릭시 나올 목록 상자 -->
							<td style="display:none; width:82px; margin-right: -14px; border-top-color: #dddddd;" id="userStateBox<%=uDTO.getUser_seq()%>" >
								<select class="form-control" data-plugin-multiselect="" style="padding: 4px; font-size: 12px;">
									<option value="1">정상</option>
									<option value="0">가입대기</option>
									<option value="-1">탈퇴</option>
								</select>
							</td>
							
							<td class="actions-hover actions-fade" id="updateButton<%=uDTO.getUser_seq()%>" style="color:black; vertical-align: middle;">
								<a href="javascript:adminUpdateUser('<%=uDTO.getUser_seq()%>')">
									<!-- 수정 하기 버튼 -->
									<i class="fa fa-pencil" id='pencilImg<%=uDTO.getUser_seq()%>'></i>
									<!-- 수정 완료 버튼, 기본 숨김 -->
									<i class="fa fa-check" id='checkImg<%=uDTO.getUser_seq()%>' style="display:none" onclick="adminUpdateUserProc('<%=uDTO.getUser_seq()%>');"></i>
								</a>
							</td>
						</tr>
					<%} %>
				</tbody>
			</table>
		</div>
	</div>
</body>

<script>

	//수정 버튼 클릭 시 이벤트
	function adminUpdateUser(user_seq){
				
		//유저 이름 박스변경
		$('#userName' + user_seq).css('display', 'none');
		$('#userNameBox' + user_seq).css('display', 'table-cell');
		
		//유저상태 변경 셀렉트 박스
		$('#userState' + user_seq).css('display', 'none');
		$('#userStateBox' + user_seq).css('display', 'table-cell');
		
		//아이콘 변경 - 기존 아이콘 숨기기
		$('#pencilImg' + user_seq).css('display', 'none');
		$('#checkImg' + user_seq).css('display', 'table-cell');
		
		//아이콘 사라짐 효과 제거
		$('#updateButton' + user_seq).removeClass('actions-hover actions-fade');
		
	}
	
	//수정완료 버튼
	function adminUpdateUserProc(user_seq) {
		
		var r = confirm('회원 정보를 수정하시겠습니까?');
			
		if(r) {
			
			var updated_user_name =  $('#userNameBoxInput' + user_seq).val();
			var updated_user_state = $('#userStateBox' + user_seq +'>select').val();
				
			console.log("변경될 유저 번호 : " + user_seq);
			console.log("변경될 유저 이름 : " + updated_user_name);
			console.log("변경될 유저 상태 : " + updated_user_state);
			
			//유저 회원 변경 사항 전송
			$.ajax({
				method : "post",
				url : "/admin/adminUpdateUserProc.do",
				data : {
					user_seq : user_seq,
					user_name : updated_user_name,
					user_state : updated_user_state
				},
				success: function(data) {
					
					callPage('configMember'); //페이지 새로고침
					
				}
				
			});
			
		} else if(!r) {
			
			callPage('configMember'); //페이지 새로 고침
			
			/* 
			//변경 취소시 원상태로 복구
			//유저 이름 박스변경
			$('#userName' + user_seq).css('display', 'table-cell');
			$('#userNameBox' + user_seq).css('display', 'none');
			
			//유저상태 변경 셀렉트 박스
			$('#userState' + user_seq).css('display', 'table-cell');
			$('#userStateBox' + user_seq).css('display', 'none');
			
			//아이콘 변경 - 기존 아이콘 나타내기
			$('#pencilImg' + user_seq).css('display', 'table-cell');
			$('#checkImg' + user_seq).css('display', 'none');	 */
		}
		
	}
	
	//유저 검색
	function adminSearchUser() {
		var searchContent = $('#userSeach').val();
		alert(searchContent);
		$.ajax({
			method : 'post',
			url : '/admin/adminSearchUser.do',
			data : {
				searchContent : searchContent
			},
			success : function(data){
				$('.content-body').html(data);
			}
		});
	}
</script>
</html>