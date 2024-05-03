package egovframework.fusion.studyRoom.vo;

public class UsePurposeVO {
	Integer purpose_id;
	String purpose_content;
	Integer default_time;
	Integer only_admin;
	
	public Integer getPurpose_id() {
		return purpose_id;
	}
	public void setPurpose_id(Integer purpose_id) {
		this.purpose_id = purpose_id;
	}
	public String getPurpose_content() {
		return purpose_content;
	}
	public void setPurpose_content(String purpose_content) {
		this.purpose_content = purpose_content;
	}
	public Integer getDefault_time() {
		return default_time;
	}
	public void setDefault_time(Integer default_time) {
		this.default_time = default_time;
	}
	public Integer getOnly_admin() {
		return only_admin;
	}
	public void setOnly_admin(Integer only_admin) {
		this.only_admin = only_admin;
	}
	
	
}
