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

#carousel_section{
    width: 100%;
    background-color: gray;
}
#carousel_section > ul{
    margin: 0px;
    padding: 0px;
    width: 100%;
    height: 100%;
    position: relative;
    overflow: hidden;
}
#carousel_section > ul > li{
    list-style: none;
    width: 100%;
    height: 100%;
    position: absolute;
    border-radius:6px;
}
#carousel_section > ul > li >img{
    list-style: none;
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius:6px;
}

</style>
<script>
	//제목 설정
	$('#pageName').html('메인화면');
	
</script>

<body>
	<!-- start: content-body -->

	<div id="carousel_section">
        <ul>
            <li> <img src="/assets/images/main/mem_main_1.jpg"> </li>
            <li> <img src="/assets/images/main/mem_main_2.jpg"> </li>
            <li> <img src="/assets/images/main/mem_main_3.jpg"> </li>
            <li> <img src="/assets/images/main/mem_main_4.jpg"> </li>
        </ul>
    </div>
    
    <div style="height:28px;"></div>
<!-- 	<div class="hero-image">
	  <div class="hero-text">
	    <h1 style="font-size:50px">그래프 제작 <br> 웹 어플리케이션</h1>
	    <h3>Custom Visualization Web Application</h3>
	    <button class="btn">Learn more</button>
	  </div>
	</div>
	 -->
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
<script>
var time; // 슬라이드 넘어가는 시간
var $carouselLi;
var carouselCount; // 캐러셀 사진 갯수
var currentIndex; // 현재 보여지는 슬라이드 인덱스 값
var caInterval;

//사진 연결
var imgW; // 사진 한장의 너비	
$(document).ready(function(){

	carouselInit(500, 2000);
});

$(window).resize(function(){
	carousel_setImgPosition();
});

/* 초기 설정 */
function carouselInit( height, t ){
	/*
	 * height : 캐러셀 높이
	 * t : 사진 전환 간격 
	*/

	time = t;
	$("#carousel_section").height(height); // 캐너셀 높이 설정
	$carouselLi = $("#carousel_section > ul >li");
	carouselCount = $carouselLi.length; // 캐러셀 사진 갯수
	currentIndex = 0; // 현재 보여지는 슬라이드 인덱스 값
	carousel_setImgPosition();
	carousel();
}

function carousel_setImgPosition(){

	imgW = $carouselLi.width(); // 사진 한장의 너비	
	// 이미지 위치 조정
	for(var i = 0; i < carouselCount; i++)
	{
		if( i == currentIndex)
		{
			$carouselLi.eq(i).css("left", 0);
		}
		else
		{
			$carouselLi.eq(i).css("left", imgW);
		}
	}
}

function carousel(){

	// 사진 넘기기
	// 사진 하나가 넘어간 후 다시 꼬리에 붙어야함
	// 화면에 보이는 슬라이드만 보이기
	caInterval = setInterval(function(){
		var left = "-" + imgW;

		//현재 슬라이드를 왼쪽으로 이동 ( 마이너스 지점 )
		$carouselLi.eq(currentIndex).animate( { left: left }, function(){
			// 다시 오른쪽 (제자리)로 이동
			$carouselLi.eq(currentIndex).css("left", imgW);

			if( currentIndex == ( carouselCount - 1 ) )
			{
				currentIndex = 0;
			}
			else
			{
				currentIndex ++;
			}
		} );

		// 다음 슬라이드 화면으로
		if( currentIndex == ( carouselCount - 1 ) )
		{
			// 마지막 슬라이드가 넘어갈땐 처음 슬라이드가 보이도록
			$carouselLi.eq(0).animate( { left: 0 } );
		}
		else
		{
			$carouselLi.eq(currentIndex + 1).animate( { left: 0 } );
		}
	}, time);
}
</script>
