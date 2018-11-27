<%@page import="java.util.List"%>
<%@page import="poly.dto.PublicDataDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	//공공데이터 가져오기
	PublicDataDTO pdDTO = (PublicDataDTO) request.getAttribute("pdDTO");
	//csv list
	List<List<String>> csvResult = (List<List<String>>) request.getAttribute("csvResult");
	//헤더 항목 선택을 위한 인덱스
	int i;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/assets/d3/d3.v5.js"></script>
<style>
	.headerSubject{
		font-size:18px;
		font-weight:bold;
		padding:10px 0;
	}
	.radio-custom {
		display:inline-block;
	    font-size: 18px;
	    padding: 0 24px;
	}
</style>
</head>
		<div class="container-fluid">
			<div class="row">
				<button type="button" class="btn btn-primary" onclick="callWriteGraphThirdStep();" style="width: 100%;  margin: 20px 0; font-size: 18px;">선택 완료</button>
			</div>
			
			<!-- Header 목록 -->
			<div class="row" id="headerList">
			
				<!-- X축 선택 박스 -->
				<blockquote class="success">
				
					<div class="headerSubject">X축 선택</div>
					
					<select class="form-control input-lg mb-md" id="xAxis">
						<%i = 0; %>
							<option value='' selected disabled hidden>X축 선택</option>	
						<% for ( String item : csvResult.get(0)) {%>
							<option value="<%=i%>"><%=item%></option>
							<%i++;%>
						<%}%>
					</select>
					
					<div id="xAxisDataList" style="padding-left: 20px;">
					</div>
					
				</blockquote>
				
				<!-- Y축 선택 박스 -->
				<blockquote class="danger">
				
					<div class="headerSubject">Y축 선택</div>
					
					<select class="form-control input-lg mb-md" id="yAxis">	
						<%i = 0; %>	
						<option value='' selected disabled hidden>Y축 선택</option>
						<% for ( String item : csvResult.get(0)) {%>
							<option value="<%=i%>"><%=item%></option>
							<%i++;%>
						<%}%>
					</select>
					
					<div id="yAxisDataList" style="padding-left: 20px;">
					</div>
					
				</blockquote>
				
				<!-- 범주 선택 박스 -->
				<blockquote class="warning">
				
					<div class="headerSubject">범주 선택(선택사항)</div>
					
					<select class="form-control input-lg mb-md" id="factor">	
						<option value='-1' selected disabled hidden>범주 선택</option>
						<option value='-1'>선택하지 않음</option>
						<%i = 0; %>	
						<% for ( String item : csvResult.get(0)) {%>
							<option value="<%=i%>"><%=item%></option>
							<%i++;%>
						<%}%>
					</select>
					
					<div id="factorDataList" style="padding-left: 20px;">
					</div>
				</blockquote>
			
			</div>
			
	<!-- 데이터 요약 -->
	<hr/>
	<div class="row">
	
		<div class="col-sm-12" style="font-size:16px; font-weight:bold; padding:0 0 12px 12px;">
			데이터 요약 통계 함수 선택
		</div>
		
		<div class="col-sm-12 radioBox">
			<div class="radio-custom">
				<input type="radio" value="합계" id="aggSum" name="aggregation">
				<label for="aggSum">합계</label>
			</div>

			<div class="radio-custom radio-primary">
				<input type="radio" value="평균" id="aggMean" name="aggregation">
				<label for="aggMean">평균</label>
			</div>

			<div class="radio-custom radio-success">
				<input type="radio" value="최대값" id="aggMax" name="aggregation">
				<label for="aggMax">최대값</label>
			</div>

			<div class="radio-custom radio-warning">
				<input type="radio" value="최소값" id="aggMin" name="aggregation">
				<label for="aggMin">최소값</label>
			</div>
			
		</div>
	</div>
		
	<button type="button" class="btn btn-info" onclick="displaySelectResult();" style="width: 100%;  margin: 20px 0; font-size: 16px;">데이터 미리보기</button>
			
			
 			<!-- 선택된 데이터 보기 -->
		<div class="row" id="displayDataResult">
		</div>
			
	</div>
		
</body>

<script>

