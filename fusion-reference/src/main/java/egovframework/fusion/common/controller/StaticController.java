package egovframework.fusion.common.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import egovframework.fusion.common.service.MenuService;
import egovframework.fusion.common.vo.MenuHistoryVO;

@RestController
public class StaticController {
	
	@Autowired
	MenuService menuService;
	
	//년별로
	@RequestMapping(value = "/static/staticMenu.do", method = RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> StaticMenu(
							@RequestParam(value = "year", required = false) String year,
							@RequestParam(value = "month", required = false) String month,
							@RequestParam(value="day", required= false)String day,
							@RequestParam(value="menu_id", required = false)Integer menu_id) {
		
		 Map<String, Object> map = new HashMap<String, Object>();

		MenuHistoryVO vo = new MenuHistoryVO();

		//변수 없을떄 가정
		List<MenuHistoryVO> yearlist = menuService.yearStatic(vo);
		map.put("yearlist", yearlist);
		
		return map;
	}
	
	
	//달별로 
	@RequestMapping(value = "/static/staticMenuMonth.do", method = RequestMethod.GET)
	@ResponseBody
	public Map<String,Object>  MonthStatic(@RequestParam(value = "year", required = false) String year,
							@RequestParam(value="menu_id", required = false)Integer menu_id) {
		
		 Map<String, Object> map = new HashMap<String, Object>();

		MenuHistoryVO vo = new MenuHistoryVO();
		if( year != null) {
			vo.setVaryear(year);
			map.put("year", year);
		}
		//변수 없을떄 가정
		List<MenuHistoryVO> monthList  = menuService.monthStatic(vo);
		
		map.put("monthList", monthList);
		return map;
	}
	
	//일별로 
	@RequestMapping(value = "/static/staticMenuDay.do", method = RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> DayStatic(
							@RequestParam(value = "year", required = false) String year,
							@RequestParam(value = "month", required = false) String month,
							@RequestParam(value="menu_id", required = false)Integer menu_id) {
		
		MenuHistoryVO vo = new MenuHistoryVO();
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("year "+ year + "month" +  month);
			
		if(year != null) {
			vo.setVaryear(year);
			map.put("year", year);
		}
		if(month!= null) {
			vo.setVarmonth(month);
			map.put("month", month);
		
		}
			
		
		List<MenuHistoryVO> dayList = menuService.dayStatic(vo);
		map.put("dayList", dayList);
		return map;
	}
	
	
	//시간별로 
	@RequestMapping(value = "/static/staticMenuTime.do", method = RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> TimeStatic(@RequestParam(value = "year", required = false) String year,
							@RequestParam(value = "month", required = false) String month,
							@RequestParam(value="day", required= false)String day,
							@RequestParam(value="menu_id", required = false)Integer menu_id) {
		
		MenuHistoryVO vo = new MenuHistoryVO();
		//변수 없을떄 가정
		System.out.println("year "+ year + "month" +  month + "day" + day);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if( year != null) {
			vo.setVaryear(year);
			map.put("year", year);
		}
		if(month != null) {
			vo.setVarmonth(month);
			map.put("month", month);
		}
		if(day != null) {
			vo.setVarday(day);
			map.put("day", day);
		}
		List<MenuHistoryVO> timeList = menuService.timeStatic(vo);
		
		map.put("timeList", timeList);
		System.out.println(timeList);
		
		return map;
	}
	

}
