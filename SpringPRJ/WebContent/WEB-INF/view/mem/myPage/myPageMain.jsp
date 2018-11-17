<%@page import="poly.dto.UserMemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	UserMemberDTO uDTO = (UserMemberDTO) session.getAttribute("uDTO");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/assets/vendor/bootstrap-fileupload/bootstrap-fileupload.min.css">

<script>
	//제목 설정
	$('#pageName').html('마이페이지');	
</script>
</head>
<body>
	<div class="panel-body">
		<form class="form-horizontal form-bordered" action="/cmmn/updateUser.do" method="POST" enctype="multipart/form-data">
			<div class="form-group">
				<label class=" col-md-3 control-label">아이디</label>
				<div class="col-md-6">
					<input type="text" value="<%=uDTO.getUser_id() %>" id="inputReadOnly" class="form-control" readonly="readonly">
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-3 control-label" for="inputPassword">비밀번호</label>
				<div class="col-md-6">
					<input type="password" class="form-control" placeholder="" name="user_passwd" id="user_passwd" required='required'>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-md-3 control-label" for="inputPassword">비밀번호 변경</label>
				<div class="col-md-6">
					<input type="password" class="form-control" placeholder="" id="user_passwd_confirm" required='required'>
				</div>
			</div>
			
			<div class="form-group">
				<label class=" col-md-3 control-label">이름</label>
				<div class="col-md-6">
					<input type="text" value="<%=uDTO.getUser_name()%>" name="user_name" id="user_name" class="form-control" required='required'>
				</div>
			</div>
			
			
			<div class="form-group">
				<label class=" col-md-3 control-label">가입날짜</label>
				<div class="col-md-6">
					<input type="text" value="<%=uDTO.getUser_reg_date() %>" id="inputReadOnly2" class="form-control" readonly="readonly">
				</div>
			</div>
			
			
			<div class="form-group">
				<label class="col-md-3 control-label">이모티콘 설정</label>
				<div class="col-md-6">
					<div class="fileupload fileupload-new" data-provides="fileupload">
						<div class="input-append">
							<div class="uneditable-input">
								<i class="fa fa-file fileupload-exists"></i>
								<span class="fileupload-preview"></span>
								<%=uDTO.getFile_py_name().split("/")[2] %>
							</div>
							<span class="btn btn-default btn-file">
								<span class="fileupload-exists">바꾸기</span>
								<span class="fileupload-new">파일 선택</span>
								<input type="file" name="uploadFile">
							</span>
							<a href="#" class="btn btn-default fileupload-exists" data-dismiss="fileupload">제거</a>
						</div>
					</div>
				</div>
			</div>
			<div> 
				<button type="submit" class="mb-xs mt-xs mr-xs btn btn-primary" style="float:right; display: inline-block;">수정하기</button>
			</div>
			<div> 
				<button type="button" class="mb-xs mt-xs mr-xs btn btn-danger" style="float:left; display: inline-block;" data-toggle="modal" data-target="#myModal">회원탈퇴</button>
			</div>
			<!-- 회원탈퇴 확인 모달 -->
				<!-- The Modal -->
				<div class="modal fade" id="myModal">
				  <div class="modal-dialog" style="margin: 300px auto;">
				    <div class="modal-content">
				    
				      <!-- Modal Header -->
				      <div class="modal-header">
				        <h4 class="modal-title">회원 탈퇴 경고</h4>
				        <button type="button" class="close" data-dismiss="modal" style="margin-top: -22px;">&times;</button>
				      </div>
				      
				      <!-- Modal body -->
				      <div class="modal-body">
				       	정말로 회원 탈퇴를 하시겠습니까? 삭제된 회원 정보는 복구할 수 없습니다.
				      </div>
				      
				      <!-- Modal footer -->
				      <div class="modal-footer">
				        <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="javascript:deleteUserYes();">예, 탈퇴하겠습니다.</button>
				        <button type="button" class="btn btn-primary" data-dismiss="modal">아니오</button>
				      </div>
				      
				    </div>
				  </div>
				</div>
			<!---------------->
		</form>
	</div>
</body>

<script>
	//회원탈퇴 확인 모달 창
	function deleteUserYes() {
		
		location.href='/cmmn/deleteUser.do';
		
	}
	
</script>

<!-- Specific Page Vendor -->
<script src="/assets/vendor/jquery-autosize/jquery.autosize.js"></script>
<script src="/assets/vendor/bootstrap-fileupload/bootstrap-fileupload.min.js"></script>
</html>