package poly.controller;

import java.util.HashMap;
import java.util.List;

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

import poly.dto.UserMemberDTO;
import poly.service.IAdminService;
import poly.util.HashFunc;


@Controller
public class AdminController {
	
	//로그 표시
	private Logger log = Logger.getLogger(this.getClass());
	
	String msg = null, url = null;
	
	//Admin 서비스
	@Resource(name="AdminService")
	private IAdminService adminService;
	
	//회원관리 페이지 이동
	@RequestMapping(value="/admin/configMember")
	public String configMember(Model model) throws Exception {
		
		//유저 리스트 가져오기
		List<UserMemberDTO> uDTOs = adminService.getAllUser();
		
		uDTOs.get(0).getUser_name();
		
		model.addAttribute("uDTOs", uDTOs);
		
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
	
	//유저 정보 찾기
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
		
}
