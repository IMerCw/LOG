package poly.persistance.mapper;

import java.util.HashMap;
import java.util.List;

import config.Mapper;
import poly.dto.ImageDTO;
import poly.dto.KakaoUserDTO;
import poly.dto.UserMemberDTO;
import poly.dto.pageParamsDTO;

@Mapper("AdminMapper")
public interface AdminMapper {

	List<UserMemberDTO> getAllUser(pageParamsDTO pDTO) throws Exception;

	int updateUser(UserMemberDTO updatedUDTO) throws Exception;

	List<UserMemberDTO> getSearchUser(String searchContent) throws Exception;

	int getTotalMemberListCount(String searchContent) throws Exception;
	
	
/*
	public List<UserMemberDTO> getAllMember() throws Exception;
	public int deleteMember(String memberId) throws Exception;
	public int updateMember(UserMemberDTO mDTO) throws Exception;
	public UserMemberDTO getLogin(HashMap<String, String> param) throws Exception;
	public String getIdChk(UserMemberDTO mDTO) throws Exception;
	public List<UserMemberDTO> getSearchList(UserMemberDTO mDTO) throws Exception;
*/
}
