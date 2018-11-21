package poly.controller;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import poly.dto.BoardReplyDTO;
import poly.dto.GraphDTO;
import poly.dto.GraphReplyDTO;
import poly.dto.PublicDataDTO;
import poly.dto.UserMemberDTO;
import poly.service.IGraphService;
import poly.util.CmmUtil;
import poly.util.ReadCSV;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

@Controller
public class GraphGalleryController {
	//로그 표시
	private Logger log = Logger.getLogger(this.getClass());
	
	//Service 선언
	@Resource(name="GraphService")
	private IGraphService graphService;
	
	/*-------------------------그래프 메인------------------------------*/
	//그래프 갤러리 - 그래프 게시글 목록
	@RequestMapping(value="/mem/graph/graphMain")
	public String graphMain(HttpServletRequest request, Model model) throws Exception {
		log.info(this.getClass().getName() + "start!");
		
		//가져올 갯수 정하기
		request.getParameter("startIndex"); //시작번호의 10개까지 
		List<GraphDTO> gDTO = graphService.getGraphList();
		
		model.addAttribute("gDTO", gDTO);
		
		log.info(this.getClass().getName() + "end");
		return "/mem/graph/graphMain";
	}
	
/*	//그래프 가져오기
	@RequestMapping(value="/mem/graph/getGraph")
	public String getGraph() throws Exception { 
		log.info(this.getClass().getName() + "start!");
		
		log.info(this.getClass().getName() + "end!");
		return 
	}*/
	///////////////////////////////////////////////////////////////////
	/*-------------------------그래프 작성------------------------------*/
	//그래프 작성 1단계 - 데이터 선택
	@RequestMapping(value="/mem/graph/writeGraph/firstStep")
	public String writeGraphFirstStep(HttpServletRequest request, Model model) throws Exception {
		log.info(this.getClass().getName() + "start!");

		//공공데이터 목록 상위 10개 가져오기
		List<PublicDataDTO> pdDTOs = graphService.getPublicData();
		
		/*
		//공공데이터 목록 확인
		for(int i = 0; i < pdDTOs.size(); i++) {
			log.info(pdDTOs.get(i).getPdata_name());
		}
		*/
		
		//공공데이터 목록 전송
		model.addAttribute("pdDTOs", pdDTOs);
		
		log.info(this.getClass().getName() + "end");
		return "/mem/graph/writeGraph/firstStep";
	}
	
	//그래프 작성 2단계 - 데이터 정제
	@RequestMapping(value="/mem/graph/writeGraph/secondStep")
	public String writeGraphSecondStep(HttpServletRequest request, HttpSession session, Model model) throws Exception {
		log.info(this.getClass().getName() + "start!");
		
		//공공데이터 번호 가져옴
		String pdata_seq = request.getParameter("pdata_seq");
		//공공데이터 정보를 가져옴
		PublicDataDTO pdDTO = graphService.getOnePublicData(pdata_seq);
		//모델에 공공데이터 넣기
		model.addAttribute("pdDTO", pdDTO);
				
		//Json파일이 저장된 실제 경로 
		String realPathJson = request.getSession().getServletContext().getRealPath("/") + "public_data/" + pdDTO.getFile_name();
		log.info(realPathJson);
		
		//csv 파일 읽은 후 List 객체에 저장
		ReadCSV readCSV = new ReadCSV();
		List<List<String>> csvResult = readCSV.getJsonParser(realPathJson);
 		
		model.addAttribute("csvResult", csvResult);
		
		log.info(this.getClass().getName() + "end");
		return "/mem/graph/writeGraph/secondStep";
	}
	
	//그래프 작성 3단계 - 데이터 선택
	@RequestMapping(value="/mem/graph/writeGraph/thirdStep")
	public String writeGraphThirdStep(HttpServletRequest request, Model model) throws Exception {
		log.info(this.getClass().getName() + "start!");
		
		log.info(this.getClass().getName() + "end");
		return "/mem/graph/writeGraph/thirdStep";
	}
	
	//그래프 작성 4단계 - 그래프 확인
	@RequestMapping(value="/mem/graph/writeGraph/FourthStep")
	public String writeGraphFourthStep(HttpServletRequest request, Model model) throws Exception {
		log.info(this.getClass().getName() + "start!");
		String graphSelect = request.getParameter("graphSelect");
		
		//선택된 그래프 전송 - 페이지로 보여짐
		model.addAttribute("graphSelect", graphSelect);
		
		log.info(this.getClass().getName() + "end");
		return "/mem/graph/writeGraph/fourthStep";
	}
	
	//그래프 작성 최종 단계 - 글 작성
	@RequestMapping(value="/mem/graph/writeGraph/completeWriteGraph")
	public String completeWriteGraph(HttpServletRequest request, Model model, GraphDTO gDTO) throws Exception {
		log.info(this.getClass().getName() + "start!");
		
		Date date = new Date();
		Long time = date.getTime();
		String json_file_name = gDTO.getUser_seq() + "_" + time + ".json";
		PrintWriter writer = null;
		try {
			String filePath = request.getSession().getServletContext().getRealPath("/resources/json/") + json_file_name;
			writer = new PrintWriter(filePath);
			writer.println(gDTO.getResult_data());
			
		} finally {
			try {
				writer.close();
			}
			catch (Exception e) {
				
			}
		}
	 

		gDTO.setJson_file_name(json_file_name);
		log.info(gDTO.getGraph_type());	// 글 제목
		log.info(gDTO.getGraph_title());	// 글 제목
		log.info(gDTO.getGraph_content()); // 글 내용
		log.info(gDTO.getGraph_hashtag());	// 글 제목
		log.info(gDTO.getResult_data()); //json 결과 값
		log.info(gDTO.getUser_seq()); // 유저 번호
		log.info(gDTO.getResult_cate() ); // 범주 목록
		log.info(gDTO.getResult_x()); // x 값 목록
		
		
		int result = graphService.insertGraph(gDTO);
		
		log.info(this.getClass().getName() + "end");
		
		return graphMain(request, model);
	}
	
