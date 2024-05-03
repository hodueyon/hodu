package egovframework.fusion.sns.service;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.fusion.sns.vo.SnsLikeVO;
import egovframework.fusion.sns.vo.SnsReplyVO;
import egovframework.fusion.sns.vo.SnsVO;

@Mapper
public interface SnsMapper {
	
	//좋아요 여부 체크
	public Integer ckLikeYn(SnsLikeVO vo);
	
	//좋아요 등록
	public void inputLike(SnsLikeVO vo);
	
	//좋아요 삭제
	public void delLIke(SnsLikeVO vo);
	
	//글 리스트 받아오기
	public List<SnsVO> snslist(SnsVO vo);
	
	//글등록
	public void insertSns(SnsVO vo);
	
	//글삭제
	public void delSns(SnsVO vo);
	
	//글수정
	public void updateSns(SnsVO vo);
	
	//댓글달기
	public void inputReply(SnsReplyVO vo);
	
	//댓글수정
	public void updateReply(SnsReplyVO vo);

	//댓글삭제
	public void delReply(SnsReplyVO vo);
	
	//댓글조회
	public List<SnsReplyVO> replylist(Integer brdid);
	
	//한건조회 - sns
	public SnsVO getSns(Integer sns_id);
	
	//한건조회  - 댓글
	public SnsReplyVO getReply(Integer reply_id);

}
