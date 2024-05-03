package egovframework.fusion.common.interceptor;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.util.ContentCachingRequestWrapper;
import org.springframework.web.util.ContentCachingResponseWrapper;

import egovframework.fusion.sns.service.SnsService;
import egovframework.fusion.sns.vo.SnsLikeVO;
import egovframework.fusion.sns.vo.SnsReplyVO;
import egovframework.fusion.sns.vo.SnsVO;

public class SnsInterceptor implements HandlerInterceptor {

	@Autowired
	SnsService service;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		System.out.println("sns용 인터셉터실행");
		// uri 뽑아내기
		String url = request.getRequestURI();

		HttpSession session = request.getSession();
		Integer auth = (Integer) session.getAttribute("auth");
		Object oId = session.getAttribute("writerId");
		String loginId = (String) oId.toString();

		SnsVO vo;
		SnsVO result;
		String writer;
		
		SnsLikeVO likevo;
		SnsReplyVO replyvo;
		
		switch (url) {
		case "/sns/inputSns.do":
			if (loginId == null) {
				PrintWriter msg = response.getWriter();
				msg.println("<script>alert('로그인 하지 않은 유저는 등록할 수 없습니다!');location.href='/user/main.do';</script>");
				msg.flush();
				msg.close();
				return false;

			} else {
				return true;

			}
		case "/sns/delSns.do":
			
			vo = extractPostedObject(request);
			result = service.getSns(vo.getSns_id());
			writer = result.getWriter();
			System.out.println("vo = " + vo.getSns_id());

			if(auth <=1 || writer == loginId) {
				return true;
			}else {
				PrintWriter msg = response.getWriter();
				msg.println("<script>alert('해당 권한이 없어 삭제가 불가능합니다!');location.href='/user/main.do';</script>");
				msg.flush();
				msg.close();
				return false;
			}
			
		case "/sns/updateSns.do":
			vo = extractPostedObject(request);
			result = service.getSns(vo.getSns_id());
			writer = result.getWriter();
			System.out.println("vo = " + vo.getSns_id());
			if(auth <=1 || writer == loginId) {
				return true;
			}else {
				PrintWriter msg = response.getWriter();
				msg.println("<script>alert('해당 권한이 없어 수정이 불가능합니다!');location.href='/user/main.do';</script>");
				msg.flush();
				msg.close();
				return false;
			}
		
		case "/sns/addLike.do":
			likevo = makeLikeVO(request);
			Integer num = service.ckLikeYn(likevo);
			if (loginId != null) {
				if(num >0) {
					PrintWriter msg = response.getWriter();
					msg.println("<script>alert('좋아요는 글 당 1번만 가능합니다!');location.href='/user/main.do';</script>");
					msg.flush();
					msg.close();
					return false;
				}else {
					return true;
				}
				
			}else {
				PrintWriter msg = response.getWriter();
				msg.println("<script>alert('비로그인 유저는 좋아요가 불가능합니다!');location.href='/user/main.do';</script>");
				msg.flush();
				msg.close();
				return false;
			}
			
		case "/sns/delLike.do":
			likevo = makeLikeVO(request);
			Integer num2 = service.ckLikeYn(likevo);
			if (loginId != null) {
				if(num2 <=0) {
					PrintWriter msg = response.getWriter();
					msg.println("<script>alert('좋아요한 적이 없습니다!!');location.href='/user/main.do';</script>");
					msg.flush();
					msg.close();
					return false;
				}else {
					return true;
				}
				
			}else {
				PrintWriter msg = response.getWriter();
				msg.println("<script>alert('비로그인 유저는 권한이 없습니다!');location.href='/user/main.do';</script>");
				msg.flush();
				msg.close();
				return false;
			}
		case "/sns/inputReply.do":
			if (loginId == null) {
				PrintWriter msg = response.getWriter();
				msg.println("<script>alert('로그인 하지 않은 댓글을 등록할 수 없습니다!');location.href='/user/main.do';</script>");
				msg.flush();
				msg.close();
				return false;

			} else {
				return true;

			}
		case "/sns/delReply.do":
			replyvo = makeReplyVO(request);
			SnsReplyVO rvo = service.getReply(replyvo.getReply_id());
			writer = rvo.getWriter();
			if(auth <=1 || writer == loginId) {
				return true;
			}else {
				PrintWriter msg = response.getWriter();
				msg.println("<script>alert('해당 권한이 없어 삭제 불가능합니다!');location.href='/user/main.do';</script>");
				msg.flush();
				msg.close();
				return false;
			}

		case "/sns/updateReply.do":
			replyvo = makeReplyVO(request);
			SnsReplyVO rvo2 = service.getReply(replyvo.getReply_id());
			writer = rvo2.getWriter();
			if(auth <=1 || writer == loginId) {
				return true;
			}else {
				PrintWriter msg = response.getWriter();
				msg.println("<script>alert('해당 권한이 없어 수정 불가능합니다!');location.href='/user/main.do';</script>");
				msg.flush();
				msg.close();
				return false;
			}
		}

		return true;
	}

	private SnsVO extractPostedObject(HttpServletRequest request) throws IOException {
		// ReareadableRequestwrAPPER를 이용해서 만든 거를 VO로 변환해주는 과정
		String body = request.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			SnsVO vo = mapper.readValue(body, SnsVO.class);
			return vo;
		} catch (IOException e) {
			System.out.println("예외");
		}
		return null;
	}
	
	private SnsLikeVO makeLikeVO(HttpServletRequest request) throws IOException {
		// ReareadableRequestwrAPPER를 이용해서 만든 거를 VO로 변환해주는 과정
		String body = request.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			SnsLikeVO likevo = mapper.readValue(body, SnsLikeVO.class);
			return likevo;
		} catch (IOException e) {
			System.out.println("예외");
		}
		return null;
	}
	
	private SnsReplyVO makeReplyVO(HttpServletRequest request) throws IOException {
		// ReareadableRequestwrAPPER를 이용해서 만든 거를 VO로 변환해주는 과정
		String body = request.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			SnsReplyVO vo = mapper.readValue(body, SnsReplyVO.class);
			return vo;
		} catch (IOException e) {
			System.out.println("예외");
		}
		return null;
	}
}
