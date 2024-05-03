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

import egovframework.fusion.board.vo.BoardVO;
import egovframework.fusion.board.vo.HistoryVO;
import egovframework.fusion.board.vo.PagingVO;


public interface BoardService {
	//공지글 리스트
	public List<BoardVO> getNoticeList(BoardVO vo);
	//공지글 가장최신 한건만
	public BoardVO getRecentNotice(Integer menu_id);
		
	//전체리스트
	public List<BoardVO> getBoardList(BoardVO boardVo);
	
	public void insBoardPost(BoardVO boardVo);
	
	public BoardVO getBoardPost(BoardVO boardVo);
	
	public void updBoardCnt(BoardVO boardVo);
	
	public void updBoardPost(BoardVO boardVo);
	
	public void delBoardPost(BoardVO boardVo);
	
	
	//게시물 총 갯수 
	public Integer cntBoard(BoardVO vo);
	
	//체크 선택 삭제
	public void delChkBoardPost(BoardVO boardVO);
	
	//클릭 기록 남기기
	public void insHistory(HistoryVO historyVo);
	
	//클릭 기록 확인
	public Integer ckHistory(HistoryVO historyVo);
}
