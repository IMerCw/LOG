package poly.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.management.StringValueExp;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpRequest;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.BoardPostDTO;
import poly.dto.BoardReplyDTO;
import poly.dto.UserMemberDTO;
import poly.service.IBoardReplyService;
import poly.service.ICommunityService;
import poly.service.IMemberService;
import poly.util.CmmUtil;

@Controller
public class CommunityController {
	
	private Logger log = Logger.getLogger(this.getClass());
	
	//service 선언
	@Resource(name="CommunityService")
	private ICommunityService communityService;
	
	//서비스 선언
	@Resource(name="BoardReplyService")
	private IBoardReplyService boardReplyService;
	
	//커뮤니티 메인
	@RequestMapping(value="/mem/community/communityMain")
	public String communityMain(HttpServletRequest request, Model model) throws Exception {
		log.info("start : " + this.getClass());
		String board_seq = "1"; //커뮤니티, 게시판 번호 1
		
		//pagination 설정
		int last_index;
		////전체 게시글 갯수 가져오기
		int totalBoardPosts = communityService.getTotalBoardPosts(board_seq);
		////전체 페이지 갯수 (한 페이지 보여 줄 게시글 10 개라고 가정할 때)
		int totalPages = (totalBoardPosts-1) / 5 + 1;
		////현재 요청 페이지
		String currentPage = CmmUtil.nvl(request.getParameter("currentPage"));
		////// null일 경우 1페이지 보여주기
		if("".equals(currentPage)) {
			currentPage = "1";
			last_index = 5;	//목록으로 가져올 마지막 게시글 번호 설정
		} 
		else {
			last_index = Integer.parseInt(currentPage) * 5;	//목록으로 가져올 마지막 게시글 번호 설정
		}
		//파라미터 확인
		log.info("Current page is : " + currentPage);
		log.info("last index is : " + last_index);
		
		Map<String, Integer> bpMap = new HashMap<String, Integer>();
		
		//service 파라미터 설정
		bpMap.put("board_seq", Integer.parseInt(board_seq));
		bpMap.put("last_index", last_index);
		
		
		//게시글 가져오기 service
		List<BoardPostDTO> bpDTOs = communityService.getBoardPostDTO(bpMap);
		
		//가져온 게시글 확인
		log.info(bpDTOs.get(0).getBoard_p_seq());
		log.info(bpDTOs.get(0).getBoard_p_title());
		log.info(bpDTOs.get(0).getBoard_p_content());
		
		log.info(totalPages);
		
		//bpDTOs, 전체 페이지 갯수, 현재페이지 전송
		model.addAttribute("bpDTOs", bpDTOs);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("currentPage", currentPage);
		
		log.info("end : " + this.getClass());
		
		return "/mem/community/communityMain";
	}
	
	//커뮤니티 상세 읽기
	@RequestMapping(value="/mem/community/communityRead")
	public String communityRead(HttpServletRequest request, Model model, String board_p_seq) throws Exception {
		log.info("start : " + this.getClass());
		log.info("board post sequence number: " + board_p_seq);
		
		//현재 페이지 
		String currentPage = CmmUtil.nvl(request.getParameter("currentPage"));
		
		//조회수 하나 증가
		int result = communityService.increaseBoardCount(board_p_seq);
		
		//게시글 가져오기
		BoardPostDTO bpDTO = communityService.getBoardPostDetailDTO(board_p_seq);
		
		//커뮤니티 게시글 상세 확인
		log.info(bpDTO.getBoard_p_title());
		log.info(bpDTO.getBoard_p_content());
		log.info(bpDTO.getFile_py_name());
		
		//bpDTO, 현재페이지, 댓글 내용 전송
		model.addAttribute("bpDTO", bpDTO);
		model.addAttribute("currentPage", currentPage);
		
		log.info("end : " + this.getClass());
		return "/mem/community/communityRead";
	}
	
	//커뮤니티 쓰기 페이지 이동
	@RequestMapping(value="/mem/community/communityWrite")
	public String communityWrite() throws Exception {
		
		return "/mem/community/communityWrite";
	}
	
	//커뮤니티 쓰기 페이지 처리
	@RequestMapping(value="/mem/community/communityWriteProc", method=RequestMethod.POST)
	public String communityWriteProc(HttpServletRequest request, Model model,HttpSession session, BoardPostDTO bpDTO) throws Exception {
		log.info("start : " + this.getClass());
		
		//세션 유저정보 가져오기
		UserMemberDTO uDTO = (UserMemberDTO) session.getAttribute("uDTO");
		
		bpDTO.setUser_seq(uDTO.getUser_seq()); // 유저 번호 삽입
		bpDTO.setBoard_seq("1"); //게시글 번호 삽입
		
		//게시글 정보 확인
		log.info(bpDTO.getUser_seq());
		log.info(bpDTO.getBoard_p_title());
		log.info(bpDTO.getBoard_p_content());
		
		//insert service
		int result = communityService.insertBoardPostDTO(bpDTO);
		
		log.info("end : " + this.getClass());
		
		return communityMain(request, model);
	}
	
