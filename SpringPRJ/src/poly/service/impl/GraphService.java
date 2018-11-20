package poly.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.GraphDTO;
import poly.dto.PublicDataDTO;
import poly.dto.UserMemberDTO;
import poly.persistance.mapper.CmmnMapper;
import poly.persistance.mapper.GraphMapper;
import poly.service.ICmmnService;
import poly.service.IGraphService;

@Service("GraphService")
public class GraphService implements IGraphService {
	
	@Resource(name="GraphMapper")
	private GraphMapper graphMapper;

	@Override
	public List<PublicDataDTO> getPublicData() throws Exception {
		return graphMapper.getPublicData();
	}

	@Override
	public PublicDataDTO getOnePublicData(String pdata_seq) throws Exception {
		return graphMapper.getOnePublicData(pdata_seq);
	}

	@Override
	public int insertGraph(GraphDTO gDTO) throws Exception {
		return graphMapper.insertGraph(gDTO);
	}

	@Override
	public List<GraphDTO> getGraphList() throws Exception {
		return graphMapper.getGraphList();
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
