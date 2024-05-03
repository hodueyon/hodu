package egovframework.fusion.common.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletRequest;
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
import egovframework.fusion.galary.vo.GalaryVO;

@Controller
public class MenuController {
	
	@Autowired
	MenuService menuService;
	
	@RequestMapping(value = "/menu/AdminMenu.do", method = RequestMethod.GET)
	public String AdminMenu(Model model) {
		
		model.addAttribute("authes", menuService.getAuthes());
		model.addAttribute("category", menuService.getCategory());
		//model.addAttribute("menulists", menuService.menulist());
		
		return "views/admin/adminMenu";
	}
	
	//메뉴등록 
	@RequestMapping(value="/menu/inputMenu.do", method = RequestMethod.POST)
	@ResponseBody
	public String inputMenu(@RequestBody MenuVO menuvo) {
		
		Integer menuid = menuService.makemenuid();
		
		if(menuvo.getMenu_category() !=5) {
			menuvo.setMenu_url(menuvo.getMenu_url()+menuid);
		}

		menuvo.setMenu_id(menuid);
		
		menuService.insMenu(menuvo);
		return "0";
	}
	
	//메뉴삭제
	@RequestMapping(value="/menu/delMenu.do", method = RequestMethod.GET)
	public String inputMenu(Integer menu_id) {
		
		menuService.delMenu(menu_id);
		return "redirect:/menu/AdminMenu.do";
	}
	
	
	//수정
	@RequestMapping(value="/menu/updateMenu.do", method = RequestMethod.POST)
	@ResponseBody
	public String updateMenu(@RequestBody MenuVO vo) {
		
		menuService.updateMenu(vo);
		return "0";

	}
	
	//메뉴이동
	@RequestMapping(value="/menu/moveMenu.do", method = RequestMethod.GET)
	public String moveMenu(Integer menu_id,Model model) throws UnsupportedEncodingException {
		
		System.out.println("컨트롤러 도착 ");
		Integer category = menuService.getmenu(menu_id).getMenu_category();

		String location = menuService.getmenu(menu_id).getMenu_url();
		if(category == 5 ) {

			//Integer num = location.indexOf("?");
			//String linkurl = location.substring(0, num-1);
			//System.out.println("ddddddddddddddddd" + linkurl);
			System.out.println(location);
			model.addAttribute("location", location);
			//return "redirect:"+ location;
			return "views/admin/goweburl";
		}else {
			System.out.println(location);
			return "redirect:"+ location;
			
		}
		
	}
	
	//통계페이지 이동
	@RequestMapping(value="/menu/moveStaticMenu.do", method = RequestMethod.GET)
	public String moveStaticMenu() throws UnsupportedEncodingException {
		

		return "views/admin/staticMenu";
	}

	
	//전체검색 이동
	@RequestMapping(value="/menu/searchAll.do", method = RequestMethod.GET)
	public String searchAll(GalaryVO vo,Model model , HttpServletResponse response, HttpServletRequest request){
		
		List<GalaryVO> menu = new ArrayList<GalaryVO>();
		Set<Integer> menuIds = new HashSet<Integer>();
		
		GalaryVO galvo = new GalaryVO();
		HttpSession session = request.getSession();
		
		String loginId = (String) session.getAttribute("writerId");
		Integer auth = (Integer) session.getAttribute("auth");
		
		if(auth == null) {
			auth = 4;
		}
		
		vo.setAuth_id(auth);
		List<GalaryVO> list = menuService.headerSrchList(vo);
		model.addAttribute("loginId", loginId);
		model.addAttribute("auth", auth);
		model.addAttribute("list", list);
		
		List<MenuVO> menulist = menuService.menulist(auth);
		model.addAttribute("menulists", menulist);
		
		for(int i = 0; i < list.size(); i++) {
			
		    int menuId = list.get(i).getMenu_id();
		    if(!menuIds.contains(menuId)) {
		        menuIds.add(menuId);
		        galvo.setMenu_id(menuId);
		        galvo.setM_category_name(list.get(i).getM_category_name());
		        galvo.setMenu_name(list.get(i).getMenu_name());
		        menu.add(galvo);
		        galvo = new GalaryVO();
		    }
		}
		

		model.addAttribute("menu", menu);
		model.addAttribute("searchtype", vo.getSearch_type());
		
		model.addAttribute("searchword", vo.getSearch_word());

		return "views/user/searchAll";
	}
	
	
	//메뉴이름 중복체크
	@RequestMapping(value="/menu/ckMenuName.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer ckMenuMane(@RequestBody MenuVO vo) {
		
			Integer num = menuService.ckmenuname(vo);
			System.out.println("num" +  num);
			return num;
	}
}
