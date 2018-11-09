package poly.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.UserMemberDTO;
import poly.persistance.mapper.MemberMapper;
import poly.service.IMemberService;

@Service("MemberService")
public class MemberService implements IMemberService {
	
	@Resource(name="MemberMapper")
	private MemberMapper memberMapper;
/*	
	@Override
	public int insertMember(UserMemberDTO mDTO) throws Exception {
		return memberMapper.insertMember(mDTO);
	}

	@Override
	public List<UserMemberDTO> getAllMember() throws Exception {
		return memberMapper.getAllMember();
	}

	@Override
	public UserMemberDTO getMemberOne(String memberId) throws Exception {
		return memberMapper.getMemberOne(memberId);
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
	}
*/
}
