package poly.persistance.mapper;


import java.util.List;
import java.util.Map;

import config.Mapper;
import poly.dto.BoardPostDTO;

@Mapper("HelpCenterMapper")
public interface HelpCenterMapper {

	//게시글 삽입
	public int insertBoardPostDTO(BoardPostDTO bpDTO) throws Exception;
	//게시글 리스트
	public List<BoardPostDTO> getBoardPostDTO(Map<String, Integer> bpMap) throws Exception;
	//게시글 상세
	public BoardPostDTO getBoardPostDetailDTO(String board_p_seq) throws Exception;
	//게시글 조회수 증가
	public int increaseBoardCount(String board_p_seq) throws Exception;
	//게시글 수정
	public int updateBoardPostDTO(BoardPostDTO bpDTO) throws Exception;
	//게시글 삭제
	public int deleteBoardPostDTO(String board_p_seq) throws Exception;
	//게시글 전체 갯수 가져오기
	public int getTotalBoardPosts(String board_seq) throws Exception;
	
}

