package poly.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.UserMemberDTO;
import poly.dto.pageParamsDTO;
import poly.persistance.mapper.AdminMapper;
import poly.service.IAdminService;

@Service("AdminService")
public class AdminService implements IAdminService {
	
	@Resource(name="AdminMapper")
	private AdminMapper adminMapper;


	@Override
	public int updateUser(UserMemberDTO updatedUDTO) throws Exception {
		return adminMapper.updateUser(updatedUDTO);
	}

	@Override
	public List<UserMemberDTO> getSearchUser(String searchContent) throws Exception {
		return adminMapper.getSearchUser(searchContent);
	}

	@Override
	public int getTotalMemberListCount(String searchContent) throws Exception {
		return adminMapper.getTotalMemberListCount(searchContent);
	}

	@Override
	public List<UserMemberDTO> getAllUser(pageParamsDTO pDTO) throws Exception {
		return adminMapper.getAllUser(pDTO);
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
