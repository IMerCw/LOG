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

import poly.dto.GraphDTO;
import poly.dto.UserMemberDTO;
import poly.service.IGraphService;
import poly.service.IMemberService;
import poly.util.CmmUtil;

@Controller
public class MyGraphController {
	
	//로그
	private Logger log = Logger.getLogger(this.getClass());
	
	//service 선언
	@Resource(name="GraphService")
	private IGraphService graphService;
	
	//내 그래프 메인
	@RequestMapping(value="/mem/myGraph/myGraphMain")
	public String myGraphMain(Model model, HttpSession session) throws Exception {
		log.info(this.getClass().getName() + "start!");
		
		//기존 세션 삭제
		session.removeAttribute("accessRoot");
				
		//필요한 파라미터 가져오기
		UserMemberDTO uDTO = (UserMemberDTO) session.getAttribute("uDTO");
		String user_seq = uDTO.getUser_seq();
		
		//내 그래프 리스트 가져오기
		List<GraphDTO> gDTO = graphService.getMyGraphList(user_seq);
		//접근한 경로 저장
		String accessRoot = "myGraph";
		
		model.addAttribute("gDTO", gDTO);
		session.setAttribute("accessRoot", accessRoot);
		log.info(this.getClass().getName() + "end");
		
		return "/mem/graph/graphMain";
	}
}