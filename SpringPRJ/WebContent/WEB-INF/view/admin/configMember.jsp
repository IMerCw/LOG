<%@page import="poly.dto.pageParamsDTO"%>
<%@page import="poly.dto.UserMemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	List<UserMemberDTO> uDTOs = (List<UserMemberDTO>) request.getAttribute("uDTOs");
	pageParamsDTO pDTO = (pageParamsDTO) request.getAttribute("pDTO");
	int currentPage = pDTO.getCurrentPage();
	int rowCount = pDTO.getRowCount();
	String sortValue = pDTO.getSortValue();
	String arrangeOrder = pDTO.getArrangeOrder();
	String searchContent = pDTO.getSearchContent();
	
	//전체ROW의 갯수
	int totalCount = pDTO.getTotalCount();
	//전체 페이지 수
	int totalPages = pDTO.getTotalPages();
	//블럭 시작 페이지 // 한 블럭 당 5페이지 씩 출력
	int startPage = ((currentPage - 1) / 5 * 5 ) + 1; 
	//블럭 끝 페이지
	int endPage = (startPage+4 > totalPages ? totalPages : startPage+4); //한 블럭 5페이지 설정 , 총 페이지의 수를 넘을 경우 totalPages로 대체
%>
<%-- 	<%="현재 페이지 : " +  currentPage%>        <br/>
	<%="페이지당 행수: " + rowCount%>            <br/>
	<%="정렬기준 키 : " + sortValue %>          <br/>
	<%="정렬순서 : " + arrangeOrder %>         <br/>
	<%="전체ROW갯수 : " + totalCount %>        <br/>
	<%="전체 페이지 수 : " + totalPages%>         <br/>
	<%="시작페이지 : " + startPage %>            <br/>
	<%="끝 페이지 : " + endPage %>              <br/>
	<%="검색어 : " + searchContent %>              <br/> --%>
	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	//제목 설정
	$('#pageName').html('회원관리');
</script>
<style>
	th, td {
		text-align: center;
		font-size: 14px;
		padding:12px;
		
	}
	tbody tr {
	    height: 64px;
	}
	td {
		font-size:12px;
		vertical-align: middle !important;
	}
	.content-body{
	    padding-left: 20px;
  		padding-right: 20px;
	}
	p {
		margin:0;
	}
	#userSeach:focus {
		border : 1px solid #999999;
	}
	.fa-sort-desc, .fa-sort-asc, .cursor-pointer {
		cursor:pointer;
	}
	.hidden-icon {
		color:#cccccc;
		transition: all 0.4s linear;
	}
	.fa-pencil, .fa-check {
		font-size:23px;
	}
</style>
	
