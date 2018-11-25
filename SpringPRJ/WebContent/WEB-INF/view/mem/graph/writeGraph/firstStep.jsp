<%@page import="java.util.List"%>
<%@page import="poly.dto.PublicDataDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	//공공데이터 목록
	List<PublicDataDTO> pdDTOs = (List<PublicDataDTO>) request.getAttribute("pdDTOs");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- Mobile Metas -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	
	

	<!-- Vendor CSS -->
	<link rel="stylesheet" href="/assets/vendor/magnific-popup/magnific-popup.css" />
	<link rel="stylesheet" href="/assets/vendor/bootstrap-datepicker/css/datepicker3.css" />

	<!-- Specific Page Vendor CSS -->
	<link rel="stylesheet" href="/assets/vendor/pnotify/pnotify.custom.css" />
	
<script>
	//제목 설정
	$('#pageName').html('그래프 갤러리');
</script>
<style>
	
	.panel-featured * {
		text-overflow:ellipsis;
		overflow:hidden;
		white-space:nowrap;
	}
</style>
</head>
<body>
	<div class="container-fluid" style="padding:0">
	
	<section class="panel form-wizard" id="w4">
		<div class="panel-body">
			<div class="wizard-progress wizard-progress-lg" style="margin: 0 auto;">
				<div class="steps-progress">
					<div class="progress-indicator" style="width: 0%;"></div>
				</div>
				<ul class="wizard-steps">
					<li class="completed active">
						<a href="#w4-account" data-toggle="tab" aria-expanded="true"><span>1</span>데이터 선택</a>
					</li>
					<li class="secondStep">
						<a href="#w4-profile" data-toggle="tab" aria-expanded="false"><span>2</span>데이터 정제</a>
					</li>
					<li class="thirdStep">
						<a href="#w4-billing" data-toggle="tab"><span>3</span>그래프 선택</a>
					</li>
					<li class="fourthStep">
						<a href="#w4-confirm" data-toggle="tab"><span>4</span>게시물 작성</a>
					</li>
				</ul>
			</div>

			<form class="form-horizontal" novalidate="novalidate">
				<div class="tab-content">
				
					<!-- 1번 탭 -->
					<div id="w4-account" class="tab-pane active">
						
						<!-- 검색 바 -->
						<div class="row" style="margin: 24px 0;">
							<div class="col-md-6"> </div>
							<div class="col-md-6">
								<form action="pages-search-results.html" class="search nav-form">
									<div class="input-group input-search">
										<input type="text" class="form-control" name="dataSearch" id="dataSearch" placeholder="데이터 검색...">
										<span class="input-group-btn">
											<button class="btn btn-default" type="submit"><i class="fa fa-search"></i></button>
										</span>
									</div>
								</form>
							</div>
						</div>
				
				
						<!-- 데이터 패널 목록 -->
						<div class="row">
							<%
								for (int i = 0; i < pdDTOs.size(); i++) {
							%>	
								<div class="col-md-4 col-sm-6" style="cursor:pointer;" onclick="callSecondStep(<%=pdDTOs.get(i).getPdata_seq()%>);">
									<section class="panel panel-featured">
										<header class="panel-heading">
							
											<h2 class="panel-title"><%=pdDTOs.get(i).getPdata_name() %></h2>
											<p class="panel-subtitle"><%=pdDTOs.get(i).getPdata_cate() %></p>
										</header>
										<div class="panel-body">
											<code><%=pdDTOs.get(i).getPdata_keyword() %></code>
										</div>
									</section>
								</div>
							<%} %>
						</div>
						
					</div>
					
					<!-- 2번 탭 -->
					<div id="w4-profile" class="tab-pane">
					
					</div>
					
					<!-- 3번 탭 -->
					<div id="w4-billing" class="tab-pane" style="text-align: center;">
						
					</div>
					<!-- 4번 탭 -->
					<div id="w4-confirm" class="tab-pane">
						
					</div>
					
				</div>
			</form>
		</div>
		
	</section>
								
		
	</div>
