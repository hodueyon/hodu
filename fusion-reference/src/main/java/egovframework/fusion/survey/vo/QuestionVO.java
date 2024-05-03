package egovframework.fusion.survey.vo;

public class QuestionVO {
	
	private Integer question_id;
	private Integer question_category;
	private Integer question_num;
	private Integer question_num_child;
	private Integer servey_id;
	private String question_content;
	private Integer question_type;
	private Integer max_choice_cnt;
	private String essential_yn;
	
	private String category_name;
	private String location;
	
	public Integer getQuestion_id() {
		return question_id;
	}
	public void setQuestion_id(Integer question_id) {
		this.question_id = question_id;
	}
	public Integer getQuestion_category() {
		return question_category;
	}
	public void setQuestion_category(Integer question_category) {
		this.question_category = question_category;
	}
	public Integer getQuestion_num() {
		return question_num;
	}
	public void setQuestion_num(Integer question_num) {
		this.question_num = question_num;
	}
	public Integer getQuestion_num_child() {
		return question_num_child;
	}
	public void setQuestion_num_child(Integer question_num_child) {
		this.question_num_child = question_num_child;
	}
	public Integer getServey_id() {
		return servey_id;
	}
	public void setServey_id(Integer servey_id) {
		this.servey_id = servey_id;
	}
	public String getQuestion_content() {
		return question_content;
	}
	public void setQuestion_content(String question_content) {
		this.question_content = question_content;
	}
	public Integer getQuestion_type() {
		return question_type;
	}
	public void setQuestion_type(Integer question_type) {
		this.question_type = question_type;
	}
	public Integer getMax_choice_cnt() {
		return max_choice_cnt;
	}
	public void setMax_choice_cnt(Integer max_choice_cnt) {
		this.max_choice_cnt = max_choice_cnt;
	}
	public String getEssential_yn() {
		return essential_yn;
	}
	public void setEssential_yn(String essential_yn) {
		this.essential_yn = essential_yn;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	
	@Override
	public String toString() {
		return "QuestionVO [question_id=" + question_id + ", question_category=" + question_category + ", question_num="
				+ question_num + ", question_num_child=" + question_num_child + ", servey_id=" + servey_id
				+ ", question_content=" + question_content + ", question_type=" + question_type + ", max_choice_cnt="
				+ max_choice_cnt + ", essential_yn=" + essential_yn + ", category_name=" + category_name + ", location="
				+ location + "]";
	}
	
	
	
}
