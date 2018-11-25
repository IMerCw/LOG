package poly.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.GraphDTO;
import poly.dto.GraphReplyDTO;
import poly.dto.PublicDataDTO;
import poly.dto.StatGraphRateDTO;
import poly.dto.UserMemberDTO;
import poly.persistance.mapper.CmmnMapper;
import poly.persistance.mapper.GraphMapper;
import poly.persistance.mapper.StatMapper;
import poly.service.ICmmnService;
import poly.service.IGraphService;
import poly.service.IStatService;

@Service("StatService")
public class StatService implements IStatService {
	
	@Resource(name="StatMapper")
	private StatMapper statMapper;

	@Override
	public List<StatGraphRateDTO> getGraphRate() throws Exception {
		return statMapper.getGraphRate();
	}

/*
	@Override
	public List<UserMemberDTO> getAllMember() throws Exception {
		return memberMapper.getAllMember();
	}


	@Override
	public List<UserMemberDTO> getSearchList(UserMemberDTO mDTO) throws Exception {
		return memberMapper.getSearchList(mDTO);
	}*/

}
