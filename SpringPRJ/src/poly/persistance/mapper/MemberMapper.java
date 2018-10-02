package poly.persistance.mapper;

import java.util.HashMap;
import java.util.List;

import config.Mapper;
import poly.dto.UserMemberDTO;

@Mapper("MemberMapper")
public interface MemberMapper {
	public int insertMember(UserMemberDTO mDTO) throws Exception;
	public List<UserMemberDTO> getAllMember() throws Exception;
	public UserMemberDTO getMemberOne(String memberId) throws Exception;
	public int deleteMember(String memberId) throws Exception;
	public int updateMember(UserMemberDTO mDTO) throws Exception;
	public UserMemberDTO getLogin(HashMap<String, String> param) throws Exception;
	public String getIdChk(UserMemberDTO mDTO) throws Exception;
	public List<UserMemberDTO> getSearchList(UserMemberDTO mDTO) throws Exception;
}
