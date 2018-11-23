package poly.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import oracle.net.aso.s;

import org.springframework.mail.javamail.JavaMailSenderImpl;

import poly.dto.BoardPostDTO;
import poly.dto.UserMemberDTO;
import poly.dto.pageParamsDTO;
import poly.service.IAdminHelpCenterService;
import poly.service.IAdminService;
import poly.service.IHelpCenterService;
import poly.util.CmmUtil;


@Controller
public class AdminController {
	
	//로그 표시
	private Logger log = Logger.getLogger(this.getClass());
	
	String msg = null, url = null;
	
	//Admin 서비스
	@Resource(name="AdminService")
	private IAdminService adminService;

	//고객센터 서비스  선언
	@Resource(name="AdminHelpCenterService")
	private IAdminHelpCenterService adminHelpCenterService;
	
	//회원관리 페이지 이동
	@RequestMapping(value="/admin/configMember")
	public String configMember(HttpServletRequest request, HttpSession session, Model model) throws Exception {
		/*-----------------------검색어-------------------------------*/
		//검색어 파라미터 설정 , 미 설정 시 ""로 설정
		String searchContent = CmmUtil.nvl((String)request.getParameter("searchContent"),"");
		
		/*---------------------------------------------------------*/
		
		/*-----------------------페이징-------------------------------*/
		//현재 페이지
		int currentPage = CmmUtil.isInteger((String)request.getParameter("currentPage"),1); //기본 1페이지
		//총 열의 갯수
		int totalCount = adminService.getTotalMemberListCount(searchContent);
		//한 페이지당 보여줄 갯수
		int rowCount = CmmUtil.isInteger((String)request.getParameter("rowCount"),10); //기본 10개
		//전체 페이지 개수
		int totalPages = ((totalCount-1) / rowCount) + 1; //전체 페이지 공식
		/*---------------------------------------------------------*/
		
		/*--------------------------정렬기준--------------------------*/
		//정렬 키값 기준
		String sortValue = CmmUtil.nvl((String)request.getParameter("sortValue"),"USER_REG_DATE"); //기본 가입날짜
		//오름차순 내림차순
		String arrangeOrder = CmmUtil.nvl((String)request.getParameter("arrangeOrder"),"DESC"); // 기본 내림차순
		/*---------------------------------------------------------*/
		

		/*----------------------유저 리스트 가져오기-----------------------*/
		//파라미터 설정
		pageParamsDTO pDTO = new pageParamsDTO();
		pDTO.setCurrentPage(currentPage);
		pDTO.setRowCount(rowCount);
		pDTO.setSortValue(sortValue);
		pDTO.setArrangeOrder(arrangeOrder);
		pDTO.setTotalCount(totalCount);
		pDTO.setTotalPages(totalPages);
		pDTO.setSearchContent(searchContent);
		
		log.info("currentPage " + currentPage);
		log.info("rowCount " + rowCount);
		log.info("sortValue " + sortValue);
		log.info("arrangeOrder " + arrangeOrder);
		log.info("totalCount "+ totalCount);
		log.info("totalPages "+ totalPages);
		log.info("searchContent "+ searchContent);
		
		List<UserMemberDTO> uDTOs = adminService.getAllUser(pDTO);
		
		model.addAttribute("uDTOs", uDTOs);
		model.addAttribute("pDTO", pDTO);
		
		return "/admin/configMember";
	}
	
	//회원 정보 수정
	@RequestMapping(value="/admin/adminUpdateUserProc")
	public @ResponseBody int adminUpdateUserProc(UserMemberDTO updatedUDTO) throws Exception {
		log.info("start: " + this.getClass().getName() );
		
		log.info(updatedUDTO.getUser_name());
		log.info(updatedUDTO.getUser_state());
		
		//변경된 회원정보 DB저장
		int insertResult = adminService.updateUser(updatedUDTO);
		
		log.info("end : " + this.getClass().getName());
		
		return insertResult;
	}
	
	//유저 리스트 검색
	@RequestMapping(value="/admin/adminSearchUser")
	public String adminSearchUser(HttpServletRequest request, Model model) throws Exception {
		log.info("start: " + this.getClass().getName() );
		
		String searchContent = (String) request.getParameter("searchContent");
		
		log.info(searchContent);
		
		// 검색어 조건의 유저 리스트 가져오기
		List<UserMemberDTO> uDTOs = adminService.getSearchUser(searchContent);
		
		model.addAttribute("uDTOs", uDTOs);
		
		log.info("end: " + this.getClass().getName() );
		return "/admin/configMember";
	}
	
	//관리자용 고객센터 이동
	@RequestMapping(value="/admin/adminHelpCenterMain")
	public String adminHelpCenter(HttpServletRequest request, HttpSession session, Model model) throws Exception {
		log.info("start: " + this.getClass().getName() );
		String board_seq = "2"; //고객센터, 게시판 번호 2
		
		//pagination 설정
		int last_index;
		////전체 게시글 갯수 가져오기
		int totalBoardPosts = adminHelpCenterService.getTotalBoardPosts(board_seq);
		////전체 페이지 갯수 (한 페이지 보여 줄 게시글 5 개라고 가정할 때)
		int totalPages = (totalBoardPosts-1) / 5 + 1;
		////현재 요청 페이지
		String currentPage = CmmUtil.nvl((String)request.getParameter("currentPage"));
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
		log.info("total pages are : " + totalPages);
		log.info("totalBoardPosts are : " + totalBoardPosts);
		
		Map<String, Integer> bpMap = new HashMap<String, Integer>();
		
		//현재 사용자 가져오기
		UserMemberDTO uDTO = (UserMemberDTO) session.getAttribute("uDTO");
		String user_seq = uDTO.getUser_seq();
		
		//service 파라미터 설정
		bpMap.put("board_seq", Integer.parseInt(board_seq));
		bpMap.put("last_index", last_index);
		
		log.info("현재 유저" + user_seq);
		
		//게시글 가져오기 service
		List<BoardPostDTO> bpDTOs = adminHelpCenterService.getBoardPostDTO(bpMap);
		
		
		
		//bpDTOs, 전체 페이지 갯수, 현재페이지 전송
		model.addAttribute("bpDTOs", bpDTOs);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("currentPage", currentPage);
		
		log.info("end : " + this.getClass());
		
		return "/mem/helpCenter/helpCenterMain";
		
	}
}
