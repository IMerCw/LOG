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
</head>
<style>
	.portlet-handler {
		cursor:pointer;
	}
	.c3 {
		cursor:pointer;
	}
</style>
<body>
	<div class="row" style="padding:20px 0"></div>
	
	<div class="row">
	
		<div class="col-md-6 col-sm-12">
			<section class="panel" id="lineChartSelect" data-portlet-item="">
				<header class="panel-heading portlet-handler">
			
					<h2 class="panel-title">라인 그래프</h2>
				</header>
				<div class="panel-body">
				
					<div id="linechart"></div>
					
				</div>
			</section>
		</div>
		
		<div class="col-md-6 col-sm-12">
			<section class="panel" id="barChartSelect" data-portlet-item="">
				<header class="panel-heading portlet-handler">
					<h2 class="panel-title">막대 그래프</h2>
				</header>
				<div class="panel-body">
					<div id="barChart"></div>
				</div>
			</section>
		</div>
	
		<div class="col-md-6 col-sm-12">
			<section class="panel" id="pieChartSelect" data-portlet-item="">
				<header class="panel-heading portlet-handler">
					<h2 class="panel-title">파이 그래프</h2>
				</header>
				<div class="panel-body">
					<div id="pieChart"></div>
				</div>
			</section>
		</div>
		
		<div class="col-md-6 col-sm-12">
			<section class="panel" id="scatterChartSelect" data-portlet-item="">
				<header class="panel-heading portlet-handler">
					<h2 class="panel-title">점 그래프</h2>
				</header>
				<div class="panel-body">
					<div id="scatterChart"></div>
				</div>
			</section>
			
			
		</div>

	
		<div class="col-md-6 col-sm-12">
			<section class="panel" id="areaChartSelect" data-portlet-item="">
				<header class="panel-heading portlet-handler">
					<h2 class="panel-title">영역 그래프</h2>
				</header>
				<div class="panel-body">
					<div id="areaChart"></div>
				</div>
			</section>
		</div>
		
		<div class="col-md-6 col-sm-12">
			
		</div>
		
	</div>
	
</body>

<script>

//클릭 이벤트

$('#lineChartSelect').click(function() {
	alert("라인그래프 선택");
	callFourthStep('lineChart');
});
$('#barChartSelect').click(function() {
	alert("바그래프 선택");	
	callFourthStep('barChart');
});
$('#pieChartSelect').click(function() {
	alert("파이그래프 선택");
	callFourthStep('pieChart');
});
$('#scatterChartSelect').click(function() {
	alert("점 그래프 선택");
	callFourthStep('scatterChart');
});
$('#areaChartSelect').click(function() {
	alert("영역그래프 선택");
	callFourthStep('areaChart');
});

//해당 그래프 페이지 이동

//그래프 이동
function callFourthStep(graphSelect) {
		$.ajax({
			type : "GET",
			url : "/mem/graph/writeGraph/FourthStep.do",
			dataType: "text",
			data : {graphSelect : graphSelect},
			error: function() {
				alert("통신실패");
			},
			success: function(data) {
				$('#w4-confirm').html(data);
				$('.next').click();
			}
		})
	}
	
/*--------라인 그래프--------*/