	///////////////////////////////////////////////////////////////////
	/*-------------------------그래프 상세 보기------------------------------*/
	//그래프 상세 보기
	@RequestMapping(value="/mem/graph/readGraph")
	public String readGraph(HttpServletRequest request, Model model, String graph_seq) throws Exception {
		log.info(this.getClass().getName() + "start!");
		log.info(graph_seq);
		GraphDTO gDTO = graphService.getGraphDetail(graph_seq);
		log.info(gDTO.getGraph_type());
		model.addAttribute("gDTO", gDTO);
		
		log.info(this.getClass().getName() + "end");
		
		return "/mem/graph/graphRead";
	}
	
	//그래프 조회수 증가
	@RequestMapping(value="/mem/graph/incrementCount")
	public @ResponseBody int incrementCount(HttpServletRequest request, Model model, String graph_seq) throws Exception {
		log.info(this.getClass().getName() + "start!");
		
		int result = graphService.incrementCount(graph_seq);
		
		log.info(this.getClass().getName() + "end");
		
		return result;
	}
	/////////////////////////////////////////////////////////////////
	
	/*-------------------------그래프 수정------------------------------*/
	//그래프 수정 화면 전환
	@RequestMapping(value="/mem/graph/updateGraph")
	public String updateGraph(HttpServletRequest request, Model model, GraphDTO gDTO) throws Exception {
		log.info(this.getClass().getName() + "start!");
		
		model.addAttribute("gDTO", gDTO);
		
		log.info(this.getClass().getName() + "end");
		
		return "/mem/graph/graphUpdate"; //수정 완료 후 상세보기로 이동
	}
	
	//그래프 수정 처리
	@RequestMapping(value="/mem/graph/updateGraphProc")
	public String callGraphUpdateProc(HttpServletRequest request, Model model, GraphDTO gDTO) throws Exception {
		log.info(this.getClass().getName() + "start!");
		
		int result = graphService.updateGraph(gDTO);
		String graph_seq = gDTO.getGraph_seq();
		
		log.info(this.getClass().getName() + "end");
		
		return readGraph(request, model, graph_seq); //수정 완료 후 상세보기로 이동
	}
	/////////////////////////////////////////////////////////////////
	
	/*-------------------------그래프 삭제------------------------------*/
	//그래프 삭제 처리 - 리스트보기 이동
	@RequestMapping(value="/mem/graph/deleteGraph")
	public String deleteGraph(HttpServletRequest request, Model model) throws Exception {
		log.info(this.getClass().getName() + "start!");
		String graph_seq = request.getParameter("graph_seq");
		int result = graphService.deleteGraph(graph_seq);
		
		log.info(this.getClass().getName() + "end");
		return	graphMain(request, model); //삭제 완료 후 리스트 보기로 이동
	}
	/////////////////////////////////////////////////////////////////
	
	

	/*-------------------------그래프 댓글------------------------------*/
	
	//댓글 가져오기 - page
	@RequestMapping(value="/mem/graph/getGraphRepliesPage")
	public String getGraphRepliesPage(HttpServletRequest request, Model model, String graph_seq) throws Exception {
		log.info("start : " + this.getClass());
		
		//댓글 가져오기
		List<GraphReplyDTO> grDTOs = graphService.getGraphReplies(graph_seq);
		
		model.addAttribute("grDTOs", grDTOs);
		
		log.info("end : " + this.getClass());
		return "/mem/graph/graphRepliesPage";
	}
	
	//댓글 작성 Procedure
	@RequestMapping(value="/mem/graph/boardReplyWriteProc")
	public @ResponseBody GraphReplyDTO boardReplyWriteProc(HttpServletRequest request, Model model, GraphReplyDTO grDTO) throws Exception {
		log.info("start : " + this.getClass());
		
		//수정할 댓글 확인
		log.info(grDTO.getGraph_seq());
		log.info(grDTO.getReply_content());
		log.info(grDTO.getUser_seq());
		log.info(grDTO.getStar_rate());
		
		//Board Reply insert service
		int result = graphService.insertGraphReply(grDTO);
		
		//결과 확인
		log.info("Result of Update Board Post : " + result);
		log.info("end : " + this.getClass());
		
		return grDTO;
	}
	
	/*
	//댓글 삭제
	@RequestMapping(value="/mem/graph/boardReplyDelete")
	public @ResponseBody String boardReplyDelete(HttpServletRequest request, Model model, String reply_seq) throws Exception {
		log.info("start : " + this.getClass());
		
		//댓글 가져오기
		int result = boardReplyService.deleteBoardReply(reply_seq);
		
		String deleteResult = String.valueOf(result);
		log.info("end : " + this.getClass());
		
		return deleteResult;
	}
	
	//댓글 삭제
	@RequestMapping(value="/mem/graph/boardReplyUpdateProc")
	public @ResponseBody String boardReplyUpdateProc(HttpServletRequest request, Model model, BoardReplyDTO brDTO) throws Exception {
		log.info("start : " + this.getClass());
		
		//댓글 가져오기
		int result = boardReplyService.updateBoardReply(brDTO);
		
		String updateResult = String.valueOf(result);
		log.info("end : " + this.getClass());
		
		return updateResult;
	}

*/	
}