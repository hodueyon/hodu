package egovframework.fusion.board.service;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.fusion.board.vo.ReplyVO;

@Mapper
public interface ReplyMapper {
	
	//댓글등록
	public void insReply(ReplyVO vo);
	
	//댓글목록조회
	public List<ReplyVO> getReplyAll(ReplyVO vo);
	
	//댓글 한건 조회
	public ReplyVO getReply(ReplyVO vo);
	
	//댓글삭제
	public void delReply(ReplyVO vo);
	
	//댓글수정
	public void updateReply(ReplyVO vo);
}
