package egovframework.fusion.galary.vo;

public class LikeVO {
	private Integer like_id;
	private Integer galary_id;
	private String user_id;
	private String like_date;
	private String cancel_yn;
	
	
	public Integer getLike_id() {
		return like_id;
	}
	public void setLike_id(Integer like_id) {
		this.like_id = like_id;
	}
	public Integer getGalary_id() {
		return galary_id;
	}
	public void setGalary_id(Integer galary_id) {
		this.galary_id = galary_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getLike_date() {
		return like_date;
	}
	public void setLike_date(String like_date) {
		this.like_date = like_date;
	}
	public String getCancel_yn() {
		return cancel_yn;
	}
	public void setCancel_yn(String cancel_yn) {
		this.cancel_yn = cancel_yn;
	}
	
	
	
}
