package egovframework.fusion.commoncode.controller;

import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.fusion.common.service.MenuService;
import egovframework.fusion.common.vo.MenuVO;
import egovframework.fusion.commoncode.service.CommonCodeService;
import egovframework.fusion.commoncode.vo.SubCommonVO;
import egovframework.fusion.commoncode.vo.UpperCommonVO;

@Controller
public class CommonCodeController {
	
	
	@Autowired
	CommonCodeService service;
	
	@Autowired
	MenuService menuService;
	
	
	//공통코드 관리 페이지 이동-표
	@RequestMapping(value="/admin/commoncodelist.do", method = RequestMethod.GET)
	public String commoncodelistTable(
							@RequestParam(value="search_type", required= false)String search_type,
							@RequestParam(value="search_word", required= false)String search_word,
							Model model) {
		
		UpperCommonVO vo = new UpperCommonVO();
		if(search_type != null || search_word !=null) {
			vo.setSearch_type(search_type);
			vo.setSearch_word(search_word);
			model.addAttribute("srctype", search_type);
			model.addAttribute("srcword", search_word);
		}
		
		//전체 목록 가져오기
		List<UpperCommonVO> uppers = service.upperList(vo);
		model.addAttribute("uppers", uppers);
		
		return "views/admin/commonCode";
	}
	
	//트리형식
	@RequestMapping(value="/admin/commoncodeTree.do", method = RequestMethod.GET)
	public String commoncodelistTree(
					@RequestParam(value="search_type", required= false)String search_type,
					@RequestParam(value="search_word", required= false)String search_word,
					Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		
		Object oId = session.getAttribute("auth");
		Integer auth = 4;
		
		if(oId == null) {
			auth = 4; 
		}else {
			auth =  (Integer) session.getAttribute("auth");
		}
		UpperCommonVO vo = new UpperCommonVO();
		if(search_type != null || search_word !=null) {
			vo.setSearch_type(search_type);
			vo.setSearch_word(search_word);
			model.addAttribute("srctype", search_type);
			model.addAttribute("srcword", search_word);
		}
		
		
		
		List<MenuVO> menulist = menuService.menulist(auth);
		
		model.addAttribute("menulists", menulist);
			
		//전체 목록 가져오기
		List<UpperCommonVO> uppers = service.upperList(vo);
		model.addAttribute("uppers", uppers);

		return "views/admin/tree";
	}
	
	
	//공통코드 소분류 코드 조회
	@RequestMapping(value="/admin/getSubCommCode.do", method=RequestMethod.POST)
	@ResponseBody
	public List<SubCommonVO> getSubCommCode(@RequestBody UpperCommonVO vo){
			
		System.out.println(vo.getUpper_id());
		
		List<SubCommonVO> list = service.subList(vo);
		
		
		return list;
	}
	
	//한개만 가져오기
	@RequestMapping(value="/admin/getUpperSubInfo.do", method=RequestMethod.POST)
	@ResponseBody
	public SubCommonVO getUpperSubInfo(String upper_id){

		SubCommonVO vo = service.getUpperSubInfo(upper_id);
		
		return vo;
	}
	
	//대분류수정
	@RequestMapping(value="/admin/updateUpperCode.do", method=RequestMethod.POST)
	@ResponseBody
	public String updateUpperCode(@RequestBody UpperCommonVO vo){

		service.updateUpper(vo);
		return "success";
	}
	
	//소분류수정
	@RequestMapping(value="/admin/updateSubCode.do", method=RequestMethod.POST)
	@ResponseBody
	public String updateSubCode(@RequestBody SubCommonVO vo){

		service.updateSub(vo);
		return "success";
	}
	
	
	//대분류삭제전체크
	@RequestMapping(value="/admin/delbeforeCks.do", method=RequestMethod.POST)
	@ResponseBody
	public String delbeforeCks(@RequestBody UpperCommonVO vo){

		return service.cksBeforDel(vo);
	}
	
	//대분류 삭제
	@RequestMapping(value="/admin/delUpperCode.do", method = RequestMethod.POST)
	@ResponseBody
	public String delUpperCode(@RequestBody UpperCommonVO vo) {
		
		service.delUpper(vo);
		
		return "sucess";
	}
	
	//소분류 삭제
	@RequestMapping(value="/admin/delSubCode.do", method = RequestMethod.POST)
	@ResponseBody
	public String delSubCode(@RequestBody SubCommonVO vo) {
		
		service.delSub(vo);
		
		return "sucess";
	}
	
	//대분류 중복 검사
	@RequestMapping(value="/admin/upperDuplicateCk.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer upperDuplicateCk(@RequestBody UpperCommonVO vo) {
		
		Integer msg = service.upperDuplicateCk(vo);
		
		return msg;
	}
	
	//소분류 중복 검사
	@RequestMapping(value="/admin/subDuplicateCk.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer subDuplicateCk(@RequestBody SubCommonVO vo) {
		
		Integer msg = service.subDuplicateCk(vo);
				
		return msg;
	}
	
	//대분류 등록
//	@RequestMapping(value="/admin/inputUpper.do", method = RequestMethod.POST)
//	@ResponseBody
//	public String inputUpper(@RequestBody UpperCommonVO vo) {
//		
//		String msg;
//		
//		if(service.findLastIdOrder().getUpper_id() == "Z") {
//			System.out.println(service.findLastIdOrder().getUpper_id());
//			msg = "대분류는 21개까지 등록 가능합니다.";
//			
//		}else{
//			System.out.println("z가 아닙니다.");
//			msg = "success";
//			service.insertUpper(vo);
//		}
//		
//		
//		return msg;
//	}
	
	//소분류 등록
	@RequestMapping(value="/admin/inputSub.do", method = RequestMethod.POST)
	@ResponseBody
	public String inputSub(@RequestBody SubCommonVO vo) {
		
		service.insertSub(vo);
		
		return "sucess";
	}
	
	//테스트
	@PostMapping("/admin/inputUpper.do")
	@ResponseBody
	public ResponseEntity<String> inputTest(@RequestBody UpperCommonVO vo) {
		
		if(service.findLastIdOrder().getUpper_id() != "Z") {
				return new ResponseEntity<>("인증필요", HttpStatus.I_AM_A_TEAPOT);
		}else{
			System.out.println("z가 아닙니다.");
			return new ResponseEntity<>("good", HttpStatus.OK);
		}

	}
	
}