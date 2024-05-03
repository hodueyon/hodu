package egovframework.fusion.sns.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.fusion.sns.vo.SnsLikeVO;
import egovframework.fusion.sns.vo.SnsReplyVO;
import egovframework.fusion.sns.vo.SnsVO;

@Service
public class SnsServiceImpl implements SnsService {
	
	@Autowired
	SnsMapper mapper;
	
	@Override
	public Integer ckLikeYn(SnsLikeVO vo) {
		// TODO Auto-generated method stub
		return mapper.ckLikeYn(vo);
	}

	@Override
	public void inputLike(SnsLikeVO vo) {
		
		mapper.inputLike(vo);
	}

	@Override
	public void delLIke(SnsLikeVO vo) {
		// TODO Auto-generated method stub
		mapper.delLIke(vo);
	}

	@Override
	public void insertSns(SnsVO vo) {
		// TODO Auto-generated method stub
		mapper.insertSns(vo);
	}

	@Override
	public void delSns(SnsVO vo) {
		// TODO Auto-generated method stub
		mapper.delSns(vo);
	}

	@Override
	public void updateSns(SnsVO vo) {
		// TODO Auto-generated method stub
		mapper.updateSns(vo);
	}

	@Override
	public void inputReply(SnsReplyVO vo) {
		// TODO Auto-generated method stub
		mapper.inputReply(vo);
	}

	@Override
	public void updateReply(SnsReplyVO vo) {
		// TODO Auto-generated method stub
		mapper.updateReply(vo);
	}

	@Override
	public void delReply(SnsReplyVO vo) {
		// TODO Auto-generated method stub
		mapper.delReply(vo);
	}

	@Override
	public List<SnsReplyVO> replylist(Integer brdid) {
		// TODO Auto-generated method stub
		return mapper.replylist(brdid);
	}

	@Override
	public List<SnsVO> snslist(SnsVO vo) {
		// TODO Auto-generated method stub
		return mapper.snslist(vo);
	}

	@Override
	public SnsVO getSns(Integer sns_id) {
		// TODO Auto-generated method stub
		return mapper.getSns(sns_id);
	}

	@Override
	public SnsReplyVO getReply(Integer reply_id) {
		// TODO Auto-generated method stub
		return mapper.getReply(reply_id);
	}

}
