<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- Load c3.css -->
<link href="/assets/c3Chart/c3.css" rel="stylesheet">
<!-- Load d3.js and c3.js -->
<script src="/assets/d3/d3.v5.js"></script>
<script src="/assets/c3Chart/c3.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body>

</body>
<script>

setTimeout(function () {
	var lineChart = c3.generate({
		bindto: "#lineChart",
	
	    data: {
	        x: 'x',
	      		xFormat: '%Y%m%d', // 'xFormat' can be used as custom format of 'x'
	        columns: [
	          
	           
	        ]
	    },
	    axis: {
	        x: {
	            type: 'timeseries',
	            tick: {
	                format: '%Y-%m-%d'
	            }
	        }
	    }
	});
	
	setTimeout(function () {
	    lineChart.load({
	        columns: [
	        	['x', '2013-01-01', '2013-01-02', '2013-01-03', '2013-01-04', '2013-01-05', '2013-01-06'],
		        ['x', '20130101', '20130102', '20130103', '20130104', '20130105', '20130106'],
	        ]
	    });
	}, 1000);
	
	setTimeout(function () {
	    lineChart.load({
	        columns: [
	        	 ['data1', 30, 200, 100, 400, 150, 250],
	             ['data2', 130, 340, 200, 500, 250, 350]
	        ]
	    });
	}, 2000);
	
}, 100);



</script>
</html>