<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="/assets/d3/d3.v5.js"></script>
	
	<!-- Resources -->
	<script src="/assets/amChart/amcharts.js"></script>
	<script src="/assets/amChart/serial.js"></script>
	<script src="/assets/amChart/export.min.js"></script>
	<link rel="stylesheet" href="/assets/amChart/export.css" type="text/css" media="all" />
	<script src="/assets/amChart/light.js"></script>
	
	<style> 
	#canvas rect { fill: steelblue } 
	
	#chartdiv {
		width		: 100%;
		height		: 500px;
		font-size	: 11px;
	}					
	</style>


</head>
<body>
<!-- 	<svg id="canvas" width="100%" height="100%">
		<g id="yaxis"></g>
  		<g id="xaxis"></g>
	</svg> -->

	<!-- HTML -->
	<div id="chartdiv"></div>	
</body>

<script>
	//그래프 너비, 높이 지정
	var width = window.innerWidth / 2.5;
	var height = 380;
	
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
			
		
		console.log(nestedData);
		
	/* 	//y축의 최대값
		var maxVal = d3.max(nestedData, function(d) {return d.value;});
		
		//x값 스케일
		var x = d3.scaleLinear()
		.domain([0,6])
	    .range([0,width]);
		
	    //y값 스케일
		var y = d3.scaleLinear()
			.domain([0,maxVal])
		    .range([height,0]);
		
	    //x축
	    xAxis = g => g
		    .attr("transform", `translate(0,${height - margin.bottom})`)
		    .call(d3.axisBottom(x)
		        .tickSizeOuter(0))
		        
		//y축
		var yscale = d3.scaleLinear()
	  		.domain([0, maxVal]) //실제값의 범위
	    	.range([height - 20, 0 + 20]); //변환할 값의 범위(역으로 처리했음!), 위아래 패딩 20을 줬다!
		
		    
		//그래프 띄우기
		d3.select("#canvas")
			.attr("width", width)
		    .attr("height", height)
			.selectAll("rect")
			.data(nestedData)
		    .enter().append("rect")
		    .attr("width", 19)
		    .attr("height",function(d) { return height - y(d.value); })
		    .attr("x",function(d,i) { return x(i); })
		    .attr("y",function(d) { return y(d.value); });
		
		
		//y축 그리기
		d3.select("#yaxis")
			.attr('transform', 'translate(50, 0)') //살짝 오른쪽으로 밀고
		    .call(d3.axisLeft(yscale)); //축함수를 넘기면 알아서 그려줌.
			 */
		    
	/* 
		d3.select("#canvas")
			.selectAll("rect")
		  	.data(nestedData)
			.enter()
		 	.append("rect")
		   	.style("fill", "steelblue")
		   	.attr("height", function(d) { return heightScale(d.value); })
		   	.attr("width", 30)
		   	.attr("x", function(d,i) { return i * 40; });  */
	
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
	}
*/
</script>
	<!-- Chart code -->
	<script>
	var chart = AmCharts.makeChart( "chartdiv", {
	  "type": "serial",
	  "theme": "light",
	  "dataProvider": [ {
	    "country": "USA",
	    "visits": 2025
	  }, {
	    "country": "China",
	    "visits": 1882
	  }, {
	    "country": "Japan",
	    "visits": 1809
	  }, {
	    "country": "Germany",
	    "visits": 1322
	  }, {
	    "country": "UK",
	    "visits": 1122
	  }, {
	    "country": "France",
	    "visits": 1114
	  }, {
	    "country": "India",
	    "visits": 984
	  }, {
	    "country": "Spain",
	    "visits": 711
	  }, {
	    "country": "Netherlands",
	    "visits": 665
	  }, {
	    "country": "Russia",
	    "visits": 580
	  }, {
	    "country": "South Korea",
	    "visits": 443
	  }, {
	    "country": "Canada",
	    "visits": 441
	  }, {
	    "country": "Brazil",
	    "visits": 395
	  } ],
	  "valueAxes": [ {
	    "gridColor": "#FFFFFF",
	    "gridAlpha": 0.2,
	    "dashLength": 0
	  } ],
	  "gridAboveGraphs": true,
	  "startDuration": 1,
	  "graphs": [ {
	    "balloonText": "[[category]]: <b>[[value]]</b>",
	    "fillAlphas": 0.8,
	    "lineAlpha": 0.2,
	    "type": "column",
	    "valueField": "visits"
	  } ],
	  "chartCursor": {
	    "categoryBalloonEnabled": false,
	    "cursorAlpha": 0,
	    "zoomable": false
	  },
	  "categoryField": "country",
	  "categoryAxis": {
	    "gridPosition": "start",
	    "gridAlpha": 0,
	    "tickPosition": "start",
	    "tickLength": 20
	  },
	  "export": {
	    "enabled": true
	  }

	} );
	</script>

</html>