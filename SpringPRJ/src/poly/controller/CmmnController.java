package poly.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.mail.Session;
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

import poly.dto.ImageDTO;
import poly.dto.UserMemberDTO;
import poly.service.ICmmnService;
import poly.util.CmmUtil;
import poly.util.UtilFile;


@Controller
public class CmmnController {

	//로그 표시
	private Logger log = Logger.getLogger(this.getClass());
	
	String msg = null, url = null;
	
	//cmmn 서비스
	@Resource(name="CmmnService")
	private ICmmnService cmmnService;
	
	
	//공통 메인 페이지
	@RequestMapping(value="/cmmn/main")
	public String cmmnMain(HttpServletRequest request, Model model) throws Exception {
		log.info(this.getClass() + " start");
		
		log.info(this.getClass() + " end");
		return "/cmmn/main";
	}
	
	//로그인 처리
	@RequestMapping(value="/cmmn/loginProc")
	public String loginProc(HttpServletRequest request, Model model, HttpSession session, UserMemberDTO uDTO) throws Exception {
		log.info(this.getClass() + " start");
		
		//아이디 및 패스워드 확인
		log.info(uDTO.getUser_id());
		log.info(uDTO.getUser_passwd());
		
		//가져오기
		UserMemberDTO verifiedUDTO = cmmnService.getUserMember(uDTO);
		
		//존재하지 않는 회원인 경우
		if(verifiedUDTO == null) {
			log.info("유효하지 않은 유저");
			
			msg = "회원가입에 실패하였습니다. 아이디 및 비밀번호를 확인해주세요.";
			url = "/cmmn/main.do";
			
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			
			return "/alert";
		}
		
		log.info("가져온 UserDTO 확인");
		log.info(verifiedUDTO.getUser_seq());
		log.info(verifiedUDTO.getUser_id());
		log.info(verifiedUDTO.getUser_name());
		log.info(verifiedUDTO.getUser_passwd());
		log.info(verifiedUDTO.getUser_reg_date());
		log.info(verifiedUDTO.getFile_py_name());
		
		session.setAttribute("uDTO", verifiedUDTO);
		
		log.info(this.getClass() + " end");
		return "redirect:/mem/main.do";
	}
	
	
	////회원가입
	//회원가입 페이지 이동
	@RequestMapping(value="/cmmn/reg")
	public String reg(HttpServletRequest request, Model model) throws Exception {
		log.info(this.getClass() + " start");

		log.info(this.getClass() + " end");
		return "/cmmn/reg";
	}
	
	@RequestMapping(value="/cmmn/idCheck")
	public @ResponseBody int idCheck(HttpServletRequest request, Model model, String user_id) throws Exception {
		log.info(this.getClass() + " start");

		int result = -1; // -1 중복사용 중
		String checkResult = CmmUtil.nvl(cmmnService.getIdChecked(user_id));
		
		log.info("checked result is : " + checkResult);
		//null 값일 경우 1 지정
		if("".equals(checkResult)) {
			result = 1; // 1 미중복 사용
		}
		
		log.info(this.getClass() + " end");
		return result;
	}
	
	
	//회원가입 처리
	@RequestMapping(value="/cmmn/regProc", method=RequestMethod.POST)
	public String regProc(HttpServletRequest request, Model model, UserMemberDTO uDTO) throws Exception {
		log.info(this.getClass() + " start");
		
		//아이디 및 패스워드, 이름 가입정보 확인
		log.info(uDTO.getUser_id());
		log.info(uDTO.getUser_passwd());
		log.info(uDTO.getUser_name());
		
		int resultInsert = cmmnService.insertUserMember(uDTO);
		
		log.info("회원가입 결과 : " + resultInsert);
		
		/*------------------------------------------*/
		//이메일 인증 모듈
		
		log.info(this.getClass() + " end");
		return "/cmmn/emailValidation";
	}
	
	//아이디 및 비밀번호 찾기
	@RequestMapping(value="/cmmn/fnd.do")
	public String fnd(HttpServletRequest request, Model model) throws Exception {
		log.info(this.getClass() + " start");
		
		log.info(this.getClass() + " end");
		return "/cmmn/fnd";
	}
	
