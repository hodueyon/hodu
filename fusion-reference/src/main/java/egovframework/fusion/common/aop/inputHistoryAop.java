package egovframework.fusion.common.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import egovframework.fusion.common.service.MenuService;
import egovframework.fusion.common.vo.MenuHistoryVO;

@Aspect
@Component
public class inputHistoryAop {
	

    @Autowired
    private HttpServletRequest request;
    
    
	@Autowired
	private MenuService service;
	
    @Around("execution(* egovframework.fusion.common.controller.MenuController.moveMenu(..))")
	public Object aroundMoveMenu(ProceedingJoinPoint pjp) throws Throwable {
    	
    	
    	
    	HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
    	String menuid = request.getParameter("menu_id");
    	request.getServletPath();

    	Integer menu_id = Integer.parseInt(menuid);

    	HttpSession session = request.getSession();
    	String userId = (String) session.getAttribute("writerId");
         
    	if(userId == null) {
    		userId = "nonuser";
    	}
		MenuHistoryVO vo = new MenuHistoryVO();
		vo.setMenu_id(menu_id);
		vo.setUser_id(userId);
		
    	service.inputMenuRecord(vo);
    	
		Object result = pjp.proceed(); // moveMenu 메소드 실행
		
		return result;
	}
	
}
