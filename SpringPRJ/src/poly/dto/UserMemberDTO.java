package poly.dto;

public class UserMemberDTO {
	private String user_seq;
	private String user_id;
	private String user_passwd;
	private String user_name;
	private String user_reg_date;
	private String update_user_seq;
	private String update_date;
	private String user_state;
	private String kakao_user_yn;
	
	//외부 필드
	private String img_seq;
	private String file_py_name;
	
	public String getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(String user_seq) {
		this.user_seq = user_seq;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_passwd() {
		return user_passwd;
	}
	public void setUser_passwd(String user_passwd) {
		this.user_passwd = user_passwd;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_reg_date() {
		return user_reg_date;
	}
	public void setUser_reg_date(String user_reg_date) {
		this.user_reg_date = user_reg_date;
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
	public String getImg_seq() {
		return img_seq;
	}
	public void setImg_seq(String img_seq) {
		this.img_seq = img_seq;
	}
	public String getFile_py_name() {
		return file_py_name;
	}
	public void setFile_py_name(String file_py_name) {
		this.file_py_name = file_py_name;
	}
	public String getUser_state() {
		return user_state;
	}
	public void setUser_state(String user_state) {
		this.user_state = user_state;
	}
	public String getKakao_user_yn() {
		return kakao_user_yn;
	}
	public void setKakao_user_yn(String kakao_user_yn) {
		this.kakao_user_yn = kakao_user_yn;
	}
	
	
	
}