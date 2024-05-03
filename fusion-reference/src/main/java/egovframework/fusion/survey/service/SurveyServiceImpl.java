package egovframework.fusion.survey.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.fusion.survey.vo.AnswerVO;
import egovframework.fusion.survey.vo.QuestionCategoryVO;
import egovframework.fusion.survey.vo.QuestionVO;
import egovframework.fusion.survey.vo.SurveyInputVO;
import egovframework.fusion.survey.vo.SurveyVO;
import egovframework.fusion.survey.vo.UserAnswerVO;
import egovframework.fusion.user.vo.AuthVO;
import egovframework.fusion.user.vo.UserVO;

@Service
public class SurveyServiceImpl extends EgovAbstractServiceImpl implements SurveyService{
	
	
	@Autowired
	SurveyMapper surveymapper;
	
	
	@Override
	public List<SurveyVO> getSurveyList() {
		// TODO Auto-generated method stub
		return surveymapper.getSurveyList();
	}
	
	@Override
	public SurveyVO getSurveyInfo(Integer survey_id) {
		// TODO Auto-generated method stub
		return surveymapper.getSurveyInfo(survey_id);
	}
	
	@Override
	public List<QuestionVO> surveyQList(QuestionVO vo) {
		// TODO Auto-generated method stub
		return surveymapper.surveyQList(vo);
	}

	@Override
	public List<AnswerVO> answerList(Integer survey_id) {
		// TODO Auto-generated method stub
		return surveymapper.answerList(survey_id);
	}

	@Override
	public Integer cntQuestion(Integer survey_id) {
		// TODO Auto-generated method stub
		return surveymapper.cntQuestion(survey_id);
	}


		
	//입력
	@Override
	public void insUserAnswer(List<UserAnswerVO> list) {
		
		 for (UserAnswerVO answer : list) {
			surveymapper.insUserAnswer(answer);
		 }
		
	}

	@Override
	public Integer cntPaticipate(UserAnswerVO vo) {
		// TODO Auto-generated method stub
		return surveymapper.cntPaticipate(vo);
	}

	@Override
	public List<UserAnswerVO> myAnswerListAll(UserAnswerVO vo) {
		// TODO Auto-generated method stub
		return surveymapper.myAnswerListAll(vo);
	}

	@Override
	public List<UserAnswerVO> myAnswerList(UserAnswerVO vo) {
		// TODO Auto-generated method stub
		return surveymapper.myAnswerList(vo);
	}

	@Override
	public void delBeforeEditAnswer(UserAnswerVO vo) {
		
		surveymapper.delBeforeEditAnswer(vo);
	}

	@Override
	public Integer cntProgressBarTotal(Integer survey_id) {
		// TODO Auto-generated method stub
		return surveymapper.cntProgressBarTotal(survey_id);
	}

	@Override
	public List<QuestionCategoryVO> q_categoryList() {
		// TODO Auto-generated method stub
		return surveymapper.q_categoryList();
	}

	@Override
	public void inputSurveyEveryThing(List<SurveyInputVO> list) {
		
		//survey 테이블에 
		List<SurveyVO> survey = list.get(0).getList();
		
		Integer surveyid =0;
		
		for(int b=0; b<survey.size(); b++) {
			SurveyVO vo = survey.get(0);
//			String enddate = vo.getEnd_date();
//	        LocalDateTime endDateTime = LocalDateTime.parse(enddate + "T23:59:59");
//	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
//	        String newEndDate = endDateTime.format(formatter);
//	        
//
//	        vo.setEnd_date(newEndDate);
//	        
			surveymapper.inputSurvey(vo);
			 surveyid = vo.getServey_id();
		}
		
		
		for(int i=0; i<list.size(); i++) {
			
			
			Integer subquesId = 0;
			Integer quesId = 0;
			
			//메인질문목록
			List<QuestionVO> Mainquestions = list.get(i).getMainQList();
			
			if(Mainquestions != null) {
				Mainquestions.get(0).setServey_id(surveyid);
				surveymapper.inputSurveyQues(Mainquestions.get(0));
				quesId = Mainquestions.get(0).getQuestion_id();
			}
			//답 옵션목록
			List<AnswerVO> anslist = list.get(i).getAnsList();
			if(anslist != null) {
				for(int j =0; j<anslist.size(); j++) {
					anslist.get(j).setQuestion_id(quesId);
					anslist.get(j).setSurvey_id(surveyid);
					surveymapper.inputAnsOption(anslist.get(j));
				}
			}
			
			//소문항
			List<QuestionVO> subQList = list.get(i).getSubQList();
			
			
			if(subQList != null) {
				subQList.get(0).setServey_id(surveyid);
				surveymapper.inputSurveyQues(subQList.get(0));
				 subquesId = subQList.get(0).getQuestion_id();
			}
			
			//소문항 답 옵션
			List<AnswerVO> subanslist = list.get(i).getSubAnsList();
			if(subanslist != null) {
				for(int a =0; a<subanslist.size(); a++) {
					subanslist.get(a).setQuestion_id(subquesId);
					subanslist.get(a).setSurvey_id(surveyid);
					surveymapper.inputAnsOption(subanslist.get(a));
				}
			}// end of if
		}// end of big for문
		
	}

