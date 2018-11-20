package poly.service;

import java.util.HashMap;
import java.util.List;

import poly.dto.GraphDTO;
import poly.dto.PublicDataDTO;
import poly.dto.UserMemberDTO;

public interface IGraphService {

	List<PublicDataDTO> getPublicData() throws Exception;

	PublicDataDTO getOnePublicData(String pdata_seq) throws Exception;

	int insertGraph(GraphDTO gDTO) throws Exception;

	List<GraphDTO> getGraphList() throws Exception;

	
	/*
	public int deleteMember(String memberId) throws Exception;
	
	public int updateMember(UserMemberDTO mDTO) throws Exception;
	
	public UserMemberDTO getLogin(HashMap<String, String> param) throws Exception;
	
	public String getIdChk(UserMemberDTO mDTO) throws Exception;
	public List<UserMemberDTO> getSearchList(UserMemberDTO mDTO) throws Exception;

	//회원리스트
	public List<UserMemberDTO> getAllMember() throws Exception;*/
}
