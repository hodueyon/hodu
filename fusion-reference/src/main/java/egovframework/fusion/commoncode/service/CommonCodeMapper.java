package egovframework.fusion.commoncode.service;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.fusion.commoncode.vo.SubCommonVO;
import egovframework.fusion.commoncode.vo.UpperCommonVO;

@Mapper
public interface CommonCodeMapper {
	

	
	//대분류만 조회
	public List<UpperCommonVO> upperList(UpperCommonVO vo);
	
	//대분류당 소분 조회
	public List<SubCommonVO> subList(UpperCommonVO vo);
	
	//한개조회
	public SubCommonVO getUpperSubInfo(String subid);
	//대분류 등록
	public void insertUpper(UpperCommonVO vo);
	
	//소분류 등록
	public void insertSub(SubCommonVO vo);

	
	//대분류 수정
	public void updateUpper(UpperCommonVO vo);

	//소분류 수정
	public void updateSub(SubCommonVO vo);

	
	//대분류 삭제
	public void delUpper(UpperCommonVO vo);
	
	//소분류 삭제
	public void delSub(SubCommonVO vo);
	
	//대분류용 알파벳, 숫자찾기
	public UpperCommonVO findLastIdOrder();
	
	//소분류용 숫자
	public Integer findLastOrder(SubCommonVO vo);
	
	//대분류 중복확인
	public Integer upperDuplicateCk(UpperCommonVO vo);
	
	//소분류 중복확인
	public Integer subDuplicateCk(SubCommonVO vo);
	
	//지역리스트
	public List<SubCommonVO> korealocations();
}
