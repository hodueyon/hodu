package egovframework.fusion.sns.vo;

public class SnsVO {
	private Integer sns_id;
	private String content;
	private String writer;
	private String del_yn;
	private String register_d;
	private Integer menu_id;
	
	
	private Integer start;
	private Integer end;
	private String search_type;
	private String search_word;
	private Integer cntPerPage;
	private Integer nowPage;
	
	private Integer likeyn;
	private Integer likecnt;
	private String user_id;
	private String user_name;
	
	
	public Integer getSns_id() {
		return sns_id;
	}
	public void setSns_id(Integer sns_id) {
		this.sns_id = sns_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public String getRegister_d() {
		return register_d;
	}
	public void setRegister_d(String register_d) {
		this.register_d = register_d;
	}
	public Integer getMenu_id() {
		return menu_id;
	}
	public void setMenu_id(Integer menu_id) {
		this.menu_id = menu_id;
	}
	public Integer getStart() {
		return start;
	}
	public void setStart(Integer start) {
		this.start = start;
	}
	public Integer getEnd() {
		return end;
	}
	public void setEnd(Integer end) {
		this.end = end;
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
	public Integer getNowPage() {
		return nowPage;
	}
	public void setNowPage(Integer nowPage) {
		this.nowPage = nowPage;
	}
	public Integer getLikeyn() {
		return likeyn;
	}
	public void setLikeyn(Integer likeyn) {
		this.likeyn = likeyn;
	}
	public Integer getLikecnt() {
		return likecnt;
	}
	public void setLikecnt(Integer likecnt) {
		this.likecnt = likecnt;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	@Override
	public String toString() {
		return "SnsVO [sns_id=" + sns_id + ", content=" + content + ", writer=" + writer + ", del_yn=" + del_yn
				+ ", register_d=" + register_d + ", menu_id=" + menu_id + ", start=" + start + ", end=" + end
				+ ", search_type=" + search_type + ", search_word=" + search_word + ", cntPerPage=" + cntPerPage
				+ ", nowPage=" + nowPage + ", likeyn=" + likeyn + ", likecnt=" + likecnt + ", user_id=" + user_id + "]";
	}
	
	
	
}
