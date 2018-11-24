package poly.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
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

import poly.dto.NoticeDTO;
import poly.dto.UserMemberDTO;
import poly.service.IMemberService;
import poly.service.INoticeService;
import poly.util.CmmUtil;

@Controller
public class NoticeController {
	//로그
	private Logger log = Logger.getLogger(this.getClass());
	
	//service 선언
	@Resource(name="NoticeService")
	private INoticeService noticeService;
	
	String msg = null, url = null;
	
	//새소식 갯수 가져오기
	@RequestMapping(value="/mem/getNoticeCount")
	public @ResponseBody int getNoticeCount(HttpServletRequest request, HttpSession session, Model model) throws Exception {
		log.info("start : " +this.getClass().getName());
		
		//필요한 파라미터 가져오기
		String user_seq = (String)request.getParameter("user_seq");
		//새 소식 갯수 4개까지만 가져오기
		int noticeCount = noticeService.getNoticeCount(user_seq);
		
		log.info("end : " +this.getClass().getName());
		return noticeCount;
	}
	//새소식 보기
	@RequestMapping(value="/mem/notificationWidget")
	public String notification(HttpServletRequest request, HttpSession session, Model model) throws Exception {
		log.info("start : " +this.getClass().getName());
		
		//필요한 파라미터 가져오기
		String user_seq = (String)request.getParameter("user_seq");
		
		//위젯용 요약데이터 : 특정 회원의 최근 7일, 4개의 데이터를 가져옴 
		List<NoticeDTO> nDTOs = noticeService.getNotificationSummary(user_seq);
		
		//모델 전송
		model.addAttribute("nDTOs", nDTOs);
		
		log.info("end : " +this.getClass().getName());
		return "/mem/notice/notificationWidget";
	}	
	
