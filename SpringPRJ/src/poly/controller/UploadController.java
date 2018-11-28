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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import poly.dto.BoardPostDTO;
import poly.dto.BoardReplyDTO;
import poly.dto.ImageDTO;
import poly.dto.UserMemberDTO;
import poly.service.IBoardReplyService;
import poly.service.ICommunityService;
import poly.service.IMemberService;
import poly.service.IUploadService;
import poly.util.CmmUtil;
import poly.util.UtilFile;

@Controller
public class UploadController {
	
	private Logger log = Logger.getLogger(this.getClass());
	
	//service 선언
	@Resource(name="UploadService")
	private IUploadService uploadService;
	
	//이미지 업로드
	@RequestMapping(value="/imageUpload")
	public @ResponseBody HashMap<String, String> imageUpload(@RequestParam("uploadFile") MultipartFile uploadFile, MultipartHttpServletRequest request, Model model, HttpSession session) throws Exception {
		log.info("start : " + this.getClass());
		
		UserMemberDTO uDTO = (UserMemberDTO) session.getAttribute("uDTO");
		
		/*------------------------파일 업로드----------------------------*/ 
		//..UtilFile 객체 생성
        UtilFile utilFile = new UtilFile();
        
        //..파일 업로드 결과값을 path로 받아온다(이미 fileUpload() 메소드에서 해당 경로에 업로드는 끝났음)
        String fileName = uploadFile.getOriginalFilename();
        log.info(fileName);
        
    	String uploadPath = utilFile.fileUpload(request, uploadFile);
    	
    	//..Service DB저장
    	ImageDTO imgDTO = new ImageDTO();
    	
    	imgDTO.setFile_path(uploadPath);
    	imgDTO.setFile_py_name("\\" + uploadPath.split("\\\\") [uploadPath.split("\\\\").length-1]);
    	imgDTO.setReg_user_seq(uDTO.getUser_seq());
    	
    	log.info(imgDTO.getFile_py_name());
    	log.info(imgDTO.getFile_path());
    	log.info(imgDTO.getReg_user_seq());
    	
    	//이미지 테이블 저장
    	int result = uploadService.updateImage(imgDTO);
    	
    	//저장된 img seq 가져오기
    	String img_seq = uploadService.getImgSeq(uDTO.getUser_seq());
    	imgDTO.setImg_seq(img_seq);
    	
    	log.info("result======" + result);
    	HashMap<String, String> imgMap = new HashMap<String, String>();
    	imgMap.put("imgSeq", imgDTO.getImg_seq());
    	imgMap.put("imgPyName", imgDTO.getFile_py_name());
    	
		log.info("end : " + this.getClass());
		
		return imgMap;
	}
	
}