package egovframework.fusion.progressBrd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.fusion.commoncode.vo.SubCommonVO;
import egovframework.fusion.progressBrd.vo.ObjectVO;
import egovframework.fusion.progressBrd.vo.ckoverVO;
import egovframework.fusion.progressBrd.vo.progressVO;
import egovframework.fusion.user.vo.UserVO;

@Service
public class ProgressServiceImpl implements ProgressService {
	
	@Autowired
	ProgressMapper mapper;

	@Override
	public List<UserVO> managerList() {
		// TODO Auto-generated method stub
		return mapper.managerList();
	}

	@Override
	public void inputBrd(progressVO vo) {
		// 
		mapper.inputBrd(vo);
	}

	@Override
	public List<SubCommonVO> getmyTabs(progressVO vo) {
		// TODO Auto-generated method stub
		return mapper.getmyTabs(vo);
	}

	@Override
	public List<progressVO> getAllBrd(progressVO vo) {
		// TODO Auto-generated method stub
		return mapper.getAllBrd(vo);
	}

	@Override
	public Integer cntTotal(progressVO vo) {
		// TODO Auto-generated method stub
		return mapper.cntTotal(vo);
	}

	@Override
	public progressVO getOnePost(Integer board_id) {
		// TODO Auto-generated method stub
		return mapper.getOnePost(board_id);
	}

	@Override
	public void inputFirstDecision(ckoverVO vo) {
		// TODO Auto-generated method stub
		mapper.inputFirstDecision(vo);
	}

	@Override
	public void updateBoard(progressVO vo) {
		// TODO Auto-generated method stub
		mapper.updateBoard(vo);
	}

	@Override
	public void updateStepStatus(progressVO vo) {
		// TODO Auto-generated method stub
		mapper.updateStepStatus(vo);
	}

	@Override
	public List<SubCommonVO> getMagTabs() {
		// TODO Auto-generated method stub
		return mapper.getMagTabs();
	}

	@Override
	public ckoverVO getFirstFeedback(Integer board_id) {
		// TODO Auto-generated method stub
		return mapper.getFirstFeedback(board_id);
	}

	@Override
	public void inputUserObject(ObjectVO vo) {
		mapper.inputUserObject(vo);
		
	}

	@Override
	public ObjectVO getRecentObject(Integer board_id) {
		// TODO Auto-generated method stub
		return mapper.getRecentObject(board_id);
	}

	@Override
	public void editMyObject(ObjectVO vo) {
		// TODO Auto-generated method stub
		mapper.editMyObject(vo);
	}

	@Override
	public Integer cntObject(Integer board_id) {
		// TODO Auto-generated method stub
		return mapper.cntObject(board_id);
	}

	@Override
	public void inputObjectReply(ObjectVO vo) {
		// TODO Auto-generated method stub
		mapper.inputObjectReply(vo);
	}

	@Override
	public List<ObjectVO> getAllObject(Integer board_id) {
		// TODO Auto-generated method stub
		return mapper.getAllObject(board_id);
	}

	@Override
	public List<SubCommonVO> getTabsForNoBrd() {
		// TODO Auto-generated method stub
		return mapper.getTabsForNoBrd();
	}
	

}
