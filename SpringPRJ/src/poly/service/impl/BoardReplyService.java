package poly.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.BoardReplyDTO;
import poly.dto.UserMemberDTO;
import poly.persistance.mapper.BoardReplyMapper;
import poly.service.IBoardReplyService;

@Service("BoardReplyService")
public class BoardReplyService implements IBoardReplyService {
	
	@Resource(name="BoardReplyMapper")
	private BoardReplyMapper boardReplyMapper;

	@Override
	public int insertBoardReplyDTO(BoardReplyDTO brDTO) throws Exception {
		return boardReplyMapper.insertBoardReplyDTO(brDTO);
	}

	@Override
	public ArrayList<BoardReplyDTO> getBoardReplyDTOs(String board_p_seq) throws Exception {
		return boardReplyMapper.getBoardReplyDTOs(board_p_seq);
	}

	@Override
	public int deleteBoardReply(String reply_seq) throws Exception {
		return boardReplyMapper.deleteBoardReply(reply_seq);
	}

	@Override
	public int updateBoardReply(BoardReplyDTO brDTO) throws Exception {
		return boardReplyMapper.updateBoardReply(brDTO);
	}
	
	
}