//x축 데이터 미리보기
$('#xAxis').change(function(){
	
	var selectedItemX = $('#xAxis option:selected').text(); //선택된 변수 이름
	
	var data =  d3.csv('/public_data/' + '<%=pdDTO.getFile_name()%>', function(csv_data) {
		
		return { 
			[selectedItemX] : csv_data[selectedItemX] 
		}
		
	}).then(function(data) {
		
		var contents = '';
		
		for(var i = 0; i < 5; i ++) {
			contents += data[i][selectedItemX] + '<br>';
		}
		
		contents += '...';
		
		$('#xAxisDataList').html(contents);
		
	});
});

//y축 데이터 미리보기
$('#yAxis').change(function(){
	
	var selectedItemY = $('#yAxis option:selected').text(); //선택된 변수 이름
	
	var data =  d3.csv('/public_data/' + '<%=pdDTO.getFile_name()%>', function(csv_data) {
		
		return { [selectedItemY] : csv_data[selectedItemY] }
		
	}).then(function(data) {
		
		var contents = '';
		
		for(var i = 0; i < 5; i ++) {
			contents += data[i][selectedItemY] + '<br>';
		}
		contents += '...';
		
		$('#yAxisDataList').html(contents);
		
	});
});

//범주 데이터 미리보기
$('#factor').change(function(){
	var selectedItemFactor = $('#factor option:selected').text(); //선택된 변수 이름
	var selectedItemFactorVal = $('#factor option:selected').val(); //선택된 변수 이름
	if(selectedItemFactorVal == -1) {
		return $('#factorDataList').html('선택하지 않았습니다.');
	}
	
	var data =  d3.csv('/public_data/' + '<%=pdDTO.getFile_name()%>', function(csv_data) {
		
		return { [selectedItemFactor] : csv_data[selectedItemFactor] }
		
	}).then(function(data) {
		
		var contents = '';
		
		for(var i = 0; i < 5; i ++) {
			contents += data[i][selectedItemFactor] + '<br>';
		}
		contents += '...';
		
		$('#factorDataList').html(contents);
		
	});
});

