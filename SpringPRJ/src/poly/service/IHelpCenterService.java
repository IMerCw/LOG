package poly.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import poly.dto.BoardPostDTO;
import poly.dto.UserMemberDTO;

public interface IHelpCenterService {
	
	public int insertBoardPostDTO(BoardPostDTO bpDTO) throws Exception;

	public List<BoardPostDTO> getBoardPostDTO(Map<String, Integer> bpMap) throws Exception;

	public BoardPostDTO getBoardPostDetailDTO(String board_p_seq) throws Exception;

	public int increaseBoardCount(String board_p_seq) throws Exception;

	public int deleteBoardPostDTO(String board_p_seq) throws Exception;

	public int updateBoardPostDTO(BoardPostDTO bpDTO) throws Exception;

	public int getTotalBoardPosts(String board_seq) throws Exception;
	
}
