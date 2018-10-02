package poly.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.UserMemberDTO;
import poly.service.IMemberService;
import poly.util.CmmUtil;

@Controller
public class MemberController {
	
	@Resource(name="MemberService")
	private IMemberService memberService;
	
	
	/*
	 * 여기는 localhost:8080/a.do라는 
	 * 요청이 들어오고
	 */
	@RequestMapping(value="a")
	public String a() throws Exception{
		//a.jsp파일을 사용자에게 보여준다
		return "/a";
	}
	/*
	 * 여기는 localhost:8080/b.do라는
	 * 요청이 들어오고
	 */
	@RequestMapping(value="b")
	public String b() throws Exception{
		//b.jsp파일을 사용자에게 보여준다
		return "/b";
	}
	
	@RequestMapping(value="c")
	public String c() throws Exception{
		return "/c";
	}
	
	@RequestMapping(value="d")
	public String d() throws Exception{
		return "/d";
	}
	
	//localhost:8080/bmi.do?cm=180&kg=70
	@RequestMapping(value="bmi")
	public String bmi(HttpServletRequest request, Model model) throws Exception{
		String cm = request.getParameter("cm");
		String kg = request.getParameter("kg");
		int icm = Integer.parseInt(cm);
		int ikg = Integer.parseInt(kg);
		
		//전달 받은 몸무게와 키를 가지고 bmi 를 계산 해주세요...
		//kg/(m*m)
		double bmi = ikg/((icm*0.01) * (icm*0.01));
		System.out.println("bmi : " + bmi);
		
		//데이터를 jsp로 전송하기 위해 model객체에 저장하는 코드
		model.addAttribute("bmi", bmi);
		//bmi.jsp를 화면에 보여줌
		return "/bmi";
	}
	
	@RequestMapping(value="post")
	public String post() throws Exception{
		return "/post";
	}
	
	@RequestMapping(value="postResult")
	public String postResult(HttpServletRequest request) throws Exception{
		String cm = request.getParameter("cm");
		String kg = request.getParameter("kg");
		System.out.println("cm: " + cm);
		System.out.println("kg : " + kg);
		return "/bmi";
	}
	
	@RequestMapping(value="detail")
	public String detail() throws Exception{
		return "/detail";
	}
	
	@RequestMapping(value="detailResult")
	public String detailResult(HttpServletRequest req, Model model) throws Exception{
		String name = req.getParameter("name");
		String age = req.getParameter("age");
		String gender = req.getParameter("gender");
		
		System.out.println("name : " + name);
		System.out.println("age : " + age);
		System.out.println("gender : " + gender);
		
		model.addAttribute("name", name);
		model.addAttribute("age", age);
		model.addAttribute("gender", gender);
		
		return "/detailResult";
	}
	
	@RequestMapping(value="main")
	public String main() throws Exception{
		return "/main";
	}
	
	@RequestMapping(value="member/memberReg")
	public String memberReg() throws Exception{
		return "/member/memberReg";
	}
	
	//회원 가입
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
	}
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