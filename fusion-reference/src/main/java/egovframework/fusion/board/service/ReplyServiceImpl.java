package egovframework.fusion.board.service;

import java.util.List;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.fusion.board.vo.ReplyVO;

@Service
public class ReplyServiceImpl extends EgovAbstractServiceImpl implements ReplyService {
	private static final Logger LOGGER = LoggerFactory.getLogger(BoardServiceImpl.class);
	
	@Autowired
	ReplyMapper replyMapper;
	
	@Override
	public void insReply(ReplyVO replyvo) {
		// TODO Auto-generated method stub
		replyMapper.insReply(replyvo);;
	}

	@Override
	public List<ReplyVO> getReplyAll(ReplyVO vo) {
		// TODO Auto-generated method stub
		return replyMapper.getReplyAll(vo);
	}

	@Override
	public ReplyVO getReply(ReplyVO vo) {
		// TODO Auto-generated method stub
		return replyMapper.getReply(vo);
	}

	@Override
	public void delReply(ReplyVO vo) {
		replyMapper.delReply(vo);
		
	}

	@Override
	public void updateReply(ReplyVO vo) {
		replyMapper.updateReply(vo);
	}

}
