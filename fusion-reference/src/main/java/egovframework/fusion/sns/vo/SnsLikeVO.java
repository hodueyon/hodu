package egovframework.fusion.sns.vo;

public class SnsLikeVO {
	private Integer sns_likeid;
	private Integer sns_id;
	private String user_id;
	
	//
	private Integer menu_id;
	private String search_type;
	private String search_word;
	private Integer cntPerPage;
	
	public Integer getSns_likeid() {
		return sns_likeid;
	}
	public void setSns_likeid(Integer sns_likeid) {
		this.sns_likeid = sns_likeid;
	}
	public Integer getSns_id() {
		return sns_id;
	}
	public void setSns_id(Integer sns_id) {
		this.sns_id = sns_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Integer getMenu_id() {
		return menu_id;
	}
	public void setMenu_id(Integer menu_id) {
		this.menu_id = menu_id;
	}
	public String getSearch_type() {
		return search_type;
	}
	public void setSearch_type(String search_type) {
		this.search_type = search_type;
	}
	public String getSearch_word() {
		return search_word;
	}
	public void setSearch_word(String search_word) {
		this.search_word = search_word;
	}
	public Integer getCntPerPage() {
		return cntPerPage;
	}
	public void setCntPerPage(Integer cntPerPage) {
		this.cntPerPage = cntPerPage;
	}
	
	

}
