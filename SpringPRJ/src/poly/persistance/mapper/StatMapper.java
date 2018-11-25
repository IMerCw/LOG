package poly.persistance.mapper;

import java.util.HashMap;
import java.util.List;

import config.Mapper;
import poly.dto.GraphDTO;
import poly.dto.GraphReplyDTO;
import poly.dto.PublicDataDTO;
import poly.dto.StatGraphRateDTO;
import poly.dto.UserMemberDTO;

@Mapper("StatMapper")
public interface StatMapper {

	List<StatGraphRateDTO> getGraphRate() throws Exception;

	
/*
	public List<UserMemberDTO> getAllMember() throws Exception;
	public int deleteMember(String memberId) throws Exception;
	public int updateMember(UserMemberDTO mDTO) throws Exception;
	public UserMemberDTO getLogin(HashMap<String, String> param) throws Exception;
	public String getIdChk(UserMemberDTO mDTO) throws Exception;
	public List<UserMemberDTO> getSearchList(UserMemberDTO mDTO) throws Exception;
*/
}
