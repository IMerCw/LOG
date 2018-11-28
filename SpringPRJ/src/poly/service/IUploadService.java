package poly.service;

import java.util.HashMap;
import java.util.List;

import poly.dto.GraphDTO;
import poly.dto.GraphReplyDTO;
import poly.dto.ImageDTO;
import poly.dto.PublicDataDTO;
import poly.dto.StatGraphRateDTO;
import poly.dto.UserMemberDTO;

public interface IUploadService {

	int updateImage(ImageDTO imgDTO) throws Exception;

	String getImgSeq(String user_seq) throws Exception;

	
	/*
	public int deleteMember(String memberId) throws Exception;
	
	public int updateMember(UserMemberDTO mDTO) throws Exception;
	
	public UserMemberDTO getLogin(HashMap<String, String> param) throws Exception;
	
	public String getIdChk(UserMemberDTO mDTO) throws Exception;
	public List<UserMemberDTO> getSearchList(UserMemberDTO mDTO) throws Exception;

	//회원리스트
	public List<UserMemberDTO> getAllMember() throws Exception;*/
}