	@Override
	public List<SurveyVO> allSurveyList() {
		// TODO Auto-generated method stub
		return surveymapper.allSurveyList();
	}

	@Override
	public Integer ckAnsUsers(Integer servey_id) {
		// TODO Auto-generated method stub
		return surveymapper.ckAnsUsers(servey_id);
	}

	@Override
	public void delSurvey(Integer servey_id) {
		// TODO Auto-generated method stub
		surveymapper.delSurvey(servey_id);
	}

	@Override
	public List<QuestionVO> getQues(Integer survey_id) {
		// TODO Auto-generated method stub
		return surveymapper.getQues(survey_id);
	}

	@Override
	public List<AnswerVO> getAnsOptions(Integer survey_id) {
		// TODO Auto-generated method stub
		return surveymapper.getAnsOptions(survey_id);
	}

	@Override
	public void delQuesForEdit(Integer SurveyId) {
		// TODO Auto-generated method stub
		surveymapper.delQuesForEdit(SurveyId);
	}

	@Override
	public void delOptionsForEdit(Integer SurveyId) {
		// TODO Auto-generated method stub
		surveymapper.delOptionsForEdit(SurveyId);
	}

	@Override
	public void delInfoForEdit(Integer SurveyId) {
		// TODO Auto-generated method stub
		surveymapper.delInfoForEdit(SurveyId);
	}

	@Override
	public List<UserAnswerVO> getDataforchart(QuestionVO vo) {
		// TODO Auto-generated method stub
		return surveymapper.getDataforchart(vo);
	}

	@Override
	public List<UserAnswerVO> getAnswerContent(QuestionVO vo) {
		// TODO Auto-generated method stub
		return surveymapper.getAnswerContent(vo);
	}

	@Override
	public List<UserAnswerVO> getEtcContent(QuestionVO vo) {
		// TODO Auto-generated method stub
		return surveymapper.getEtcContent(vo);
	}

	@Override
	public Integer getCkQuestType(QuestionVO vo) {
		// TODO Auto-generated method stub
		return surveymapper.getCkQuestType(vo);
	}

	@Override
	public List<QuestionVO> listQuesNums(Integer survey_id) {
		// TODO Auto-generated method stub
		return surveymapper.listQuesNums(survey_id);
	}

	@Override
	public SurveyVO getInfoSurvey(Integer survey_id) {
		// TODO Auto-generated method stub
		return surveymapper.getInfoSurvey(survey_id);
	}

	@Override
	public QuestionVO getInfoQuest(Integer question_id) {
		// TODO Auto-generated method stub
		return surveymapper.getInfoQuest(question_id);
	}

	@Override
	public List<AnswerVO> getInfoAnswerOption(Integer question_id) {
		// TODO Auto-generated method stub
		return surveymapper.getInfoAnswerOption(question_id);
	}

	@Override
	public List<QuestionVO> getSubQues(Integer survey_id) {
		// TODO Auto-generated method stub
		return surveymapper.getSubQues(survey_id);
	}

	@Override
	public List<SurveyVO> SurveyListForSurvey() {
		// TODO Auto-generated method stub
		return surveymapper.SurveyListForSurvey();
	}

	@Override
	public List<AuthVO> AuthList() {
		// TODO Auto-generated method stub
		return surveymapper.AuthList();
	}

	@Override
	public Integer cntAnswerUser(QuestionVO vo) {
		// TODO Auto-generated method stub
		return surveymapper.cntAnswerUser(vo);
	}

	@Override
	public UserVO getMyAuth(String userid) {
		// TODO Auto-generated method stub
		return surveymapper.getMyAuth(userid);
	}

	@Override
	public Integer ckDate(Integer surveyid) {
		// TODO Auto-generated method stub
		return surveymapper.ckDate(surveyid);
	}

	@Override
	public List<SurveyVO> getSurveyListforstat() {
		// TODO Auto-generated method stub
		return surveymapper.getSurveyListforstat();
	}




	

}
