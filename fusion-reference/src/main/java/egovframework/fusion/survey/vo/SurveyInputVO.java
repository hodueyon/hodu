package egovframework.fusion.survey.vo;

import java.util.List;

public class SurveyInputVO {
	private List<SurveyVO> list;
	private List<QuestionVO> mainQList;
	private List<QuestionVO> subQList;
	private List<AnswerVO> ansList;
	private List<AnswerVO> subAnsList;
	
	public List<SurveyVO> getList() {
		return list;
	}
	public void setList(List<SurveyVO> list) {
		this.list = list;
	}
	public List<QuestionVO> getMainQList() {
		return mainQList;
	}
	public void setMainQList(List<QuestionVO> mainQList) {
		this.mainQList = mainQList;
	}
	public List<QuestionVO> getSubQList() {
		return subQList;
	}
	public void setSubQList(List<QuestionVO> subQList) {
		this.subQList = subQList;
	}
	public List<AnswerVO> getAnsList() {
		return ansList;
	}
	public void setAnsList(List<AnswerVO> ansList) {
		this.ansList = ansList;
	}
	public List<AnswerVO> getSubAnsList() {
		return subAnsList;
	}
	public void setSubAnsList(List<AnswerVO> subAnsList) {
		this.subAnsList = subAnsList;
	}
	
	
}
