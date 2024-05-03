/*********************************************************
 * 업 무 명 : 게시판 컨트롤러
 * 설 명 : 게시판을 조회하는 화면에서 사용 
 * 작 성 자 : 김민규
 * 작 성 일 : 2022.10.06
 * 관련테이블 : 
 * Copyright ⓒ fusionsoft.co.kr
 *
 *********************************************************/
package egovframework.fusion.board.service;

import java.util.List;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import egovframework.fusion.board.vo.BoardVO;
import egovframework.fusion.board.vo.HistoryVO;
import egovframework.fusion.board.vo.PagingVO;

@Service
public class BoardServiceImpl extends EgovAbstractServiceImpl implements BoardService{

	private static final Logger LOGGER = LoggerFactory.getLogger(BoardServiceImpl.class);
	
	@Autowired
	BoardMapper boardMapper;
	
	@Override
	public List<BoardVO> getBoardList(BoardVO boardVo) {
		
		
		return boardMapper.getBoardList(boardVo);
	}


	@Override
	public void insBoardPost(BoardVO boardVo) {
		boardMapper.insBoardPost(boardVo);
	}

	@Override
	public BoardVO getBoardPost(BoardVO boardVo) {
		return boardMapper.getBoardPost(boardVo);
	}

	@Override
	public void updBoardCnt(BoardVO boardVo) {
		boardMapper.updBoardCnt(boardVo);
	}

	@Override
	public void updBoardPost(BoardVO boardVo) {
		boardMapper.updBoardPost(boardVo);
	}

	@Override
	public void delBoardPost(BoardVO boardVo) {
		boardMapper.delBoardPost(boardVo);
	}
	
	
	@Override
	public void delChkBoardPost(BoardVO boardVO) {
		//체크 선택삭제
		boardMapper.delChkBoardPost(boardVO.getNumArr());
	}

	@Override
	public Integer cntBoard(BoardVO vo) {
		// 
		return boardMapper.cntBoard(vo);
	}

	@Override
	public void insHistory(HistoryVO historyVo) {
		// TODO Auto-generated method stub
		boardMapper.insHistory(historyVo);
	}

	@Override
	public Integer ckHistory(HistoryVO historyVo) {
		// TODO Auto-generated method stub
		
		return boardMapper.ckHistory(historyVo) ;
	}


	//공지목록 - 최신순 다섯개 
	@Override
	public List<BoardVO> getNoticeList(BoardVO vo) {
		// TODO Auto-generated method stub
		return boardMapper.getNoticeList(vo);
	}


	@Override
	public BoardVO getRecentNotice(Integer menu_id) {
		// TODO Auto-generated method stub
		return boardMapper.getRecentNotice(menu_id);
	}



}
