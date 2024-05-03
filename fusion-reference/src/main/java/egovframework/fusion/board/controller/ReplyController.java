package egovframework.fusion.board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.fusion.board.service.ReplyService;
import egovframework.fusion.board.vo.ReplyVO;

@Controller
public class ReplyController {
	
	@Autowired
	ReplyService replyService;

	//댓글달기
	@ResponseBody
	@RequestMapping(value="/board/inputReply.do", method=RequestMethod.POST)
	public List<ReplyVO> inputReply(@RequestBody ReplyVO vo, HttpServletRequest request, HttpServletResponse response) {
		//세션에서 뽑아내기
		HttpSession session = request.getSession();
		String loginId = (String)session.getAttribute("memberId");
		System.out.println(vo);
		vo.setWriter(loginId);
		
		if(vo.getParent_id()== null) {
			vo.setParent_id(0);
		}
		
		//댓글등록
		replyService.insReply(vo);
		
		//댓글조회
		List<ReplyVO> list = replyService.getReplyAll(vo);
		
		return list;
	}
	//댓글수정
	@ResponseBody
	@RequestMapping(value="/board/updateReply.do", method=RequestMethod.POST)
	public String updateReply(@RequestBody ReplyVO vo) {
		replyService.updateReply(vo);
		
		String msg= "수정 완료되었습니다!";
		return msg;
	}
	
	//댓글삭제
	@ResponseBody
	@RequestMapping(value="/board/delReply.do", method=RequestMethod.POST)
	public String delReply(@RequestBody ReplyVO vo) {
		
		replyService.delReply(vo);
		String msg = "삭제 완료 되었습니다!";
		return msg;
	}
}
