package poly.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.mail.Session;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import poly.dto.ImageDTO;
import poly.dto.KakaoUserDTO;
import poly.dto.UserMemberDTO;
import poly.service.ICmmnService;
import poly.util.CmmUtil;
import poly.util.HashFunc;
import poly.util.MailHandler;
import poly.util.UtilFile;


@Controller
public class SocialNetworkController {

	//로그 표시
	private Logger log = Logger.getLogger(this.getClass());
	
	String msg = null, url = null;

	//cmmn 서비스
	@Resource(name="CmmnService")
	private ICmmnService cmmnService;
	
    private final static String K_CLIENT_ID = "59c7e2d73ac8002bd4a89d0d5569c167";
    private final static String K_REDIRECT_URI = "http://localhost:8080/kakaoLogin.do";

    //카카오 로그인 리다이렉트
	@RequestMapping(value="/kakaoLogin")
	public String kakaoLogin(@RequestParam("code") String code, HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.info("Start : kakaoLogin");

		JsonNode userInfo = getKakaoUserInfo(code);
		
		System.out.println(userInfo);
		
		String id = userInfo.get("id").toString().replaceAll("\"", "");
		String nickName = userInfo.get("properties").get("nickname").toString().replaceAll("\"", "");
		String profile_image = userInfo.get("properties").get("profile_image").toString().replaceAll("\"", "");
		String thumbnail_image = userInfo.get("properties").get("thumbnail_image").toString().replaceAll("\"", "");
		String email = userInfo.get("kakao_account").get("email").toString().replaceAll("\"", "");
		
		log.info(id);
		log.info(nickName);
		log.info(email);
		
		/*********************이미 가입된 회원인지 확인*********************/
		UserMemberDTO uDTO = null;
		String user_seq = CmmUtil.nvl(cmmnService.getIdChecked(email));
		log.info(user_seq);
		int insertResult, updateResult;
		if("".equals(user_seq)) {
			log.info("새로운 카카오 회원입니다.");
			/*********************가입이 되어 있지 않은 경우*********************/

			//회원가입용 멤버 DTO 설정 
			uDTO = new UserMemberDTO();
			uDTO.setUser_name(nickName); //유저 이름
			uDTO.setUser_id(email); //유저 이메일
			uDTO.setUser_passwd("0"); // 유저 비밀번호는 설정하지 않음
			uDTO.setUser_state("1"); //가입시 유저 상태 1 - 정상 설정
			uDTO.setKakao_user_yn("1"); // 카카오 유저일 경우 1 설정
			
			cmmnService.insertUserMember(uDTO); //DB저장
			
			uDTO = cmmnService.getKakaoUser(uDTO);// seq값을 받기 위한 유저 정보 다시 가져오기
			
			//유저 이미지 정보 저장
			ImageDTO imgDTO = new ImageDTO();
			imgDTO.setReg_user_seq(uDTO.getUser_seq());
			imgDTO.setFile_py_name(profile_image);
			
			insertResult = cmmnService.updateImage(imgDTO); // 유저 이미지 정보 저장
			
        	String img_seq = cmmnService.getImgSeq(uDTO.getUser_seq()); //저장된 img seq 가져오기
        	uDTO.setImg_seq(img_seq); //이미지 변경사항 서비스 보내기전 설정
    		updateResult = cmmnService.updateImgSeq(uDTO); // 유저 이미지 정보 DB변경
    		
			
			//카카오 계정 정보를 DB에 저장
			KakaoUserDTO kDTO = new KakaoUserDTO();
			kDTO.setUser_seq(uDTO.getUser_seq());
			kDTO.setKakao_id(id);
			kDTO.setThumbnail_image(thumbnail_image);
			kDTO.setProfile_image(profile_image);
			
			insertResult = cmmnService.insertKakaoUser(kDTO); // 카카오 유저 정보 DB에 저장
			
			
			/************************************************************/
			
		} else {
			log.info("이미 가입된 카카오 회원입니다.");
			uDTO = new UserMemberDTO();
			uDTO.setUser_id(email); // select 시 필요한 파라미터 설정
			uDTO =  cmmnService.getKakaoUser(uDTO); //DB에서 정보 가져오기
		}
		
		uDTO.setFile_py_name(profile_image); // 이미지 정보
		session.setAttribute("uDTO", uDTO); // 세션에 유저정보 저장

		log.info("End : kakaoLogin");
		
		return "redirect:/mem/main.do";
	}
	
	
	public String getAccessToken(String autorize_code) {

	      final String RequestUrl = "https://kauth.kakao.com/oauth/token";
	      final List<NameValuePair> postParams = new ArrayList<NameValuePair>();
	      postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
	      postParams.add(new BasicNameValuePair("client_id", K_CLIENT_ID)); // REST API KEY
	      postParams.add(new BasicNameValuePair("redirect_uri", K_REDIRECT_URI)); // 리다이렉트 URI
	      postParams.add(new BasicNameValuePair("code", autorize_code)); // 로그인 과정 중 얻은 code 값

	      final HttpClient client = HttpClientBuilder.create().build();
	      final HttpPost post = new HttpPost(RequestUrl);
	      JsonNode returnNode = null;

	      try {

	        post.setEntity(new UrlEncodedFormEntity(postParams));
	        final HttpResponse response = client.execute(post);
	        final int responseCode = response.getStatusLine().getStatusCode();

	        // JSON 형태 반환값 처리

	        ObjectMapper mapper = new ObjectMapper();
	        returnNode = mapper.readTree(response.getEntity().getContent());

	      } catch (UnsupportedEncodingException e) {

	        e.printStackTrace();

	      } catch (ClientProtocolException e) {

	        e.printStackTrace();

	      } catch (IOException e) {

	        e.printStackTrace();

	      } finally {
	        // clear resources
	      }
	      return returnNode.get("access_token").toString();
	      
	    }

    public JsonNode getKakaoUserInfo(String autorize_code) {

	      final String RequestUrl = "https://kapi.kakao.com/v2/user/me";
//	      String CLIENT_ID = K_CLIENT_ID; // REST API KEY
//	      String REDIRECT_URI = K_REDIRECT_URI; // 리다이렉트 URI
//	      String code = autorize_code; // 로그인 과정중 얻은 토큰 값
	      
	      final HttpClient client = HttpClientBuilder.create().build();
	      final HttpPost post = new HttpPost(RequestUrl);
	      String accessToken = getAccessToken(autorize_code);
	      // add header
	      post.addHeader("Authorization", "Bearer " + accessToken);
	      
	      JsonNode returnNode = null;

	      try {
	    	  
	        final HttpResponse response = client.execute(post);
	        final int responseCode = response.getStatusLine().getStatusCode();
	        System.out.println("\nSending 'POST' request to URL : " + RequestUrl);
	        System.out.println("Response Code : " + responseCode);

	        // JSON 형태 반환값 처리
	        ObjectMapper mapper = new ObjectMapper();
	        returnNode = mapper.readTree(response.getEntity().getContent());
	      } catch (UnsupportedEncodingException e) {
	        e.printStackTrace();
	      } catch (ClientProtocolException e) {
	        e.printStackTrace();
	      } catch (IOException e) {
	        e.printStackTrace();
	      } finally {

	        // clear resources
	      }
	      return returnNode;
	    }
	
}
