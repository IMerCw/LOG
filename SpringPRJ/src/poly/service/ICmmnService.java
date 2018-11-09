package poly.service;

import java.util.HashMap;
import java.util.List;

import poly.dto.UserMemberDTO;

public interface ICmmnService {

	//로그인
	public UserMemberDTO getUserMember(UserMemberDTO uDTO) throws Exception;

	//회원가입
	public int insertUserMember(UserMemberDTO uDTO) throws Exception;

	public UserMemberDTO fndPasswd(String user_id) throws Exception;

	public int deleteUser(UserMemberDTO uDTO) throws Exception;

	public int updateUser(UserMemberDTO uDTO) throws Exception;

	public String getIdChecked(String user_id) throws Exception;
	
	/*
	public int deleteMember(String memberId) throws Exception;
	
	public int updateMember(UserMemberDTO mDTO) throws Exception;
	
	public UserMemberDTO getLogin(HashMap<String, String> param) throws Exception;
	
	public String getIdChk(UserMemberDTO mDTO) throws Exception;
	public List<UserMemberDTO> getSearchList(UserMemberDTO mDTO) throws Exception;

	//회원리스트
	public List<UserMemberDTO> getAllMember() throws Exception;*/
}
