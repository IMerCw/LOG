package poly.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.BoardPostDTO;
import poly.dto.UserMemberDTO;
import poly.persistance.mapper.HelpCenterMapper;
import poly.service.IHelpCenterService;

@Service("HelpCenterService")
public class HelpCenterService implements IHelpCenterService {
	
	@Resource(name="HelpCenterMapper")
	private HelpCenterMapper helpCenterMapper;
	


	@Override
	public int insertBoardPostDTO(BoardPostDTO bpDTO) throws Exception {
		return helpCenterMapper.insertBoardPostDTO(bpDTO);
	}



	@Override
	public List<BoardPostDTO> getBoardPostDTO(Map<String, Integer> bpMap) throws Exception {
		return helpCenterMapper.getBoardPostDTO(bpMap);
	}



	@Override
	public BoardPostDTO getBoardPostDetailDTO(String board_p_seq) throws Exception {
		return helpCenterMapper.getBoardPostDetailDTO(board_p_seq);
	}


	@Override
	public int increaseBoardCount(String board_p_seq) throws Exception {
		return helpCenterMapper.increaseBoardCount(board_p_seq);
	}



	@Override
	public int deleteBoardPostDTO(String board_p_seq) throws Exception {
		return helpCenterMapper.deleteBoardPostDTO(board_p_seq);
	}



	@Override
	public int updateBoardPostDTO(BoardPostDTO bpDTO) throws Exception {
		return helpCenterMapper.updateBoardPostDTO(bpDTO);
	}



	@Override
	public int getTotalBoardPosts(String board_seq) throws Exception {
		return helpCenterMapper.getTotalBoardPosts(board_seq);
	}




}
