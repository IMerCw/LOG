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
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR" rel="stylesheet">
<!-- 입력폼 노란색 배경 제거 -->
<style>
	input:-webkit-autofill { -webkit-box-shadow: 0 0 0 30px #fff inset ; -webkit-text-fill-color: #000; } 
	input:-webkit-autofill, input:-webkit-autofill:hover, input:-webkit-autofill:focus, input:-webkit-autofill:active { transition: background-color 5000s ease-in-out 0s; }
	.has-val + .focus-input100 + .label-input100 { top: 10px; }
	body { font-family: 'Noto Sans KR', sans-serif; }
</style>

</head>
<body style="background-color: #666666;">
	
		<div class="limiter">
			<div class="container-login100">
				<div class="wrap-login100">
					<form class="login100-form validate-form" action="/cmmn/loginProc.do" method="post">
						<span class="login100-form-title p-b-43">
							로그인
						</span>
						
						
						<div class="wrap-input100 validate-input" data-validate = "유효한 형식을 입력해주세요.">
							<input class="input100 has-val" type="text" name="user_id" required="required">
							<span class="focus-input100"></span>
							<span class="label-input100">아이디</span>
						</div>
						
						
						<div class="wrap-input100 validate-input" data-validate="패스워드를 입력해주세요.">
							<input class="input100 has-val" type="password" name="user_passwd" required="required">
							<span class="focus-input100"></span>
							<span class="label-input100">패스워드</span>
						</div>
	
						<div class="flex-sb-m w-full p-t-3 p-b-32">
							<div class="contact100-form-checkbox">
								<input class="input-checkbox100" id="ckb1" type="checkbox" name="remember-me">
								<label class="label-checkbox100" for="ckb1">
									아이디 기억하기
								</label>
							</div>
	
							<div>
								<span class="txt2" style="cursor:pointer; color:#000000;" onclick="javscript:location.href='/cmmn/reg.do'">
									가입하기
								</span>
								&nbsp;
								<a href="/cmmn/fnd.do" class="txt1">
									비밀번호 찾기
								</a>
							</div>
						</div>
				
	
						<div class="container-login100-form-btn">
							<button type="submit" class="login100-form-btn" style="font-size: 18px; font-weight: bold;">
								로그인
							</button>
						</div>
						
						<%-- 카카오 로그인 버튼 --%>
						<div class="login100-form-social flex-c-m" style="padding: 18px 0;">
							<img src="/assets/images/kakao_account_login_btn_medium_wide_ov.png" style="cursor:pointer;" 
									onclick="location.href='https://kauth.kakao.com/oauth/authorize?client_id=59c7e2d73ac8002bd4a89d0d5569c167&redirect_uri=http://localhost:8080/kakaoLogin.do&response_type=code'"/>
						</div>
						
					</form>
					<div class="login100-more" style="background-image: url('/assets/login/images/main.jpg');">
					</div>
				</div>
			</div>
		</div>
	

	
	
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
</body>
</html>