package egovframework.fusion.progressBrd.service;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.fusion.board.vo.BoardVO;
import egovframework.fusion.commoncode.vo.SubCommonVO;
import egovframework.fusion.progressBrd.vo.ObjectVO;
import egovframework.fusion.progressBrd.vo.ckoverVO;
import egovframework.fusion.progressBrd.vo.progressVO;
import egovframework.fusion.user.vo.UserVO;

@Mapper
public interface ProgressMapper {
	
	
	//관리자 리스트 불러오기
	public List<UserVO> managerList();
	
	//사용자 글등록
	public void inputBrd(progressVO vo);
	
	//사용자 탭용 
	public List<SubCommonVO> getmyTabs(progressVO vo);
	
	//관리자 탭
	public List<SubCommonVO> getMagTabs();
	
	//글목록
	public List<progressVO> getAllBrd(progressVO vo);
	
	//토탈
	public Integer cntTotal(progressVO vo);
	
	//한글 조회
	public progressVO getOnePost(Integer board_id);
	
	//첫 검토 등록
	public void inputFirstDecision(ckoverVO vo);
	
	//사용자 수정
	public void updateBoard(progressVO vo);
	
	//상태 및 진행단계 수정
	public void updateStepStatus(progressVO vo);
	
	//첫 검토 불러오기
	public ckoverVO getFirstFeedback(Integer board_id);
	
	//사용자 이의제기
	public void inputUserObject(ObjectVO vo);
	
	//가장 최근의 이의제기 불러오기
	public ObjectVO getRecentObject(Integer board_id);
	
	//이의제기 수정
	public void editMyObject(ObjectVO vo);
	
	//이의제기 몇번째인지 갯수
	public Integer cntObject(Integer board_id);
	
	//관리자 이의제기 의견 등록
	public void inputObjectReply(ObjectVO vo);
	
	//모든 의의제기 리스트 가져오기
	public List<ObjectVO> getAllObject(Integer board_id);
	
	//작성글 하나도 없는 유저를 위한 탭입니다~
	public List<SubCommonVO> getTabsForNoBrd();
}
