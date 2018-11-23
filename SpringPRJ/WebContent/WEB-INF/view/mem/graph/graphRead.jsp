<%@page import="poly.dto.UserMemberDTO"%>
<%@page import="poly.dto.GraphDTO"%>
<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	GraphDTO gDTO = (GraphDTO) request.getAttribute("gDTO");
	String graphSelect = gDTO.getGraph_type();
	Float starRate;
	UserMemberDTO uDTO = (UserMemberDTO)session.getAttribute("uDTO");
	String accessRoot = (String) session.getAttribute("accessRoot"); //접근 한 경로 - myGraph / graphGallery
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/assets/css/starRating.css" rel="stylesheet" type="text/css" />
<!-- Specific Page Vendor -->
<link rel="stylesheet" href="/assets/vendor/pnotify/pnotify.custom.css">
<script src="/assets/vendor/pnotify/pnotify.custom.js"></script>
<script src="/assets/javascripts/ui-elements/examples.notifications.js"></script>

<!-- Load c3.css -->
<link href="/assets/c3Chart/c3.css" rel="stylesheet">
<!-- Load d3.js and c3.js -->
<script src="/assets/d3/d3.v5.js"></script>
<script src="/assets/c3Chart/c3.js"></script>

<style>
	.contentSubject {
		font-size:18px;
		text-overflow: ellipsis;
		overflow: hidden;
		white-space: nowrap;
	}
	.boardContent {
	    border-bottom: 1px solid #cccccc;
	    padding: 10px;
	}
	.boardWritingInfo{
		text-align:right; padding-top: 8px;
	}
	.boardWritingInfo > div:first-child {
		text-align:left;
	}
	.img-circle {
		width:20px; max-height: 28px;
	}
