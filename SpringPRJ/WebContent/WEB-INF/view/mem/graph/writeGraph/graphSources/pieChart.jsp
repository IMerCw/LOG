<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="pieChartResult"></div>
</body>
<script>

/*---------파이그래프--------*/
setTimeout(function () {
	
	var pieChart = c3.generate({
			bindto: "#pieChartResult",
			data: {
			    json: 
			    	resultData
			    ,
			    keys: {
			       x: 'factor', // it's possible to specify 'x' when category axis
			      value: resultCategory
			    }
			    ,
		        type : 'pie',
		        onclick: function (d, i) { console.log("onclick", d, i); },
		        onmouseover: function (d, i) { console.log("onmouseover", d, i); },
		        onmouseout: function (d, i) { console.log("onmouseout", d, i); }
		    }
		});
		
	
		
},100);

</script>
</html>