	//커뮤니티 게시글 수정
	@RequestMapping(value="/mem/community/communityUpdate")
	public String communityUpdate(HttpServletRequest request, Model model, BoardPostDTO bpDTO) throws Exception {
		log.info("start : " + this.getClass());
		
		//현재 페이지
		String currentPage = CmmUtil.nvl(request.getParameter("currentPage"));
		
		//bpDTO, 현재페이지 전송
		model.addAttribute("bpDTO",bpDTO);
		model.addAttribute("currentPage", currentPage);
		
		log.info("end : " + this.getClass());
		return "/mem/community/communityUpdate";
	}
	
	//커뮤니티 게시글 수정 Procdure
	@RequestMapping(value="/mem/community/communityUpdateProc")
	public String communityUpdateProc(HttpServletRequest request, Model model, BoardPostDTO bpDTO) throws Exception {
		log.info("start : " + this.getClass());
		
		log.info(bpDTO.getUpdate_user_seq());
		log.info(bpDTO.getBoard_p_title());
		log.info(bpDTO.getBoard_p_content());
		
		//게시글 수정 service
		int result = communityService.updateBoardPostDTO(bpDTO);
		
		//결과 확인
		log.info("Result of Update Board Post : " + result);
		log.info("end : " + this.getClass());
		return communityRead(request, model, bpDTO.getBoard_p_seq());
	}
	
	//커뮤니티 게시글 삭제
	@RequestMapping(value="/mem/community/communityDelete")
	public String communityDelete(HttpServletRequest request, Model model, String board_p_seq) throws Exception {
		log.info("start : " + this.getClass());
		
		//게시글 삭제 service
		int result = communityService.deleteBoardPostDTO(board_p_seq);
		
		log.info("end : " + this.getClass());
		return communityMain(request, model);
	}
	
	/*------------------------------------*/
	
	//댓글 가져오기 - page
	@RequestMapping(value="/mem/community/getBoardRepliesPage")
	public String getBoardRepliesPage(HttpServletRequest request, Model model, String board_p_seq) throws Exception {
		log.info("start : " + this.getClass());
		
		//댓글 가져오기
		List<BoardReplyDTO> brDTO = boardReplyService.getBoardReplyDTOs(board_p_seq);
		
		model.addAttribute("brDTO", brDTO);
		
		log.info("end : " + this.getClass());
		return "/mem/community/boardRepliesPage";
	}
	
	//댓글 가져오기
	@RequestMapping(value="/mem/community/getBoardReplies")
	public @ResponseBody ArrayList<BoardReplyDTO> getBoardReplies(HttpServletRequest request, Model model, String board_p_seq) throws Exception {
		log.info("start : " + this.getClass());
		
		//댓글 가져오기
		ArrayList<BoardReplyDTO> brDTO = boardReplyService.getBoardReplyDTOs(board_p_seq);
		
		model.addAttribute("brDTO", brDTO);
		
		log.info("end : " + this.getClass());
		
		return brDTO;
	}
	
	//댓글 작성 Procedure
	@RequestMapping(value="/mem/community/boardReplyWriteProc")
	public @ResponseBody BoardReplyDTO boardReplyWriteProc(HttpServletRequest request, Model model, BoardReplyDTO brDTO) throws Exception {
		log.info("start : " + this.getClass());
		
		//수정할 댓글 확인
		log.info(brDTO.getBoard_p_seq());
		log.info(brDTO.getReply_content());
		log.info(brDTO.getUser_seq());
		
		//Board Reply insert service
		int result = boardReplyService.insertBoardReplyDTO(brDTO);
		
		//결과 확인
		log.info("Result of Update Board Post : " + result);
		log.info("end : " + this.getClass());
		
		return brDTO;
	}
	
	//댓글 삭제
	@RequestMapping(value="/mem/community/boardReplyDelete")
	public @ResponseBody String boardReplyDelete(HttpServletRequest request, Model model, String reply_seq) throws Exception {
		log.info("start : " + this.getClass());
		
		//댓글 가져오기
		int result = boardReplyService.deleteBoardReply(reply_seq);
		
		String deleteResult = String.valueOf(result);
		log.info("end : " + this.getClass());
		
		return deleteResult;
	}
	
	//댓글 삭제
	@RequestMapping(value="/mem/community/boardReplyUpdateProc")
	public @ResponseBody String boardReplyUpdateProc(HttpServletRequest request, Model model, BoardReplyDTO brDTO) throws Exception {
		log.info("start : " + this.getClass());
		
		//댓글 가져오기
		int result = boardReplyService.updateBoardReply(brDTO);
		
		String updateResult = String.valueOf(result);
		log.info("end : " + this.getClass());
		
		return updateResult;
	}

}