var resultData = []; //그래프로 띄울 ARRAY 변수
var resultXItem = []; //최종데이터 X 값 Array //중복이 없으므로 set 형식
var resultFactorItem = new Set(); //최종데이터 X 값 Array //중복이 없으므로 set 형식
var resultCategory = []; //최종 데이터의 X값 카테고리
////////////////////////////////////////////////
 
	//데이터 미리보기함수
	function displaySelectResult() {
	
		resultData = []; //그래프로 띄울 ARRAY 변수
		resultXItem = []; //최종데이터 X 값 Array //중복이 없으므로 set 형식
		resultFactorItem = new Set(); //최종데이터 X 값 Array //중복이 없으므로 set 형식
		resultCategory = []
		
		
		var selectedItemX = $('#xAxis option:selected').text();
		var selectedItemY = $('#yAxis option:selected').text();
		var selectedItemFactor = $('#factor option:selected').text();
		var selectedItemFactorVal = $('#factor option:selected').val();
					
		//데이터 정제		
		var dataSource = '/public_data/' + '<%=pdDTO.getFile_name()%>';
		
		var data =  d3.csv(dataSource, function(csv_data) {
			
				return {
					
					[selectedItemX] : csv_data[selectedItemX], //x축 기준 aggregation
					[selectedItemY] : csv_data[selectedItemY], //y축 기준 aggregation
					[selectedItemFactor] : csv_data[selectedItemFactor] //범주 aggregation
					
				}
				
			}).then(function(data){
				
				var nestedData = d3.nest()
					

					
					//Aggregation Key Setting / X값 어떤 키를 기준으로 잡을 것인가
				 	.key(function(d) {
						var slctdItmX = d[selectedItemX];  
							
						if(slctdItmX != '' && /\s/g.test(slctdItmX)) {
				 			
							return slctdItmX.split(' ')[0];
							
				 		}else {
				 			
				 			return slctdItmX;
				 			
				 		}	
						
					}).sortKeys(d3.ascending) //Key 오름차순 정렬
					
					//Aggregation Key Setting / 범주 어떤 키를 기준으로 잡을 것인가
				 	.key(function(d) {
				 		
				 		var slctdItmFctr = d[selectedItemFactor];
					 		
				 		if(slctdItmFctr != '' && /\s/g.test(slctdItmFctr)) {
				 			
							return slctdItmFctr.split(' ')[0];
							
				 		}else {
				 			
				 			return slctdItmFctr;
				 			
				 		}					 			
					}) 
					
					//Aggregation Y-values By Key / 기준 키를 가지고 데이터를 요약
				 	.rollup(function(v) {
				 		
				 		var aggFunc = $('.radioBox input:checked').val(); //선택된 요약 함수
				 		
				 		if(aggFunc == "합계") {
					 		
				 			return d3.sum(v, function(d){ return parseInt(d[selectedItemY]); })
					 		
				 		} else if (aggFunc == "평균") {
				 			
				 			var temp = d3.mean(v, function(d){ return (d[selectedItemY]); });
				 			
					 		return (Math.round(temp * 100) / 100);  
					 		
				 		} else if (aggFunc == "최대값") {
				 			
					 		return d3.max(v, function(d){ return parseInt(d[selectedItemY]); })
				 			
				 		} else if (aggFunc == "최소값") {
				 		
					 		return d3.min(v, function(d){ return parseInt(d[selectedItemY]); })
				 		
				 		}
				 	})
				 	
				 	//최종 입력
				 	.entries(data);
				
				//최종 데이터
				console.log(nestedData);
				
				
				//그래프로 띄울 리스트에 들어가는 각 행 json
				var rsltJson = {};
				
				for(var i = 0; i < nestedData.length; i++) {
					//범주 데이터 어레이 저장					
					if(nestedData[i].key == '') continue;
					
					rsltJson = {}; //결과 데이터 JSON선언
					rsltJson.factor = nestedData[i].key; //factor이름에 key값 저장 
					
					//X 데이터 어레이 값 저장
					for(var j = 0; j < nestedData[i].values.length; j++) {
						
						if(nestedData[i].values[j].key == '') continue;
						
						else if(nestedData[i].values[j].key == 'undefined') {
							//범주 미 선택시 합계함수 이름을 저장
							rsltJson[$('.radioBox input:checked').val()] = nestedData[i].values[j].value;
						}
						else {
							rsltJson[nestedData[i].values[j].key] = nestedData[i].values[j].value;
						}
					}
					
					resultData.push(rsltJson); //그래프로 띄울 각 행의 값을 최종 데이터 어레이에 저장
				}
				
				for(var i = 0; i < nestedData.length; i++) {
					resultXItem.push(nestedData[i].key);
					for(var j = 0; j < nestedData[i].values.length; j++) {
						if(nestedData[i].values[j].key === '') continue;
						resultFactorItem.add(nestedData[i].values[j].key);
					}
				}
				
				//범주 미 선택시 합계요약 함수를 범주로 저장
				if(resultFactorItem.has("undefined")){
					var aggFunc = $('.radioBox input:checked').val(); //선택된 요약 함수
			 		
					resultCategory.push(aggFunc);
					
				} 
				else {
					resultCategory = Array.from(resultFactorItem);
				}
				
				console.log(resultCategory); //범주에 들어갈 데이터
				console.log(resultData);
 
				
				
				/////////////////미리보기 표시//////////////
				var contents = '';
				contents += '<h4>선택된 범주 값 목록: </h4>';
				contents += '<p>';
				
				if(selectedItemFactorVal==-1) {
					
					contents += '선택하지 않았습니다.';
				}
				
				else {
					resultCategory.forEach(item => {
					
						contents += item + ', ';	
					
					});
				}
				contents += '</p>';
				
				
				contents += '<h4>선택된 XY값 목록</h4>';
				contents += '<p>';
				contents += JSON.stringify(resultData);
				contents += '</p>';
				$('#displayDataResult').html(contents);
				////////////////////////////////////////
					
		});
		
	};
	
	
	// 1번째 단계 - 데이터 선택 이동
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
	

	// 3번째 단계 - 그래프 선택 이동
	function callWriteGraphThirdStep() {
		if(resultData.length > 0) {
			
			$.ajax({
				type :"POST",
				url : "/mem/graph/writeGraph/thirdStep.do",
				dataType : "text",
				error: function() {
					alert("통신 실패");
				},
				success: function(data) {
					$('#w4-billing').html(data);
					$('.thirdStep>a').click();
					displaySecondStepSuccess();
				}
			});
			
		} else{
			alert('데이터를 선택해 주세요.');
		}
		
	}
	

</script>

</html>