package poly.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.BoardPostDTO;
import poly.dto.UserMemberDTO;
import poly.persistance.mapper.AdminHelpCenterMapper;
import poly.service.IAdminHelpCenterService;
import poly.service.IHelpCenterService;

@Service("AdminHelpCenterService")
public class AdminHelpCenterService implements IAdminHelpCenterService {
	
	@Resource(name="AdminHelpCenterMapper")
	private AdminHelpCenterMapper adminHelpCenterMapper;
	


	@Override
	public int insertBoardPostDTO(BoardPostDTO bpDTO) throws Exception {
		return adminHelpCenterMapper.insertBoardPostDTO(bpDTO);
	}



	@Override
	public List<BoardPostDTO> getBoardPostDTO(Map<String, Integer> bpMap) throws Exception {
		return adminHelpCenterMapper.getBoardPostDTO(bpMap);
	}



	@Override
	public BoardPostDTO getBoardPostDetailDTO(String board_p_seq) throws Exception {
		return adminHelpCenterMapper.getBoardPostDetailDTO(board_p_seq);
	}


	@Override
	public int increaseBoardCount(String board_p_seq) throws Exception {
		return adminHelpCenterMapper.increaseBoardCount(board_p_seq);
	}



	@Override
	public int deleteBoardPostDTO(String board_p_seq) throws Exception {
		return adminHelpCenterMapper.deleteBoardPostDTO(board_p_seq);
	}



	@Override
	public int updateBoardPostDTO(BoardPostDTO bpDTO) throws Exception {
		return adminHelpCenterMapper.updateBoardPostDTO(bpDTO);
	}



	@Override
	public int getTotalBoardPosts(String board_seq) throws Exception {
		return adminHelpCenterMapper.getTotalBoardPosts(board_seq);
	}




}
