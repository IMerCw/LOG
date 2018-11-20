<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="barChartResult"></div>
</body>
<script>
/*--------막대 그래프--------*/	
setTimeout(function () {
	var barChart = c3.generate({
		bindto: "#barChartResult",
		data: {
		    json: 
		    	resultData
		    ,
		    keys: {
		       //x: 'factor', // it's possible to specify 'x' when category axis
		       value: resultCategory
		    },
			type: 'bar'
		  },
		   axis: {
		    x: {
		       type: 'category',
		       categories: resultXItem
		    }
		  },
	    bar: {
	        width: {
	            ratio: 0.5 // this makes bar width 50% of length between ticks
	        }
	        // or
	        //width: 100 // this makes bar width 100px
	    }
	
	    
	});
	
}, 100);

/*------------------------*/
</script>
</html>