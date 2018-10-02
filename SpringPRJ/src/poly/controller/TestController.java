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


@Controller
public class TestController {
	
	@RequestMapping(value="/brain04/ReadCookies")
	public String ReadCookies(HttpServletRequest request, Model model) throws Exception {
		return "/brain04/ReadCookies";
	}
	
	@RequestMapping(value="/brain04/DeleteCookie")
	public String DeleteCookie(HttpServletRequest request, Model model) throws Exception {
		return "/brain04/DeleteCookie";
	}
	
	@RequestMapping(value="/brain04/StoreCookies")
	public String StoreCookies(HttpServletRequest request, Model model) throws Exception {
		return "/brain04/StoreCookies";
	}
	
	
}
