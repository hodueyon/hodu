package egovframework.fusion.survey.service;

import java.util.List;

import egovframework.fusion.survey.vo.AnswerVO;
import egovframework.fusion.survey.vo.QuestionCategoryVO;
import egovframework.fusion.survey.vo.QuestionVO;
import egovframework.fusion.survey.vo.SurveyInputVO;
import egovframework.fusion.survey.vo.SurveyVO;
import egovframework.fusion.survey.vo.UserAnswerVO;
import egovframework.fusion.user.vo.AuthVO;
import egovframework.fusion.user.vo.UserVO;

public interface SurveyService {


	//리스트 조회
		public List<SurveyVO> getSurveyList();
		//설문조사 info
		public SurveyVO getSurveyInfo(Integer survey_id);
		
		//페이징처리를 하는 질문 조회
		public List<QuestionVO> surveyQList(QuestionVO vo);
		
		//답변(체크사항)리스트
		public List<AnswerVO> answerList(Integer survey_id);
		
		//페이징용 cnt
		public Integer cntQuestion(Integer survey_id);
		
		//입력
		public void insUserAnswer(List<UserAnswerVO> list);
		
		//수정용 삭제~~~~!!!!
		public void delBeforeEditAnswer(UserAnswerVO vo);
			
		
		//나의 답변 리스트 
		public List<UserAnswerVO> myAnswerListAll(UserAnswerVO vo);
		//나의 답변 조회
		public List<UserAnswerVO> myAnswerList(UserAnswerVO vo);
			
		
		//몇번째 설문조사인지 확인하기
		public Integer cntPaticipate(UserAnswerVO vo);
		
		//프로그레스바용 토탈
		public Integer cntProgressBarTotal(Integer survey_id);
		
		//카테고리뽑기
		public List<QuestionCategoryVO> q_categoryList();
		
		//등록
		public void inputSurveyEveryThing(List<SurveyInputVO> list);
		
		//리스트 
		public List<SurveyVO> allSurveyList();
		//대답한 유저있는지 체크
		public Integer ckAnsUsers(Integer servey_id);
		
		//설문조사 삭제
		public void delSurvey(Integer servey_id);
		
		//수정때문에데이터 불러오는 메소드들 ~~!!
		public List<QuestionVO> getQues(Integer survey_id);
		public List<QuestionVO> getSubQues(Integer survey_id);

		public List<AnswerVO> getAnsOptions(Integer survey_id);
		
		//수정 위해서 수정하는 질문, 옵션 등록 --이미있는걸로 사용하기~~~!!
		public void delQuesForEdit(Integer SurveyId);
		public void delOptionsForEdit(Integer SurveyId);
		public void delInfoForEdit(Integer SurveyId);
		
		//객관식통계
		public List<UserAnswerVO> getDataforchart(QuestionVO vo);
		
		//주관식 통계 
		public List<UserAnswerVO> getAnswerContent(QuestionVO vo);
		
		//기타 작성값 가져오기
		public List<UserAnswerVO> getEtcContent(QuestionVO vo);
		
		//질문 타입 체크 
		public Integer getCkQuestType(QuestionVO vo);
		
		//번호리스트뽑기
		public List<QuestionVO> listQuesNums(Integer survey_id);
		
		//1개의 설문조사info뽑기
		public SurveyVO getInfoSurvey(Integer survey_id);
		
		
		//1개의질문에 대해서 뽑기
		public QuestionVO getInfoQuest(Integer question_id);
		
		public List<AnswerVO> getInfoAnswerOption(Integer question_id);
		
		public List<SurveyVO> SurveyListForSurvey();
		
		//권한 목록
		public List<AuthVO> AuthList();

		//그 지역 응답자수나 총 응답자수
		public Integer cntAnswerUser(QuestionVO vo);
		
		//회원 아이디에 맞는 권한이름찬기
		public UserVO getMyAuth(String userid);
		
		public Integer ckDate(Integer surveyid);
		
		//통계용..
		public List<SurveyVO> getSurveyListforstat(); 

}
