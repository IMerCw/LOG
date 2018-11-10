package poly.dto;

public class BoardPostDTO {
	private String board_p_seq;
	private String user_seq;
	private String board_seq;
	private String board_p_title;
	private String board_p_content;
	private String board_count;
	private String reg_date;
	private String update_user_seq;
	private String update_date;
	
	//외부 필드
	private String reply_total;
	
	//외부 필드
	private String user_name;
	
	private String file_py_name;
	
	/////
	public String getBoard_p_seq() {
		return board_p_seq;
	}
	public void setBoard_p_seq(String board_p_seq) {
		this.board_p_seq = board_p_seq;
	}
	public String getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(String user_seq) {
		this.user_seq = user_seq;
	}
	public String getBoard_seq() {
		return board_seq;
	}
	public void setBoard_seq(String board_seq) {
		this.board_seq = board_seq;
	}
	public String getBoard_p_title() {
		return board_p_title;
	}
	public void setBoard_p_title(String board_p_title) {
		this.board_p_title = board_p_title;
	}
	public String getBoard_p_content() {
		return board_p_content;
	}
	public void setBoard_p_content(String board_p_content) {
		this.board_p_content = board_p_content;
	}
	public String getBoard_count() {
		return board_count;
	}
	public void setBoard_count(String board_count) {
		this.board_count = board_count;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUpdate_user_seq() {
		return update_user_seq;
	}
	public void setUpdate_user_seq(String update_user_seq) {
		this.update_user_seq = update_user_seq;
	}
	public String getReply_total() {
		return reply_total;
	}
	public void setReply_total(String reply_total) {
		this.reply_total = reply_total;
	}
	public String getFile_py_name() {
		return file_py_name;
	}
	public void setFile_py_name(String file_py_name) {
		this.file_py_name = file_py_name;
	}
	
	
}