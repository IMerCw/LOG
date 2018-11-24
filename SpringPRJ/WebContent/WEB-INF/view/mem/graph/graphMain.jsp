<%@page import="poly.dto.GraphDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	List<GraphDTO> gDTO = (List<GraphDTO>) request.getAttribute("gDTO"); //그래프 리스트  
	Float starRate; //평점
	String graphType; //그래프 타입 전역변수
	String accessRoot = (String) session.getAttribute("accessRoot"); //접근 한 경로 - 마이그래프 / 그래프갤러리
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Load c3.css -->
<link href="/assets/c3Chart/c3.css" rel="stylesheet">
<!-- Load d3.js and c3.js -->
<script src="/assets/d3/d3.v5.js"></script>
<script src="/assets/c3Chart/c3.js"></script>
<script>
<%if (accessRoot.equals("graphGallery")) {%>
	//제목 설정
	$('#pageName').html('그래프 갤러리');
<%} else if(accessRoot.equals("myGraph")) {%>
	$('#pageName').html('내 그래프');
<%}%>
</script>
<style>
	.rating > .fa { color:#ed9c28 }
</style>
</head>
<body>
	<%if (accessRoot.equals("graphGallery")) {%>
	<div class="row">
		<div class="col-md-12">
			<button type="button" class="mb-xs mt-xs mr-xs btn btn-primary" style="float:right; font-size: 20px;" onclick="javascript:callWriteGraphFirstStep()">그래프 작성하기</button>
		</div>
	</div>
	<%} if (gDTO.isEmpty()) {%>
	<div class="container-fluid">
		<h1>작성한 그래프가 없습니다.</h1>
	</div>
	<%} %>
	<div class="row">
		<%for(int i = 0; i < gDTO.size(); i++) {%>
		
		<%-- 그래프를 띄울 div --%>
		<section class="panel col-md-12" onclick="getGraphDetail('<%=gDTO.get(i).getGraph_seq()%>')" style="cursor:pointer;">
			<div class="panel-body">
				<div id="graphSeq<%=gDTO.get(i).getGraph_seq()%>">
									
				</div>
			</div>
			<%-- 그래프 제목 --%>			
			<div class="panel-footer">
				<div class="row" style="font-size:18px;">
					<div class="col-md-12">
						<%=gDTO.get(i).getGraph_title() %>
					</div>
				</div>
				
				<%-- 게시글 정보 --%>
				<div class="row" style="font-size:11px; margin-top: 8px;">
					<div class="col-md-6 rating" style="text-align:left;">
						<%-- 별점 표시 --%>
						<%if(gDTO.get(i).getStar_rate() != null) {%>
							<% starRate = Float.valueOf(gDTO.get(i).getStar_rate()); %>
							<%for(int j = 0; j < 5; j++, starRate--) {%>
								<%if(starRate < 1 && starRate >= 0.5 ) {%>
									<i class="fa fa-star-half-o"></i> 
								<%} else if (starRate <= 0.0 ){ %>
									<i class="fa fa-star-o"></i> 
								<%}else { %>
									<i class="fa fa-star"></i>
								<%} %>
							<%} %>
						<%} else { %>
							별점이 없습니다.
						<%} %>
					</div>
					<div class="col-md-6" style="text-align:right;">
						<img src="<%=gDTO.get(i).getFile_py_name()%>" class="img-circle" style="max-width: 30px; max-height: 32px;">
						&nbsp;&nbsp;
						<%=gDTO.get(i).getUser_name() %>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-12" style="text-align:right;">
						조회수 <%=gDTO.get(i).getRead_count() %> /
						<%=gDTO.get(i).getReg_date() %>
					</div>
				</div>
				
			</div>
		</section>
		
		<%} %>
	</div>
</body>
<script>

	//그래프 작성 1단계 이동
	function callWriteGraphFirstStep() {
		$.ajax({
			type : "GET",
			url : "/mem/graph/writeGraph/firstStep.do",
			dataType: "text",
			error: function() {
				alert("통신실패");
			},
			success: function(data) {
				$('.content-body').html(data);
			}
		})
	}
	
	
	///////////////////////////////////////////////////////////
	/////////////////////////그래프/////////////////////////////
	
	<%for(int i = 0; i <gDTO.size(); i++) {%>	
		<%graphType = gDTO.get(i).getGraph_type();%>
			//JSON 파일 가져오기
			$.getJSON( '/resources/json/<%=gDTO.get(i).getJson_file_name()%>', function(jsonData) {
			
			<%if(graphType.equals("barChart")) {%>
				
				/*--------막대 그래프--------*/
				setTimeout(function () {
					var barChart = c3.generate({
						bindto: "#graphSeq<%=gDTO.get(i).getGraph_seq()%>",
						data: {
						    json: 
						    	jsonData
						    ,
						    keys: {
						       //x: 'factor', // it's possible to specify 'x' when category axis
						       value: ('<%=gDTO.get(i).getResult_cate()%>').split(',')
						    },
							type: 'bar'
						  },
						   axis: {
						    x: {
						       type: 'category',
						       categories:  ('<%=gDTO.get(i).getResult_x()%>').split(',')
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
			<%}%>
		/*------------------------*/
			<%if(graphType.equals("areaChart")) {%>
	
			/*-----------영역 그래프--------*/
	
			var typesJson = {};
			for(var i = 0; i < resultCategory.length; i++) {
				typesJson[resultCategory[i]] = 'area-spline';
			}
			resultCategory
			setTimeout(function () {
				var chart = c3.generate({
					bindto: "#graphSeq<%=gDTO.get(i).getGraph_seq()%>",
					data: {
					    json: 
					    	jsonData
					    ,
					    keys: {
					       x: 'factor', // it's possible to specify 'x' when category axis
					       value: ('<%=gDTO.get(i).getResult_cate()%>').split(',')
					    }
					    ,
					    type: 
					    	typesJson
					  },
					  axis: {
					    x: {
					       type: 'category'
					    }
					  }
				});
			}, 100);
	
			/*------------------------*/
			
			<%}%>
			<%if(graphType.equals("lineChart")) {%>
	
			/*--------라인 그래프--------*/
	
			setTimeout(function () {
				c3.generate({
					bindto: "#graphSeq<%=gDTO.get(i).getGraph_seq()%>",
					
					data: {
					    json: 
					    	jsonData
					    ,
					    keys: {
					       x: 'factor', // it's possible to specify 'x' when category axis
					       value: ('<%=gDTO.get(i).getResult_cate()%>').split(',')
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
			<%}%>
			<%if(graphType.equals("pieChart")) {%>
	
			/*---------파이그래프--------*/
			
			var resultCategory = ('<%=gDTO.get(i).getResult_cate()%>').split(','); 
			
			//범주 미 선택시 변수 다시 설정
			var resultDataPieChart = [];
			var rsltDataJsonPieChart = {};
			var resultCategoryPieChart = []; //범주로 들어갈 변수 선언
			console.log("test");
			console.log(resultCategory);
			console.log(resultCategory.length==1);
			if(resultCategory.length==1) {
			
				jsonData.forEach(item=>{
					rsltDataJsonPieChart = {}; // 배열에 한 행씩 저장될 JSON 선언
					rsltDataJsonPieChart.factor = item.factor; // 각 배열의 첫 번째 열 값을 factor라는 이름으로 저장
					rsltDataJsonPieChart[item.factor] = item[resultCategory.toString()]; //각 배열의 두 번째 열 값을 그 배열의 팩터 값으로 저장
					resultDataPieChart.push(rsltDataJsonPieChart); //최종 배열에 각각의 JSON변수 저장
					
					//범주용 데이터 설정
					resultCategoryPieChart.push(item.factor);
					
				});
				
				jsonData = resultDataPieChart;
				resultCategory = resultCategoryPieChart;
			}
			
			
			
			setTimeout(function () {
				
				var pieChart = c3.generate({
						bindto: "#graphSeq<%=gDTO.get(i).getGraph_seq()%>",
						data: {
						    json: 
						    	jsonData
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
	
			<%}%>
			<%if(graphType.equals("scatterChart")) {%>
	
			/*-----------점 그래프--------*/
			setTimeout(function () {
				var scatterChart = c3.generate({
					bindto: "#graphSeq<%=gDTO.get(i).getGraph_seq()%>",
					data: {
						  json:	
							  jsonData
						  ,
						    keys: {
						       x: 'factor', // it's possible to specify 'x' when category axis
						      value: ('<%=gDTO.get(i).getResult_cate()%>').split(',')	
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
			<%}%>
		});
	<%}%>
	
	
	//그래프 게시글 상세보기
	function getGraphDetail(graphSeq) {
		//게시글 조회수 1 증가
		$.ajax({
			type : "POST",
			url : "/mem/graph/incrementCount.do",
			dataType: "text",
			data : {
				graph_seq: graphSeq
			},
			error: function() {
				alert("통신실패");
			},
			success: function(data) {
				console.log("increment count result: " + data);
			}
		})
		//게시글 상세 접근
		$.ajax({
			type : "POST",
			url : "/mem/graph/readGraph.do",
			dataType: "text",
			data : {
				graph_seq: graphSeq
			},
			error: function() {
				alert("통신실패");
			},
			success: function(data) {
				$('.content-body').html(data);
			}
		})
	}
</script>
</html>