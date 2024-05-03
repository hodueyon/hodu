package egovframework.fusion.commoncode.service;

import java.util.List;

import egovframework.fusion.commoncode.vo.SubCommonVO;
import egovframework.fusion.commoncode.vo.UpperCommonVO;

public interface CommonCodeService {

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
		
		//삭제 전 소분류 존재 확인
		public String cksBeforDel(UpperCommonVO vo);
		
		
		//대분류 중복확인
		public Integer upperDuplicateCk(UpperCommonVO vo);
		
		//소분류 중복확인
		public Integer subDuplicateCk(SubCommonVO vo);
		
		//지역리스트
		public List<SubCommonVO> korealocations();
		
		//대분류용 알파벳, 숫자찾기
		public UpperCommonVO findLastIdOrder();
		
}
