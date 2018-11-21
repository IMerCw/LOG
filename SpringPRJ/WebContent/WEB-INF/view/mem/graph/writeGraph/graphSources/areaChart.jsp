<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="areaChartResult"></div>
</body>
<script>

/*-----------영역 그래프--------*/

setTimeout(function () {
	var chart = c3.generate({
		bindto: "#areaChartResult",
		data: {
		    json: 
		    	resultData
		    ,
		    keys: {
		       x: 'factor', // it's possible to specify 'x' when category axis
		       value: resultCategory
		    }
		    ,
		    types : {
		    	factor: 'area-spline'
		    }
		  },
		  axis: {
		    x: {
		       type: 'category'
		    }
		  }
	});
}, 100);

/*------------------------*/

</script>
</html>