	//새소식 자세히 보기
	@RequestMapping(value="/mem/notificationDetail")
	public String nofiticationDetail(HttpServletRequest request, Model model) throws Exception {
		log.info("start : " +this.getClass().getName());
		
		//필요한 파라미터 가져오기
		String user_seq = (String)request.getParameter("user_seq");
		
		//특정 유저의 게시글 중 댓글 최근 10개의 데이터 가져오기
		List<NoticeDTO> nDTOs = noticeService.getNotification(user_seq);		
		
		//모델 전송
		model.addAttribute("nDTOs", nDTOs);
		
		log.info("end : " +this.getClass().getName());
		
		return "/mem/notice/notificationDetail";
	}
	
/*	//회원 가입
	@RequestMapping(value="member/memberRegProc")
	public String memberRegProc(HttpServletRequest req, Model model, UserMemberDTO mDTO) throws Exception{
		
		//변수들을 각각 넘기면 코드도 길고 귀찮으니까 DTO를 사용한다.
		//DTO는 Data Fransfer Object의 약자로 데이터 전송을 위한 객체
		
		int result = memberService.insertMember(mDTO);
		
		if(result != 1){
			//회원가입이 정상적으로 이루어지지 않음
			model.addAttribute("msg", "회원가입에 실패 하셨습니다.");
			model.addAttribute("url", "/member/memberReg.do");
		}else{
			//회원가입이 정상적으로 이루어짐
			//정상적으로 회원가입이 되면 '회원가입이 되었습니다' alert창 띄우고 main.do로 이동
			model.addAttribute("msg", "회원가입이 되었습니다.");
			model.addAttribute("url", "/main.do");
		}
		
		return "/alert";
	}
	
	
	@RequestMapping(value="member/memberList")
	public String memberList(Model model) throws Exception{
		List<UserMemberDTO> mList = memberService.getAllMember();
		model.addAttribute("mList", mList);
		return "/member/memberList";
	}
	
	@RequestMapping(value="member/memberDetail")
	public String memberDetail(HttpServletRequest request, Model model) throws Exception{
		
		String memberId = request.getParameter("memberId");
		
		UserMemberDTO mDTO = memberService.getMemberOne(memberId);
		
		model.addAttribute("mDTO", mDTO);
		
		return "/member/memberDetail";
	}
	
	@RequestMapping(value="member/deleteMember")
	public String deleteMember(HttpServletRequest request, Model model) throws Exception{
		
		String memberId = request.getParameter("memberId");
		
		int result = memberService.deleteMember(memberId);
		
		if(result == 1){
			model.addAttribute("msg", "삭제");
			model.addAttribute("url", "/main.do");
		}
		
		return "/alert";
	}
	
	@RequestMapping(value="member/updateView")
	public String updateView(HttpServletRequest request, Model model) throws Exception{
		
		String memberId = request.getParameter("memberId");
		
		UserMemberDTO mDTO = memberService.getMemberOne(memberId);
		
		model.addAttribute("mDTO", mDTO);
		
		return "/member/updateView";
	}*/
	/*
	@RequestMapping(value="member/memberUpdateProc")
	public String updateProc(HttpServletRequest request, Model model) throws Exception{
		
		String memberId = request.getParameter("memberId");
		String name = request.getParameter("name");
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String gender = request.getParameter("gender");
		
		UserMemberDTO mDTO = new UserMemberDTO();
		mDTO.setMember_id(memberId);
		mDTO.setMember_name(name);
		mDTO.setId(id);
		mDTO.setPassword(password);
		mDTO.setGender(gender);
		
		int result = memberService.updateMember(mDTO);
		
		if(result != 0){
			model.addAttribute("msg", "수정되었습니다.");
		}else{
			model.addAttribute("msg", "수정 실패");
		}
		
		model.addAttribute("url", "/member/memberDetail.do?memberId=" + memberId);
		
		return "/alert";
	}
	
	@RequestMapping(value="member/loginProc", method=RequestMethod.POST)
	public String loginProc(@RequestParam HashMap<String, String> param, HttpSession session, Model model) throws Exception{
		UserMemberDTO mDTO = memberService.getLogin(param);
		if(mDTO==null){
			//로그인 실패 상태
			model.addAttribute("msg", "로그인 실패");
		}else{
			//로그인 성공
			session.setAttribute("id", mDTO.getId());
			model.addAttribute("msg", "로그인 성공");
		}
		model.addAttribute("url", "/main.do");
		
		return "/alert";
	}
	
	@RequestMapping(value="member/logout")
	public String logout(HttpSession session) throws Exception{
		//세션을 초기화 하는 함수
		//세션이 초기화가 됐으니 로그인이 풀렸겠죠???
		session.invalidate();
		
		//그다음 메인 페이지를 보여줘라...
		return "redirect:/main.do";
	}
	
	@RequestMapping(value="/member/idChk")
	public @ResponseBody String idChk(@RequestParam(value="id") String id) throws Exception{
		UserMemberDTO mDTO = new UserMemberDTO();
		mDTO.setId(CmmUtil.nvl(id));
		
		System.out.println(id);
		String idChk = memberService.getIdChk(mDTO);
		
		System.out.println(idChk);
		
		return idChk;
	}
	
	@RequestMapping(value="/member/searchList")
	public @ResponseBody List<UserMemberDTO> searchList(@RequestParam(value="search") String search) throws Exception{
		System.out.println(search);
		
		UserMemberDTO mDTO = new UserMemberDTO();
		mDTO.setId(CmmUtil.nvl(search));
		
		List<UserMemberDTO> mList = memberService.getSearchList(mDTO);
		
		for(UserMemberDTO dDTO : mList){
			System.out.println(dDTO.getId());
			System.out.println(dDTO.getMember_name());
			System.out.println(dDTO.getMember_id());
			System.out.println(dDTO.getGender());
		}
		
		return mList;
	}
	
	@RequestMapping(value="/member/rList")
	public @ResponseBody List<UserMemberDTO> rList() throws Exception{
		List<UserMemberDTO> mList = memberService.getAllMember();
		return mList;
	}
	
	@RequestMapping(value="/jsptest")
	public String jsptest(HttpServletRequest request, Model model) throws Exception {
		
		return "/jsptest";
	}*/
	
	
}