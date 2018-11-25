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
	.bg-image {
	  background-image: url("/assets/images/main/mem_main_4.jpg"");
	  background-color: #cccccc;
	  height: 500px;
	  background-position: center;
	  background-repeat: no-repeat;
	  background-size: cover;
	  position: relative;
	}
	
</style>
<script>
	//제목 설정
	$('#pageName').html('메인화면');
	
</script>

<body>

<!-- start: content-body -->
<div class="bg-image">
	<!-- <img src="/assets/images/main/mem_main_4.jpg" class="main_img"/> -->
	<h1>그래프 제작 웹 어플리케이션</h1>
</div> 
<!-- end: content-body -->

<section class="panel">
	<div class="panel-body" style="">
	<%for(StatGraphRateDTO sgrDTO : sgrDTOs) {%>
		<h1><%=sgrDTO.getGraph_title() %></h1>
		<p>댓글 <%=sgrDTO.getRate_count()%></p>
		<p>평점:<%=sgrDTO.getStar_rate()%></p>
		<p>작성날짜:<%=sgrDTO.getReg_date()%></p>
		<img src="<%=sgrDTO.getFile_py_name() %>" class="imgIcon img-circle"> <%=sgrDTO.getUser_name()%>
	<%} %>
	</div>
</section>
</body>

