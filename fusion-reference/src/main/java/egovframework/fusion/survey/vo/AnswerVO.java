package egovframework.fusion.survey.vo;

public class AnswerVO {
	private Integer answer_id;
	private Integer answer_order;
	private Integer question_id;
	private Integer  survey_id;
	private String answer_content;
	private Integer answer_type;
	
	public Integer getAnswer_id() {
		return answer_id;
	}
	public void setAnswer_id(Integer answer_id) {
		this.answer_id = answer_id;
	}
	public Integer getAnswer_order() {
		return answer_order;
	}
	public void setAnswer_order(Integer answer_order) {
		this.answer_order = answer_order;
	}
	public Integer getQuestion_id() {
		return question_id;
	}
	public void setQuestion_id(Integer question_id) {
		this.question_id = question_id;
	}
	public Integer getSurvey_id() {
		return survey_id;
	}
	public void setSurvey_id(Integer survey_id) {
		this.survey_id = survey_id;
	}
	public String getAnswer_content() {
		return answer_content;
	}
	public void setAnswer_content(String answer_content) {
		this.answer_content = answer_content;
	}
	public Integer getAnswer_type() {
		return answer_type;
	}
	public void setAnswer_type(Integer answer_type) {
		this.answer_type = answer_type;
	}
	


}