setTimeout(function () {
	var lineChart = c3.generate({
		bindto: "#linechart",
	
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
	            ['data3', 400, 500, 450, 700, 600, 500]
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

/*------------------------*/	


/*--------막대 그래프--------*/	
setTimeout(function () {
	var barChart = c3.generate({
		bindto: "#barChart",
	    data: {
	        columns: [
	           
	        ],
	        type: 'bar'
	    },
	    bar: {
	        width: {
	            ratio: 0.5 // this makes bar width 50% of length between ticks
	        }
	        // or
	        //width: 100 // this makes bar width 100px
	    }
	
	    
	});
	setTimeout(function () {
		barChart.load({
	        columns: [
	        	 ['data1', 30, 200, 100, 400, 150, 250],
	             ['data2', 130, 100, 140, 200, 150, 50]
	        ]
	    });
	}, 2000);
}, 100);

/*------------------------*/

/*---------파이그래프--------*/
setTimeout(function () {
	
	var pieChart = c3.generate({
			bindto: "#pieChart",
		    data: {
		        // iris data from R
		        columns: [
		            ['data1', 30],
		            ['data2', 120],
		        ],
		        type : 'pie',
		        onclick: function (d, i) { console.log("onclick", d, i); },
		        onmouseover: function (d, i) { console.log("onmouseover", d, i); },
		        onmouseout: function (d, i) { console.log("onmouseout", d, i); }
		    }
		});
		
		setTimeout(function () {
			pieChart.load({
		        columns: [
		            ["setosa", 0.2, 0.2, 0.2, 0.2, 0.2, 0.4, 0.3, 0.2, 0.2, 0.1, 0.2, 0.2, 0.1, 0.1, 0.2, 0.4, 0.4, 0.3, 0.3, 0.3, 0.2, 0.4, 0.2, 0.5, 0.2, 0.2, 0.4, 0.2, 0.2, 0.2, 0.2, 0.4, 0.1, 0.2, 0.2, 0.2, 0.2, 0.1, 0.2, 0.2, 0.3, 0.3, 0.2, 0.6, 0.4, 0.3, 0.2, 0.2, 0.2, 0.2],
		            ["versicolor", 1.4, 1.5, 1.5, 1.3, 1.5, 1.3, 1.6, 1.0, 1.3, 1.4, 1.0, 1.5, 1.0, 1.4, 1.3, 1.4, 1.5, 1.0, 1.5, 1.1, 1.8, 1.3, 1.5, 1.2, 1.3, 1.4, 1.4, 1.7, 1.5, 1.0, 1.1, 1.0, 1.2, 1.6, 1.5, 1.6, 1.5, 1.3, 1.3, 1.3, 1.2, 1.4, 1.2, 1.0, 1.3, 1.2, 1.3, 1.3, 1.1, 1.3],
		            ["virginica", 2.5, 1.9, 2.1, 1.8, 2.2, 2.1, 1.7, 1.8, 1.8, 2.5, 2.0, 1.9, 2.1, 2.0, 2.4, 2.3, 1.8, 2.2, 2.3, 1.5, 2.3, 2.0, 2.0, 1.8, 2.1, 1.8, 1.8, 1.8, 2.1, 1.6, 1.9, 2.0, 2.2, 1.5, 1.4, 2.3, 2.4, 1.8, 1.8, 2.1, 2.4, 2.3, 1.9, 2.3, 2.5, 2.3, 1.9, 2.0, 2.3, 1.8],
		        ]
		    });
		}, 1500);
		
		setTimeout(function () {
			pieChart.unload({
		        ids: 'data1'
		    });
			pieChart.unload({
		        ids: 'data2'
		    });
		}, 2500);
		
},100);

/*-----------점 그래프--------*/
setTimeout(function () {
	var scatterChart = c3.generate({
		bindto: "#scatterChart",
		data: {
		      xs: {
		          setosa: 'setosa_x',
		          versicolor: 'versicolor_x',
		      },
		      // iris data from R
		      columns: [
		          ["setosa_x", 3.5, 3.0, 3.2, 3.1, 3.6, 3.9, 3.4, 3.4, 2.9, 3.1, 3.7, 3.4, 3.0, 3.0, 4.0, 4.4, 3.9, 3.5, 3.8, 3.8, 3.4, 3.7, 3.6, 3.3, 3.4, 3.0, 3.4, 3.5, 3.4, 3.2, 3.1, 3.4, 4.1, 4.2, 3.1, 3.2, 3.5, 3.6, 3.0, 3.4, 3.5, 2.3, 3.2, 3.5, 3.8, 3.0, 3.8, 3.2, 3.7, 3.3],
		          ["versicolor_x", 3.2, 3.2, 3.1, 2.3, 2.8, 2.8, 3.3, 2.4, 2.9, 2.7, 2.0, 3.0, 2.2, 2.9, 2.9, 3.1, 3.0, 2.7, 2.2, 2.5, 3.2, 2.8, 2.5, 2.8, 2.9, 3.0, 2.8, 3.0, 2.9, 2.6, 2.4, 2.4, 2.7, 2.7, 3.0, 3.4, 3.1, 2.3, 3.0, 2.5, 2.6, 3.0, 2.6, 2.3, 2.7, 3.0, 2.9, 2.9, 2.5, 2.8],
		          ["setosa", 0.2, 0.2, 0.2, 0.2, 0.2, 0.4, 0.3, 0.2, 0.2, 0.1, 0.2, 0.2, 0.1, 0.1, 0.2, 0.4, 0.4, 0.3, 0.3, 0.3, 0.2, 0.4, 0.2, 0.5, 0.2, 0.2, 0.4, 0.2, 0.2, 0.2, 0.2, 0.4, 0.1, 0.2, 0.2, 0.2, 0.2, 0.1, 0.2, 0.2, 0.3, 0.3, 0.2, 0.6, 0.4, 0.3, 0.2, 0.2, 0.2, 0.2],
		          ["versicolor", 1.4, 1.5, 1.5, 1.3, 1.5, 1.3, 1.6, 1.0, 1.3, 1.4, 1.0, 1.5, 1.0, 1.4, 1.3, 1.4, 1.5, 1.0, 1.5, 1.1, 1.8, 1.3, 1.5, 1.2, 1.3, 1.4, 1.4, 1.7, 1.5, 1.0, 1.1, 1.0, 1.2, 1.6, 1.5, 1.6, 1.5, 1.3, 1.3, 1.3, 1.2, 1.4, 1.2, 1.0, 1.3, 1.2, 1.3, 1.3, 1.1, 1.3],
		      ],
		      type: 'scatter'
		  },
		   axis: {
		        x: {
		            label: 'Sepal.Width',
		            tick: {
		                fit: false
		            }
		        },
		        y: {
		            label: 'Petal.Width'
		        }
		    }
		});
	
		setTimeout(function () {
			scatterChart.load({
		        xs: {
		            virginica: 'virginica_x'
		        },
		        columns: [
		            ["virginica_x", 3.3, 2.7, 3.0, 2.9, 3.0, 3.0, 2.5, 2.9, 2.5, 3.6, 3.2, 2.7, 3.0, 2.5, 2.8, 3.2, 3.0, 3.8, 2.6, 2.2, 3.2, 2.8, 2.8, 2.7, 3.3, 3.2, 2.8, 3.0, 2.8, 3.0, 2.8, 3.8, 2.8, 2.8, 2.6, 3.0, 3.4, 3.1, 3.0, 3.1, 3.1, 3.1, 2.7, 3.2, 3.3, 3.0, 2.5, 3.0, 3.4, 3.0],
		            ["virginica", 2.5, 1.9, 2.1, 1.8, 2.2, 2.1, 1.7, 1.8, 1.8, 2.5, 2.0, 1.9, 2.1, 2.0, 2.4, 2.3, 1.8, 2.2, 2.3, 1.5, 2.3, 2.0, 2.0, 1.8, 2.1, 1.8, 1.8, 1.8, 2.1, 1.6, 1.9, 2.0, 2.2, 1.5, 1.4, 2.3, 2.4, 1.8, 1.8, 2.1, 2.4, 2.3, 1.9, 2.3, 2.5, 2.3, 1.9, 2.0, 2.3, 1.8],
		        ]
		    });
		}, 1000);
	
		setTimeout(function () {
			scatterChart.unload({
		        ids: 'setosa'
		    });
		}, 2000);
	
		setTimeout(function () {
			scatterChart.load({
		        columns: [
		            ["virginica", 0.2, 0.2, 0.2, 0.2, 0.2, 0.4, 0.3, 0.2, 0.2, 0.1, 0.2, 0.2, 0.1, 0.1, 0.2, 0.4, 0.4, 0.3, 0.3, 0.3, 0.2, 0.4, 0.2, 0.5, 0.2, 0.2, 0.4, 0.2, 0.2, 0.2, 0.2, 0.4, 0.1, 0.2, 0.2, 0.2, 0.2, 0.1, 0.2, 0.2, 0.3, 0.3, 0.2, 0.6, 0.4, 0.3, 0.2, 0.2, 0.2, 0.2],
		        ]
		    });
		}, 3000);
}, 100);		

/*------------------------*/
	

/*-----------영역 그래프--------*/
setTimeout(function () {
	var chart = c3.generate({
		bindto: "#areaChart",
	    data: {
	        columns: [
	            ['data1', 300, 350, 300, 0, 0, 0],
	            ['data2', 130, 100, 140, 200, 150, 50]
	        ],
	        types: {
	            data1: 'area',
	            data2: 'area-spline'
	        }
	    }
	});
}, 100);

/*------------------------*/

</script>
	
</html>