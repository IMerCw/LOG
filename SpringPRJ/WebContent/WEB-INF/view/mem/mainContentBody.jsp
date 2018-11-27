<%@page import="poly.dto.StatGraphRateDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<StatGraphRateDTO> sgrDTOs = (List<StatGraphRateDTO>)request.getAttribute("sgrDTOs");
%>
<head>
</head>

<style>
.panel-heading-icon > i {
    padding: 20px;
}
.main_img { 
	width:24%;
}
.imgIcon {
	height:32px;
}

.hero-image {
	border-radius:6px;
	background-image:url("/assets/images/main/mem_main_4_blue.png");
	background-color: #cccccc;
	height: 500px;
	background-position: center;
	background-repeat: no-repeat;
	background-size: cover;
	position: relative;
}

.hero-text {
	text-align: center;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	color: white;
}
</style>
<script>
	//제목 설정
	$('#pageName').html('메인화면');
	
</script>

<body>

	<!-- start: content-body -->
	<div class="hero-image">
	  <div class="hero-text">
	    <h1 style="font-size:50px">그래프 제작 <br> 웹 어플리케이션</h1>
	    <h3>Custom Visualization Web Application</h3>
	    <button class="btn">Learn more</button>
	  </div>
	</div>
	
	<div style="height:28px;"></div>
	<section class="panel">
		<div class="panel-body" style="">
			<blockquote class="blockquote-reverse" style="margin:0;">
				<p>Learn from yesterday, live for today, hope for tomorrow. The
					important thing is not to stop questioning.</p>
				<small>A. Einstein, <cite title="Magazine X">Magazine X</cite></small>
			</blockquote>
		</div>
	</section>

<%-- 	<section class="panel">
	<div class="panel-body" style="">
	<%for(StatGraphRateDTO sgrDTO : sgrDTOs) {%>
		<h1><%=sgrDTO.getGraph_title() %></h1>
		<p>댓글 <%=sgrDTO.getRate_count()%></p>
		<p>평점:<%=sgrDTO.getStar_rate()%></p>
		<p>작성날짜:<%=sgrDTO.getReg_date()%></p>
		<img src="<%=sgrDTO.getFile_py_name() %>" class="imgIcon img-circle"> <%=sgrDTO.getUser_name()%>
	<%} %>
	</div>
	</section> --%>
</body>