	//비밀번호 찾기
	@RequestMapping(value="/cmmn/fndProc.do")
	public String fndProc(HttpServletRequest request, Model model) throws Exception {
		log.info(this.getClass() + " start");
		
		String user_id = CmmUtil.nvl(request.getParameter("user_id"));
		
		log.info("아이디 확인: " + user_id);
		
		UserMemberDTO uDTO = cmmnService.fndPasswd(user_id);
		
		//존재하지 않는 회원인 경우
		if(uDTO == null) {
			log.info("유효하지 않은 유저");
			
			msg = "존재하지 않는 회원입니다.";
			url = "/cmmn/main.do";
			
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			
			return "/alert";
		}
		
		//아이디 및 패스워드, 이름 가입정보 확인
		log.info(uDTO.getUser_id());
		log.info(uDTO.getUser_passwd());
		log.info(uDTO.getUser_name());
		
		//임시비밀번호 이메일 전송  모듈
		/****************************/
		/****************************/
		
		//이메일 전송 후
		msg = "임시비밀번호를 전송하였습니다. 확인해주세요.";
		url = "/cmmn/main.do";
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		log.info(this.getClass() + " end");
		return "/alert";
	}
	
	//회원 탈퇴
	@RequestMapping(value="/cmmn/deleteUser")
	public String deleteUser(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		log.info(this.getClass() + " start");
		
		UserMemberDTO uDTO = (UserMemberDTO) session.getAttribute("uDTO");
		int result = cmmnService.deleteUser(uDTO);
		
		log.info("회원 상태 변경 결과: " + result);
		
		
		msg = "성공적으로 탈퇴하였습니다.";
		url = "/cmmn/main.do";
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		log.info(this.getClass() + " end");
		return "/alert";
	}
	
	
	//회원 수정
	@RequestMapping(value="/cmmn/updateUser")
	public String updateUser(@RequestParam("uploadFile") MultipartFile uploadFile, MultipartHttpServletRequest request, Model model, HttpSession session, UserMemberDTO updatedUDTO) throws Exception {
		log.info(this.getClass() + " start");
		
		UserMemberDTO uDTO = (UserMemberDTO)session.getAttribute("uDTO");
		
		updatedUDTO.setUser_seq(uDTO.getUser_seq());
		//수정된 회원 정보 확인
		log.info(updatedUDTO.getUser_seq());
		log.info(updatedUDTO.getUser_passwd());
		log.info(updatedUDTO.getUser_name());
		//파일 업로드 
		//..UtilFile 객체 생성
        UtilFile utilFile = new UtilFile();
        
        //..파일 업로드 결과값을 path로 받아온다(이미 fileUpload() 메소드에서 해당 경로에 업로드는 끝났음)
        String uploadPath = utilFile.fileUpload(request, uploadFile);
        //..Service DB저장
        ImageDTO imgDTO = new ImageDTO();
        imgDTO.setFile_path(uploadPath);
        imgDTO.setFile_py_name(uploadPath.split("\\\\") [uploadPath.split("\\\\").length-1]);
        imgDTO.setReg_user_seq(updatedUDTO.getUser_seq());
        imgDTO.setUpdate_user_seq(updatedUDTO.getUser_seq());
        
        log.info(imgDTO.getFile_py_name());
        log.info(imgDTO.getFile_path());
        
        //이미지 테이블 저장
        int result = cmmnService.updateImage(imgDTO);
        log.info("result======" + result);
        
		//회원 정보 업로드
		result = cmmnService.updateUser(updatedUDTO);
		
		log.info("회원 상태 변경 결과: " + result);
		
		msg = "성공적으로 수정하였습니다.";
		url = "/mem/main.do";
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		log.info(this.getClass() + " end");
		return "/alert";
	}
	//로그아웃
	@RequestMapping(value="/cmmn/logout")
	public String logout(HttpSession session) throws Exception{
		log.info(this.getClass() + " start");
		
		//세션 초기화
		session.invalidate();
		
		log.info(this.getClass() + " end");
		return "redirect:/cmmn/main.do";
	}

	
}
