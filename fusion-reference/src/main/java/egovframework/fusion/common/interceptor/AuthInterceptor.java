package egovframework.fusion.common.interceptor;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;


import egovframework.fusion.common.service.MenuService;
import egovframework.fusion.common.vo.MenuVO;

public class AuthInterceptor implements HandlerInterceptor{
	
	@Autowired
	MenuService service;
	

	 @Override
	    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		   System.out.println("preHandle >>>  Controller 실행 전 실행");
		   String queryString = request.getQueryString();
	        String url = request.getRequestURI();
	        StringBuilder sb = new StringBuilder();
	        
			String fullUrl = url+"?"+queryString;

		    HttpSession session = request.getSession();
		    Integer auth = (Integer) session.getAttribute("auth");
		    if (auth == null) {
		        auth = 4;
		    }
		    
		    System.out.println(auth);
		   //
		  //메뉴용
	        List<MenuVO> menulist = service.menulist(auth);
	        request.setAttribute("menulists", menulist);
		    
	        // menu_id 있는 경우
		    if (request.getParameter("menu_id") != null) {
		        Integer menu_id = Integer.parseInt(request.getParameter("menu_id"));
		        Integer authmenu = service.getmenu(menu_id).getAuth_id();
		        if (auth > authmenu) { 
		        	// 세션의 권한 값이 메뉴의 권한 값보다 높은 경우
		            response.setContentType("text/html; charset=UTF-8");
		            //권한 없을때 보낼 메세지 작성하기
		            //PrintWriter : 바이트를 문자형태로 바꿔준다고 한다네요..
			        menulist = service.menulist(auth);
			        request.setAttribute("menulists", menulist);
		            PrintWriter msg = response.getWriter();
		            msg.println("<script>alert('권한이 없습니다!');location.href='/user/main.do';</script>"); 
		            msg.flush();
		            msg.close();
		            return false;
		        }else {
			        request.setAttribute("menulists", menulist);
			        
			        return true;
		        }
		    } else { // menu_id 파라미터가 없는 경우(링크형 등등~~~);
		        Integer subAuthMenu = service.getmenubyurl(url).getAuth_id();
		        if(auth <= subAuthMenu) {
		        	return true;
		        }else {
		        	request.setAttribute("menulists", menulist);
		        	response.setContentType("text/html; charset=UTF-8");
		            PrintWriter msg = response.getWriter();
		            msg.println("<script>alert('권한이 없습니다!');location.href='/user/main.do';</script>");
		            msg.flush();
		            msg.close();

		            return false;
		        }
		    }
	    }
	 
	    @Override
	    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modeAndView) throws Exception {
	        System.out.println("postHandle >>>  Controller 실행 후 실행");
	        
	        //세션 자격 넣어주깅
		    HttpSession session = request.getSession();
		    Integer auth = (Integer) session.getAttribute("auth");
		    if (auth == null) {
		        auth = 4;
		    }
		    
	        request.setAttribute("auth", auth);

	        
	    }
	 
	    @Override
	    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex){
	        System.out.println("afterCompletion >>>  preHandle 메소드 return값이 true일 때 실행");
	    }
}