</body>
<script>
	// 2번째 단계 - 데이터 정제 이동
	function callSecondStep(pdata_seq) {
		$.ajax({
			type :"POST",
			url : "/mem/graph/writeGraph/secondStep.do",
			dataType : "text",
			data : {
					pdata_seq : pdata_seq
			},
			error: function() {
				alert("통신 실패");
			},
			success: function(data) {
				$('#w4-profile').html(data);
				$('.secondStep>a').click();
				displayFirstStepSuccess();
			}
		});
	}
	
	
	<%---------- 모달 --------------%>
	var stack_topleft = {"dir1": "down", "dir2": "right", "push": "top"};
	var stack_bottomleft = {"dir1": "right", "dir2": "up", "push": "top"};
	var stack_bottomright = {"dir1": "up", "dir2": "left", "firstpos1": 15, "firstpos2": 15};
	var stack_bar_top = {"dir1": "down", "dir2": "right", "push": "top", "spacing1": 0, "spacing2": 0};
	var stack_bar_bottom = {"dir1": "up", "dir2": "right", "spacing1": 0, "spacing2": 0};
	<%----------1단계 성공  ----------%>
	function displayFirstStepSuccess() {
		new PNotify({
			title: '데이터 선택 성공',
			text: '데이터 선택이 완료되었습니다.',
			type: 'success',
			addclass: 'stack-bar-top',
			stack: stack_bar_top,
			width: "100%"
		});
	}
	<%----------2단계 성공  ----------%>
	function displaySecondStepSuccess() {
		new PNotify({
			title: '데이터 정제 성공',
			text: '데이터 정제가 완료되었습니다.',
			type: 'success',
			addclass: 'stack-bar-top',
			stack: stack_bar_top,
			width: "100%"
		});
	}
	<%----------3단계 성공  ----------%>
	function displayThirdStepSuccess() {
		new PNotify({
			title: '그래프 선택 성공',
			text: '그래프 선택이 완료되었습니다.',
			type: 'success',
			addclass: 'stack-bar-top',
			stack: stack_bar_top,
			width: "100%"
		});
	}
	
	function displayErrorNotice() {
		new PNotify({
			title: '댓글 쓰기 실패',
			text: '댓글을 작성해주세요.',
			type: 'error',
			shadow: true
		});
	}
	function displayDeleteNotice() {
		new PNotify({
			title: '댓글 삭제 완료',
			text: '댓글을 정상적으로 삭제하였습니다.',
			shadow: true
		});
	}
</script>
<!-- Vendor -->
<!-- 	
	<script src="/assets/vendor/jquery/jquery.js"></script>
	<script src="/assets/vendor/jquery-browser-mobile/jquery.browser.mobile.js"></script>
	<script src="/assets/vendor/bootstrap/js/bootstrap.js"></script>
	<script src="/assets/vendor/nanoscroller/nanoscroller.js"></script>
	<script src="/assets/vendor/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
	<script src="/assets/vendor/magnific-popup/magnific-popup.js"></script>
	<script src="/assets/vendor/jquery-placeholder/jquery.placeholder.js"></script>
	 -->
	<!-- Specific Page Vendor -->
	<script src="/assets/vendor/jquery-validation/jquery.validate.js"></script>
	<script src="/assets/vendor/bootstrap-wizard/jquery.bootstrap.wizard.js"></script>
	<script src="/assets/vendor/pnotify/pnotify.custom.js"></script>

	<!-- Theme Base, Components and Settings -->
	<script src="/assets/javascripts/theme.js"></script>
	
	<!-- Theme Custom -->
	<script src="/assets/javascripts/theme.custom.js"></script>
	
	<!-- Theme Initialization Files -->
	<script src="/assets/javascripts/theme.init.js"></script>


	<!-- Examples -->
	<script src="/assets/javascripts/forms/examples.wizard.js"></script>
</html>