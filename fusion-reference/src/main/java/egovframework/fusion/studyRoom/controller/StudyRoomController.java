package egovframework.fusion.studyRoom.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.fusion.studyRoom.service.StudyService;
import egovframework.fusion.studyRoom.vo.ReserveVO;
import egovframework.fusion.studyRoom.vo.SeatVO;

@Controller
public class StudyRoomController {
	
	@Autowired
	StudyService service;

	//예약페이지
	@RequestMapping(value="/study/studyRoom.do" , method = RequestMethod.GET)
	public String studyRoom(String use_start,  Model model,HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Object oId = session.getAttribute("writerId");
		String loginId = (String) oId.toString();
		
		Integer room_id = 1;
		//독서실 데이터 
		model.addAttribute("info", service.getInfoStudyRoom(room_id));
		//독서실좌석 데이터
		  LocalDate now = LocalDate.now();
		  DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		  String str = now.format(formatter);
		  model.addAttribute("today", str);

		if(use_start == null) {
			use_start = str;
		}

		ReserveVO vo = new ReserveVO();
		vo.setUse_start(use_start);
		vo.setRoom_id(1);
		model.addAttribute("use_start", use_start);
		model.addAttribute("seats", service.getSeats(vo));

		  Integer gap;
		if(use_start.equals(str)) {
			gap = service.getInfoStudyRoom(room_id).getThetime();
		}else {
			gap = service.getInfoStudyRoom(room_id).getGap();
		}
		

		model.addAttribute("gap", gap);

		//목적 데이터 가져오기
		model.addAttribute("purposes", service.purposeList());
		
		//예약목록 땡겨오기 
		model.addAttribute("myReservations",service.myReservationList(loginId));
		return "views/studyRoom/studyRoom";
	}
	
	//날짜, 좌석 당 예약 현황 등등 가져오기
	@RequestMapping(value="/study/getInfoReserveBySeat.do" , method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object>getInfoReserveBySeat(@RequestBody ReserveVO vo){
		Map<String, Object> map = new HashMap<>();
		
		//예약정보 등등~
		map.put("list", service.getInfoReserveBySeat(vo));
		
		return map;
		
	}
	
	//예약하기
	@RequestMapping(value="/study/inputReservation.do", method=RequestMethod.POST)
	@ResponseBody
	public String inputReservation(@RequestBody ReserveVO vo, 
			HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		
		Object oId = session.getAttribute("writerId");
		String loginId = (String) oId.toString();
		vo.setUser_id(loginId);
		String result;

        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDateTime = now.format(formatter);
        System.out.println(formattedDateTime);
        System.out.println(vo.getUse_start());
		
        Integer num = formattedDateTime.compareTo(vo.getUse_start()); 
       if(num > 0) {
    	   result = "mincheob";
       }else {
		
		//한번 더 db 넣기전에 중복되는 사람 있는지 체크체크~!
		if(num<=0 && service.ckReserve(vo).size() <= 0) {
			result = "true";
			service.insertReservation(vo);
		}else {
			result = "false";
		}
       }
		
		return result;
	}
	
	//예약취소
	@RequestMapping(value="/study/cancelReservation.do", method=RequestMethod.POST)
	@ResponseBody
	public List<ReserveVO> cancelReservation(Integer reserve_id, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		
		Object oId = session.getAttribute("writerId");
		String loginId = (String) oId.toString();
		
		List<ReserveVO> list = new ArrayList<>();
		
		
		service.canleReservation(reserve_id);
		list = service.myReservationList(loginId);
			
		return list;
	}
	
	//예약시간에 예약한 사람있는지 확인
	@RequestMapping(value="/study/ckOverlapTime.do", method=RequestMethod.POST)
	@ResponseBody
	public String ckOverlapTime(@RequestBody ReserveVO vo, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		 
		String result;
		
		if(service.ckReserve(vo).size() <= 0) {
			result = "true";
		}else {
			result = "false";
		}
		
		return result;
	}
	
	//혹시?유저가?동시간에 혹시 다른 자리에 예약했는지 체크체크
	@RequestMapping(value="/study/ckMyOverlapTimeSeat.do", method=RequestMethod.POST)
	@ResponseBody
	public String ckMyOverlapTimeSeat(@RequestBody ReserveVO vo, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		
		Object oId = session.getAttribute("writerId");
		String loginId = (String) oId.toString();
		vo.setUser_id(loginId);
		
		String result;
		
		for(int i=0; i<service.ckTimeMyOtherReserv(vo).size(); i++) {
			System.out.println(service.ckTimeMyOtherReserv(vo).get(i).toString());
		}
		if(service.ckTimeMyOtherReserv(vo).size() <= 0) {
			result = "true";
		}else {
			result = "false";
		}
		
		return result;
	}
	
	
}
