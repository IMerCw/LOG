<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>LOG ::: Welcome to LOG</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="/assets/login/mages/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/assets/login/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/assets/login/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/assets/login/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/assets/login/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="/assets/login/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/assets/login/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/assets/login/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="/assets/login/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/assets/login/css/util.css">
	<link rel="stylesheet" type="text/css" href="/assets/login/css/main.css">
<!--===============================================================================================-->
<!--===============================================================================================-->
	<script src="/assets/login/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="/assets/login/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="/assets/login/vendor/bootstrap/js/popper.js"></script>
	<script src="/assets/login/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="/assets/login/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="/assets/login/vendor/daterangepicker/moment.min.js"></script>
	<script src="/assets/login/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="/assets/login/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="/assets/login/js/main.js"></script>
<!--===============================================================================================-->
<!--===============================================================================================-->
<!--===============================================================================================-->
	<script type="text/javascript" src="/assets/pnotify/pnotify.custom.min.js"></script>
	<link href="/assets/pnotify/pnotify.custom.min.css" media="all" rel="stylesheet" type="text/css" />

	
		
<style>
	/* 	<!-- 입력폼 노란색 배경 제거 --> */
	input:-webkit-autofill { -webkit-box-shadow: 0 0 0 30px #fff inset ; -webkit-text-fill-color: #000; } 
	input:-webkit-autofill, input:-webkit-autofill:hover, input:-webkit-autofill:focus, input:-webkit-autofill:active { transition: background-color 5000s ease-in-out 0s; }
	.has-val + .focus-input100 + .label-input100 { top: 10px; }
</style>

</head>
<body style="background-color: #666666;">
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				<form class="login100-form validate-form" id="regForm" action="/cmmn/regProc.do", method="POST">
					<span class="login100-form-title p-b-43">
						회원가입
					</span>
					
					<!-- 이메일 입력 -->
					<div class="wrap-input100 validate-input">
						<input class="input100 has-val" type="text" name="user_id" id="user_id" required="required">
						<span class="focus-input100"></span>
						<span class="label-input100">아이디(이메일 형식)</span>
					</div>
					
					<!-- 이메일 중복 체크 --> 
					<div class="wrap-input100" id="idCheckPrint" style="font-size:12px; color:white; padding-bottom: 1px; height: 25px; padding-left: 27px;"></div>
					
					<!-- 패스워드 입력 -->
					<div class="wrap-input100 validate-input" data-validate="패스워드는 필수 항목입니다.">
						<input class="input100 has-val" type="password" name="user_passwd" id="user_passwd" required="required">
						<span class="focus-input100"></span>
						<span class="label-input100">비밀번호</span>
					</div>
					
					<!-- 패스워드 재입력 -->
					<div class="wrap-input100 validate-input" data-validate="패스워드는 필수 항목입니다.">
						<input class="input100 has-val" type="password" name="user_passwd2" id="user_passwd2" required="required">
						<span class="focus-input100"></span>
						<span class="label-input100">비밀번호 확인</span>
					</div>
					<!-- 비밀번호 유효성 검사 -->
					<div class="wrap-input100" id="passwdCheckPrint" style="font-size:12px; color:white; padding-bottom: 1px; height: 25px; padding-left: 27px;"></div>
					
					<!-- 이름 입력 폼-->
					<div class="wrap-input100 validate-input" data-validate="이름은 필수 항목입니다.">
						<input class="input100 has-val" type="text" name="user_name" id="user_name" required='required'>
						<span class="focus-input100"></span>
						<span class="label-input100">이름</span>
					</div>
					
					<!-- 가입버튼 -->
					<div class="container-login100-form-btn">
						<button type="button" class="login100-form-btn" style="font-size: 18px; font-weight: bold;" onclick="callRegProc(); return false;">
							가입하기
						</button>
					</div>
					
					<div class="text-center p-t-46 p-b-20" style="padding-top:20px;">
						<span class="txt2" style="cursor:pointer; "onclick="javscript:location.href='/cmmn/main.do'">
							이미 아이디가 있습니까?
						</span>
					</div>
					
					<div class="login100-form-social flex-c-m">
						<a href="/assets/login#" class="login100-form-social-item flex-c-m bg1 m-r-5">
							<i class="fa fa-facebook-f" aria-hidden="true"></i>
						</a>

						<a href="/assets/login#" class="login100-form-social-item flex-c-m bg2 m-r-5">
							<i class="fa fa-twitter" aria-hidden="true"></i>
						</a>
					</div>
				</form>

				<div class="login100-more" style="background-image: url('/assets/login/images/main.jpg');">
				</div>
			</div>
		</div>
	</div>
	
	
	
</body>

<script>
	
	//이메일 중복 체크
	$('#user_id').keyup(function() {
		if(!verifyEmail($('#user_id').val())) {
			
			$('#idCheckPrint').html(function() {
				$('#idCheckPrint').removeClass('bg-success');
				$('#idCheckPrint').addClass('bg-danger');
				
				return '이메일 형식을 올바르게 지정해 주세요.';
			});
			
		}else {
			//AJAX로 아이디 중복 확인
			$.ajax({
				type : "POST",
				url : "/cmmn/idCheck.do",
				dataType: "text",
				data : { user_id : $('#user_id').val() },
				error: function() {
					alert("통신실패");
				},
				success: function(result) {
					
					console.log(result);
					
					$('#idCheckPrint').html(function() {
						
						if(result == '1') {
							$('#idCheckPrint').removeClass('bg-danger');
							$('#idCheckPrint').addClass('bg-success');
							return '사용 가능한 아이디입니다.';
						} else {
							$('#idCheckPrint').removeClass('bg-success');
							$('#idCheckPrint').addClass('bg-danger');
							return '사용 불가능한 아이디입니다.';
						}
					});
				}
			});
		}
		
	})
		
	//이메일 체크
	function verifyEmail(emailVal) {
		// 이메일 검증 스크립트 작성
		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		// 검증에 사용할 정규식 변수 regExp에 저장
		if (emailVal.match(regExp) != null) {
			return true;
		}
		else {
			return false;
		}
	};
		
	
	
	//키 입력 후 비밀번호 유효성 검사 이벤트
	$('#user_passwd').keyup(function() {
		doChkPwd();
		
	});
	$('#user_passwd2').keyup(function() {
		doChkPwd();
		
	});
	

	//비밀번호 검사하기 함수
	function doChkPwd(){
		
		if(!chkPwd($.trim($('#user_passwd').val()))) {
			
			$('#user_passwd').focus();
			
			$('#passwdCheckPrint').removeClass('bg-success');
			$('#passwdCheckPrint').addClass('bg-danger');
			$('#passwdCheckPrint').html('비밀번호는 영문, 숫자 혼합하여 6~20자리 이내여야 합니다.');
			
			return false;
		
		} else {
			
			chkPwdIdentify();
			
		}
	}
	
	
	//비밀번호 일치 검사 함수
	function chkPwdIdentify () {
		if( $.trim($('#user_passwd').val()) != $.trim($('#user_passwd2').val())) {
			
			$('#passwdCheckPrint').removeClass('bg-success');
			$('#passwdCheckPrint').addClass('bg-danger');
			$('#passwdCheckPrint').html('비밀번호가 일치하지 않습니다.');
			return false
			
		} else {
			
			$('#passwdCheckPrint').removeClass('bg-danger');
			$('#passwdCheckPrint').addClass('bg-success');
			$('#passwdCheckPrint').html('사용가능한 비밀번호 입니다.');
			return true
			
		}
		
	}
	
	/*-- 유효성 검사 모듈 --*/
	function chkPwd(str) {

		var reg_pwd = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;

		if (!reg_pwd.test(str)) {

			return false;

		}

	return true;

	}
	/*----------------*/

	/*----------------*/
	////가입하기 버튼
	// 모든 조건이 참이여야만 가입하도록 설정
	function callRegProc() {
		
		if (verifyEmail($('#user_id').val())) {	//이메일 유효성검사
		
			if(chkPwd($.trim($('#user_passwd').val()))) {	//패스워드 유효성검사
			
					
				if ($('#user_passwd').val() == $('#user_passwd2').val()) { //패스워드 일치 검사
					
					return $('#regForm').submit(); //전송
					
				} else {
					
					errorNotify("작성하신 비밀번호가 일치하지 않습니다.");
					
					return null;
					
				}
			}
		}

	}
	
	
</script>
</html>