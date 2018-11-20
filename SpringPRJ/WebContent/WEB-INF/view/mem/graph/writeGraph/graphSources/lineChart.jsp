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
	<div id="lineChartResult"></div>
</body>
<script>

/*--------라인 그래프--------*/

setTimeout(function () {
	c3.generate({
		bindto: "#lineChartResult",
		
		data: {
		    json: 
		    	resultData
		    ,
		    keys: {
		       x: 'factor', // it's possible to specify 'x' when category axis
		      value: resultCategory
		    }
		  },
		  axis: {
		    x: {
		       type: 'category'
		    }
		  }

	})
}, 100);

/*------------------------*/	



</script>
</html>