</head>
<body>
	<div class="container-fluid panel" style="background-color:#ffffff; color:black; padding:10px;">
		<!-- 회원 검색 -->
		<div class="row" style="margin-bottom: 10px;">
			<div class="col-md-8" style="padding-top:3px;">
				<select id="rowCountBox" class="form-control input-sm mb-md">
					<option selected disabled>출력 개수 설정</option>
					<option>5</option>
					<option>10</option>
					<option>30</option>
				</select>
			</div>
			<div class="col-md-4">
				<div class="input-group input-search">
					<input type="text" class="form-control" name="q" id="userSearchBox" placeholder="회원검색...">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button" onclick="adminSearchUser(); return false;">
							<i class="fa fa-search"></i>
						</button>
					</span>
				</div>
			</div>
		</div>
		
		<div class="table-responsive">
			<table class="table table-hover mb-none">
			
				<thead>
					<tr>
						<th class="cursor-pointer <%=sortValue.equals("USER_SEQ") ? "" : "tableHeader" %>" onclick="getValueSorted('USER_SEQ', '<%=arrangeOrder.equals("DESC") ? "ASC" : "DESC" %>')">
							#
							<%if("DESC".equals(arrangeOrder) && "USER_SEQ".equals(sortValue)){%>
								<i class="fa fa-sort-desc"></i>
							<%} else if("ASC".equals(arrangeOrder) && "USER_SEQ".equals(sortValue)){%>
								<i class="fa fa-sort-asc"></i>
							<%} else {%>
								<i class="fa fa-sort-desc hidden-icon" onclick="getValueSorted('USER_SEQ', 'DESC')"></i>
							<%} %>
						</th>
						<th class="cursor-pointer <%=sortValue.equals("USER_ID") ? "" : "tableHeader" %>" onclick="getValueSorted('USER_ID', '<%=arrangeOrder.equals("DESC") ? "ASC" : "DESC" %>')">
							회원 아이디
							<%if("DESC".equals(arrangeOrder) && "USER_ID".equals(sortValue)){%>
								<i class="fa fa-sort-desc"></i>
							<%} else if("ASC".equals(arrangeOrder) && "USER_ID".equals(sortValue)){%>
								<i class="fa fa-sort-asc" ></i>
							<%} else {%>
								<i class="fa fa-sort-desc hidden-icon" onclick="getValueSorted('USER_ID', 'DESC')"></i>
							<%} %>
						</th>
						<th class="cursor-pointer <%=sortValue.equals("USER_NAME") ? "" : "tableHeader" %>" onclick="getValueSorted('USER_NAME', '<%=arrangeOrder.equals("DESC") ? "ASC" : "DESC" %>')">
							회원 이름
							<%if("DESC".equals(arrangeOrder) && "USER_NAME".equals(sortValue)){%>
								<i class="fa fa-sort-desc"></i>
							<%} else if("ASC".equals(arrangeOrder) && "USER_NAME".equals(sortValue)){%>
								<i class="fa fa-sort-asc"></i>
							<%} else {%>
								<i class="fa fa-sort-desc hidden-icon" onclick="getValueSorted('USER_NAME', 'DESC')"></i>
							<%} %>
						</th>
						<th>
							이모티콘
						</th>
						<th class="cursor-pointer <%=sortValue.equals("USER_REG_DATE") ? "" : "tableHeader" %>" onclick="getValueSorted('USER_REG_DATE', '<%=arrangeOrder.equals("DESC") ? "ASC" : "DESC" %>')">
							가입날짜
							<%if("DESC".equals(arrangeOrder) && "USER_REG_DATE".equals(sortValue)){%>
								<i class="fa fa-sort-desc" onclick="getValueSorted('USER_REG_DATE', 'ASC')"></i>
							<%} else if("ASC".equals(arrangeOrder) && "USER_REG_DATE".equals(sortValue)){%>
								<i class="fa fa-sort-asc" onclick="getValueSorted('USER_REG_DATE', 'DESC')"></i>
							<%} else {%>
								<i class="fa fa-sort-desc hidden-icon" onclick="getValueSorted('USER_REG_DATE', 'DESC')"></i>
							<%} %>
						</th>
						<th>
							회원상태
						</th>
						<th>
							수정
						</th>
					</tr>
				</thead>
				
				<tbody>
					<%for(UserMemberDTO uDTO: uDTOs) {%>
						<tr>
							<td><%=uDTO.getUser_seq() %>      </td>
							<td><%=uDTO.getUser_id() %>       </td>
							
							<!-- 유저 이름 -->
							<td style="width:180px;" id="userName<%=uDTO.getUser_seq()%>"> <%=uDTO.getUser_name() %></td>
							<!---- 숨겨진 input box ---->
							<td style="display:none" id="userNameBox<%=uDTO.getUser_seq()%>">
								<input type="text" class="form-control input-sm" id="userNameBoxInput<%=uDTO.getUser_seq()%>" value="<%=uDTO.getUser_name()%>"/>
							</td>
							<!-------------->
							<td style=" text-align:center;"> <img src="<%=uDTO.getFile_py_name() %>" class="img-circle" style="max-height:32px;"/></td> 
							<td><%=uDTO.getUser_reg_date() %> </td>
							<td id="userState<%=uDTO.getUser_seq() %>">
								<%if(uDTO.getUser_state().equals("1") && uDTO.getKakao_user_yn().equals("1")) {%>
									<p style="color: #ed9c28; font-weight: bold;">카카오유저</p>
								<%} else if(uDTO.getUser_state().equals("1")) {%>
									<p style="color: #09B23C; font-weight: bold;">정상</p>
								<%} else if ( uDTO.getUser_state().equals("0")) { %>
									<p style="color: #428bca; font-weight: bold;">가입대기</p>
								<%} else if ( uDTO.getUser_state().equals("-1")) { %>
									<p style="color: #FF0000; font-weight: bold;">탈퇴</p>
								<%} %>
							</td>
							
							<!-- 수정 버튼 클릭시 나올 목록 상자 -->
							<td style="display:none; width:82px; margin-right: -14px; border-top-color: #dddddd;" id="userStateBox<%=uDTO.getUser_seq()%>" >
								<select class="form-control" data-plugin-multiselect="" style="padding: 4px; font-size: 12px;">
									<option value="1">정상</option>
									<option value="0">가입대기</option>
									<option value="-1">탈퇴</option>
								</select>
							</td>
							
							<td class="actions-hover actions-fade" id="updateButton<%=uDTO.getUser_seq()%>" style="color:black; vertical-align: middle;">
								<a href="javascript:adminUpdateUser('<%=uDTO.getUser_seq()%>')">
									<!-- 수정 하기 버튼 -->
									<i class="fa fa-pencil" id='pencilImg<%=uDTO.getUser_seq()%>'></i>
									<!-- 수정 완료 버튼, 기본 숨김 -->
									<i class="fa fa-check" id='checkImg<%=uDTO.getUser_seq()%>' style="display:none" onclick="adminUpdateUserProc('<%=uDTO.getUser_seq()%>');"></i>
								</a>
							</td>
						</tr>
					<%} %>
				</tbody>
			</table>
		</div>
		<!-- start: PAGINATION -->
			<div class="row" style="display:block;">
				<div class="col-md-6" style="text-align: left; margin: 32px 0; padding-left: 30px;">
					전체 <%=totalCount%> 회원이 출력되었습니다.
				</div>
				<div class="col-md-6" style="text-align:right; margin:10px 0; padding-right: 28px;">
					<nav aria-label="...">
						<ul class="pagination">
							<%if(startPage != 1) {%>
					    	<li class="page-item">
					    		<span class="page-link" onclick="callConfigMember(<%=startPage-1%>)">이전</span>
					    	</li>
					    	<%} %>
					    	
					    	<%for (int i = startPage; i <= endPage; i++ ) {%>
				    			<%if (i == currentPage) {%>
					    			<li class="page-item active">
									  <span class="page-link">
									    <%=i %>
									    <span class="sr-only">(current)</span>
									  </span>
									</li>
				    			<%} else { %>
					    			<li class="page-item"><a class="page-link" onclick="callConfigMember(<%=i%>)"><%=i%></a></li>
				    			<%} %>
						    <%} %>
						    
						    <%if(endPage != totalPages) {%>
						    	<li class="page-item">
						    		<span class="page-link" onclick="callConfigMember(<%=endPage+1%>)">다음</span>
						    	</li>
						    <%} %>
					  	</ul>
					</nav>
				</div>
			</div>
		<!-- end: PAGINATION -->
	</div>
