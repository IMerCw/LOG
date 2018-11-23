package poly.persistance.mapper;

import java.util.HashMap;
import java.util.List;

import config.Mapper;
import poly.dto.GraphDTO;
import poly.dto.GraphReplyDTO;
import poly.dto.PublicDataDTO;
import poly.dto.UserMemberDTO;

@Mapper("GraphMapper")
public interface GraphMapper {

	//공공데이터 목록 가져오기
	List<PublicDataDTO> getPublicData() throws Exception;
	
	//공공데이터 1개 가져오기
	PublicDataDTO getOnePublicData(String pdata_seq) throws Exception;

	int insertGraph(GraphDTO gDTO) throws Exception;

	List<GraphDTO> getGraphList() throws Exception;

	GraphDTO getGraphDetail(String graphSeq) throws Exception;

	int deleteGraph(String graph_seq) throws Exception;

	int updateGraph(GraphDTO gDTO) throws Exception;

	int incrementCount(String graph_seq) throws Exception;

	int insertGraphReply(GraphReplyDTO grDTO) throws Exception;

	List<GraphReplyDTO> getGraphReplies(String graph_seq) throws Exception;

	int deleteGraphReply(String reply_seq) throws Exception;

	int updateBoardReply(GraphReplyDTO grDTO) throws Exception;

	List<GraphDTO> getMyGraphList(String user_seq) throws Exception;
	
/*
	//로그인
	public UserMemberDTO getUserMember(UserMemberDTO uDTO) throws Exception;
	
	//회원가입
	public int insertUserMember(UserMemberDTO uDTO) throws Exception;

	//비밀번호 찾기
	public UserMemberDTO fndPasswd(String user_id)  throws Exception;

	public int deleteUser(UserMemberDTO uDTO) throws Exception;

	public int updateUser(UserMemberDTO uDTO) throws Exception;

	public String getIdChecked(String user_id) throws Exception;*/


	
/*
	public List<UserMemberDTO> getAllMember() throws Exception;
	public int deleteMember(String memberId) throws Exception;
	public int updateMember(UserMemberDTO mDTO) throws Exception;
	public UserMemberDTO getLogin(HashMap<String, String> param) throws Exception;
	public String getIdChk(UserMemberDTO mDTO) throws Exception;
	public List<UserMemberDTO> getSearchList(UserMemberDTO mDTO) throws Exception;
*/
}
