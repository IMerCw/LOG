package poly.service;

import java.util.HashMap;
import java.util.List;

import poly.dto.UserMemberDTO;

public interface IMemberService {
	public int insertMember(UserMemberDTO mDTO) throws Exception;
	public List<UserMemberDTO> getAllMember() throws Exception;
	public UserMemberDTO getMemberOne(String memberId) throws Exception;
	public int deleteMember(String memberId) throws Exception;
	public int updateMember(UserMemberDTO mDTO) throws Exception;
	public UserMemberDTO getLogin(HashMap<String, String> param) throws Exception;
	public String getIdChk(UserMemberDTO mDTO) throws Exception;
	public List<UserMemberDTO> getSearchList(UserMemberDTO mDTO) throws Exception;
}
