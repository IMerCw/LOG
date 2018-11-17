package poly.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.ImageDTO;
import poly.dto.KakaoUserDTO;
import poly.dto.UserMemberDTO;
import poly.persistance.mapper.CmmnMapper;
import poly.service.ICmmnService;

@Service("CmmnService")
public class CmmnService implements ICmmnService {
	
	@Resource(name="CmmnMapper")
	private CmmnMapper cmmnMapper;
	
	
	//로그인
	@Override
	public UserMemberDTO getUserMember(UserMemberDTO uDTO) throws Exception {
		return cmmnMapper.getUserMember(uDTO);
	}

	//회원가입
	@Override
	public int insertUserMember(UserMemberDTO uDTO) throws Exception {
		return cmmnMapper.insertUserMember(uDTO);
	}

	@Override
	public UserMemberDTO fndPasswd(String user_id) throws Exception {
		return cmmnMapper.fndPasswd(user_id);
	}

	@Override
	public int deleteUser(UserMemberDTO uDTO) throws Exception {
		return cmmnMapper.deleteUser(uDTO);
	}

	@Override
	public int updateUser(UserMemberDTO uDTO) throws Exception {
		return cmmnMapper.updateUser(uDTO);
	}

	@Override
	public String getIdChecked(String user_id) throws Exception {
		return cmmnMapper.getIdChecked(user_id);
	}

	@Override
	public int updateImage(ImageDTO imgDTO) throws Exception {
		return cmmnMapper.updateImage(imgDTO);
	}

	@Override
	public int setUserState(UserMemberDTO uDTO) throws Exception {
		return cmmnMapper.setUserState(uDTO);
	}

	@Override
	public int setTempPasswd(UserMemberDTO uDTO) throws Exception {
		return cmmnMapper.setTempPasswd(uDTO);
	}

	@Override
	public String getImgSeq(String user_seq) throws Exception {
		return cmmnMapper.getImgSeq(user_seq);
	}

	@Override
	public int insertKakaoUser(KakaoUserDTO kDTO) throws Exception {
		return cmmnMapper.insertKakaoUser(kDTO);
	}

	@Override
	public UserMemberDTO getKakaoUser(UserMemberDTO uDTO) throws Exception {
		return cmmnMapper.getKakaoUser(uDTO);
	}

	@Override
	public int updateImgSeq(UserMemberDTO uDTO) throws Exception {
		return cmmnMapper.updateImgSeq(uDTO);
	}


	
/*
	@Override
	public List<UserMemberDTO> getAllMember() throws Exception {
		return memberMapper.getAllMember();
	}



	@Override
	public int deleteMember(String memberId) throws Exception {
		return memberMapper.deleteMember(memberId);
	}

	@Override
	public int updateMember(UserMemberDTO mDTO) throws Exception {
		return memberMapper.updateMember(mDTO);
	}

	@Override
	public UserMemberDTO getLogin(HashMap<String, String> param) throws Exception {
		return memberMapper.getLogin(param);
	}

	@Override
	public String getIdChk(UserMemberDTO mDTO) throws Exception {
		return memberMapper.getIdChk(mDTO);
	}

	@Override
	public List<UserMemberDTO> getSearchList(UserMemberDTO mDTO) throws Exception {
		return memberMapper.getSearchList(mDTO);
	}*/

}
