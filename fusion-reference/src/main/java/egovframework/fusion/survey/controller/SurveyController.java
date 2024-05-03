package egovframework.fusion.survey.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.fusion.common.service.MenuService;
import egovframework.fusion.common.vo.MenuVO;
import egovframework.fusion.survey.service.SurveyService;
import egovframework.fusion.survey.vo.QuestionVO;
import egovframework.fusion.survey.vo.SurveyVO;
import egovframework.fusion.survey.vo.UserAnswerVO;


@Controller
public class SurveyController {
	
	@Autowired
	SurveyService service;
	
	@Autowired
	MenuService menuService;
	
	//설문조사 리스트로
	@RequestMapping(value="/survey/surveyListForUser.do", method=RequestMethod.GET)
	public String surveyListForUser(Integer servey_id, Model model) {
		
		model.addAttribute( "list",service.SurveyListForSurvey());
		
		return  "views/survey/surveyListForUser";
	}
	
	//설문조사 info
	@RequestMapping(value="/survey/sureveyInfo.do", method=RequestMethod.GET)
	public String surveyList(Integer servey_id, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {

		Integer auth = (Integer) session.getAttribute("auth");
		
		if (auth == null) {
	        auth = 4;
	    }
	    
		List<MenuVO> menulist = menuService.menulist(auth);
		
		model.addAttribute("cnt", service.cntQuestion(servey_id));
		model.addAttribute("menulists", menulist);
		Object oId = session.getAttribute("writerId");
		if (oId != null) {
			String loginId = (String) oId.toString();
			model.addAttribute("loginId", loginId);
			UserAnswerVO uao = new UserAnswerVO();
			uao.setSurvey_id(servey_id);
			uao.setUser_id(loginId);
			service.myAnswerListAll(uao);
			model.addAttribute("myanswers" , service.myAnswerListAll(uao));
		}		
		
		model.addAttribute("surveyInfo", service.getSurveyInfo(servey_id));
		return  "views/survey/surveyInfo";

	}
	
	//설문조사 설문지 페이지 
	@RequestMapping(value= "/survey/questionList.do", method=RequestMethod.GET)
	public String questionList(Integer survey_id, Model model, HttpServletRequest request, HttpServletResponse response) {

		// 세션아이디값
		HttpSession session = request.getSession();

		Object oId = session.getAttribute("writerId");
		String loginId = null;
		String myauthname = null;
		if(!(oId == null)) {
			loginId = (String) oId.toString();
			myauthname = service.getMyAuth(loginId).getAuth_name();;
		}
		
		SurveyVO svo = service.getSurveyInfo(survey_id);
		String target = svo.getServey_target();
		//설문지 번호
		model.addAttribute("surveyId", survey_id);
		System.out.println(myauthname);
		System.out.println(target);
		if(loginId == null ){
			model.addAttribute("msg2", "비회원 설문조사 응답이 불가능 합니다!");
			return "/views/survey/dontGoSurveyPageMsg";
		}
		
		if(!target.equals("users") && !myauthname.equals(target)) {
				model.addAttribute("msg1", "설문 조사 대상이 아니라면 응답이 불가능 합니다!");
				return "/views/survey/dontGoSurveyPageMsg";
		}
		else{//로그인한 아이디 

				Integer maxSurveyCnt = svo.getParticipate_cnt();
				Integer ckDate = service.ckDate(survey_id);
				model.addAttribute("loginId", loginId);
				QuestionVO questionvo = new QuestionVO();
				questionvo.setServey_id(survey_id);
				UserAnswerVO uao = new UserAnswerVO();
				uao.setUser_id(loginId);
				uao.setSurvey_id(survey_id);//몇번째 참여인지 수 체크
				Integer cnt = service.cntPaticipate(uao);
				model.addAttribute("pcnt", cnt+1);
				
				List<UserAnswerVO> myanswers = service.myAnswerListAll(uao);
				
				for(int i=0; i<myanswers.size(); i++) {
					if(myanswers.get(i).getTemp_yn() == "y") {
						 model.addAttribute("msg1","미완료된 설문이 있습니다.\\n해당 설문을 완료한 후 새로운 답변을 작성해주세요"); 
						 return "/views/survey/dontGoSurveyPageMsg"; 
					}
				}
				
			
					
				if(ckDate == 3) {
					 model.addAttribute("msg1","설문조사 시행 기간이 아닙니다."); 
					 return "/views/survey/dontGoSurveyPageMsg"; 

				}
					

			  if(maxSurveyCnt < cnt+1) { 
				  model.addAttribute("msg1","제한된 참여 가능 횟수에 모두 참여하였습니다."); 
				  return "/views/survey/dontGoSurveyPageMsg"; 
			  }
		

				model.addAttribute("total", service.cntQuestion(survey_id));
				System.out.println(service.cntQuestion(survey_id));
				//문항리스트
				model.addAttribute("questions", service.surveyQList(questionvo));
				//선택지 리스트
				model.addAttribute("answers", service.answerList(survey_id));
				//설문조사정보 가져가기
				model.addAttribute("surveyInfo",svo);
				//프로그레스바용 토탈
				model.addAttribute("pgtotal", service.cntProgressBarTotal(survey_id));
				
				
				return "/views/survey/questionList";

			}

	};
	
	//설문조사 등록
	@RequestMapping(value="/survey/inputSurvey.do", method=RequestMethod.POST)
	@ResponseBody
	public String inputSurveyInc(@RequestBody List<UserAnswerVO> list) {

		String msg = null;
		
		for(int i = 0; i<list.size(); i++) {
			System.out.println(list.get(i));
			Integer sid = list.get(i).getSurvey_id();
			SurveyVO vo = service.getSurveyInfo(sid);
			Integer ckDate = service.ckDate(sid);
			
				if(ckDate == 3) {
					 msg = "설문조사 시행 기간이 아닙니다."; 

				}
					
				if(vo.getParticipate_cnt() <list.get(i).getParticipate_num()) {
					msg = "응답할 수 있는 횟수가 초과되어 제출이 불가능합니다";
				}
				if(ckDate == 1) {
					msg = "pass";
				}
			
		}
		
		if(msg == "pass") {
			service.insUserAnswer(list);
		}
		
		
		return msg;
	};
	
	//수정하러가기
	@RequestMapping(value="/survey/myAnswerEdit.do", method=RequestMethod.GET)
	public String myAnswerEdit(Integer survey_id, Integer participate_num
								,Model model
								, HttpServletRequest request
								, HttpServletResponse response
								, HttpSession session) {
		// 세션아이디값
		Object oId = session.getAttribute("writerId");
				
		String loginId = (String) oId.toString();
		UserAnswerVO vo = new UserAnswerVO();
		vo.setParticipate_num(participate_num);
		vo.setUser_id(loginId);
		vo.setSurvey_id(survey_id);
		SurveyVO svo = service.getSurveyInfo(survey_id);
		
		List<UserAnswerVO> list = service.myAnswerList(vo);
		for(int i=0; i<list.size(); i++) {
			System.out.println(list.get(i));
		}

		model.addAttribute("myAnswerList", list);
		
		model.addAttribute("myanscnt", participate_num);
		//모든 설문지 질문과 답 옵션

		QuestionVO questionvo = new QuestionVO();
		questionvo.setServey_id(survey_id);
		UserAnswerVO uao = new UserAnswerVO();
		uao.setUser_id(loginId);
		uao.setSurvey_id(survey_id);
		

		//몇번째 참여인지 수 체크
		Integer cnt = service.cntPaticipate(uao);
		model.addAttribute("pcnt", cnt);
		
		

		Integer maxSurveyCnt = svo.getParticipate_cnt();
		 if(maxSurveyCnt < cnt) { 
			  model.addAttribute("msg1","제한된 참여 가능 횟수에 모두 참여하였습니다."); 
		  return "/views/survey/dontGoSurveyPageMsg"; 
		  }
		
		
		//로그인한 아이디 
		model.addAttribute("loginId", loginId);
		//totalcnt
		model.addAttribute("total", service.cntQuestion(survey_id));
		System.out.println(service.cntQuestion(survey_id));
		//문항리스트
		model.addAttribute("questions", service.surveyQList(questionvo));
		//선택지 리스트
		model.addAttribute("answers", service.answerList(survey_id));
		//설문지 번호
		model.addAttribute("surveyId", survey_id);
		//설문조사정보 가져가기
		model.addAttribute("surveyInfo",svo);
		//프로그레스바용 토탈
		model.addAttribute("pgtotal", service.cntProgressBarTotal(survey_id));
		
	
		//return "gogogo";
		return "/views/survey/questionList"; 
	}
	
	//post로 작성 내역 가져오기 
	@RequestMapping(value="/survey/getmySurveyRecord.do", method=RequestMethod.POST)
	@ResponseBody
	public List<UserAnswerVO> getmySurveyRecord(@RequestBody UserAnswerVO vo ,  HttpServletRequest request
												, HttpServletResponse response
												, HttpSession session) {

		Map<String, Object> map = new HashMap<String, Object>();

		
		Object oId = session.getAttribute("writerId");
		String loginId = (String) oId.toString();
		vo.setUser_id(loginId);
		
		List<UserAnswerVO> list = service.myAnswerList(vo);

		map.put("myAnswerList", list);

		return list;
	};
	
	//수정시 이전 내역 다 삭제
	@RequestMapping(value="/survey/myAnswerEditInc.do", method=RequestMethod.POST)
	@ResponseBody
	public String myAnswerEditInc(@RequestBody UserAnswerVO vo) {
		
		String msg = null;
		
		Integer sid = vo.getSurvey_id();
		SurveyVO svo = service.getSurveyInfo(sid);
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date sday;
		Date eday;

		try {
			sday = dateFormat.parse(svo.getStart_date());
			eday = dateFormat.parse(svo.getEnd_date());
			
			if (sday.compareTo(new Date()) > 0) {
			    msg = "아직 설문조사 시작 전입니다.";
			}
			if(eday.compareTo(new Date()) < 0) {
				msg = "설문조사가 이미 종료되었으므로 제출이 불가능합니다.";
			}
			if(svo.getParticipate_cnt() < vo.getParticipate_num()) {
				msg = "응답할 수 있는 횟수가 초과되어 제출이 불가능합니다";
			}
			if(sday.compareTo(new Date()) <= 0 && eday.compareTo(new Date()) >= 0) {
				msg = "pass";
			}
			

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		if(msg == "pass") {
			 service.delBeforeEditAnswer(vo);
		}
	
		
		return msg;
	}

	
}
