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
//범주 미 선택시 변수 다시 설정

var resultDataPieChart = [];
var rsltDataJsonPieChart = {};
var resultCategoryPieChart = []; //범주로 들어갈 변수 선언

if($('#factor option:selected').val()==-1) {

	resultData.forEach(item=>{
		rsltDataJsonPieChart = {}; // 배열에 한 행씩 저장될 JSON 선언
		rsltDataJsonPieChart.factor = item.factor; // 각 배열의 첫 번째 열 값을 factor라는 이름으로 저장
		rsltDataJsonPieChart[item.factor] = item[resultCategory.toString()]; //각 배열의 두 번째 열 값을 그 배열의 팩터 값으로 저장
		resultDataPieChart.push(rsltDataJsonPieChart); //최종 배열에 각각의 JSON변수 저장
		
		//범주용 데이터 설정
		resultCategoryPieChart.push(item.factor);
		
	});
	
	resultData = resultDataPieChart;
	resultCategory = resultCategoryPieChart;
}


/*---------파이그래프--------*/
setTimeout(function () {
	
		
	var pieChart = c3.generate({
			bindto: "#pieChartResult",
			data: {
			    json: 
			    	resultData
			    ,
			     keys: {
			       x: 'factor' // it's possible to specify 'x' when category axis
			      ,value: resultCategory
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