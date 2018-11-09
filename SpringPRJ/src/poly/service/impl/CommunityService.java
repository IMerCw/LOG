package poly.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.BoardPostDTO;
import poly.dto.UserMemberDTO;
import poly.persistance.mapper.CmmnMapper;
import poly.persistance.mapper.CommunityMapper;
import poly.service.ICmmnService;
import poly.service.ICommunityService;

@Service("CommunityService")
public class CommunityService implements ICommunityService {
	
	@Resource(name="CommunityMapper")
	private CommunityMapper communityMapper;
	


	@Override
	public int insertBoardPostDTO(BoardPostDTO bpDTO) throws Exception {
		return communityMapper.insertBoardPostDTO(bpDTO);
	}



	@Override
	public List<BoardPostDTO> getBoardPostDTO(Map<String, Integer> bpMap) throws Exception {
		return communityMapper.getBoardPostDTO(bpMap);
	}



	@Override
	public BoardPostDTO getBoardPostDetailDTO(String board_p_seq) throws Exception {
		return communityMapper.getBoardPostDetailDTO(board_p_seq);
	}


	@Override
	public int increaseBoardCount(String board_p_seq) throws Exception {
		return communityMapper.increaseBoardCount(board_p_seq);
	}



	@Override
	public int deleteBoardPostDTO(String board_p_seq) throws Exception {
		return communityMapper.deleteBoardPostDTO(board_p_seq);
	}



	@Override
	public int updateBoardPostDTO(BoardPostDTO bpDTO) throws Exception {
		return communityMapper.updateBoardPostDTO(bpDTO);
	}



	@Override
	public int getTotalBoardPosts(String board_seq) throws Exception {
		return communityMapper.getTotalBoardPosts(board_seq);
	}




}
