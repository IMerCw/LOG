<%@page import="java.util.List"%>
<%@page import="poly.dto.PublicDataDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	//공공데이터 목록
	List<PublicDataDTO> pdDTOs = (List<PublicDataDTO>) request.getAttribute("pdDTOs");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/assets/vendor/pnotify/pnotify.custom.css">
<script>
	//제목 설정
	$('#pageName').html('그래프 갤러리');
</script>
<style>
	.panel-featured * {
		text-overflow:ellipsis;
		overflow:hidden;
		white-space:nowrap;
	}

</style>
</head>
<body>
	<div class="container-fluid" style="padding:0">
	
	<section class="panel form-wizard" id="w4">
		<div class="panel-body">
			<div class="wizard-progress wizard-progress-lg" style="margin: 0 auto;">
				<div class="steps-progress">
					<div class="progress-indicator" style="width: 0%;"></div>
				</div>
				<ul class="wizard-steps">
					<li class="completed active">
						<a href="#w4-account" data-toggle="tab" aria-expanded="true"><span>1</span>데이터 선택</a>
					</li>
					<li class="">
						<a href="#w4-profile" data-toggle="tab" aria-expanded="false"><span>2</span>데이터 정제</a>
					</li>
					<li>
						<a href="#w4-billing" data-toggle="tab"><span>3</span>그래프 선택</a>
					</li>
					<li>
						<a href="#w4-confirm" data-toggle="tab"><span>4</span>게시물 작성</a>
					</li>
				</ul>
			</div>

			<form class="form-horizontal" novalidate="novalidate">
				<div class="tab-content">
				
					<!-- 1번 탭 -->
					<div id="w4-account" class="tab-pane active">
						
						<!-- 검색 바 -->
						<div class="row" style="margin: 24px 0;">
							<div class="col-md-6"> </div>
							<div class="col-md-6">
								<form action="pages-search-results.html" class="search nav-form">
									<div class="input-group input-search">
										<input type="text" class="form-control" name="dataSearch" id="dataSearch" placeholder="데이터 검색...">
										<span class="input-group-btn">
											<button class="btn btn-default" type="submit"><i class="fa fa-search"></i></button>
										</span>
									</div>
								</form>
							</div>
						</div>
				
				
						<!-- 데이터 패널 목록 -->
						<div class="row">
							<%
								for (int i = 0; i < pdDTOs.size(); i++) {
							%>	
								<div class="col-md-4 col-sm-6" style="cursor:pointer;" onclick="callSecondStep(<%=pdDTOs.get(i).getPdata_seq()%>);">
									<section class="panel panel-featured">
										<header class="panel-heading">
							
											<h2 class="panel-title"><%=pdDTOs.get(i).getPdata_name() %></h2>
											<p class="panel-subtitle"><%=pdDTOs.get(i).getPdata_cate() %></p>
										</header>
										<div class="panel-body">
											<code><%=pdDTOs.get(i).getPdata_keyword() %></code>
										</div>
									</section>
								</div>
							<%} %>
						</div>
						
						
					</div>
					
					<!-- 2번 탭 -->
					<div id="w4-profile" class="tab-pane">
					
						
					</div>
					
					<!-- 3번 탭 -->
					<div id="w4-billing" class="tab-pane">
						
						
						
					</div>
					<!-- 4번 탭 -->
					<div id="w4-confirm" class="tab-pane">
						
						
					</div>
					
					
				</div>
			</form>
		</div>
		
		<!-- 패널 푸터 panel footer -->
		<div class="panel-footer">
			<ul class="pager">
				<li class="previous disabled">
					<a><i class="fa fa-angle-left"></i> 이전</a>
				</li>
				<li class="finish hidden pull-right">
					<a>작성 완료</a>
				</li>
				<li class="next">
					<a>다음 <i class="fa fa-angle-right"></i></a>
				</li>
			</ul>
		</div>
		
	</section>
								
		
	</div>
</body>
<script>
	// 2번째 단계 - 데이터 정제 이동
	function callSecondStep(pdata_seq) {
		$.ajax({
			type :"POST",
			url : "/mem/graph/writeGraph/secondStep.do",
			dataType : "text",
			data : {
					pdata_seq : pdata_seq
			},
			error: function() {
				alert("통신 실패");
			},
			success: function(data) {
				$('#w4-profile').html(data);
				$('.next').click();
			}
		});
	}
	
</script>
	<!-- Specific Page Vendor -->
	<script src="/assets/vendor/jquery-validation/jquery.validate.js"></script>
	<script src="/assets/vendor/bootstrap-wizard/jquery.bootstrap.wizard.js"></script>
	<script src="/assets/vendor/pnotify/pnotify.custom.js"></script>
	<script src="/assets/javascripts/forms/examples.wizard.js"></script>
</html>