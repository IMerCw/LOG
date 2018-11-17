<%@page import="poly.dto.UserMemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	UserMemberDTO uDTO = (UserMemberDTO)session.getAttribute("uDTO");
	Boolean isAdmin = (uDTO.getUser_id().equals("admin"));
%>
<html class="fixed">
<head>
	
	<!-- Basic -->
	<meta charset="UTF-8">

	<title>LOG ::: Lay On Graph </title>
	<meta name="keywords" content="HTML5 Admin Template" />
	<meta name="description" content="JSOFT Admin - Responsive HTML5 Template">
	<meta name="author" content="JSOFT.net">

	<!-- Mobile Metas -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

	<!-- Web Fonts  -->
	<link href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800|Shadows+Into+Light" rel="stylesheet" type="text/css">

	<!-- Vendor CSS -->
	<link rel="stylesheet" href="/assets/vendor/bootstrap/css/bootstrap.css" />
	<link rel="stylesheet" href="/assets/vendor/font-awesome/css/font-awesome.css" />
	<link rel="stylesheet" href="/assets/vendor/magnific-popup/magnific-popup.css" />
	<link rel="stylesheet" href="/assets/vendor/bootstrap-datepicker/css/datepicker3.css" />
	
	<!-- Specific Page Vendor CSS -->
	<link rel="stylesheet" href="/assets/vendor/jquery-ui/css/ui-lightness/jquery-ui-1.10.4.custom.css" />
	<link rel="stylesheet" href="/assets/vendor/bootstrap-multiselect/bootstrap-multiselect.css" />
	<link rel="stylesheet" href="/assets/vendor/morris/morris.css" />

	<!-- Theme CSS -->
	<link rel="stylesheet" href="/assets/stylesheets/theme.css" />

	<!-- Skin CSS -->
	<link rel="stylesheet" href="/assets/stylesheets/skins/default.css" />

	<!-- Theme Custom CSS -->
	<link rel="stylesheet" href="/assets/stylesheets/theme-custom.css">

	<!-- Head Libs -->
	<script src="/assets/vendor/modernizr/modernizr.js"></script>
	<!-- Web Font -->
	<link href="http://fonts.googleapis.com/earlyaccess/nanumgothic.css" rel="stylesheet">
	
	<style>
		body { font-family: 'Nanum Gothic', serif; }
		ul.nav-main li a { font-size:14px; }
		.sidebar-widget .widget-header h6 { color:#ffffff;}
		ul.nav-main > li > a:hover  { background-color: #171717;}
		ul.nav-main > li > a:focus, .nav > li > a:hover, .nav > li > a:focus { background-color: transparent;}
		.sidebar-left .sidebar-header .sidebar-title { color:white;}
		
		@media only screen and (max-width: 767px){
			.content-body  {
				padding: 15px;
			}
		}
		
		@media only screen and (max-width: 767px) {
			.header .header-right {
				height:50px;			
			}
		}
		.img-circle{
			border-radius:20%;
		}
		<%--관리자일 경우 CSS변경 --%>
		<%if(isAdmin) {%>
		
			.sidebar-left {
				background-color:#000000;
			}
			.page-header {
				background-color:#000000;
			}
			ul.nav-main > li.nav-active > a  {
				box-shadow: 2px 0 0 #ffffff inset;
			}
			
		<%}%>
	</style>
</head>
<body>
	<section class="body">

		<!-- start: header -->
		<header class="header">
			<div class="logo-container">
				<a href="/mem/main.do" class="logo" style="font-size: 20px; font-weight: bold; color: #56708a;">
					<img src="/assets/images/space.svg" height="35" alt="JSOFT Admin" />
					LOG
				</a>
				<div class="visible-xs toggle-sidebar-left" data-toggle-class="sidebar-left-opened" data-target="html" data-fire-event="sidebar-left-opened">
					<i class="fa fa-bars" aria-label="Toggle sidebar" style="padding-top:8px;"></i>
				</div>
			</div>
		
			<!-- start: search & user box -->
			<div class="header-right" style="padding-top: 8px;">
		
				<form action="pages-search-results.html" class="search nav-form">
					<div class="input-group input-search">
						<input type="text" class="form-control" name="q" id="q" placeholder="Search...">
						<span class="input-group-btn">
							<button class="btn btn-default" type="submit"><i class="fa fa-search"></i></button>
						</span>
					</div>
				</form>
		
				<!-- start : 새 소식 알림 notification -->
				<ul class="notifications" style="margin: 0 20px;">
					<li>
						<a href="#" class="dropdown-toggle notification-icon" data-toggle="dropdown">
							<i class="fa fa-bell"></i>
							<span class="badge">3</span>
						</a>
						
						<div class="dropdown-menu notification-menu">
							<div class="notification-title">
								<span class="pull-right label label-default">3</span>
								새 소식 알림
							</div>
		
							<div class="content">
								<ul>
									<li>
										<a href="#" class="clearfix">
											<div class="image">
												<i class="fa fa-thumbs-down bg-danger"></i>
											</div>
											<span class="title">Server is Down!</span>
											<span class="message">Just now</span>
										</a>
									</li>
									<li>
										<a href="#" class="clearfix">
											<div class="image">
												<i class="fa fa-lock bg-warning"></i>
											</div>
											<span class="title">User Locked</span>
											<span class="message">15 minutes ago</span>
										</a>
									</li>
									<li>
										<a href="#" class="clearfix">
											<div class="image">
												<i class="fa fa-signal bg-success"></i>
											</div>
											<span class="title">Connection Restaured</span>
											<span class="message">10/10/2014</span>
										</a>
									</li>
								</ul>
		
								<hr />
		
								<div class="text-right">
									<a href="#" class="view-more">View All</a>
								</div>
							</div>
						</div>
					</li>
				</ul>
				<!-- end : 새 소식 알림 notification -->
				
				<div id="userbox" class="userbox" style="margin: 5px;">
					<a href="#" data-toggle="dropdown">
						<figure class="profile-picture">
							<%if(uDTO.getFile_py_name() != null) {%>
								<img src="<%=uDTO.getFile_py_name()%>" alt="이모티콘" class="img-circle" 
									data-lock-picture="/assets/images/!logged-user.jpg" style="max-height: 38px;" />
							<%} else {%>
								<img src="/assets/images/default_user.svg" alt="이모티콘" class="img-circle" 
									data-lock-picture="/assets/images/!logged-user.jpg" style="max-height: 38px;" />
							
							<%} %>
						</figure>
						<div class="profile-info" data-lock-name="John Doe" data-lock-email="johndoe@JSOFT.com">
							<span class="name"><%=uDTO.getUser_name()%></span>
							<span class="role">환영합니다.</span>
						</div>
		
						<i class="fa custom-caret"></i>
					</a>
		
					<div class="dropdown-menu">
						<ul class="list-unstyled">
							<li class="divider"></li>
							<li>
								<a role="menuitem" tabindex="-1" href="javascript:callPage('myPage');"><i class="fa fa-user"></i> 내 정보</a>
							</li>
							<li>
								<a role="menuitem" tabindex="-1" href="#" data-lock-screen="true"><i class="fa fa-question-circle"></i>&nbsp;도움말</a>
							</li>
							<li>
								<a href="/cmmn/logout.do" role="menuitem" tabindex="-1" href="pages-signin.html"><i class="fa fa-power-off"></i> 로그아웃</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<!-- end: search & user box -->
		</header>
		<!-- end: header -->
		

		<div class="inner-wrapper">
			<!-- start: sidebar -->
			<aside id="sidebar-left" class="sidebar-left">
			
				<div class="sidebar-header">
					<div class="sidebar-title">
						메뉴
					</div>
					<div class="sidebar-toggle hidden-xs" data-toggle-class="sidebar-left-collapsed" data-target="html" data-fire-event="sidebar-left-toggle">
						<i class="fa fa-bars" aria-label="Toggle sidebar"></i>
					</div>
				</div>
			
				<div class="nano">
					<div class="nano-content">
						<nav id="menu" class="nav-main" role="navigation">
							<ul class="nav nav-main">
							
								<li id="mainPage" class="nav-active">
									<a href="#" onclick="javascript:callPage('mainPage');">
										<i class="fa fa-home" aria-hidden="true"></i>
										<span>메인화면</span>
									</a>
								</li>
								<li id="graphGallery">
									<a href="#" onclick="javascript:callPage('graphGallery');">
										<i class="fa fa-bar-chart-o" aria-hidden="true"></i>
										<span>그래프 갤러리</span>
									</a>
								</li>
								<li id="myGraph">
									<a href="#" onclick="javascript:callPage('myGraphPage');">
										<i class="fa fa-star-o" aria-hidden="true"></i>
										<span>내 그래프</span>
									</a>
								</li>
								<li id="community">
									<a href="#" onclick="javascript:callPage('communityPage');">
										<i class="fa fa-list-alt" aria-hidden="true"></i>
										<span>커뮤니티</span>
									</a>
								</li>
								<li id="helpCenter">
									<a href="#" onclick="javascript:callPage('helpCenterPage');">
										<i class="fa fa-question-circle" aria-hidden="true"></i>
										<span>고객센터</span>
									</a>
								</li>
								<%if(isAdmin) {%>
								<li id="myPage">
									<a href="#" onclick="javascript:callPage('configMember');">
										<i class="fa fa-group"></i>
										<span>회원관리</span>
									</a>
								</li>
								<%} else {%>
								<li id="myPage">
									<a href="#" onclick="javascript:callPage('myPage');">
										<i class="fa fa-wrench" aria-hidden="true"></i>
										<span>마이페이지</span>
									</a>
								</li>
								
								<%} %>
							</ul>
						</nav>
			
						<hr class="separator" />
			
						<div class="sidebar-widget widget-tasks">
							<div class="widget-header">
								<h6>Projects</h6>
								<div class="widget-toggle">+</div>
							</div>
							<div class="widget-content">
								<ul class="list-unstyled m-none">
									<li><a href="#">JSOFT HTML5 Template</a></li>
									<li><a href="#">Tucson Template</a></li>
									<li><a href="#">JSOFT Admin</a></li>
								</ul>
							</div>
						</div>
			
						<hr class="separator" />
			
						<div class="sidebar-widget widget-stats">
							<div class="widget-header">
								<h6>Company Stats</h6>
								<div class="widget-toggle">+</div>
							</div>
							<div class="widget-content">
								<ul>
									<li>
										<span class="stats-title">Stat 1</span>
										<span class="stats-complete">85%</span>
										<div class="progress">
											<div class="progress-bar progress-bar-primary progress-without-number" role="progressbar" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100" style="width: 85%;">
												<span class="sr-only">85% Complete</span>
											</div>
										</div>
									</li>
									<li>
										<span class="stats-title">Stat 2</span>
										<span class="stats-complete">70%</span>
										<div class="progress">
											<div class="progress-bar progress-bar-primary progress-without-number" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width: 70%;">
												<span class="sr-only">70% Complete</span>
											</div>
										</div>
									</li>
									<li>
										<span class="stats-title">Stat 3</span>
										<span class="stats-complete">2%</span>
										<div class="progress">
											<div class="progress-bar progress-bar-primary progress-without-number" role="progressbar" aria-valuenow="2" aria-valuemin="0" aria-valuemax="100" style="width: 2%;">
												<span class="sr-only">2% Complete</span>
											</div>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>
			
				</div>
			
			</aside>
			<!-- end: sidebar -->

			<section role="main" class="content-body">
				
			</section>
		</div>

		<aside id="sidebar-right" class="sidebar-right">
			<div class="nano">
				<div class="nano-content">
					<a href="#" class="mobile-close visible-xs">
						Collapse <i class="fa fa-chevron-right"></i>
					</a>				
					<!-- start: header-->
						<header class="page-header">
							<h2 id="pageName">페이지 이름</h2>
						
							<div class="right-wrapper pull-right">
								<ol class="breadcrumbs">
									<li>
										<a href="index.html">
											<i class="fa fa-home"></i>
										</a>
									</li>
									<li><span>대시보드</span></li>
								</ol>
						
								<a class="sidebar-right-toggle" data-open="sidebar-right"><i class="fa fa-chevron-left"></i></a>
							</div>
						</header>
					<!-- end: header-->
		
					<div class="sidebar-right-wrapper">
		
						<div class="sidebar-widget widget-calendar">
							<h6>Upcoming Tasks</h6>
							<div data-plugin-datepicker data-plugin-skin="dark" ></div>
		
							<ul>
								<li>
									<time datetime="2014-04-19T00:00+00:00">04/19/2014</time>
									<span>Company Meeting</span>
								</li>
							</ul>
						</div>
		
						<div class="sidebar-widget widget-friends">
							<h6>Friends</h6>
							<ul>
								<li class="status-online">
									<figure class="profile-picture">
										<img src="/assets/images/!sample-user.jpg" alt="Joseph Doe" class="img-circle">
									</figure>
									<div class="profile-info">
										<span class="name">Joseph Doe Junior</span>
										<span class="title">Hey, how are you?</span>
									</div>
								</li>
								<li class="status-online">
									<figure class="profile-picture">
										<img src="/assets/images/!sample-user.jpg" alt="Joseph Doe" class="img-circle">
									</figure>
									<div class="profile-info">
										<span class="name">Joseph Doe Junior</span>
										<span class="title">Hey, how are you?</span>
									</div>
								</li>
								<li class="status-offline">
									<figure class="profile-picture">
										<img src="/assets/images/!sample-user.jpg" alt="Joseph Doe" class="img-circle">
									</figure>
									<div class="profile-info">
										<span class="name">Joseph Doe Junior</span>
										<span class="title">Hey, how are you?</span>
									</div>
								</li>
								<li class="status-offline">
									<figure class="profile-picture">
										<img src="/assets/images/!sample-user.jpg" alt="Joseph Doe" class="img-circle">
									</figure>
									<div class="profile-info">
										<span class="name">Joseph Doe Junior</span>
										<span class="title">Hey, how are you?</span>
									</div>
								</li>
							</ul>
						</div>
		
					</div>
				</div>
			</div>
		</aside>
	</section>
	
	<!-- Vendor -->
	<script src="/assets/vendor/jquery/jquery.js"></script>
	<script src="/assets/vendor/jquery-browser-mobile/jquery.browser.mobile.js"></script>
	<script src="/assets/vendor/bootstrap/js/bootstrap.js"></script>
	<script src="/assets/vendor/nanoscroller/nanoscroller.js"></script>
	<script src="/assets/vendor/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
	<script src="/assets/vendor/magnific-popup/magnific-popup.js"></script>
	<script src="/assets/vendor/jquery-placeholder/jquery.placeholder.js"></script>
	
	<!-- Specific Page Vendor -->
	<script src="/assets/vendor/jquery-ui/js/jquery-ui-1.10.4.custom.js"></script>
	<script src="/assets/vendor/jquery-ui-touch-punch/jquery.ui.touch-punch.js"></script>
	<script src="/assets/vendor/jquery-appear/jquery.appear.js"></script>
	<script src="/assets/vendor/bootstrap-multiselect/bootstrap-multiselect.js"></script>
	<script src="/assets/vendor/jquery-easypiechart/jquery.easypiechart.js"></script>
	<script src="/assets/vendor/flot/jquery.flot.js"></script>
	<script src="/assets/vendor/flot-tooltip/jquery.flot.tooltip.js"></script>
	<script src="/assets/vendor/flot/jquery.flot.pie.js"></script>
	<script src="/assets/vendor/flot/jquery.flot.categories.js"></script>
	<script src="/assets/vendor/flot/jquery.flot.resize.js"></script>
	<script src="/assets/vendor/jquery-sparkline/jquery.sparkline.js"></script>
	<script src="/assets/vendor/raphael/raphael.js"></script>
	<script src="/assets/vendor/morris/morris.js"></script>
	<script src="/assets/vendor/gauge/gauge.js"></script>
	<script src="/assets/vendor/snap-svg/snap.svg.js"></script>
	<script src="/assets/vendor/liquid-meter/liquid.meter.js"></script>
	<script src="/assets/vendor/jqvmap/jquery.vmap.js"></script>
	<script src="/assets/vendor/jqvmap/data/jquery.vmap.sampledata.js"></script>
	<script src="/assets/vendor/jqvmap/maps/jquery.vmap.world.js"></script>
	<script src="/assets/vendor/jqvmap/maps/continents/jquery.vmap.africa.js"></script>
	<script src="/assets/vendor/jqvmap/maps/continents/jquery.vmap.asia.js"></script>
	<script src="/assets/vendor/jqvmap/maps/continents/jquery.vmap.australia.js"></script>
	<script src="/assets/vendor/jqvmap/maps/continents/jquery.vmap.europe.js"></script>
	<script src="/assets/vendor/jqvmap/maps/continents/jquery.vmap.north-america.js"></script>
	<script src="/assets/vendor/jqvmap/maps/continents/jquery.vmap.south-america.js"></script>
	
	<!-- Theme Base, Components and Settings -->
	<script src="/assets/javascripts/theme.js"></script>
	
	<!-- Theme Custom -->
	<script src="/assets/javascripts/theme.custom.js"></script>
	
	<!-- Theme Initialization Files -->
	<script src="/assets/javascripts/theme.init.js"></script>


	<!-- Examples -->
	<script src="/assets/javascripts/dashboard/examples.dashboard.js"></script>
</body>

<script>
	//처음은 항상 기본 메인페이지로 이동
	callPage('mainPage');
	
	////페이지 별로 content-body내에 페이지 삽입
	function callPage(pageName) {
		//메인페이지
		if (pageName == 'mainPage') {
			$('.nav-main li').removeClass('nav-active'); // 이전 페이지에서의 nav-active 클래스 제거
			$('#mainPage').addClass('nav-active'); // 현재 메뉴의 nav-active 클래스 추가
			$('#mainPage>a').blur(); // focus 해제
			$.ajax({
				type : "GET",
				url : "/mem/mainContentBody.do",
				dataType: "text",
				error: function() {
					alert("통신실패");
				},
				success: function(data) {
					$('.content-body').html(data);
				}
			})
		}
		
		else if (pageName == 'graphGallery'){
			$('.nav-main li').removeClass('nav-active'); // 이전 페이지에서의 nav-active 클래스 제거
			$('#graphGallery').addClass('nav-active'); // 현재 메뉴의 nav-active 클래스 추가
			$('#graphGallery>a').blur(); // focus 해제
			$.ajax({
				type : "GET",
				url : "/mem/graph/graphMain.do",
				dataType: "text",
				error: function() {
					alert("통신실패");
				},
				success: function(data) {
					$('.content-body').html(data);
				}
			})
		}
		
		else if (pageName == 'myGraphPage'){
			$('.nav-main li').removeClass('nav-active'); // 이전 페이지에서의 nav-active 클래스 제거
			$('#myGraph').addClass('nav-active'); // 현재 메뉴의 nav-active 클래스 추가
			$('#myGraph>a').blur(); // focus 해제
			$.ajax({
				type : "GET",
				url : "/mem/myGraph/myGraphMain.do",
				dataType: "text",
				error: function() {
					alert("통신실패");
				},
				success: function(data) {
					$('.content-body').html(data);
				}
			})
		}
		
		else if (pageName == 'communityPage'){
			$('.nav-main li').removeClass('nav-active'); // 이전 페이지에서의 nav-active 클래스 제거
			$('#community').addClass('nav-active'); // 현재 메뉴의 nav-active 클래스 추가
			$('#community>a').blur(); // focus 해제
			$.ajax({
				type : "GET",
				url : "/mem/community/communityMain.do",
				dataType: "text",
				data: {currentPage : '1'},
				error: function() {
					alert("통신실패");
				},
				success: function(data) {
					$('.content-body').html(data);
				}
			})
		}
		
		else if (pageName == 'helpCenterPage'){
			<%-- 현재 페이지 초기화 --%>
			$('.nav-main li').removeClass('nav-active'); // 이전 페이지에서의 nav-active 클래스 제거
			$('#helpCenter').addClass('nav-active'); // 현재 메뉴의 nav-active 클래스 추가
			$('#helpCenter>a').blur(); // focus 해제
			$.ajax({
				type : "GET",
				url : "/mem/helpCenter/helpCenterMain.do",
				dataType: "text",
				data : {currentPage : 1},
				error: function() {
					alert("통신실패");
				},
				success: function(data) {
					$('.content-body').html(data);
				}
			})
		}
		
		else if (pageName == 'myPage'){
			$('.nav-main li').removeClass('nav-active'); // 이전 페이지에서의 nav-active 클래스 제거
			$('#myPage').addClass('nav-active'); // 현재 메뉴의 nav-active 클래스 추가
			$('#myPage>a').blur(); // focus 해제
			$.ajax({
				type : "GET",
				url : "/mem/myPage/myPageMain.do",
				dataType: "text",
				error: function() {
					alert("통신실패");
				},
				success: function(data) {
					$('.content-body').html(data);
				}
			})
		}			
		else if (pageName == 'configMember'){
			$('.nav-main li').removeClass('nav-active'); // 이전 페이지에서의 nav-active 클래스 제거
			$('#myPage').addClass('nav-active'); // 현재 메뉴의 nav-active 클래스 추가
			$('#myPage>a').blur(); // focus 해제
			$.ajax({
				type : "GET",
				url : "/admin/configMember.do",
				dataType: "text",
				error: function() {
					alert("통신실패");
				},
				success: function(data) {
					$('.content-body').html(data);
				}
			})
		}			
	}
	
	/* blur foucs해제 */

	
	
		
</script>
</html>