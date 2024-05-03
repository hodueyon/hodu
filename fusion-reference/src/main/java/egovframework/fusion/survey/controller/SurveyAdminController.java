package egovframework.fusion.survey.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.fusion.common.service.MenuService;
import egovframework.fusion.common.vo.MenuVO;
import egovframework.fusion.commoncode.service.CommonCodeService;
import egovframework.fusion.survey.service.SurveyService;
import egovframework.fusion.survey.vo.AnswerVO;
import egovframework.fusion.survey.vo.QuestionCategoryVO;
import egovframework.fusion.survey.vo.QuestionVO;
import egovframework.fusion.survey.vo.SurveyInputVO;
import egovframework.fusion.survey.vo.SurveyVO;
import egovframework.fusion.survey.vo.UserAnswerVO;

@Controller
public class SurveyAdminController {
		
	@Autowired
	MenuService menuService;
	@Autowired
	CommonCodeService codeservice;

	@Autowired
	SurveyService surveyservice;
	
		//관리자페이지 오픈
		@RequestMapping(value="/survey/surveyAdmin.do",  method = RequestMethod.GET)
		public String surveyAdmin(@RequestParam(required = false)Integer menu_id, Model model) {
			
			List<SurveyVO> list = surveyservice.allSurveyList();
			model.addAttribute("list",list);

			return "views/survey/surveyAdmin";
		}
	
		//한건의 내용 확인
		
	
		//등록페이지 오픈
		@RequestMapping(value="/survey/surveyInputFrm.do",  method = RequestMethod.GET)
		public String surveyInputFrm( Model model,HttpSession session, HttpServletRequest request, HttpServletResponse response) {
			
			Object oId = session.getAttribute("auth");
			Integer auth = 4;
			//메뉴리스트
			if(oId == null) {
				auth = 4; 
			}else {
				auth =  (Integer) session.getAttribute("auth");
			}
			List<MenuVO> menulist = menuService.menulist(auth);
			
			List<QuestionCategoryVO> list = surveyservice.q_categoryList();
			
			model.addAttribute("menulists", menulist);
			model.addAttribute("quesCategory",list);
			model.addAttribute("targetList", surveyservice.AuthList());

			return "views/survey/surveyInputFrm";
		}
		
		//등록
		@RequestMapping(value="/survey/surveyInput.do",  method = RequestMethod.POST)
		@ResponseBody
		public String surveyInput(@RequestBody List<SurveyInputVO> list, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
			
			surveyservice.inputSurveyEveryThing(list);
			
			
			return "success";
		}
	
		//삭제
		@RequestMapping(value="/survey/delsurvey.do",  method = RequestMethod.POST)
		@ResponseBody
		public String delsurvey(Integer survey_id) {
			
			surveyservice.delSurvey(survey_id);
			
			
			return "success";
		}
		
		//수정페이지오픈전 체크
		@RequestMapping(value="/survey/ckBeforeEdit.do",  method = RequestMethod.POST)
		@ResponseBody
		public String ckBeforeEdit(Integer survey_id) {
			
			Integer num = surveyservice.ckAnsUsers(survey_id);
			
			String msg = "";
			if(num >0) {
				msg = "false";
			}else {
				msg = "true";
			}
			return msg;
		}
		
		//수정
		@RequestMapping(value="/survey/editSurveyFrm.do",  method = RequestMethod.GET)
		public String editSurveyFrm(Integer survey_id,Model model,HttpSession session, HttpServletRequest request, HttpServletResponse response) {
			System.out.println("수정컨트롤러");
			Object oId = session.getAttribute("auth");
			Integer auth = 4;
			//메뉴리스트
			if(oId == null) {
				auth = 4; 
			}else {
				auth =  (Integer) session.getAttribute("auth");
			}
			List<MenuVO> menulist = menuService.menulist(auth);
			
			List<QuestionCategoryVO> list = surveyservice.q_categoryList();
			
			model.addAttribute("menulists", menulist);
			
			model.addAttribute("quesCategory",list);
			
			model.addAttribute("info", surveyservice.getSurveyInfo(survey_id));
			
			model.addAttribute("ques", surveyservice.getQues(survey_id));
			
			model.addAttribute("options", surveyservice.getAnsOptions(survey_id));
			
			model.addAttribute("targetList", surveyservice.AuthList());
			
			
			model.addAttribute("surveyId", survey_id);
			List<QuestionVO> subqueslist = surveyservice.getSubQues(survey_id);
			if(subqueslist != null) {
				model.addAttribute("subqueslist", subqueslist);
			}
			return "views/survey/editSurvey";
			}
		
		//통계
		@RequestMapping(value="/survey/surveyStatitcs.do",  method = RequestMethod.GET)
		public String surveyStatitcs(Integer survey_id,Model model) {
			
			List<SurveyVO> list = surveyservice.getSurveyListforstat();
			model.addAttribute("list",list);
			
			
			return "views/survey/surveyStatistic";
		}
		
		//순번 가져오기
		@RequestMapping(value="/survey/getQuesList.do", method = RequestMethod.POST)
		@ResponseBody
		public List<QuestionVO> getQuesList(@RequestBody QuestionVO vo,HttpSession session, HttpServletRequest request, HttpServletResponse response) {
			
			surveyservice.listQuesNums(vo.getServey_id());
			
			return surveyservice.listQuesNums(vo.getServey_id());
		}
		
		//통계
		@RequestMapping(value="/survey/getDataForChart.do",  method = RequestMethod.POST)
		@ResponseBody
		public Map<String,Object> getDataForChart(@RequestBody QuestionVO vo,HttpSession session, HttpServletRequest request, HttpServletResponse response) {
			Map<String,Object> map = new HashMap<String, Object>();
			Integer type = surveyservice.getCkQuestType(vo);
			System.out.println(type);
			
			;
			map.put("type", type);
			map.put("info", surveyservice.getInfoSurvey(vo.getServey_id()));
			map.put("location", codeservice.korealocations());
			map.put("quesInfo", surveyservice.getInfoQuest(vo.getQuestion_id()));
			map.put("answererCnt", surveyservice.cntAnswerUser(vo));
			
			if(type == 1) {
				//객관식
				List<UserAnswerVO> list = surveyservice.getDataforchart(vo);
				map.put("list",list);
				List<UserAnswerVO> etcConList = surveyservice.getEtcContent(vo);
				if(etcConList.size() >0) {
					map.put("etces", etcConList);
				}
				List<AnswerVO> ansOptions = surveyservice.getInfoAnswerOption(type);
				if(ansOptions.size() >0) {
					map.put("ansOptions", ansOptions);
				}
			}else if(type ==2) {
				map.put("answers", surveyservice.getAnswerContent(vo));
			}
			//주관식일때 
			return map;
		}
		
		//수정떄문에 삭제
		@RequestMapping(value="/survey/delForEdit.do",  method = RequestMethod.POST)
		@ResponseBody
		public String delForEdit(Integer survey_id,HttpSession session, HttpServletRequest request, HttpServletResponse response) {
			String msg = "sucess";
			
			surveyservice.delQuesForEdit(survey_id);
			surveyservice.delOptionsForEdit(survey_id);
			surveyservice.delInfoForEdit(survey_id);;

			return msg;
		}
		
		
		
}
