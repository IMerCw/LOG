package poly.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import poly.dto.BoardReplyDTO;
import poly.dto.UserMemberDTO;

public interface IBoardReplyService {

	int insertBoardReplyDTO(BoardReplyDTO brDTO) throws Exception;

	ArrayList<BoardReplyDTO> getBoardReplyDTOs(String board_p_seq) throws Exception;

	int deleteBoardReply(String reply_seq) throws Exception;

	int updateBoardReply(BoardReplyDTO brDTO) throws Exception;
	 

}
