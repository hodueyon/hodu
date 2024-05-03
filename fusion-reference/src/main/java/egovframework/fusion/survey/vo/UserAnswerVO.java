package egovframework.fusion.survey.vo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserAnswerVO {
	private Integer userans_id;
	private Integer participate_num;
	private String user_id;
	private Integer question_id;
	private String answer_content;
	private Integer survey_id;
	private String etc_content;
	private Integer answer_id;
	private String temp_yn;
	
	//통계용
	private Integer question_num;
	private Integer answer_cnt;
	private double answer_ratio;
	private Integer question_num_child;
	
	//
	private List<Integer> ansIdArr;
	private List<String> ansConArr;
	
	
	private Integer total_q_cnt;
	private Integer complete_cnt;
	private Integer question_type;
	
	
	public Integer getUserans_id() {
		return userans_id;
	}
	public void setUserans_id(Integer userans_id) {
		this.userans_id = userans_id;
	}
	public Integer getParticipate_num() {
		return participate_num;
	}
	public void setParticipate_num(Integer participate_num) {
		this.participate_num = participate_num;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Integer getQuestion_id() {
		return question_id;
	}
	public void setQuestion_id(Integer question_id) {
		this.question_id = question_id;
	}
	public String getAnswer_content() {
		return answer_content;
	}
	public void setAnswer_content(String answer_content) {
		this.answer_content = answer_content;
	}
	public Integer getSurvey_id() {
		return survey_id;
	}
	public void setSurvey_id(Integer survey_id) {
		this.survey_id = survey_id;
	}
	public String getEtc_content() {
		return etc_content;
	}
	public void setEtc_content(String etc_content) {
		this.etc_content = etc_content;
	}
	public Integer getAnswer_id() {
		return answer_id;
	}
	public void setAnswer_id(Integer answer_id) {
		this.answer_id = answer_id;
	}
	public List<Integer> getAnsIdArr() {
		return ansIdArr;
	}
	public void setAnsIdArr(List<Integer> ansIdArr) {
		this.ansIdArr = ansIdArr;
	}
	public List<String> getAnsConArr() {
		return ansConArr;
	}
	public void setAnsConArr(List<String> ansConArr) {
		this.ansConArr = ansConArr;
	}

	public Integer getTotal_q_cnt() {
		return total_q_cnt;
	}
	public void setTotal_q_cnt(Integer total_q_cnt) {
		this.total_q_cnt = total_q_cnt;
	}
	public Integer getComplete_cnt() {
		return complete_cnt;
	}
	public void setComplete_cnt(Integer complete_cnt) {
		this.complete_cnt = complete_cnt;
	}
	
	
	public Integer getQuestion_type() {
		return question_type;
	}
	public void setQuestion_type(Integer question_type) {
		this.question_type = question_type;
	}
	
	public String getTemp_yn() {
		return temp_yn;
	}
	public void setTemp_yn(String temp_yn) {
		this.temp_yn = temp_yn;
	}
	
	public Integer getQuestion_num() {
		return question_num;
	}
	public void setQuestion_num(Integer question_num) {
		this.question_num = question_num;
	}
	public Integer getAnswer_cnt() {
		return answer_cnt;
	}
	public void setAnswer_cnt(Integer answer_cnt) {
		this.answer_cnt = answer_cnt;
	}
	public double getAnswer_ratio() {
		return answer_ratio;
	}
	public void setAnswer_ratio(double answer_ratio) {
		this.answer_ratio = answer_ratio;
	}
	
	public Integer getQuestion_num_child() {
		return question_num_child;
	}
	public void setQuestion_num_child(Integer question_num_child) {
		this.question_num_child = question_num_child;
	}
	@Override
	public String toString() {
		return "UserAnswerVO [userans_id=" + userans_id + ", participate_num=" + participate_num + ", user_id="
				+ user_id + ", question_id=" + question_id + ", answer_content=" + answer_content + ", survey_id="
				+ survey_id + ", etc_content=" + etc_content + ", answer_id=" + answer_id + ", ansIdArr=" + ansIdArr
				+ ", ansConArr=" + ansConArr + "]";
	}
	
	
	
}
