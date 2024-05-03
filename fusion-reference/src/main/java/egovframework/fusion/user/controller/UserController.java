package egovframework.fusion.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.ejb.PostActivate;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.fusion.common.service.MenuService;
import egovframework.fusion.common.vo.MenuVO;
import egovframework.fusion.commoncode.service.CommonCodeService;
import egovframework.fusion.commoncode.vo.SubCommonVO;
import egovframework.fusion.user.service.UserService;
import egovframework.fusion.user.vo.UserVO;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	MenuService menuService;
	
	@Autowired
	CommonCodeService cservice;
	
	//회원관리
	@RequestMapping(value="/user/userList.do", method = RequestMethod.GET)
	public String userList(Model model) {
		
		 model.addAttribute("users", userService.getUserList());
		return "views/admin/userList";
	}
	
	//회원가입 페이지 이동
	@RequestMapping(value="/user/applyUser.do", method = RequestMethod.GET)
	public String applyFrm(Model model) {

		 List<SubCommonVO> locations  =	 cservice.korealocations(); 
		for(int i =0 ; i<locations.size(); i++) {
			System.out.println(locations.get(i).getSub_name());
		}
		 
		 model.addAttribute("locations",locations);
		 
		 Integer auth = 4;
		 
			List<MenuVO> menulist = menuService.menulist(auth);
			
			model.addAttribute("menulists", menulist);
		return "views/user/applyUser";
	}
	
	//아이디 중복확인
	@ResponseBody
	@RequestMapping(value="/user/checkId.do", method=RequestMethod.POST)
	public String checkId(@RequestBody UserVO vo) {
		
		Integer num = userService.getCheckId(vo);
		System.out.println("------" +num); 
		String result = "";
		if(num == 0 && vo.getUser_name() != null && vo.getUser_name() != "") {
			result = "true";
		}else {
			result =  "false";
		}
		System.out.println(result);
		return result;
	}
	
	//회원가입
	
	@RequestMapping(value="/user/applyUser.do", method=RequestMethod.POST)
	@PostMapping("/user/applyUser.do")
	public String applyNewUser(UserVO vo) {
		System.out.println(vo);

		userService.insUser(vo);
		
		return "redirect:/user/main.do";
	 }

	
	//로그인 페이지 이동
	@RequestMapping(value="/user/loginfrm.do", method=RequestMethod.GET)
	public String loginFrm(Model model) {
		
		 Integer auth = 4;
		 
			List<MenuVO> menulist = menuService.menulist(auth);
			
			model.addAttribute("menulists", menulist);
		return "views/user/logIn";
	}
	
	//로그인
	@RequestMapping(value="/user/login.do", method=RequestMethod.POST)
	public String doLogin(UserVO vo, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<>();
		userService.getUser(vo);
		System.out.println(userService.getUser(vo));
		
		if(userService.getUser(vo) == "yes") {
			
			userService.getUserInfo(vo).getUser_id();
			String userid = vo.getUser_name();
			String writerId = userService.getUserInfo(vo).getUser_id();;
			Integer auth = userService.getUserInfo(vo).getAuth();
			String name = userService.getUserInfo(vo).getReal_name();		
			
			
			//세션 생성하고 세션객체에 저장
			HttpSession session = request.getSession();
			session.setAttribute("memberId", userid);
			session.setAttribute("writerId", writerId);
			session.setAttribute("name", name);
			session.setAttribute("auth", auth);
			
			return "redirect:/user/main.do";
		}else if(userService.getUser(vo) == "noInfo") {
			
			String msg = "존재하지 않는 아이디 입니다.";
			map.put("msg", msg);
			System.out.println(msg);
			return "views/board/loginfail";
		}else {
			String msg = "비밀번호가 틀립니다!";
			map.put("msg", msg);
			System.out.println(msg);
			return "views/board/loginfail";
		}
	}
	
	//로그아웃
	@RequestMapping(value="/user/logout.do", method=RequestMethod.GET)
	public String doLogout( HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		session.invalidate();
		
		return "redirect:/user/main.do";
	}
	
	//메인
	@RequestMapping(value="/user/main.do",method=RequestMethod.GET)
	public String Main(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();


		String loginId = (String) session.getAttribute("writerId");
		Integer auth = (Integer) session.getAttribute("auth");
		
	    if (auth == null) {
	        auth = 4;
	    }
	    
		List<MenuVO> menulist = menuService.menulist(auth);
		
		model.addAttribute("menulists", menulist);
		model.addAttribute("auth", auth);
		model.addAttribute("loginId", loginId);
		return "views/user/main";
	}
}
