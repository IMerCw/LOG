<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="scatterChartResult"></div>
</body>
<script>

/*-----------점 그래프--------*/
setTimeout(function () {
	var scatterChart = c3.generate({
		bindto: "#scatterChartResult",
		data: {
			  json:	resultData
			  ,
			    keys: {
			       x: 'factor', // it's possible to specify 'x' when category axis
			      value: resultCategory
			    }
			  ,
		      type: 'scatter'
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