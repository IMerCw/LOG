package poly.persistance.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import config.Mapper;
import poly.dto.BoardReplyDTO;
import poly.dto.UserMemberDTO;

@Mapper("BoardReplyMapper")
public interface BoardReplyMapper {

	int insertBoardReplyDTO(BoardReplyDTO brDTO) throws Exception;

	ArrayList<BoardReplyDTO> getBoardReplyDTOs(String board_p_seq) throws Exception;

	int deleteBoardReply(String reply_seq) throws Exception;

	int updateBoardReply(BoardReplyDTO brDTO) throws Exception;

}
