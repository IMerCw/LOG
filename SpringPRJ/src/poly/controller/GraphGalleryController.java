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
public class GraphGalleryController {

	//Service 선언
	@Resource(name="MemberService")
	private IMemberService memberService;
	
	//그래프 갤러리
	@RequestMapping(value="/mem/graph/graphMain")
	public String graphMain(Model model) throws Exception {
		
		return "/mem/graph/graphMain";
	}
	
}