package poly.dto;

public class BoardReplyDTO {
	private String reply_seq;
	private String user_seq;
	private String board_p_seq;
	private String reply_content;
	private String reg_date;
	private String exp_yn;
	private String update_user_seq;
	private String update_date;
	//외부 필드
	private String user_name;
	private String file_py_name;
	
	public String getReply_seq() {
		return reply_seq;
	}
	public void setReply_seq(String reply_seq) {
		this.reply_seq = reply_seq;
	}
	public String getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(String user_seq) {
		this.user_seq = user_seq;
	}
	public String getBoard_p_seq() {
		return board_p_seq;
	}
	public void setBoard_p_seq(String board_p_seq) {
		this.board_p_seq = board_p_seq;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getExp_yn() {
		return exp_yn;
	}
	public void setExp_yn(String exp_yn) {
		this.exp_yn = exp_yn;
	}
	public String getUpdate_user_seq() {
		return update_user_seq;
	}
	public void setUpdate_user_seq(String update_user_seq) {
		this.update_user_seq = update_user_seq;
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
	public String getFile_py_name() {
		return file_py_name;
	}
	public void setFile_py_name(String file_py_name) {
		this.file_py_name = file_py_name;
	}
	
	
}