</body>

<script>
//기본 파라미터 값 세팅
var rowCount = '<%=rowCount%>';
var sortValue = '<%=sortValue%>';
var arrangeOrder = '<%=arrangeOrder%>';
var searchContent = '<%=searchContent%>';
	
	//새로운 페이지 불러오기
	function callConfigMember(pageNum) {
		
		$.ajax({
			type :"POST",
			url : "/admin/configMember.do",
			dataType : "text",
			data : {
				currentPage : pageNum,
				rowCount : rowCount,
				sortValue : sortValue, 
				arrangeOrder : arrangeOrder,
				searchContent : searchContent
			},
			error:function() {
				alert("통신 실패");
			},
			success: function(data) {
				$('.content-body').html(data);
			}
		});
	}

	//수정 버튼 클릭 시 이벤트
	function adminUpdateUser(user_seq){
				
		//유저 이름 박스변경
		$('#userName' + user_seq).css('display', 'none');
		$('#userNameBox' + user_seq).css('display', 'table-cell');
		
		//유저상태 변경 셀렉트 박스
		$('#userState' + user_seq).css('display', 'none');
		$('#userStateBox' + user_seq).css('display', 'table-cell');
		
		//아이콘 변경 - 기존 아이콘 숨기기
		$('#pencilImg' + user_seq).css('display', 'none');
		$('#checkImg' + user_seq).css('display', 'table-cell');
		
		//아이콘 사라짐 효과 제거
		$('#updateButton' + user_seq).removeClass('actions-hover actions-fade');
		
	}
	
	//수정완료 버튼
	function adminUpdateUserProc(user_seq) {
		
		var r = confirm('회원 정보를 수정하시겠습니까?');
			
		if(r) {
			
			var updated_user_name =  $('#userNameBoxInput' + user_seq).val();
			var updated_user_state = $('#userStateBox' + user_seq +'>select').val();
				
			console.log("변경될 유저 번호 : " + user_seq);
			console.log("변경될 유저 이름 : " + updated_user_name);
			console.log("변경될 유저 상태 : " + updated_user_state);
			
			//유저 회원 변경 사항 전송
			$.ajax({
				method : "post",
				url : "/admin/adminUpdateUserProc.do",
				data : {
					user_seq : user_seq,
					user_name : updated_user_name,
					user_state : updated_user_state
				},
				success: function(data) {
					
					callConfigMember('<%=currentPage%>'); //페이지 새로고침
					
				}
				
			});
			
		} else if(!r) {
			
			callConfigMember('<%=currentPage%>'); //페이지 새로 고침
			
		}
		
	}
	
	//유저 검색
	function adminSearchUser() {
		searchContent = $('#userSearchBox').val();
		callConfigMember(1);
	}
	
	//정렬하기
	function getValueSorted(sortValue, arrangeOrder) {
		$.ajax({
			type :"POST",
			url : "/admin/configMember.do",
			dataType : "text",
			data : {
				currentPage : '<%=currentPage%>',
				rowCount : rowCount,
				sortValue : sortValue, 
				arrangeOrder : arrangeOrder,
				searchContent : searchContent
			},
			error:function() {
				alert("통신 실패");
			},
			success: function(data) {
				$('.content-body').html(data);
			}
		});
	}
	
	//hover effect
	$('.tableHeader').hover(
		function() {
			$(this).find('i').removeClass('hidden-icon');
		}, function () {
			$(this).find('i').addClass('hidden-icon');			
		}
	)
	
	//출력 개수 변경
	$('#rowCountBox').change(function(){
		rowCount = this.value;
		callConfigMember(1);
	});
				
</script>
</html>