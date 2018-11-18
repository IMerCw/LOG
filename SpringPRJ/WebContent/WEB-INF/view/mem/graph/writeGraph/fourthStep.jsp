<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String graphSelect = (String) request.getParameter("graphSelect"); //그래프 종류
%>

<html>
<head>
	<!-- Load c3.css -->
	<link href="/assets/c3Chart/c3.css" rel="stylesheet">
	<!-- Load d3.js and c3.js -->
	<script src="/assets/d3/d3.v5.js"></script>
	<script src="/assets/c3Chart/c3.js"></script>
</head>
<body>

<div id="<%=graphSelect%>"></div>

<%if(graphSelect.equals("lineChart")){ %>
	<%@include file="/WEB-INF/view/mem/graph/writeGraph/graphSources/lineChart.jsp" %>
<%} else if (graphSelect.equals("barChart")) {%>
	<%@include file="/WEB-INF/view/mem/graph/writeGraph/graphSources/barChart.jsp" %>
<%} else if (graphSelect.equals("pieChart")) {%>
	<%@include file="/WEB-INF/view/mem/graph/writeGraph/graphSources/pieChart.jsp" %>
<%} else if (graphSelect.equals("scatterChart")) {%>
	<%@include file="/WEB-INF/view/mem/graph/writeGraph/graphSources/scatterChart.jsp" %>
<%} else if (graphSelect.equals("areaChart")) {%>
	<%@include file="/WEB-INF/view/mem/graph/writeGraph/graphSources/areaChart.jsp" %>
<%} %>

<body>

<script>
	
	var data =  d3.csv("/public_data/전국무더위쉼터표준데이터.csv", function(csv_data) {
		
		return {
			
			소재지도로명주소: csv_data.소재지도로명주소.split(' ')[0], //x축
			소재지지번주소: csv_data.소재지지번주소.split(' ')[0], //x축
			이용가능인원수 : +csv_data.이용가능인원수
			
		};
		
	}).then(function(data){
		
		
		var nestedData = d3.nest()
		
		 	.key(function(d) { 
		 		
		  		if(d.소재지도로명주소 == '') {
		  			
		  			return d.소재지지번주소;
		  			
		  		}else{
		  			
		  			return d.소재지도로명주소;	
		  		}
		  	
			})
		 	.rollup(function(v) { return d3.sum(v, function(d){ return Math.ceil(d.이용가능인원수); })})
		 	.entries(data);
		
		var dataCols = [];
		
		for(var i = 0; i < nestedData.length; i++) {
			var dataCol = [];
			dataCol.push(nestedData[i].key);
			dataCol.push(nestedData[i].value);
			dataCols.push(dataCol);
		}
		
		console.log(nestedData);
		console.log(dataCols);
		
	});
	/* 

	function doroAddress(addr) {
		
		
		'서울특별시'
		'부산광역시'
		'대구광역시'
		'인천광역시'
		'광주광역시'
		'대전광역시'
		'울산광역시'
		'경기도'
		'강원도'
		'충청북도'
		'충청남도'
		'전라북도'
		'전라남도'
		'경상북도'
		'경상남도'
		'제주특별자치도'
	}*/

	
	

</script>
	
</html>