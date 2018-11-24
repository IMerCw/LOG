<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="poly.dto.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<NoticeDTO> nDTOs = (List<NoticeDTO>) request.getAttribute("nDTOs");
	
	//현재 시각 가져오기
	DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	TimeZone time = TimeZone.getTimeZone("Asia/Seoul");
	// 주어진 시간대에 맞게 현재 시각으로 초기화된 GregorianCalender 객체를 반환.
	Calendar cal = Calendar.getInstance (time);  
	String boardName, boardIcon="fa-star";

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="/assets/stylesheets/theme-custom.css">
<link rel="stylesheet" href="/assets/stylesheets/skins/default.css">
<style>
	@media only screen and (max-width: 991px) {
	
		.timeline .tm-items > li .tm-icon {
			padding-top:7px;
    	}	
    }
</style>
<script>
	//제목 설정
	$('#pageName').html('새 소식 알림');
</script>
</head>
<body>
<div class="timeline">
<div class="tm-body">
	<div class="tm-title">
		<h3 class="h5 text-uppercase" style="font-size:20px;"><%=  cal.get ( Calendar.YEAR ) + "년 " + " " + (cal.get( Calendar.MONTH ) + 1)  + "월"%></h3>
	</div>
	<ol class="tm-items">
		<%for(NoticeDTO nDTO:nDTOs) { %>
			<li>
				<div class="tm-info">
					<%if("1".equals(nDTO.getBoard_seq())) { %>
						<%boardName = "커뮤니티"; boardIcon = "fa-list-ul";%>
					<%} else if ("2".equals(nDTO.getBoard_seq())) { %>
						<%boardName = "고객센터"; boardIcon = " fa-question";%>
					<%} else if ("3".equals(nDTO.getBoard_seq())) { %>
						<%boardName = "그래프 갤러리"; boardIcon = "fa-bar-chart-o";%>
					<%} else { %>
						<%boardName = ""; %>
					<%} %>
					
					<div class="tm-icon"><i class="fa <%=boardIcon%>"></i></div>
					<time class="tm-datetime" datetime="<%=nDTO.getReg_date()%>">
						<div class="tm-datetime-date"><%=nDTO.getReg_date() %></div>
						<div class="tm-datetime-time"><%=nDTO.getReg_date().split("\\s+")[1]%></div>
					</time>
				
				</div>
				
				<div class="tm-box appear-animation fadeInRight appear-animation-visible" data-appear-animation="fadeInRight" data-appear-animation-delay="100" style="animation-delay: 100ms;">
					<p>
						<%=nDTO.getReply_content()%>
					</p>
					<div class="tm-meta">
						<span>
							 By&nbsp;&nbsp;<img src="<%=nDTO.getFile_py_name() %>" class="img-circle" style="height:32px; width:32px;"/>&nbsp;&nbsp;<%=nDTO.getUser_name() %>
						</span>
						<span>
							<i class="fa fa-tags"></i> <%=boardName %>
						</span>
						<span>
							<i class="fa fa-comments"></i> <a href="#"><%=nDTO.getBoard_p_title()%></a>
						</span>
					</div>
				</div>
			</li>
		<%} %>
		<!-- 
		<li>
			<div class="tm-info">
				<div class="tm-icon"><i class="fa fa-thumbs-up"></i></div>
				<time class="tm-datetime" datetime="2013-11-19 18:13">
					<div class="tm-datetime-date">7 months ago.</div>
					<div class="tm-datetime-time">06:13 PM</div>
				</time>
			</div>
			<div class="tm-box appear-animation fadeInRight appear-animation-visible" data-appear-animation="fadeInRight" data-appear-animation-delay="250" style="animation-delay: 250ms;">
				<p>
					What is your biggest developer pain point?
				</p>
			</div>
		</li>
		<li>
			<div class="tm-info">
				<div class="tm-icon"><i class="fa fa-map-marker"></i></div>
				<time class="tm-datetime" datetime="2013-11-14 17:25">
					<div class="tm-datetime-date">7 months ago.</div>
					<div class="tm-datetime-time">05:25 PM</div>
				</time>
			</div>
			</li>
		</ol>
		<div class="tm-title">
			<h3 class="h5 text-uppercase">September 2013</h3>
		</div>
		<ol class="tm-items">
			<li>
				<div class="tm-info">
					<div class="tm-icon"><i class="fa fa-heart"></i></div>
					<time class="tm-datetime" datetime="2013-09-08 16:13">
						<div class="tm-datetime-date">9 months ago.</div>
						<div class="tm-datetime-time">04:13 PM</div>
					</time>
				</div>
				<div class="tm-box appear-animation fadeInRight appear-animation-visible" data-appear-animation="fadeInRight">
					<p>
						Checkout! How cool is that!
					</p>
					<div class="thumbnail-gallery">
						<a class="img-thumbnail" href="assets/images/projects/project-4.jpg">
							<span class="zoom">
								<i class="fa fa-search"></i>
							</span>
						</a>
						<a class="img-thumbnail" href="assets/images/projects/project-3.jpg">
							<span class="zoom">
								<i class="fa fa-search"></i>
							</span>
						</a>
						<a class="img-thumbnail" href="assets/images/projects/project-2.jpg">
							<span class="zoom">
								<i class="fa fa-search"></i>
							</span>
						</a>
					</div>
					<div class="tm-meta">
						<span>
							<i class="fa fa-user"></i> By <a href="#">John Doe</a>
						</span>
						<span>
							<i class="fa fa-tag"></i> <a href="#">Duis</a>, <a href="#">News</a>
						</span>
						<span>
							<i class="fa fa-comments"></i> <a href="#">12 Comments</a>
						</span>
					</div>
				</div>
			</li>
			<li>
				<div class="tm-info">
					<div class="tm-icon"><i class="fa fa-video-camera"></i></div>
					<time class="tm-datetime" datetime="2013-09-08 11:26">
						<div class="tm-datetime-date">9 months ago.</div>
						<div class="tm-datetime-time">11:26 AM</div>
					</time>
				</div>
				<div class="tm-box appear-animation fadeInRight appear-animation-visible" data-appear-animation="fadeInRight">
					<p>
						Google Fonts gives you access to over 600 web fonts!
					</p>
					<div class="embed-responsive embed-responsive-16by9">
						<iframe class="embed-responsive-item" src="//player.vimeo.com/video/67957799"></iframe>
					</div>
					<div class="tm-meta">
						<span>
							<i class="fa fa-user"></i> By <a href="#">John Doe</a>
						</span>
						<span>
							<i class="fa fa-thumbs-up"></i> 122 Likes
						</span>
						<span>
							<i class="fa fa-comments"></i> <a href="#">3 Comments</a>
						</span>
					</div>
				</div>
			</li> -->
			
			
		</ol>
	</div>
</div>
</body>
<!-- Specific Page Vendor -->
<script src="/assets/vendor/jquery-appear/jquery.appear.js"></script>

<!-- Theme Base, Components and Settings -->
<script src="/assets/javascripts/theme.js"></script>

<!-- Theme Custom -->
<script src="/assets/javascripts/theme.custom.js"></script>

<!-- Theme Initialization Files -->
<script src="/assets/javascripts/theme.init.js"></script>


</html>