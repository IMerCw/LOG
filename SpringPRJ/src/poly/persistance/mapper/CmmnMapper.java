package poly.persistance.mapper;

import java.util.HashMap;
import java.util.List;

import config.Mapper;
import poly.dto.ImageDTO;
import poly.dto.KakaoUserDTO;
import poly.dto.UserMemberDTO;

@Mapper("CmmnMapper")
public interface CmmnMapper {

	//로그인
	public UserMemberDTO getUserMember(UserMemberDTO uDTO) throws Exception;
	
	//회원가입
	public int insertUserMember(UserMemberDTO uDTO) throws Exception;

	//비밀번호 찾기
	public UserMemberDTO fndPasswd(String user_id)  throws Exception;

	public int deleteUser(UserMemberDTO uDTO) throws Exception;

	public int updateUser(UserMemberDTO uDTO) throws Exception;

	public String getIdChecked(String user_id) throws Exception;

	public int updateImage(ImageDTO imgDTO) throws Exception;

	public int setUserState(UserMemberDTO uDTO) throws Exception;

	public int setTempPasswd(UserMemberDTO uDTO) throws Exception;

	public String getImgSeq(String user_seq) throws Exception;

	public int insertKakaoUser(KakaoUserDTO kDTO) throws Exception;

	public UserMemberDTO getKakaoUser(UserMemberDTO uDTO) throws Exception;

	public int updateImgSeq(UserMemberDTO uDTO) throws Exception;


	
	
/*
	public List<UserMemberDTO> getAllMember() throws Exception;
	public int deleteMember(String memberId) throws Exception;
	public int updateMember(UserMemberDTO mDTO) throws Exception;
	public UserMemberDTO getLogin(HashMap<String, String> param) throws Exception;
	public String getIdChk(UserMemberDTO mDTO) throws Exception;
	public List<UserMemberDTO> getSearchList(UserMemberDTO mDTO) throws Exception;
*/
}