</style>
</head>
<body>

	<div class="container-fluid" style="background-color:#ffffff; color:black; border-radius: 4px; padding-bottom: 8px;">
		<div class="row">
			<div class="panel-body">
				<div id="graphSeq<%=gDTO.getGraph_seq()%>"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-8" style="text-align:left;"><h3><%=gDTO.getGraph_title()%></h3></div>
			<div class="col-md-4" style="text-align:right; color: sandybrown;">
				<%-- 별점 표시 --%>
				<h3>
				<%if(gDTO.getStar_rate() != null) {%>
					<%= starRate = Float.valueOf(gDTO.getStar_rate()) %>
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
				</h3> 
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-6" style="text-align:left;"><img src="<%=gDTO.getFile_py_name()%>" class="img-circle" style="width:28px;"> &nbsp; <%=gDTO.getUser_name() %></div>
			<div class="col-md-6" style="text-align:right;">조회수:<%=gDTO.getRead_count() %> / <%=gDTO.getReg_date() %></div>
		</div>
		
		<div class="row" style="width: 100%; background-color: #cccccc; margin: 10px 0; height: 2px;"></div>

		<div class="row" style="min-height: 180px; padding-top: 6px;">
			<div class="col-md-12" id="ouput">
				<%=gDTO.getGraph_content().replaceAll("& lt;", "<").replaceAll("& gt;", ">")%>
			</div>
		</div>		
		<%if(uDTO.getUser_seq().equals(gDTO.getUser_seq()) || "0".equals(uDTO.getUser_seq())) {%>
			<div class="row" style="padding:12px;"> 
				<button type="button" class="mb-xs mt-xs mr-xs btn btn-primary" style="float:right; display: inline-block;" onclick="callGraphUpdate()">수정하기</button>
				<button type="button" class="mb-xs mt-xs mr-xs btn btn-danger" style="float:right; display: inline-block;" onclick="callGraphDelete()">삭제하기</button>
			</div>
		<%}%>
		
		<!-- 댓글 출력 -->
		<div class="container-fluid" id="boardReplyContainer" style="padding:0;">
		<%-- 		
		<%for(int i = 0; i < brDTO.size(); i++) { %>
			
		<%} %> 
		--%>
		</div>
		<!-- 댓글 작성 입력 폼 -->
		<div class="row" id="replyWriteContainer">
			<div class="form-group">
				<div class="col-md-12" style="padding-bottom: 5px; padding-top: 10px;">
					<span class="star-input">
					  <span class="input">
					    <input type="radio" name="star-input" id="p1" value="1"><label for="p1">0.5</label>
					    <input type="radio" name="star-input" id="p2" value="2"><label for="p2">1</label>
					    <input type="radio" name="star-input" id="p3" value="3"><label for="p3">1.5</label>
					    <input type="radio" name="star-input" id="p4" value="4"><label for="p4">2</label>
					    <input type="radio" name="star-input" id="p5" value="5"><label for="p5">2.5</label>
					    <input type="radio" name="star-input" id="p6" value="6"><label for="p6">3</label>
					    <input type="radio" name="star-input" id="p7" value="7"><label for="p7">3.5</label>
					    <input type="radio" name="star-input" id="p8" value="8"><label for="p8">4</label>
					    <input type="radio" name="star-input" id="p9" value="9"><label for="p9">4.5</label>
					    <input type="radio" name="star-input" id="p10" value="10"><label for="p10">5</label>
					  </span>
					  <output for="star-input" style="color:#777777; padding:0;"><b>0</b>점</output>
					</span>
				</div>
				<div class="col-md-12">
					<textarea class="form-control" id="graphReply" rows="3" id="textareaAutosize" data-plugin-textarea-autosize="" placeholder="댓글을 작성해주세요." 
						style="width:100%; overflow: hidden; overflow-wrap: break-word; resize: none; height: 74px;"></textarea>
				</div>
				
			</div>
		</div>
		<div>
			<%-- 내 그래프에서 목록보기 이동시 --%>
			<%if(accessRoot.equals("myGraph")) {%>
			<button type="button" class="mb-xs mt-xs mr-xs btn btn-default" style="float:left; display: inline-block;" onclick="callPage('myGraphPage');">내 그래프 목록보기</button>
			<%} else { %>
			<button type="button" class="mb-xs mt-xs mr-xs btn btn-default" style="float:left; display: inline-block;" onclick="callPage('graphGallery');">목록보기</button>
			<%} %>
			<button type="button" class="mb-xs mt-xs mr-xs btn btn-primary" style="float:right; display: inline-block;" onclick="callGraphReplyWriteProc();">댓글작성</button>
		</div>
		
		
	</div>
</body>

<script>
function showContent() {
    $('.output').html($('#summernote').summernote('code'));
}

/*-------------게시글-------------*/
//게시글 목록
/* function callGraphMain() {
	$.ajax({
		type : "POST",
		url : "/mem/graph/graphMain.do",
		dataType: "text",
		error: function() {
			alert("통신실패");
		},
		success: function(data) {
			$('.content-body').html(data);
		}
	})
} */

//게시글 수정
function callGraphUpdate() {
	$.ajax({
		type : "POST",
		url : "/mem/graph/updateGraph.do",
		dataType: "text",
		data:{
			graph_seq: '<%=gDTO.getGraph_seq()%>', 
			graph_title: '<%=gDTO.getGraph_title()%>', 
			graph_content: '<%=gDTO.getGraph_content()%>',
			graph_hashtag: '<%=gDTO.getGraph_hashtag()%>'
		},
		error: function() {
			alert("통신실패");
		},
		success: function(data) {
			$('.content-body').html(data);
		}
	})
}	

//게시글 삭제
function callGraphDelete() {
	$.ajax({
		type : "POST",
		url : "/mem/graph/deleteGraph.do",
		dataType: "text",
		data : {graph_seq : '<%=gDTO.getGraph_seq()%>'},
		error: function() {
			alert("통신실패");
		},
		success: function(data) {
			$('.content-body').html(data);
		}
	})
}
///////////////////////////////////////////////
//댓글 불러오기
	function callGraphRepliesPage() {
		var contents = '';
		$.ajax({
			type : "POST",
			url : "/mem/graph/getGraphRepliesPage.do",
			dataType: "text",
			data : {
				graph_seq : '<%=gDTO.getGraph_seq()%>'
			},
			error: function() {
				alert("통신실패");
			},
			success: function(data) {
				$('#boardReplyContainer').html(data);
			}
		});
	};

	//댓글 목록 불러오기
	callGraphRepliesPage();
	
	//댓글 작성
	function callGraphReplyWriteProc(){
		if($('#graphReply').val() == '') {
			displayErrorNotice();
			return null;
		}
		$.ajax({
			type : "POST",
			url : "/mem/graph/graphReplyWriteProc.do",
			dataType: "text",
			data : {
				graph_seq : '<%=gDTO.getGraph_seq()%>',
				reply_content : $('#graphReply').val(),
				user_seq : '<%=uDTO.getUser_seq()%>',
				star_rate : $('.star-input > output > b').text()
			},
			error: function() {
				alert("통신실패");
			},
			success: function(data) {
				$('#graphReply').val(function(){return ''}); //작성한 내용 지우기				
				callGraphRepliesPage(); //댓글 목록 불러오기
				displaySuccessNotice(); 
			}
		})
	}
	
	
	//댓글 수정 화면 전환
	function callGraphReplyUpdate(replySeq){
		var updateContents = '';

		
		/* 평점 */
		updateContents += '<div class="col-md-12" style="padding-bottom: 5px; padding-top: 10px;">'; 
		updateContents += '<span class="starUpdate">'; 
		updateContents += '<span class="input">';
		updateContents += '<input type="radio" name="starUpdate" id="p1Update" value="1"><label for="p1Update">0.5</label>';
		updateContents += '<input type="radio" name="starUpdate" id="p2Update" value="2"><label for="p2Update">1</label>'; 
		updateContents += '<input type="radio" name="starUpdate" id="p3Update" value="3"><label for="p3Update">1.5</label>';   
		updateContents += '<input type="radio" name="starUpdate" id="p4Update" value="4"><label for="p4Update">2</label>';     
		updateContents += '<input type="radio" name="starUpdate" id="p5Update" value="5"><label for="p5Update">2.5</label>';   
		updateContents += '<input type="radio" name="starUpdate" id="p6Update" value="6"><label for="p6Update">3</label>';         
		updateContents += '<input type="radio" name="starUpdate" id="p7Update" value="7"><label for="p7Update">3.5</label>';   
		updateContents += '<input type="radio" name="starUpdate" id="p8Update" value="8"><label for="p8Update">4</label>';     
		updateContents += '<input type="radio" name="starUpdate" id="p9Update" value="9"><label for="p9Update">4.5</label>';   	    
		updateContents += '<input type="radio" name="starUpdate" id="p10Update" value="10"><label for="p10Update">5</label>';	    
		updateContents += '</span>';		    
		updateContents += '<output for="starUpdate" style="color:#777777; padding:0;"><b>0</b>점</output>';   
		updateContents += '</span>';   
		updateContents += '</div>';		
				
		
		updateContents += '<div class="form-group">';
		updateContents += '<div class="col-md-12">'; 
		updateContents += '<textarea class="form-control" rows="3" id="replyContentUpdate" data-plugin-textarea-autosize=""'; 
		updateContents += 'style="width:100%; overflow: hidden; overflow-wrap: break-word; resize: none; height: 74px;">';
		updateContents += $('#replyContent'+replySeq).html();
		updateContents += '</textarea>';
		updateContents += '<div style="text-align:right;">';
		updateContents += '<a href="javascript:callGraphRepliesPage()">취소</a> / <a href="javascript:callGraphReplyUpdateProc(' + replySeq + ')">수정</a></div>';
		updateContents += '</div>';
		updateContents += '</div></div>';
		
		$('#'+replySeq).html(function(){return updateContents});
		
		starRatingUpdate(); // 평점 수정 함수
		
	}
	
	
	//댓글 수정 처리 Procedure
	function callGraphReplyUpdateProc(replySeq){
		if( $('#replyContentUpdate').val() == '') {
			displayErrorNotice();
			return false;
		}
		
		$.ajax({
			type : "POST",
			url : "/mem/graph/graphReplyUpdateProc.do",
			dataType: "json",
			data : {
				reply_seq : replySeq,
				reply_content : $('#replyContentUpdate').val(),
				user_seq : '<%=uDTO.getUser_seq()%>',
				graph_seq : '<%=gDTO.getGraph_seq()%>',
				star_rate : $('.starUpdate > output > b').text()
			},
			error: function() {
				alert("통신실패");
			},
			success: function(data) {
				//댓글 목록 불러오기
				callGraphRepliesPage();
				displaySuccessNotice();
			}
		})
	}
	
	//댓글 삭제
	function callGraphReplyDelete(replySeq){
		var r = confirm("정말로 삭제하시겠습니까?");
		if(r) {
			$.ajax({
				type : "POST",
				url : "/mem/graph/graphReplyDelete.do",
				dataType: "text",
				data : {
					reply_seq : replySeq
				},
				error: function() {
					alert("통신실패");
				},
				success: function(data) {
					console.log(data);
					//댓글 목록 불러오기 , 새로고침
					callGraphRepliesPage();
					displayDeleteNotice();
				}
			})
		}
	}
	
	<%-- 모달 --%>
	function displaySuccessNotice() {
		new PNotify({
			title: '댓글 쓰기 성공',
			text: '댓글 쓰기가 완료되었습니다.',
			type: 'success',
			shadow: true
		});
	}
	function displayErrorNotice() {
		new PNotify({
			title: '댓글 쓰기 실패',
			text: '댓글을 작성해주세요.',
			type: 'error',
			shadow: true
		});
	}
	function displayDeleteNotice() {
		new PNotify({
			title: '댓글 삭제 완료',
			text: '댓글을 정상적으로 삭제하였습니다.',
			shadow: true
		});
	}

</script>

<script>
	
<%String graphType = gDTO.getGraph_type();%>
	//JSON 파일 가져오기
	$.getJSON( '/resources/json/<%=gDTO.getJson_file_name()%>', function(jsonData) {
		console.log('<%=gDTO.getGraph_seq()%> 그래프 번호' );
	
	<%if(graphType.equals("barChart")) {%>
		console.log(jsonData);
		
		/*--------막대 그래프--------*/
		setTimeout(function () {
			var barChart = c3.generate({
				bindto: "#graphSeq<%=gDTO.getGraph_seq()%>",
				data: {
				    json: 
				    	jsonData
				    ,
				    keys: {
				       //x: 'factor', // it's possible to specify 'x' when category axis
				       value: ('<%=gDTO.getResult_cate()%>').split(',')
				    },
					type: 'bar'
				  },
				   axis: {
				    x: {
				       type: 'category',
				       categories:  ('<%=gDTO.getResult_x()%>').split(',')
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
			bindto: "#graphSeq<%=gDTO.getGraph_seq()%>",
			data: {
			    json: 
			    	jsonData
			    ,
			    keys: {
			       x: 'factor', // it's possible to specify 'x' when category axis
			       value: ('<%=gDTO.getResult_cate()%>').split(',')
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
			bindto: "#graphSeq<%=gDTO.getGraph_seq()%>",
			
			data: {
			    json: 
			    	jsonData
			    ,
			    keys: {
			       x: 'factor', // it's possible to specify 'x' when category axis
			       value: ('<%=gDTO.getResult_cate()%>').split(',')
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
	setTimeout(function () {
		
		var pieChart = c3.generate({
				bindto: "#graphSeq<%=gDTO.getGraph_seq()%>",
				data: {
				    json: 
				    	jsonData
				    ,
				    keys: {
				       x: 'factor', // it's possible to specify 'x' when category axis
				       value: ('<%=gDTO.getResult_cate()%>').split(',')
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
			bindto: "#graphSeq<%=gDTO.getGraph_seq()%>",
			data: {
				  json:	
					  jsonData
				  ,
				    keys: {
				       x: 'factor', // it's possible to specify 'x' when category axis
				      value: ('<%=gDTO.getResult_cate()%>').split(',')	
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
</script>
<!-- 별점  -->
<script>
//star rating
var starRating = function(){
  var $star = $(".star-input"),
      $result = $star.find("output>b");
  $(document)
    .on("focusin", ".star-input>.input", function(){
    $(this).addClass("focus");
  })
    .on("focusout", ".star-input>.input", function(){
    var $this = $(this);
    setTimeout(function(){
      if($this.find(":focus").length === 0){
        $this.removeClass("focus");
      }
    }, 100);
  })
    .on("change", ".star-input :radio", function(){
    $result.text($(this).next().text());
  })
    .on("mouseover", ".star-input label", function(){
    $result.text($(this).text());
  })
    .on("mouseleave", ".star-input>.input", function(){
    var $checked = $star.find(":checked");
    if($checked.length === 0){
      $result.text("0");
    } else {
      $result.text($checked.next().text());
    }
  });
};
starRating();
</script>

<script>
/////업데이트용
//star rating
var starRatingUpdate = function(){
  var $star = $(".starUpdate"),
  	  $result = $star.find("output>b");
  
  console.log($result.text());
  
  $(document)
    .on("focusin", ".starUpdate>.input", function(){
    $(this).addClass("focus");
  })
    .on("focusout", ".starUpdate>.input", function(){
    var $this = $(this);
    setTimeout(function(){
      if($this.find(":focus").length === 0){
        $this.removeClass("focus");
      }
    }, 100);
  })
    .on("change", ".starUpdate :radio", function(){
    $result.text($(this).next().text());
  })
    .on("mouseover", ".starUpdate label", function(){
    $result.text($(this).text());
  })
    .on("mouseleave", ".starUpdate>.input", function(){
    var $checked = $star.find(":checked");
    if($checked.length === 0){
      $result.text("0");
    } else {
      $result.text($checked.next().text());
    }
  });
};

</script>

</html>