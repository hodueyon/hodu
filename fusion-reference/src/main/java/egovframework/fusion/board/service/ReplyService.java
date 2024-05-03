package egovframework.fusion.board.service;

import java.util.List;

import egovframework.fusion.board.vo.ReplyVO;

public interface ReplyService {
	
	//등록
	public void insReply(ReplyVO replyvo);
	//댓글조회
	public List<ReplyVO> getReplyAll(ReplyVO vo);
	
	//댓글 한건 조회
	public ReplyVO getReply(ReplyVO vo);
	
	//댓글삭제
	public void delReply(ReplyVO vo);
	
	//댓글수정
	public void updateReply(ReplyVO vo);
}
