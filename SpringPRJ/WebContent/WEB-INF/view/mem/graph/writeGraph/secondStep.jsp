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
</style>
</head>
		<div class="container-fluid">
			<div class="row">
				<button type="button" class="btn btn-primary" onclick="callWriteeGraphThirdStep();" style="width: 100%;  margin: 20px 0; font-size: 18px;">선택 완료</button>
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
				
					<div class="headerSubject">범주 선택</div>
					
					<select class="form-control input-lg mb-md" id="factor">	
						<option value='' selected disabled hidden>범주 선택</option>
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
	<div class="row">
		<div class="col-sm-12">
			데이터 요약 통계 함수 선택
		</div>
		<div class="col-sm-12">
			<div class="radio-custom">
				<input type="radio" id="radioExample1" name="radioExample">
				<label for="radioExample1">합계</label>
			</div>

			<div class="radio-custom radio-primary">
				<input type="radio" id="radioExample2" name="radioExample">
				<label for="radioExample2">평균</label>
			</div>

			<div class="radio-custom radio-success">
				<input type="radio" id="radioExample3" name="radioExample">
				<label for="radioExample3">최대값</label>
			</div>

			<div class="radio-custom radio-warning">
				<input type="radio" id="radioExample4" name="radioExample">
				<label for="radioExample4">최소값</label>
			</div>

			<div class="radio-custom radio-danger">
				<input type="radio" id="radioExample5" name="radioExample">
				<label for="radioExample5">Radio Danger</label>
			</div>

		</div>
	</div>
		
	<button type="button" class="btn btn-info" onclick="displaySelectResult();" style="width: 100%;  margin: 20px 0; font-size: 16px;">데이터 미리보기</button>
			
			
			<!-- 선택된 데이터 보기 -->
			<div class="row" id="displayDataResult">
				<%
					for (i = 0; i < csvResult.size(); i++) {
				%>
					<%=csvResult.get(i)%> <br/>
				<%
					}
				%>
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

var blank_pattern = /[\s]/g; //공백 검사

////////////////////////////////////////////////
 
	//데이터 미리보기함수
	function displaySelectResult() {
		
		var selectedItemX = $('#xAxis option:selected').text();
		var selectedItemY = $('#yAxis option:selected').text();
		var selectedItemFactor = $('#factor option:selected').text();
					
		//데이터 정제		
		var data =  d3.csv('/public_data/' + '<%=pdDTO.getFile_name()%>', function(csv_data) {
				
				return {
				
					[selectedItemX] : csv_data[selectedItemX], //x축 기준 aggregation
					[selectedItemY] : csv_data[selectedItemY], //y축 기준 aggregation
					[selectedItemFactor] : csv_data[selectedItemFactor] //범주 aggregation
					
				}
				
			}).then(function(data){
				
				var nestedData = d3.nest()
					
					//Aggregation Key Setting / 어떤 키를 기준으로 잡을 것인가
				 	.key(function(d) {
						return d[selectedItemX].split(' ')[0] 		
					}) 
					
					//Aggregation Y-values By Key / 기준 키를 가지고 데이터를 요약
				 	.rollup(function(v) { return d3.sum(v, function(d){ return d[selectedItemY]; })})
				 	
				 	//최종 입력
				 	.entries(data);
				
				console.log(nestedData);
				/* console.log(csv_data[selectedItem]);
				
				contents += csv_data[selectedItem];
				$('#xAxisDataList').html(contents.toString()); */
					
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
	function callWriteeGraphThirdStep() {
		$.ajax({
			type :"POST",
			url : "/mem/graph/writeGraph/thirdStep.do",
			dataType : "text",
			error: function() {
				alert("통신 실패");
			},
			success: function(data) {
				$('#w4-billing').html(data);
				$('.next').click();
			}
		});
	}
	

</script>

</html>