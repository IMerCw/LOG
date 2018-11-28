package poly.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.GraphDTO;
import poly.dto.GraphReplyDTO;
import poly.dto.ImageDTO;
import poly.dto.PublicDataDTO;
import poly.dto.StatGraphRateDTO;
import poly.dto.UserMemberDTO;
import poly.persistance.mapper.CmmnMapper;
import poly.persistance.mapper.GraphMapper;
import poly.persistance.mapper.StatMapper;
import poly.persistance.mapper.UploadMapper;
import poly.service.ICmmnService;
import poly.service.IGraphService;
import poly.service.IStatService;
import poly.service.IUploadService;

@Service("UploadService")
public class UploadService implements IUploadService {
	
	@Resource(name="UploadMapper")
	private UploadMapper uploadMapper;

	@Override
	public int updateImage(ImageDTO imgDTO) throws Exception {
		return uploadMapper.updateImage(imgDTO);
	}

	@Override
	public String getImgSeq(String user_seq) throws Exception {
		return uploadMapper.getImgSeq(user_seq);
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
